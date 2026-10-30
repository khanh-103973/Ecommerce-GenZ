import { Field } from '../../components/ui.jsx';

export function ProductForm({ product, lookups, onSave, busy }) {
  return (
    <form
      className="form-grid"
      onSubmit={(e) => {
        e.preventDefault();
        const body = Object.fromEntries(new FormData(e.currentTarget));
        onSave({
          ...body,
          categoryId: Number(body.categoryId),
          brandId: Number(body.brandId),
          isActive: body.isActive === 'on',
        });
      }}
    >
      <Field
        label="Tên sản phẩm"
        name="name"
        required
        maxLength={200}
        defaultValue={product?.name || ''}
      />
      <label className="field">
        <span>Danh mục</span>
        <select name="categoryId" required defaultValue={product?.categoryId || ''}>
          <option value="" disabled>
            Chọn danh mục
          </option>
          {lookups.categories.map((x) => (
            <option key={x.id} value={x.id}>
              {x.name}
            </option>
          ))}
        </select>
      </label>
      <label className="field">
        <span>Thương hiệu</span>
        <select name="brandId" required defaultValue={product?.brandId || ''}>
          <option value="" disabled>
            Chọn thương hiệu
          </option>
          {lookups.brands.map((x) => (
            <option key={x.id} value={x.id}>
              {x.name}
            </option>
          ))}
        </select>
      </label>
      <label className="field wide">
        <span>Mô tả</span>
        <textarea name="description" maxLength={4000} defaultValue={product?.description || ''} />
      </label>
      <label className="check">
        <input type="checkbox" name="isActive" defaultChecked={product?.isActive ?? true} /> Đang
        bán
      </label>
      <button className="primary" disabled={busy}>
        {busy ? 'Đang lưu…' : 'Lưu sản phẩm'}
      </button>
    </form>
  );
}

export function VariantForm({ variant, onSave, busy, onCancel }) {
  return (
    <form
      className="variant-form"
      onSubmit={(e) => {
        e.preventDefault();
        const values = Object.fromEntries(new FormData(e.currentTarget));
        onSave({
          ...values,
          price: Number(values.price),
          stockQuantity: Number(values.stockQuantity),
          isActive: values.isActive === 'on',
          ...(variant ? { rowVersion: variant.rowVersion } : {}),
        });
      }}
    >
      <Field label="SKU" name="sku" required maxLength={64} defaultValue={variant?.sku || ''} />
      <Field label="Size" name="size" required maxLength={20} defaultValue={variant?.size || ''} />
      <Field label="Màu" name="color" required maxLength={50} defaultValue={variant?.color || ''} />
      <Field
        label="Giá (VND)"
        name="price"
        type="number"
        required
        min="0"
        step="1"
        max="999999999999999"
        defaultValue={variant?.price ?? 0}
      />
      <Field
        label="Tồn kho"
        name="stockQuantity"
        type="number"
        required
        min="0"
        max="2147483647"
        step="1"
        defaultValue={variant?.stockQuantity ?? 0}
      />
      <label className="check">
        <input type="checkbox" name="isActive" defaultChecked={variant?.isActive ?? true} /> Đang
        bán
      </label>
      <button className="primary" disabled={busy}>
        Lưu biến thể
      </button>
      {onCancel && (
        <button type="button" className="outline" onClick={onCancel}>
          Đóng
        </button>
      )}
    </form>
  );
}
