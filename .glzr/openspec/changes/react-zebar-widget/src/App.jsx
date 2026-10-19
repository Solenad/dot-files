import React, { useEffect, useState } from 'react';
import * as zebar from 'zebar';
import DateDisplay from './components/DateDisplay';
import CpuUsage from './components/CpuUsage';
import MemoryUsage from './components/MemoryUsage';
import BatteryStatus from './components/BatteryStatus';
import NetworkInfo from './components/NetworkInfo';
import WeatherDisplay from './components/WeatherDisplay';
import WorkspaceIndicator from './components/WorkspaceIndicator';
import Card from './components/Card';

function App() {
  const [output, setOutput] = useState(null);
  const [theme, setTheme] = useState('light');

  // Create provider group
  useEffect(() => {
    const providers = zebar.createProviderGroup({
      date: { type: 'date', formatting: 'EEE d MMM t' },
      cpu: { type: 'cpu' },
      memory: { type: 'memory' },
      battery: { type: 'battery' },
      network: { type: 'network' },
      weather: { type: 'weather' },
      glazewm: { type: 'glazewm' },
      komorebi: { type: 'komorebi' }
    });

    // Listen for updates
    providers.onOutput(() => {
      setOutput(providers.outputMap);
    });

    // Initial output
    setOutput(providers.outputMap);

    return () => {
      // Cleanup
    };
  }, []);

  // Toggle theme
  useEffect(() => {
    const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');
    const handleChange = (e) => setTheme(e.matches ? 'dark' : 'light');
    
    mediaQuery.addEventListener('change', handleChange);
    handleChange(mediaQuery);
    
    return () => mediaQuery.removeEventListener('change', handleChange);
  }, []);

  if (!output) {
    return (
      <div className="app loading">
        <div className="loader"></div>
      </div>
    );
  }

  return (
    <div className="app" data-theme={theme}>
      <div className="widget-container">
        {/* Workspaces - Left */}
        {(output.glazewm || output.komorebi) && (
          <WorkspaceIndicator 
            glazewm={output.glazewm} 
            komorebi={output.komorebi} 
          />
        )}
        
        {/* Date - Center */}
        <Card>
          <DateDisplay date={output.date} />
        </Card>
        
        {/* System Info - Right */}
        <div className="system-info">
          {output.network && (
            <Card>
              <NetworkInfo network={output.network} />
            </Card>
          )}
          
          {output.memory && (
            <Card>
              <MemoryUsage memory={output.memory} />
            </Card>
          )}
          
          {output.cpu && (
            <Card>
              <CpuUsage cpu={output.cpu} />
            </Card>
          )}
          
          {output.battery && (
            <Card>
              <BatteryStatus battery={output.battery} />
            </Card>
          )}
          
          {output.weather && (
            <Card>
              <WeatherDisplay weather={output.weather} />
            </Card>
          )}
        </div>
      </div>
    </div>
  );
}

export default App;