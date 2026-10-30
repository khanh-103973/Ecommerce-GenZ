import { createContext, useContext, useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { api, setToken } from '../api.js';

const Auth = createContext(null);

export const useAuth = () => useContext(Auth);

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  const [expired, setExpired] = useState(false);
  useEffect(() => {
    const fn = () => {
      setUser(null);
      setExpired(true);
    };
    window.addEventListener('auth-expired', fn);
    return () => window.removeEventListener('auth-expired', fn);
  }, []);
  async function login(email, password) {
    const result = await api('/auth/login', { method: 'POST', body: { email, password } });
    setToken(result.accessToken);
    try {
      const profile = await api('/auth/me');
      setUser(profile);
      setExpired(false);
      return profile;
    } catch (e) {
      setToken(null);
      throw e;
    }
  }
  const logout = () => {
    setToken(null);
    setUser(null);
  };
  return (
    <Auth.Provider value={{ user, login, logout }}>
      {expired && (
        <div className="expired">
          Phiên đăng nhập đã hết hạn. <Link to="/login">Đăng nhập lại</Link>
        </div>
      )}
      {children}
    </Auth.Provider>
  );
}
