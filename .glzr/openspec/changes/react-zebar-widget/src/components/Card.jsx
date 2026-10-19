import React from 'react';

const Card = ({ children, className = '' }) => {
  return (
    <div className={`card ${className}`}>
      {children}
      <style>{`
        .card {
          background: var(--bg-card);
          border: 1px solid var(--border-color);
          border-radius: var(--radius-lg);
          padding: var(--spacing-md);
          box-shadow: var(--shadow-sm);
          transition: all var(--transition-normal);
        }
        
        .card:hover {
          box-shadow: var(--shadow-md);
          transform: translateY(-2px);
        }
      `}</style>
    </div>
  );
};

export default Card;