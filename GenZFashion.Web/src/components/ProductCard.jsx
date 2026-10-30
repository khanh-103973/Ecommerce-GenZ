import { Link } from 'react-router-dom';
import { ArrowUpRight } from 'lucide-react';
import { money } from '../api.js';
import { ProductArt } from './ProductArt.jsx';

export function ProductCard({ product }) {
  return (
    <Link className="product-card" to={`/products/${product.id}`}>
      <ProductArt url={product.imageUrl} name={product.name} />
      <div className="product-meta">
        <span>{product.categoryName.replace(' [synthetic]', '')}</span>
        <ArrowUpRight size={18} />
      </div>
      <h3>{product.name}</h3>
      <p>
        {product.minPrice == null ? 'Chưa có giá' : money(product.minPrice)}
        {product.stockQuantity === 0 && <small>Hết hàng</small>}
      </p>
    </Link>
  );
}
