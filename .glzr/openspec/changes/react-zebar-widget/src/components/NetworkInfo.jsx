import React from 'react';
import { formatNetwork, getSignalStrength } from '../utils/formatters';

const NetworkInfo = ({ network }) => {
  const ssid = formatNetwork(network);
  const signal = getSignalStrength(network);
  
  return (
    <div className="network-info">
      <span className="icon">📶</span>
      <span className="ssid">{ssid}</span>
      <style>{`
        .network-info {
          display: flex;
          align-items: center;
          gap: var(--spacing-xs);
          font-size: var(--font-sm);
        }
        .ssid { 
          font-weight: 500; 
          max-width: 100px;
          overflow: hidden;
          text-overflow: ellipsis;
          white-space: nowrap;
        }
      `}</style>
    </div>
  );
};

export default NetworkInfo;