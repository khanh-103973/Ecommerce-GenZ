import { useState } from 'react';
import { Link } from 'react-router-dom';
import { ArrowUpRight, Plus } from 'lucide-react';
import { useData } from '../../hooks/useData.js';
import { DataState, Pager } from '../../components/ui.jsx';

export function AdminProducts() {
  const [page, setPage] = useState(1);
  const state = useData(`/admin/products?page=${page}`);
  return (
    <>
      <div className="section-heading">
        <div>
          <span className="eyebrow">CATALOG MANAGEMENT</span>
          <h1>Sản phẩm</h1>
        </div>
        <Link className="primary" to="/admin/products/new">
          <Plus size={17} /> Thêm sản phẩm
        </Link>
      </div>
      <DataState state={state}>
        <div className="panel table-wrap">
          <table>
            <thead>
              <tr>
                <th>Mã</th>
                <th>Tên sản phẩm</th>
                <th>Trạng thái</th>
                <th />
              </tr>
            </thead>
            <tbody>
              {state.data?.items.map((p) => (
                <tr key={p.id}>
                  <td>#{p.id}</td>
                  <td>{p.name}</td>
                  <td>
                    <span className={`badge ${p.isActive ? 'Completed' : 'Cancelled'}`}>
                      {p.isActive ? 'Đang bán' : 'Đang ẩn'}
                    </span>
                  </td>
                  <td>
                    <Link className="text-link" to={`/admin/products/${p.id}`}>
                      Quản lý <ArrowUpRight size={14} />
                    </Link>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          {!state.data?.items.length && <div className="state">Chưa có sản phẩm.</div>}
        </div>
        <Pager page={page} total={state.data?.total || 0} onChange={setPage} />
      </DataState>
    </>
  );
}
