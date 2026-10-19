import React from 'react';

const DateDisplay = ({ date }) => {
  const formatted = date?.formatted || '--';
  
  return (
    <div className="date-display">
      <span className="date-text">{formatted}</span>
      <style>{`
        .date-display {
          display: flex;
          align-items: center;
          gap: var(--spacing-sm);
        }
        .date-text {
          font-size: var(--font-md);
          font-weight: 600;
          color: var(--text-primary);
        }
      `}</style>
    </div>
  );
};

export default DateDisplay;