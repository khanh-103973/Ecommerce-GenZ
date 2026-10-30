import { Link } from 'react-router-dom';
import { ArrowUpRight, ArrowRight } from 'lucide-react';
import { useData } from '../hooks/useData.js';
import { DataState } from '../components/ui.jsx';
import { ProductArt } from '../components/ProductArt.jsx';
import { ProductCard } from '../components/ProductCard.jsx';

export function Home() {
  const state = useData('/products?pageSize=4&sortBy=newest');
  return (
    <>
      <section className="hero">
        <div className="hero-copy">
          <span className="eyebrow">THE EVERYDAY COLLECTION / 2026</span>
          <h1>
            YOUR STYLE.
            <br />
            YOUR <em>RULES.</em>
          </h1>
          <p>
            Mặc điều bạn thích. Chọn chất riêng.
            <br />
            Những món đồ cho mọi phiên bản của bạn.
          </p>
          <Link className="primary" to="/shop">
            Khám phá bộ sưu tập <ArrowUpRight size={20} />
          </Link>
          <div className="hero-note">
            <span>01 — 20</span> MỘT TỦ ĐỒ. NHIỀU CÁ TÍNH.
          </div>
        </div>
        <div className="hero-visual">
          <span className="sticker">
            NO RULES
            <br />
            JUST YOU ✳
          </span>
          <ProductArt name="Áo thun" />
          <div className="hero-tag">
            EVERYDAY
            <br />
            <b>ESSENTIALS.</b>
          </div>
          <span className="vertical-note">GEN Z FASHION — STUDIO EDITION</span>
        </div>
      </section>
      <div className="brand-strip">
        <span>✳ CHẤT RIÊNG MỖI NGÀY</span>
        <span>THANH TOÁN KHI NHẬN HÀNG</span>
        <span>KHÁM PHÁ PHONG CÁCH CỦA BẠN ↗</span>
      </div>
      <section className="section">
        <div className="section-heading">
          <div>
            <span className="eyebrow">THE EDIT</span>
            <h2>
              Lựa chọn mới mỗi ngày<span>.</span>
            </h2>
          </div>
          <Link to="/shop">
            Xem tất cả <ArrowRight size={18} />
          </Link>
        </div>
        <DataState state={state}>
          <div className="product-grid">
            {state.data?.items.map((p) => (
              <ProductCard key={p.id} product={p} />
            ))}
          </div>
        </DataState>
      </section>
      <section className="manifesto">
        <span>BE BOLD. BE YOURSELF.</span>
        <h2>
          Không cần giống ai.
          <br />
          Chỉ cần là bạn.
        </h2>
        <Link className="outline" to="/shop">
          Tìm phong cách của bạn <ArrowUpRight size={18} />
        </Link>
      </section>
    </>
  );
}
