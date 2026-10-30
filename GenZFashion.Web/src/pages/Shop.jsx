import { useState } from 'react';
import { Search, SlidersHorizontal } from 'lucide-react';
import { useData } from '../hooks/useData.js';
import { DataState, Pager } from '../components/ui.jsx';
import { ProductCard } from '../components/ProductCard.jsx';

export function Shop() {
  const [search, setSearch] = useState(''),
    [term, setTerm] = useState('');
  const [category, setCategory] = useState(''),
    [brand, setBrand] = useState('');
  const [page, setPage] = useState(1),
    [sortBy, setSortBy] = useState('newest');
  const [inStockOnly, setInStockOnly] = useState(false);
  const lookups = useData('/catalog');
  const params = new URLSearchParams({
    page: String(page),
    pageSize: '12',
    sortBy,
    inStockOnly: String(inStockOnly),
    ...(term ? { search: term } : {}),
    ...(category ? { categoryId: category } : {}),
    ...(brand ? { brandId: brand } : {}),
  });
  const state = useData(`/products?${params}`);
  function resetFilters() {
    setSearch('');
    setTerm('');
    setCategory('');
    setBrand('');
    setSortBy('newest');
    setInStockOnly(false);
    setPage(1);
  }
  return (
    <main className="section shop">
      <span className="eyebrow">FIND YOUR NEXT FAVORITE</span>
      <h1 className="page-title">
        THE COLLECTION<span>.</span>
      </h1>
      <div className="filters">
        <form
          onSubmit={(e) => {
            e.preventDefault();
            setTerm(search);
            setPage(1);
          }}
          className="search"
        >
          <Search size={18} />
          <input
            aria-label="Tìm sản phẩm"
            placeholder="Tìm sản phẩm…"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
          />
          <button type="submit">Tìm</button>
        </form>
        <SlidersHorizontal size={18} />
        <select
          aria-label="Danh mục"
          value={category}
          onChange={(e) => {
            setCategory(e.target.value);
            setPage(1);
          }}
        >
          <option value="">Tất cả danh mục</option>
          {lookups.data?.categories.map((c) => (
            <option key={c.id} value={c.id}>
              {c.name}
            </option>
          ))}
        </select>
        <select
          aria-label="Thương hiệu"
          value={brand}
          onChange={(e) => {
            setBrand(e.target.value);
            setPage(1);
          }}
        >
          <option value="">Tất cả thương hiệu</option>
          {lookups.data?.brands.map((c) => (
            <option key={c.id} value={c.id}>
              {c.name}
            </option>
          ))}
        </select>
      </div>
      <div className="collection-toolbar">
        <label className="check">
          <input
            type="checkbox"
            checked={inStockOnly}
            onChange={(e) => {
              setInStockOnly(e.target.checked);
              setPage(1);
            }}
          />{' '}
          Chỉ hiện sản phẩm còn hàng
        </label>
        <button className="text-link" onClick={resetFilters}>
          Xóa bộ lọc
        </button>
        <label className="sort-control">
          Sắp xếp
          <select
            aria-label="Sắp xếp sản phẩm"
            value={sortBy}
            onChange={(e) => {
              setSortBy(e.target.value);
              setPage(1);
            }}
          >
            <option value="newest">Mới nhất</option>
            <option value="priceAsc">Giá thấp đến cao</option>
            <option value="priceDesc">Giá cao đến thấp</option>
            <option value="name">Tên sản phẩm A–Z</option>
          </select>
        </label>
      </div>
      {lookups.error && <p className="notice error">Không tải được bộ lọc: {lookups.error}</p>}
      <DataState state={state}>
        {state.data?.items.length ? (
          <div className="product-grid">
            {state.data.items.map((p) => (
              <ProductCard key={p.id} product={p} />
            ))}
          </div>
        ) : (
          <div className="state">
            Không tìm thấy sản phẩm phù hợp.
            <button className="outline" onClick={resetFilters}>
              Xóa bộ lọc
            </button>
          </div>
        )}
        <Pager page={page} total={state.data?.total || 0} pageSize={12} onChange={setPage} />
      </DataState>
    </main>
  );
}
