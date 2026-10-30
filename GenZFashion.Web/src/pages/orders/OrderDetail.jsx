import { Link, useParams } from 'react-router-dom';
import { ArrowRight, RefreshCw, ChevronLeft } from 'lucide-react';
import { api, money } from '../../api.js';
import { useData } from '../../hooks/useData.js';
import { useTask } from '../../hooks/useTask.jsx';
import { DataState, Badge } from '../../components/ui.jsx';

export function OrderDetail({ admin = false }) {
  const { id } = useParams();
  const state = useData(`${admin ? '/admin' : ''}/orders/${id}`);
  const task = useTask();
  const order = state.data;
  const next = { Pending: 'Confirmed', Confirmed: 'Shipping', Shipping: 'Completed' };
  return (
    <>
      <Link className="back" to={admin ? '/admin/orders' : '/orders'}>
        <ChevronLeft size={16} /> Danh sách đơn
      </Link>
      <DataState state={state}>
        {order && (
          <>
            <div className="section-heading">
              <div>
                <span className="eyebrow">ORDER DETAILS</span>
                <h1>Đơn hàng #{order.id}</h1>
              </div>
              <Badge status={order.status} />
            </div>
            <div className="order-columns">
              <div className="panel">
                <h2>Sản phẩm đã mua</h2>
                {order.items.map((i, n) => (
                  <div className="order-line" key={n}>
                    <div>
                      <h3>{i.productName}</h3>
                      <p className="muted">
                        {i.sku} · {i.size} / {i.color} · SL {i.quantity}
                      </p>
                    </div>
                    <b>{money(i.unitPrice * i.quantity)}</b>
                  </div>
                ))}
                <div className="totals">
                  <p className="grand">
                    Tổng thanh toán <b>{money(order.total)}</b>
                  </p>
                </div>
              </div>
              <div className="panel">
                <h2>Thông tin nhận hàng</h2>
                <p>
                  <b>{order.recipientName}</b>
                </p>
                <p>{order.phone}</p>
                <p>{order.address}</p>
                <p className="muted">Thanh toán khi nhận hàng · {order.paymentMethod}</p>
                <div className="stack">
                  {admin && next[order.status] && (
                    <button
                      className="primary"
                      disabled={task.busy}
                      onClick={() =>
                        task.run(async () => {
                          await api(`/admin/orders/${id}/status`, {
                            method: 'PUT',
                            body: { status: next[order.status], rowVersion: order.rowVersion },
                          });
                          state.reload();
                        })
                      }
                    >
                      {
                        {
                          Confirmed: 'Xác nhận đơn',
                          Shipping: 'Bắt đầu giao hàng',
                          Completed: 'Hoàn tất đơn',
                        }[next[order.status]]
                      }{' '}
                      <ArrowRight size={16} />
                    </button>
                  )}
                  {(order.status === 'Pending' || (admin && order.status === 'Confirmed')) && (
                    <button
                      className="outline danger"
                      disabled={task.busy}
                      onClick={() => {
                        if (window.confirm('Hủy đơn hàng này và hoàn lại tồn kho?'))
                          task.run(async () => {
                            await api(
                              admin ? `/admin/orders/${id}/status` : `/orders/${id}/cancel`,
                              {
                                method: admin ? 'PUT' : 'POST',
                                ...(admin
                                  ? { body: { status: 'Cancelled', rowVersion: order.rowVersion } }
                                  : {}),
                              }
                            );
                            state.reload();
                          }, 'Đã hủy đơn và hoàn lại tồn kho.');
                      }}
                    >
                      Hủy đơn hàng
                    </button>
                  )}
                  <button className="text-link" onClick={state.reload}>
                    <RefreshCw size={15} /> Tải lại dữ liệu
                  </button>
                </div>
                {task.notice}
              </div>
            </div>
          </>
        )}
      </DataState>
    </>
  );
}
