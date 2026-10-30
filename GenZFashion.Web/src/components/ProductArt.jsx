import { useEffect, useState } from 'react';

export function ProductArt({ url, name = '', className = '' }) {
  const [failed, setFailed] = useState(false);
  useEffect(() => setFailed(false), [url]);
  const pants = name.toLowerCase().includes('quần');
  return (
    <div className={`product-art ${className}`}>
      {url && !failed ? (
        <img
          src={url}
          alt={name}
          loading="lazy"
          referrerPolicy="no-referrer"
          onError={() => setFailed(true)}
        />
      ) : (
        <>
          <svg viewBox="0 0 240 260" aria-hidden="true">
            <defs>
              <linearGradient id={pants ? 'pants' : 'shirt'} x1="0" x2="1">
                <stop stopColor="#373b3b" />
                <stop offset=".5" stopColor="#555c58" />
                <stop offset="1" stopColor="#292e2b" />
              </linearGradient>
            </defs>
            {pants ? (
              <path
                d="M66 36h108l16 191-53 3-17-120-18 120-52-3z"
                fill="url(#pants)"
                stroke="#222"
                strokeWidth="2"
              />
            ) : (
              <>
                <path
                  d="m76 39-47 31 23 49 27-14-3 126h90l-4-126 27 14 23-49-47-31-23 15h-43z"
                  fill="url(#shirt)"
                  stroke="#272d29"
                  strokeWidth="2"
                />
                <path d="M98 43q22 32 45 0" fill="none" stroke="#222925" strokeWidth="7" />
                <path d="M95 127h49" stroke="#c8ef40" strokeWidth="3" />
                <text x="101" y="148" fill="#dbe0d5" fontSize="10" fontFamily="sans-serif">
                  GEN Z
                </text>
              </>
            )}
          </svg>
          <span className="art-label">Ảnh minh họa · GZ STUDIO</span>
        </>
      )}
    </div>
  );
}
