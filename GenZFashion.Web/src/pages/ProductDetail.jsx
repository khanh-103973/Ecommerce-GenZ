import { useEffect, useState } from 'react';
import { Link, useParams, useNavigate } from 'react-router-dom';
import { ArrowRight, ShoppingBag, ChevronLeft } from 'lucide-react';
import { api, money } from '../api.js';
import { useAuth } from '../context/AuthContext.jsx';
import { useData } from '../hooks/useData.js';
import { useTask } from '../hooks/useTask.jsx';
import { DataState, Field } from '../components/ui.jsx';
import { ProductArt } from '../components/ProductArt.jsx';

export function ProductDetail() {
  const { id } = useParams();
  const state = useData(`/products/${id}`);
  const [variantId, setVariantId] = useState(''),
    [quantity, setQuantity] = useState(1),
    [imageIndex, setImageIndex] = useState(0);
  const { user } = useAuth();
  const task = useTask();
  const navigate = useNavigate();
  useEffect(() => {
    setVariantId('');
    setQuantity(1);
    setImageIndex(0);
  }, [id]);
  const product = state.data;
  const selected = product?.variants.find((v) => String(v.id) === variantId);
  return (
    <main className="section">
      <Link className="back" to="/shop">
        <ChevronLeft size={16} /> Bộ sưu tập
      </Link>
      <DataState state={state}>
        {product && (
          <div className="detail-grid">
            <div>
              <ProductArt
                className="detail-art"
                url={product.images[imageIndex]?.url}
                name={product.images[imageIndex]?.altText || product.name}
              />
              {product.images.length > 1 && (
                <div className="thumbnails">
                  {product.images.map((image, i) => (
                    <button
                      key={image.id}
                      aria-label={`Xem ảnh ${i + 1}`}
                      className={i === imageIndex ? 'selected' : ''}
                      onClick={() => setImageIndex(i)}
                    >
                      <ProductArt url={image.url} name={image.altText} />
                    </button>
                  ))}
                </div>
              )}
            </div>
            <div className="detail-info">
              <span className="eyebrow">{product.brandName}</span>
              <h1>{product.name}</h1>
              <p className="description">{product.description}</p>
              <div className="price">
                {selected
                  ? money(selected.price)
                  : product.variants.length
                    ? `Từ ${money(Math.min(...product.variants.map((v) => v.price)))}`
                    : 'Chưa có biến thể'}
              </div>
              <span className="field-label">CHỌN SIZE / MÀU</span>
              <div className="variants">
                {product.variants.map((v) => (
                  <button
                    key={v.id}
                    disabled={!v.stockQuantity}
                    className={variantId === String(v.id) ? 'selected' : ''}
                    onClick={() => setVariantId(String(v.id))}
                  >
                    {v.size} / {v.color}
                    {!v.stockQuantity ? ' · Hết hàng' : ''}
                  </button>
                ))}
              </div>
              {selected && <p className="muted">Còn {selected.stockQuantity} sản phẩm</p>}
              <div className="buy-row">
                <Field
                  label="Số lượng"
                  type="number"
                  min="1"
                  max={Math.min(selected?.stockQuantity || 99, 99)}
                  value={quantity}
                  onChange={(e) => setQuantity(Number(e.target.value))}
                />
                <button
                  className="primary"
                  disabled={
                    task.busy ||
                    !selected ||
                    !Number.isInteger(quantity) ||
                    quantity < 1 ||
                    quantity > Math.min(selected.stockQuantity, 99)
                  }
                  onClick={() => {
                    if (!user) {
                      navigate('/login', {
                        state: { from: `/products/${id}`, requiredRole: 'Customer' },
                      });
                      return;
                    }
                    if (!user.roles.includes('Customer')) {
                      task.run(async () => {
                        throw new Error('Vui lòng dùng tài khoản Customer để mua hàng.');
                      });
                      return;
                    }
                    task.run(
                      () => api(`/cart/items/${variantId}`, { method: 'PUT', body: { quantity } }),
                      'Đã lưu số lượng vào giỏ hàng.'
                    );
                  }}
                >
                  <ShoppingBag size={18} /> {task.busy ? 'Đang lưu…' : 'Thêm vào giỏ'}
                </button>
              </div>
              {task.notice}
              <Link className="text-link" to="/cart">
                Xem giỏ hàng <ArrowRight size={16} />
              </Link>
              <div className="detail-perks">
                <p>01 / Thanh toán khi nhận hàng (COD)</p>
                <p>02 / Phí giao hàng demo: 0đ</p>
                <p>03 / Giá và tồn kho được xác nhận khi đặt đơn</p>
              </div>
            </div>
          </div>
        )}
      </DataState>
    </main>
  );
}
