import { useState } from 'react';
import { Navigate, useNavigate, useLocation } from 'react-router-dom';
import { ArrowRight } from 'lucide-react';
import { api } from '../api.js';
import { loginDestination } from '../auth-navigation.js';
import { useAuth } from '../context/AuthContext.jsx';
import { useTask } from '../hooks/useTask.jsx';
import { Field } from '../components/ui.jsx';

export function Login() {
  const location = useLocation();
  const [register, setRegister] = useState(false);
  const { user, login } = useAuth();
  const task = useTask();
  const navigate = useNavigate();
  if (user) return <Navigate to={loginDestination(user, location.state)} replace />;
  return (
    <main className="auth-page">
      <div className="auth-art">
        <span className="eyebrow">WELCOME TO THE CLUB</span>
        <h1>
          BE YOU.
          <br />
          WEAR YOU.
        </h1>
        <span className="auth-star">✳</span>
        <p>Một tài khoản. Cả thế giới phong cách.</p>
      </div>
      <form
        className="auth-form"
        onSubmit={(e) => {
          e.preventDefault();
          const values = Object.fromEntries(new FormData(e.currentTarget));
          task.run(async () => {
            if (register) await api('/auth/register', { method: 'POST', body: values });
            const profile = await login(values.email, values.password);
            navigate(loginDestination(profile, location.state), { replace: true });
          }, '');
        }}
      >
        <span className="eyebrow">GZ MEMBERS</span>
        <h2>{register ? 'Tạo tài khoản' : 'Chào bạn trở lại.'}</h2>
        <p className="muted">
          {register ? 'Đăng ký để bắt đầu mua sắm.' : 'Đăng nhập để tiếp tục hành trình của bạn.'}
        </p>
        {register && (
          <Field label="Họ và tên" name="fullName" required maxLength={100} autoComplete="name" />
        )}
        <Field
          label="Email"
          name="email"
          type="email"
          required
          maxLength={256}
          autoComplete="username"
        />
        <Field
          label="Mật khẩu"
          name="password"
          type="password"
          required
          minLength={register ? 10 : 1}
          maxLength={128}
          autoComplete={register ? 'new-password' : 'current-password'}
        />
        {register && (
          <small>Mật khẩu từ 10 ký tự, gồm chữ hoa, chữ thường, số và ký tự đặc biệt.</small>
        )}
        {task.notice}
        <button className="primary" disabled={task.busy}>
          {task.busy ? 'Đang xử lý…' : register ? 'Tạo tài khoản' : 'Đăng nhập'}{' '}
          <ArrowRight size={18} />
        </button>
        <button type="button" className="text-link" onClick={() => setRegister(!register)}>
          {register ? 'Đã có tài khoản? Đăng nhập' : 'Chưa có tài khoản? Đăng ký'}
        </button>
      </form>
    </main>
  );
}
