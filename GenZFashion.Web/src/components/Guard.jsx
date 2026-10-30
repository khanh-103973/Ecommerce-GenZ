import { Link, Navigate, useLocation } from 'react-router-dom';
import { useAuth } from '../context/AuthContext.jsx';

export function Guard({ role, children }) {
  const { user } = useAuth();
  const location = useLocation();
  return !user ? (
    <Navigate
      to="/login"
      state={{ from: location.pathname + location.search + location.hash, requiredRole: role }}
      replace
    />
  ) : !user.roles.includes(role) ? (
    <main className="section state">
      Tài khoản của bạn không có quyền vào khu vực này.{' '}
      <Link to={role === 'Customer' ? '/admin' : '/shop'}>Quay lại</Link>
    </main>
  ) : (
    children
  );
}
