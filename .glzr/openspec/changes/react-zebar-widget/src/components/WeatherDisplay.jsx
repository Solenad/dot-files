import React from 'react';
import { formatTemperature, getWeatherIcon } from '../utils/formatters';

const WeatherDisplay = ({ weather }) => {
  const temp = weather?.celsiusTemp;
  const status = weather?.status;
  
  return (
    <div className="weather-display">
      <span className="icon">{getWeatherIcon(status)}</span>
      <span className="temp">{formatTemperature(temp)}</span>
      <style>{`
        .weather-display {
          display: flex;
          align-items: center;
          gap: var(--spacing-xs);
          font-size: var(--font-sm);
        }
        .icon { font-size: var(--font-md); }
        .temp { font-weight: 600; }
      `}</style>
    </div>
  );
};

export default WeatherDisplay;