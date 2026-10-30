import { useState } from 'react';
import { Link } from 'react-router-dom';
import { ArrowUpRight, Search } from 'lucide-react';
import { money } from '../../api.js';
import { useData } from '../../hooks/useData.js';
import { DataState, Pager } from '../../components/ui.jsx';

export function Customers() {
  const [search, setSearch] = useState(''),
    [term, setTerm] = useState(''),
    [page, setPage] = useState(1);
  const state = useData(`/admin/customers?page=${page}&search=${encodeURIComponent(term)}`);
  return (
    <>
      <div className="section-heading">
        <div>
          <span className="eyebrow">YOUR COMMUNITY</span>
          <h1>Khách hàng</h1>
        </div>
        <form
          className="search"
          onSubmit={(e) => {
            e.preventDefault();
            setTerm(search);
            setPage(1);
          }}
        >
          <Search size={17} />
          <input
            aria-label="Tìm khách hàng"
            placeholder="Tên hoặc email…"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
          />
          <button>Tìm</button>
        </form>
      </div>
      <DataState state={state}>
        <div className="panel table-wrap">
          <table>
            <thead>
              <tr>
                <th>Khách hàng</th>
                <th>Email</th>
                <th>Số đơn</th>
                <th>Chi tiêu hoàn tất</th>
                <th />
              </tr>
            </thead>
            <tbody>
              {state.data?.items.map((c) => (
                <tr key={c.id}>
                  <td>{c.fullName}</td>
                  <td>{c.email}</td>
                  <td>{c.orderCount}</td>
                  <td>{money(c.completedSpend)}</td>
                  <td>
                    <Link className="text-link" to={`/admin/customers/${c.id}`}>
                      Chi tiết <ArrowUpRight size={14} />
                    </Link>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          {!state.data?.items.length && <div className="state">Không tìm thấy khách hàng.</div>}
        </div>
        <Pager page={page} total={state.data?.total || 0} onChange={setPage} />
      </DataState>
    </>
  );
}
