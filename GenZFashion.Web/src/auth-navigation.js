// Only return to a route in this app that the signed-in account can access.
export function loginDestination(user, state) {
  const fallback = user.roles.includes('Admin') ? '/admin' : '/shop';
  const from = state?.from;
  if (typeof from !== 'string' || !from.startsWith('/') || from.startsWith('//') || from.includes('\\')) return fallback;
  if (/^\/login(?:[/?#]|$)/.test(from)) return fallback;
  if (state.requiredRole && !user.roles.includes(state.requiredRole)) return fallback;
  if (/^\/admin(?:[/?#]|$)/.test(from) && !user.roles.includes('Admin')) return fallback;
  if (/^\/(?:cart|orders)(?:[/?#]|$)/.test(from) && !user.roles.includes('Customer')) return fallback;
  return from;
}
