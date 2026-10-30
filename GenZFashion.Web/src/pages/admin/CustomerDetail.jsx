import { useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { ChevronLeft } from 'lucide-react';
import { money } from '../../api.js';
import { useData } from '../../hooks/useData.js';
import { DataState, Badge, Pager } from '../../components/ui.jsx';

export function CustomerDetail() {
  const { id } = useParams();
  const [page, setPage] = useState(1);
  const customer = useData(`/admin/customers/${id}`),
    orders = useData(`/admin/customers/${id}/orders?page=${page}`);
  return (
    <>
      <Link className="back" to="/admin/customers">
        <ChevronLeft size={16} /> Danh sách khách hàng
      </Link>
      <DataState state={customer}>
        {customer.data && (
          <div className="panel">
            <h1>{customer.data.fullName}</h1>
            <p>{customer.data.email}</p>
            <p>
              {customer.data.orderCount} đơn · {customer.data.completedOrderCount} hoàn tất
            </p>
            <strong>Chi tiêu hoàn tất: {money(customer.data.completedSpend)}</strong>
          </div>
        )}
      </DataState>
      <h2>Lịch sử mua hàng</h2>
      <DataState state={orders}>
        <div className="panel table-wrap">
          <table>
            <thead>
              <tr>
                <th>Mã đơn</th>
                <th>Tổng tiền</th>
                <th>Trạng thái</th>
                <th />
              </tr>
            </thead>
            <tbody>
              {orders.data?.items.map((o) => (
                <tr key={o.id}>
                  <td>#{o.id}</td>
                  <td>{money(o.total)}</td>
                  <td>
                    <Badge status={o.status} />
                  </td>
                  <td>
                    <Link to={`/admin/orders/${o.id}`}>Chi tiết ↗</Link>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          {!orders.data?.items.length && <div className="state">Chưa có đơn hàng.</div>}
        </div>
        <Pager page={page} total={orders.data?.total || 0} onChange={setPage} />
      </DataState>
    </>
  );
}
