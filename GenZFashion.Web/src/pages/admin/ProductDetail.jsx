import { useState } from 'react';
import { Link, useParams, useNavigate } from 'react-router-dom';
import { RefreshCw, ChevronLeft } from 'lucide-react';
import { api, money } from '../../api.js';
import { useData } from '../../hooks/useData.js';
import { useTask } from '../../hooks/useTask.jsx';
import { DataState, Field } from '../../components/ui.jsx';
import { ProductArt } from '../../components/ProductArt.jsx';
import { ProductForm, VariantForm } from './ProductForms.jsx';

export function AdminProductDetail() {
  const { id } = useParams();
  const isNew = id === 'new';
  const state = useData(isNew ? null : `/admin/products/${id}`);
  const lookups = useData('/admin/products/lookups');
  const task = useTask();
  const navigate = useNavigate();
  const [editing, setEditing] = useState(null);
  const [imageEdit, setImageEdit] = useState(null);
  const [imageFormVersion, setImageFormVersion] = useState(0);
  function saveProduct(body) {
    task.run(async () => {
      if (isNew) {
        const result = await api('/admin/products', { method: 'POST', body });
        navigate(`/admin/products/${result.id}`);
      } else {
        await api(`/admin/products/${id}`, { method: 'PUT', body });
        state.reload();
      }
    });
  }
  return (
    <>
      <Link className="back" to="/admin/products">
        <ChevronLeft size={16} /> Danh sách sản phẩm
      </Link>
      <div className="section-heading">
        <h1>{isNew ? 'Thêm sản phẩm' : 'Quản lý sản phẩm'}</h1>
        {!isNew && (
          <button
            className="outline"
            onClick={() => {
              setEditing(null);
              state.reload();
            }}
          >
            <RefreshCw size={16} /> Tải lại
          </button>
        )}
      </div>
      {task.notice}
      <DataState state={lookups}>
        <DataState state={state}>
          {lookups.data && (isNew || state.data) && (
            <>
              <div className="panel">
                <h2>Thông tin chung</h2>
                <ProductForm
                  key={state.data ? JSON.stringify(state.data) : 'new'}
                  product={state.data}
                  lookups={lookups.data}
                  onSave={saveProduct}
                  busy={task.busy}
                />
              </div>
              {!isNew && (
                <>
                  <div className="panel">
                    <h2>Biến thể & tồn kho</h2>
                    <div className="table-wrap">
                      <table>
                        <thead>
                          <tr>
                            <th>SKU</th>
                            <th>Size / Màu</th>
                            <th>Giá</th>
                            <th>Tồn</th>
                            <th>Trạng thái</th>
                            <th />
                          </tr>
                        </thead>
                        <tbody>
                          {state.data.variants.map((v) => (
                            <tr key={v.id}>
                              <td>{v.sku}</td>
                              <td>
                                {v.size} / {v.color}
                              </td>
                              <td>{money(v.price)}</td>
                              <td>{v.stockQuantity}</td>
                              <td>{v.isActive ? 'Đang bán' : 'Đang ẩn'}</td>
                              <td>
                                <button className="text-link" onClick={() => setEditing(v)}>
                                  Sửa
                                </button>
                              </td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                    <h3>{editing ? 'Sửa biến thể' : 'Thêm biến thể'}</h3>
                    <VariantForm
                      key={editing?.id || 'new'}
                      variant={editing}
                      busy={task.busy}
                      onCancel={editing ? () => setEditing(null) : null}
                      onSave={(body) =>
                        task.run(async () => {
                          await api(
                            `/admin/products/${id}/variants${editing ? `/${editing.id}` : ''}`,
                            { method: editing ? 'PUT' : 'POST', body }
                          );
                          setEditing(null);
                          state.reload();
                        })
                      }
                    />
                  </div>
                  <div className="panel">
                    <h2>Ảnh sản phẩm</h2>
                    <p className="muted">
                      Ảnh có thứ tự nhỏ nhất là ảnh đại diện. Chỉ nhận URL HTTPS.
                    </p>
                    <div className="image-admin-list">
                      {state.data.images.map((img) => (
                        <div key={img.id}>
                          <ProductArt url={img.url} name={img.altText} />
                          <p>
                            {img.altText || 'Chưa có mô tả'} · Thứ tự {img.sortOrder}
                          </p>
                          <button className="text-link" onClick={() => setImageEdit(img)}>
                            Sửa
                          </button>
                          <button
                            className="text-link danger"
                            disabled={task.busy}
                            onClick={() => {
                              if (window.confirm('Xóa đường dẫn ảnh này khỏi sản phẩm?'))
                                task.run(async () => {
                                  await api(`/admin/products/${id}/images/${img.id}`, {
                                    method: 'DELETE',
                                  });
                                  setImageEdit(null);
                                  setImageFormVersion((v) => v + 1);
                                  state.reload();
                                });
                            }}
                          >
                            Xóa
                          </button>
                        </div>
                      ))}
                    </div>
                    <form
                      key={`${imageEdit?.id || 'new'}-${imageFormVersion}`}
                      className="form-grid"
                      onSubmit={(e) => {
                        e.preventDefault();
                        const values = Object.fromEntries(new FormData(e.currentTarget));
                        task.run(async () => {
                          await api(
                            `/admin/products/${id}/images${imageEdit ? `/${imageEdit.id}` : ''}`,
                            {
                              method: imageEdit ? 'PUT' : 'POST',
                              body: { ...values, sortOrder: Number(values.sortOrder) },
                            }
                          );
                          setImageEdit(null);
                          setImageFormVersion((v) => v + 1);
                          state.reload();
                        });
                      }}
                    >
                      <Field
                        label="URL ảnh HTTPS"
                        name="url"
                        type="url"
                        required
                        pattern="https://.*"
                        maxLength={2048}
                        defaultValue={imageEdit?.url || ''}
                      />
                      <Field
                        label="Mô tả ảnh"
                        name="altText"
                        maxLength={200}
                        defaultValue={imageEdit?.altText || ''}
                      />
                      <Field
                        label="Thứ tự"
                        name="sortOrder"
                        type="number"
                        min="0"
                        max="2147483647"
                        step="1"
                        required
                        defaultValue={imageEdit?.sortOrder ?? 0}
                      />
                      <button className="primary" disabled={task.busy}>
                        {imageEdit ? 'Lưu ảnh' : 'Thêm ảnh'}
                      </button>
                      {imageEdit && (
                        <button
                          className="outline"
                          type="button"
                          onClick={() => setImageEdit(null)}
                        >
                          Đóng
                        </button>
                      )}
                    </form>
                  </div>
                </>
              )}
            </>
          )}
        </DataState>
      </DataState>
    </>
  );
}
