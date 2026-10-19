import React from 'react';
import { formatBatteryStatus } from '../utils/formatters';

const BatteryStatus = ({ battery }) => {
  const percent = battery?.chargePercent || 0;
  const isCharging = battery?.isCharging || false;
  
  return (
    <div className="battery-status">
      <span className="icon">{isCharging ? '⚡' : '🔋'}</span>
      <span className="value">{percent}%</span>
      <style>{`
        .battery-status {
          display: flex;
          align-items: center;
          gap: var(--spacing-xs);
          font-size: var(--font-sm);
        }
        .icon { font-size: var(--font-md); }
        .value { font-weight: 600; }
      `}</style>
    </div>
  );
};

export default BatteryStatus;