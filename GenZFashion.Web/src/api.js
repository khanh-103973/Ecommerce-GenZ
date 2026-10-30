let token = null;
export function setToken(value) { token = value; }
export async function api(path, { method = 'GET', body, signal } = {}) {
  let response;
  try {
    response = await fetch(`/api${path}`, {
      method, signal,
      headers: { ...(body === undefined ? {} : { 'Content-Type': 'application/json' }), ...(token ? { Authorization: `Bearer ${token}` } : {}) },
      ...(body === undefined ? {} : { body: JSON.stringify(body) }),
    });
  } catch (error) {
    if (error.name === 'AbortError') throw error;
    throw new Error('Không kết nối được API. Kiểm tra backend đang chạy với profile https.');
  }
  const text = await response.text();
  let data;
  try { data = text ? JSON.parse(text) : null; } catch { data = null; }
  if (!response.ok) {
    if (response.status === 401 && token) {
      token = null; window.dispatchEvent(new Event('auth-expired'));
    }
    const details = data?.errors;
    const errors = Array.isArray(details) ? details.map(x => x.description) : Object.values(details || {}).flat();
    throw new Error(data?.detail || data?.message || errors.join(' ') || ({401:'Vui lòng đăng nhập lại.',403:'Tài khoản không có quyền thực hiện thao tác này.',404:'Không tìm thấy dữ liệu.',409:'Dữ liệu đã thay đổi. Tải lại trước khi thử lại.',429:'Bạn thao tác quá nhanh. Vui lòng thử lại sau một phút.'}[response.status]) || `Không thể thực hiện (HTTP ${response.status}).`);
  }
  return data;
}
export const money = value => new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND', maximumFractionDigits: 0 }).format(value ?? 0);
export const statusLabels = { Pending:'Chờ xác nhận', Confirmed:'Đã xác nhận', Shipping:'Đang giao', Completed:'Hoàn tất', Cancelled:'Đã hủy' };
