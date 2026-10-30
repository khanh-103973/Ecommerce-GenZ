import { useState } from 'react';
import { Link, NavLink } from 'react-router-dom';
import { ArrowUpRight, ShoppingBag, UserRound, LogOut, Menu, X } from 'lucide-react';
import { useAuth } from '../context/AuthContext.jsx';

export function Header() {
  const { user, logout } = useAuth();
  const [open, setOpen] = useState(false);
  return (
    <>
      <div className="ticker">
        GEN Z. YOUR RULES. <span>✳</span> THỜI TRANG THEO CÁCH CỦA BẠN <span>✳</span> GENZ FASHION
      </div>
      <header className="header">
        <Link className="logo" to="/">
          GZ<span>.</span>STORE<sup>DEMO</sup>
        </Link>
        <button className="icon mobile" aria-label="Mở menu" onClick={() => setOpen(!open)}>
          {open ? <X /> : <Menu />}
        </button>
        <nav className={open ? 'open' : ''} onClick={() => setOpen(false)}>
          <NavLink to="/" end>
            Trang chủ
          </NavLink>
          <NavLink to="/shop">Khám phá</NavLink>
          {user?.roles.includes('Customer') && <NavLink to="/orders">Đơn của tôi</NavLink>}
          {user?.roles.includes('Admin') && (
            <NavLink to="/admin">
              Quản trị <ArrowUpRight size={14} />
            </NavLink>
          )}
        </nav>
        <div className="header-actions">
          {user ? (
            <>
              <span className="user-name">{user.fullName}</span>
              <button className="icon" title="Đăng xuất" aria-label="Đăng xuất" onClick={logout}>
                <LogOut size={19} />
              </button>
            </>
          ) : (
            <Link className="icon" to="/login" aria-label="Đăng nhập">
              <UserRound size={21} />
            </Link>
          )}
          <Link className="icon" to="/cart" aria-label="Giỏ hàng">
            <ShoppingBag size={21} />
          </Link>
        </div>
      </header>
    </>
  );
}

export function Footer() {
  return (
    <footer>
      <Link className="logo" to="/">
        GZ<span>.</span>STORE
      </Link>
      <p>
        Wear your own way.
        <br />
        <small>Dự án thực hành GenZ Fashion · Dữ liệu demo synthetic</small>
      </p>
      <Link to="/shop">
        Khám phá sản phẩm <ArrowUpRight size={18} />
      </Link>
    </footer>
  );
}

export function StoreLayout({ children }) {
  return (
    <>
      <Header />
      {children}
      <Footer />
    </>
  );
}
