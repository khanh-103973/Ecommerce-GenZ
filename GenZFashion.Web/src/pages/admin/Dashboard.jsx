import { Link } from 'react-router-dom';
import { ArrowUpRight, ShoppingBag, Package, ClipboardList, Plus, RefreshCw } from 'lucide-react';
import { money, statusLabels } from '../../api.js';
import { useData } from '../../hooks/useData.js';
import { DataState } from '../../components/ui.jsx';

export function Dashboard() {
  const state = useData('/admin/dashboard');
  const d = state.data;
  return (
    <>
      <div className="section-heading">
        <div>
          <span className="eyebrow">YOUR STORE AT A GLANCE</span>
          <h1>Tổng quan cửa hàng</h1>
          <p className="muted">Mọi con số, một góc nhìn.</p>
        </div>
        <button className="outline" onClick={state.reload}>
          <RefreshCw size={16} /> Cập nhật
        </button>
      </div>
      <DataState state={state}>
        {d && (
          <>
            <div className="stats">
              <div className="stat highlight">
                <span>Doanh thu hoàn tất</span>
                <strong>{money(d.completedRevenue)}</strong>
                <small>Tổng doanh thu từ đơn hoàn tất</small>
                <ArrowUpRight />
              </div>
              <div className="stat">
                <span>Tổng đơn hàng</span>
                <strong>{d.totalOrders}</strong>
                <small>{d.ordersByStatus.Pending} đơn chờ xác nhận</small>
                <ClipboardList />
              </div>
              <div className="stat">
                <span>Sản phẩm đang bán</span>
                <strong>{d.activeProducts}</strong>
                <small>{d.hiddenProducts} sản phẩm đang ẩn</small>
                <Package />
              </div>
              <div className="stat">
                <span>Biến thể tồn thấp</span>
                <strong>{d.lowStockCount}</strong>
                <small>Còn tối đa {d.lowStockThreshold} chiếc</small>
                <ShoppingBag />
              </div>
            </div>
            <div className="dashboard-grid">
              <div className="panel">
                <div className="section-heading">
                  <h2>Trạng thái đơn hàng</h2>
                  <Link to="/admin/orders">
                    <ArrowUpRight size={20} />
                  </Link>
                </div>
                <div className="status-chart">
                  {Object.entries(d.ordersByStatus).map(([key, count]) => (
                    <div className="status-bar" key={key}>
                      <span>{statusLabels[key]}</span>
                      <div>
                        <i
                          style={{ width: `${d.totalOrders ? (count / d.totalOrders) * 100 : 0}%` }}
                        />
                      </div>
                      <b>{count}</b>
                    </div>
                  ))}
                </div>
                <p className="muted">Số liệu toàn thời gian · VND</p>
              </div>
              <div className="panel dashboard-note">
                <span className="eyebrow">MAKE IT YOURS</span>
                <h2>
                  Quản lý gọn.
                  <br />
                  Phong cách riêng.
                </h2>
                <p>Thêm sản phẩm, cập nhật tồn kho và xử lý đơn hàng từ một nơi.</p>
                <Link className="primary" to="/admin/products/new">
                  Thêm sản phẩm <Plus size={18} />
                </Link>
              </div>
            </div>
            <div className="panel">
              <div className="section-heading">
                <h2>Cần chú ý tồn kho</h2>
                <small>{d.lowStockCount} biến thể · Hiện tối đa 20</small>
              </div>
              <div className="table-wrap">
                <table>
                  <thead>
                    <tr>
                      <th>Sản phẩm</th>
                      <th>SKU</th>
                      <th>Size / Màu</th>
                      <th>Tồn kho</th>
                      <th />
                    </tr>
                  </thead>
                  <tbody>
                    {d.lowStockVariants.map((v) => (
                      <tr key={v.id}>
                        <td>{v.productName}</td>
                        <td>{v.sku}</td>
                        <td>
                          {v.size} / {v.color}
                        </td>
                        <td>
                          <span className={`stock-count ${!v.stockQuantity ? 'zero' : ''}`}>
                            {v.stockQuantity}
                          </span>
                        </td>
                        <td>
                          <Link to={`/admin/products/${v.productId}`} className="text-link">
                            Cập nhật <ArrowUpRight size={14} />
                          </Link>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
                {!d.lowStockVariants.length && (
                  <div className="state">Chưa có biến thể tồn thấp.</div>
                )}
              </div>
            </div>
          </>
        )}
      </DataState>
    </>
  );
}
