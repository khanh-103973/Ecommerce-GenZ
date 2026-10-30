import { BrowserRouter, Routes, Route, Link } from 'react-router-dom';
import { AuthProvider } from './context/AuthContext.jsx';
import { Guard } from './components/Guard.jsx';
import { ScrollToTop } from './components/ScrollToTop.jsx';
import { StoreLayout } from './layouts/StoreLayout.jsx';
import { AdminLayout } from './layouts/AdminLayout.jsx';
import { Home } from './pages/Home.jsx';
import { Shop } from './pages/Shop.jsx';
import { ProductDetail } from './pages/ProductDetail.jsx';
import { Login } from './pages/Login.jsx';
import { Cart } from './pages/Cart.jsx';
import { OrderList } from './pages/orders/OrderList.jsx';
import { OrderDetail } from './pages/orders/OrderDetail.jsx';
import { Dashboard } from './pages/admin/Dashboard.jsx';
import { AdminProducts } from './pages/admin/Products.jsx';
import { AdminProductDetail } from './pages/admin/ProductDetail.jsx';
import { LookupAdmin } from './pages/admin/Lookups.jsx';
import { Customers } from './pages/admin/Customers.jsx';
import { CustomerDetail } from './pages/admin/CustomerDetail.jsx';

const customerPage = (element) => (
  <Guard role="Customer">
    <StoreLayout>
      <main className="section">{element}</main>
    </StoreLayout>
  </Guard>
);

const adminPage = (element) => (
  <Guard role="Admin">
    <AdminLayout>{element}</AdminLayout>
  </Guard>
);

export function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <ScrollToTop />
        <Routes>
          <Route
            path="/"
            element={
              <StoreLayout>
                <Home />
              </StoreLayout>
            }
          />
          <Route
            path="/shop"
            element={
              <StoreLayout>
                <Shop />
              </StoreLayout>
            }
          />
          <Route
            path="/products/:id"
            element={
              <StoreLayout>
                <ProductDetail />
              </StoreLayout>
            }
          />
          <Route
            path="/login"
            element={
              <StoreLayout>
                <Login />
              </StoreLayout>
            }
          />
          <Route
            path="/cart"
            element={
              <Guard role="Customer">
                <StoreLayout>
                  <Cart />
                </StoreLayout>
              </Guard>
            }
          />
          <Route path="/orders" element={customerPage(<OrderList />)} />
          <Route path="/orders/:id" element={customerPage(<OrderDetail />)} />
          <Route path="/admin" element={adminPage(<Dashboard />)} />
          <Route path="/admin/products" element={adminPage(<AdminProducts />)} />
          <Route path="/admin/products/:id" element={adminPage(<AdminProductDetail />)} />
          <Route path="/admin/orders" element={adminPage(<OrderList admin />)} />
          <Route path="/admin/orders/:id" element={adminPage(<OrderDetail admin />)} />
          <Route path="/admin/customers" element={adminPage(<Customers />)} />
          <Route path="/admin/customers/:id" element={adminPage(<CustomerDetail />)} />
          <Route
            path="/admin/categories"
            element={adminPage(
              <LookupAdmin key="categories" resource="categories" label="Danh mục" />
            )}
          />
          <Route
            path="/admin/brands"
            element={adminPage(<LookupAdmin key="brands" resource="brands" label="Thương hiệu" />)}
          />
          <Route
            path="*"
            element={
              <StoreLayout>
                <div className="section state">
                  <h1>Không tìm thấy trang.</h1>
                  <Link to="/">Về trang chủ</Link>
                </div>
              </StoreLayout>
            }
          />
        </Routes>
      </AuthProvider>
    </BrowserRouter>
  );
}
