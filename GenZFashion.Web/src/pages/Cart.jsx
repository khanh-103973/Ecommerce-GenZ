import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { ArrowRight, ShoppingBag } from 'lucide-react';
import { api, money } from '../api.js';
import { useData } from '../hooks/useData.js';
import { useTask } from '../hooks/useTask.jsx';
import { DataState, Field } from '../components/ui.jsx';
import { ProductArt } from '../components/ProductArt.jsx';

export function Cart() {
  const state = useData('/cart');
  const task = useTask();
  const navigate = useNavigate();
  const [requestId, setRequestId] = useState(() => crypto.randomUUID());
  return (
    <main className="section">
      <span className="eyebrow">YOUR NEXT FAVORITES</span>
      <h1 className="page-title">
        Giỏ hàng<span>.</span>
      </h1>
      <DataState state={state}>
        {state.data?.items.length ? (
          <div className="cart-layout">
            <div>
              {state.data.items.map((item) => (
                <div className="cart-item" key={item.productVariantId}>
                  <ProductArt name={item.name} />
                  <div>
                    <h3>{item.name}</h3>
                    <p className="muted">
                      {item.size} / {item.color}
                    </p>
                    <strong>{money(item.price)}</strong>
                    {!item.isAvailable && (
                      <p className="error">Sản phẩm ngừng bán hoặc không đủ tồn kho.</p>
                    )}
                    <div className="quantity-row">
                      <button
                        className="outline"
                        disabled={task.busy || item.quantity <= 1}
                        onClick={() =>
                          task.run(async () => {
                            await api(`/cart/items/${item.productVariantId}`, {
                              method: 'PUT',
                              body: { quantity: item.quantity - 1 },
                            });
                            setRequestId(crypto.randomUUID());
                            state.reload();
                          })
                        }
                      >
                        −
                      </button>
                      <span>{item.quantity}</span>
                      <button
                        className="outline"
                        disabled={task.busy || item.quantity >= Math.min(item.stockQuantity, 99)}
                        onClick={() =>
                          task.run(async () => {
                            await api(`/cart/items/${item.productVariantId}`, {
                              method: 'PUT',
                              body: { quantity: item.quantity + 1 },
                            });
                            setRequestId(crypto.randomUUID());
                            state.reload();
                          })
                        }
                      >
                        +
                      </button>
                      <button
                        className="text-link"
                        disabled={task.busy}
                        onClick={() =>
                          task.run(async () => {
                            await api(`/cart/items/${item.productVariantId}`, { method: 'DELETE' });
                            setRequestId(crypto.randomUUID());
                            state.reload();
                          }, 'Đã bỏ sản phẩm khỏi giỏ.')
                        }
                      >
                        Bỏ khỏi giỏ
                      </button>
                    </div>
                  </div>
                </div>
              ))}
            </div>
            <form
              className="checkout panel"
              onSubmit={(e) => {
                e.preventDefault();
                const body = { ...Object.fromEntries(new FormData(e.currentTarget)), requestId };
                task.run(async () => {
                  const order = await api('/orders', { method: 'POST', body });
                  navigate(`/orders/${order.id}`);
                }, '');
              }}
            >
              <h2>Thông tin nhận hàng</h2>
              <Field label="Tên người nhận" name="recipientName" required maxLength={100} />
              <Field
                label="Số điện thoại"
                name="phone"
                required
                pattern="\+?[0-9]{9,15}"
                maxLength={16}
              />
              <Field label="Địa chỉ nhận hàng" name="address" required maxLength={500} />
              <div className="totals">
                <p>
                  Tạm tính <b>{money(state.data.estimatedTotal)}</b>
                </p>
                <p>
                  Giao hàng demo <b>0đ</b>
                </p>
                <p className="grand">
                  Tổng cộng <b>{money(state.data.estimatedTotal)}</b>
                </p>
              </div>
              <p className="muted">Thanh toán khi nhận hàng · COD</p>
              <button
                className="primary"
                disabled={task.busy || state.data.items.some((i) => !i.isAvailable)}
              >
                {task.busy ? 'Đang đặt hàng…' : 'Đặt hàng COD'} <ArrowRight size={18} />
              </button>
              <small>Giá và tồn kho được kiểm tra lại khi đặt đơn.</small>
            </form>
          </div>
        ) : (
          <div className="state">
            <ShoppingBag size={40} />
            <h2>Giỏ hàng còn trống.</h2>
            <Link className="primary" to="/shop">
              Khám phá sản phẩm <ArrowRight size={18} />
            </Link>
          </div>
        )}
        {task.notice}
      </DataState>
    </main>
  );
}
