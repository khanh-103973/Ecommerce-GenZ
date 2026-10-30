import { useState } from 'react';

import { api } from '../../api.js';
import { useData } from '../../hooks/useData.js';
import { useTask } from '../../hooks/useTask.jsx';
import { DataState, Field } from '../../components/ui.jsx';

export function LookupAdmin({ resource, label }) {
  const state = useData(`/admin/${resource}`);
  const [editing, setEditing] = useState(null);
  const [formVersion, setFormVersion] = useState(0);
  const task = useTask();
  return (
    <>
      <div className="section-heading">
        <div>
          <span className="eyebrow">CATALOG SETTINGS</span>
          <h1>{label}</h1>
        </div>
      </div>
      {task.notice}
      <div className="panel">
        <form
          key={`${editing?.id || 'new'}-${formVersion}`}
          className="inline-form"
          onSubmit={(e) => {
            e.preventDefault();
            const body = Object.fromEntries(new FormData(e.currentTarget));
            task.run(async () => {
              await api(`/admin/${resource}${editing ? `/${editing.id}` : ''}`, {
                method: editing ? 'PUT' : 'POST',
                body,
              });
              setEditing(null);
              setFormVersion((v) => v + 1);
              state.reload();
            });
          }}
        >
          <Field
            label={editing ? 'Đổi tên' : 'Thêm mới'}
            name="name"
            required
            maxLength={100}
            defaultValue={editing?.name || ''}
          />
          <button className="primary" disabled={task.busy}>
            {editing ? 'Lưu' : 'Thêm'}
          </button>
          {editing && (
            <button type="button" className="outline" onClick={() => setEditing(null)}>
              Đóng
            </button>
          )}
        </form>
      </div>
      <DataState state={state}>
        <div className="panel table-wrap">
          <table>
            <thead>
              <tr>
                <th>Mã</th>
                <th>Tên</th>
                <th>Thao tác</th>
              </tr>
            </thead>
            <tbody>
              {state.data?.map((x) => (
                <tr key={x.id}>
                  <td>#{x.id}</td>
                  <td>{x.name}</td>
                  <td>
                    <button className="text-link" onClick={() => setEditing(x)}>
                      Sửa
                    </button>
                    <button
                      className="text-link danger"
                      disabled={task.busy}
                      onClick={() => {
                        if (
                          window.confirm(
                            `Xóa ${x.name}? Chỉ xóa được khi chưa có sản phẩm sử dụng.`
                          )
                        )
                          task.run(async () => {
                            await api(`/admin/${resource}/${x.id}`, { method: 'DELETE' });
                            state.reload();
                          });
                      }}
                    >
                      Xóa
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          {!state.data?.length && <div className="state">Chưa có dữ liệu.</div>}
        </div>
      </DataState>
    </>
  );
}
