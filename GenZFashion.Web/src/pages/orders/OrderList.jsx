import { useState } from 'react';
import { Link } from 'react-router-dom';
import { ArrowUpRight } from 'lucide-react';
import { money, statusLabels } from '../../api.js';
import { useData } from '../../hooks/useData.js';
import { DataState, Badge, Pager } from '../../components/ui.jsx';

export function OrderList({ admin = false }) {
  const [page, setPage] = useState(1),
    [status, setStatus] = useState('');
  const state = useData(
    `${admin ? '/admin' : ''}/orders?page=${page}&pageSize=10${status ? `&status=${status}` : ''}`
  );
  return (
    <>
      <div className="section-heading">
        <div>
          <span className="eyebrow">{admin ? 'ORDER MANAGEMENT' : 'YOUR PURCHASES'}</span>
          <h1>{admin ? 'Quản lý đơn hàng' : 'Đơn hàng của tôi'}</h1>
        </div>
        {admin && (
          <select
            aria-label="Lọc trạng thái"
            value={status}
            onChange={(e) => {
              setStatus(e.target.value);
              setPage(1);
            }}
          >
            <option value="">Tất cả trạng thái</option>
            {Object.entries(statusLabels).map(([key, label]) => (
              <option key={key} value={key}>
                {label}
              </option>
            ))}
          </select>
        )}
      </div>
      <DataState state={state}>
        <div className="table-wrap">
          <table>
            <thead>
              <tr>
                <th>Mã đơn</th>
                {admin && <th>Người nhận</th>}
                <th>Ngày đặt</th>
                <th>Tổng tiền</th>
                <th>Trạng thái</th>
                <th />
              </tr>
            </thead>
            <tbody>
              {state.data?.items.map((o) => (
                <tr key={o.id}>
                  <td>#{o.id}</td>
                  {admin && <td>{o.recipientName}</td>}
                  <td>
                    {new Date(
                      o.createdAt + 'Z'.repeat(!o.createdAt.endsWith('Z'))
                    ).toLocaleDateString('vi-VN')}
                  </td>
                  <td>{money(o.total)}</td>
                  <td>
                    <Badge status={o.status} />
                  </td>
                  <td>
                    <Link className="text-link" to={`${admin ? '/admin' : ''}/orders/${o.id}`}>
                      Chi tiết <ArrowUpRight size={14} />
                    </Link>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          {!state.data?.items.length && <div className="state">Chưa có đơn hàng.</div>}
        </div>
        <Pager page={page} total={state.data?.total || 0} onChange={setPage} />
      </DataState>
    </>
  );
}
