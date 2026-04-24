import React, { useMemo } from 'react';
import { formatPercent, getUsageColor } from '../utils/formatters';

const CpuUsage = ({ cpu }) => {
  const usage = cpu?.usage || 0;
  const color = useMemo(() => getUsageColor(usage), [usage]);
  
  return (
    <div className="cpu-usage">
      <span className="label">CPU</span>
      <span className="value" style={{ color }}>{formatPercent(usage)}</span>
      <style>{`
        .cpu-usage {
          display: flex;
          align-items: center;
          gap: var(--spacing-sm);
          font-size: var(--font-sm);
        }
        .label { color: var(--text-muted); font-weight: 500; }
        .value { font-weight: 600; font-variant-numeric: tabular-nums; }
      `}</style>
    </div>
  );
};

export default CpuUsage;