import assert from 'node:assert/strict';
import test from 'node:test';
import { loginDestination } from './auth-navigation.js';

const customer = { roles: ['Customer'] };
const admin = { roles: ['Admin'] };

test('returns to the customer route including query and fragment', () => {
  assert.equal(loginDestination(customer, { from: '/cart', requiredRole: 'Customer' }), '/cart');
  assert.equal(loginDestination(customer, { from: '/orders/7?view=detail#items', requiredRole: 'Customer' }), '/orders/7?view=detail#items');
  assert.equal(loginDestination(customer, { from: '/products/38', requiredRole: 'Customer' }), '/products/38');
});

test('returns to admin routes when authorized', () => {
  assert.equal(loginDestination(admin, { from: '/admin/products/38', requiredRole: 'Admin' }), '/admin/products/38');
});

test('uses the role home when a different account lacks the required role', () => {
  assert.equal(loginDestination(customer, { from: '/admin', requiredRole: 'Admin' }), '/shop');
  assert.equal(loginDestination(admin, { from: '/cart', requiredRole: 'Customer' }), '/admin');
  assert.equal(loginDestination(customer, { from: '/admin/products/38' }), '/shop');
  assert.equal(loginDestination(admin, { from: '/orders/7' }), '/admin');
});

test('rejects external URLs and login loops', () => {
  for (const from of ['https://example.test', '//example.test', '/\\example.test', '/login', '/login?next=x', '/login#form']) {
    assert.equal(loginDestination(customer, { from }), '/shop');
  }
});

test('uses the default destination without valid return state', () => {
  for (const state of [undefined, null, {}, { from: 123 }, { from: '' }]) {
    assert.equal(loginDestination(customer, state), '/shop');
    assert.equal(loginDestination(admin, state), '/admin');
  }
});
