import React, { createContext, useContext, useEffect, useState } from 'react';
import * as zebar from 'zebar';

// Create provider group with all available providers
export const createProviders = () => {
  return zebar.createProviderGroup({
    date: { type: 'date', formatting: 'EEE d MMM t' },
    cpu: { type: 'cpu' },
    memory: { type: 'memory' },
    battery: { type: 'battery' },
    network: { type: 'network' },
    weather: { type: 'weather' },
    glazewm: { type: 'glazewm' },
    komorebi: { type: 'komorebi' }
  });
};

// React Context for provider data
const ZebarContext = createContext(null);

export const ZebarProvider = ({ children }) => {
  const [providers, setProviders] = useState(null);

  useEffect(() => {
    const providerGroup = createProviders();
    setProviders(providerGroup);

    // Listen for output updates
    providerGroup.onOutput(() => {
      setProviders({ ...providerGroup });
    });

    return () => {
      // Cleanup if needed
    };
  }, []);

  if (!providers) {
    return <div>Loading...</div>;
  }

  return (
    <ZebarContext.Provider value={providers}>
      {children}
    </ZebarContext.Provider>
  );
};

export const useZebar = () => {
  const context = useContext(ZebarContext);
  if (!context) {
    throw new Error('useZebar must be used within a ZebarProvider');
  }
  return context;
};