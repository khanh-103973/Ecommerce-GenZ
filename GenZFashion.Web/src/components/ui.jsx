import { RefreshCw } from 'lucide-react';
import { statusLabels } from '../api.js';

export function DataState({ state, children }) {
  return state.loading ? (
    <div className="state">Đang tải dữ liệu…</div>
  ) : state.error ? (
    <div className="state error" role="alert">
      {state.error}
      <button className="outline" onClick={state.reload}>
        <RefreshCw size={15} /> Thử lại
      </button>
    </div>
  ) : (
    children
  );
}

export function Field({ label, ...props }) {
  return (
    <label className="field">
      <span>{label}</span>
      <input {...props} />
    </label>
  );
}

export function Badge({ status }) {
  return <span className={`badge ${status}`}>{statusLabels[status] || status}</span>;
}

export function Pager({ page, total, pageSize = 10, onChange }) {
  const pages = Math.max(1, Math.ceil(total / pageSize));
  return (
    <div className="pager">
      <span>
        {total} kết quả · Trang {page}/{pages}
      </span>
      <button className="outline" disabled={page <= 1} onClick={() => onChange(page - 1)}>
        Trước
      </button>
      <button className="outline" disabled={page >= pages} onClick={() => onChange(page + 1)}>
        Sau
      </button>
    </div>
  );
}
