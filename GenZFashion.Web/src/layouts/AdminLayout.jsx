import { Link, NavLink } from 'react-router-dom';
import {
  ArrowUpRight,
  LayoutDashboard,
  Package,
  ClipboardList,
  Users,
  Tags,
  LogOut,
} from 'lucide-react';
import { useAuth } from '../context/AuthContext.jsx';

const adminNav = [
  ['/admin', 'Tổng quan', LayoutDashboard],
  ['/admin/products', 'Sản phẩm', Package],
  ['/admin/orders', 'Đơn hàng', ClipboardList],
  ['/admin/customers', 'Khách hàng', Users],
  ['/admin/categories', 'Danh mục', Tags],
  ['/admin/brands', 'Thương hiệu', Tags],
];

export function AdminLayout({ children }) {
  const { user, logout } = useAuth();
  return (
    <div className="admin-shell">
      <aside className="sidebar">
        <Link className="logo" to="/">
          GZ<span>.</span>STORE
        </Link>
        <span className="sidebar-label">KHÔNG GIAN QUẢN TRỊ</span>
        <nav>
          {adminNav.map(([path, label, Icon]) => (
            <NavLink key={path} to={path} end={path === '/admin'}>
              <Icon size={19} />
              {label}
            </NavLink>
          ))}
        </nav>
        <div className="sidebar-bottom">
          <Link to="/shop">
            <ArrowUpRight size={17} /> Xem cửa hàng
          </Link>
          <button onClick={logout}>
            <LogOut size={17} /> Đăng xuất
          </button>
        </div>
      </aside>
      <div className="admin-main">
        <header className="admin-top">
          <span>GENZ FASHION / ADMIN</span>
          <span>
            <span className="online-dot" /> {user.fullName}{' '}
            <button className="icon admin-mobile-logout" aria-label="Đăng xuất" onClick={logout}>
              <LogOut size={16} />
            </button>
          </span>
        </header>
        <main className="admin-content">{children}</main>
      </div>
    </div>
  );
}
