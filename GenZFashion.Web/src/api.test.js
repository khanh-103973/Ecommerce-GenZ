import assert from 'node:assert/strict';
import test from 'node:test';
import { api } from './api.js';

function respond(t, body, status, contentType = 'application/json') {
  t.mock.method(
    globalThis,
    'fetch',
    async () =>
      new Response(body === null ? null : JSON.stringify(body), {
        status,
        headers: { 'Content-Type': contentType },
      })
  );
}

test('shows safe server detail from a 500 ProblemDetails response', async (t) => {
  respond(
    t,
    { status: 500, detail: 'Không thể xử lý yêu cầu lúc này.' },
    500,
    'application/problem+json'
  );
  await assert.rejects(api('/products'), { message: 'Không thể xử lý yêu cầu lúc này.' });
});

test('keeps support for legacy business error messages', async (t) => {
  respond(t, { message: 'Tên đã tồn tại.' }, 409);
  await assert.rejects(api('/admin/categories'), { message: 'Tên đã tồn tại.' });
});

test('shows field validation errors', async (t) => {
  respond(
    t,
    { status: 400, errors: { Name: ['Tên không được để trống.'] } },
    400,
    'application/problem+json'
  );
  await assert.rejects(api('/admin/categories'), { message: 'Tên không được để trống.' });
});

test('keeps support for Identity validation errors', async (t) => {
  respond(t, { errors: [{ code: 'PasswordTooShort', description: 'Mật khẩu quá ngắn.' }] }, 400);
  await assert.rejects(api('/auth/register'), { message: 'Mật khẩu quá ngắn.' });
});

test('accepts an empty 204 response', async (t) => {
  respond(t, null, 204);
  assert.equal(await api('/cart/items/1', { method: 'DELETE' }), null);
});
