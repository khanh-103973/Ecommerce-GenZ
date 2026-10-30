import assert from 'node:assert/strict';

async function request(url) {
  return fetch(url, { redirect: 'manual', signal: AbortSignal.timeout(10000) });
}

async function waitFor(url) {
  for (let attempt = 0; attempt < 30; attempt++) {
    try {
      const response = await request(url);
      await response.text();
      if (response.status === 200) return;
    } catch {
      // Allow startup time, without treating a failed request as success.
    }
    await new Promise((resolve) => setTimeout(resolve, 1000));
  }
  throw new Error(`Service did not start: ${url}`);
}

await waitFor('http://api:8080/api/health/live');
await waitFor('http://web:8080/shop');

for (const origin of ['http://api:8080', 'http://web:8080']) {
  const live = await request(`${origin}/api/health/live`);
  assert.equal(live.status, 200);
  assert.equal(await live.text(), 'Healthy');
  const ready = await request(`${origin}/api/health/ready`);
  assert.equal(ready.status, 503);
  assert.equal(await ready.text(), 'Unhealthy');
}

const shop = await request('http://web:8080/shop');
assert.equal(shop.status, 200);
const html = await shop.text();
assert.match(html, /id="root"/);
const script = html.match(/src="(\/assets\/[^"\s]+\.js)"/);
assert.ok(script, 'Built JavaScript must be referenced in index.html');
const asset = await request(`http://web:8080${script[1]}`);
assert.equal(asset.status, 200);
assert.match(asset.headers.get('content-type'), /javascript/);
await asset.text();
const missing = await request('http://web:8080/assets/not-a-real-file.js');
assert.equal(missing.status, 404);
await missing.text();

const me = await request('http://web:8080/api/auth/me');
assert.equal(me.status, 401);
assert.match(me.headers.get('content-type'), /application\/problem\+json/);
assert.equal((await me.json()).status, 401);
const missingApi = await request('http://web:8080/api/not-a-real-route?probe=1');
assert.equal(missingApi.status, 404);
assert.equal((await missingApi.json()).status, 404);
console.log('PASS: direct/proxied live=200 and ready=503, SPA route, built JS, missing asset=404, proxied auth=401 and API route=404.');
