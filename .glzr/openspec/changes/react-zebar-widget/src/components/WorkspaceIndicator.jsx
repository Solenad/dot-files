import React from 'react';

const WorkspaceIndicator = ({ glazewm, komorebi }) => {
  const workspaces = glazewm?.currentWorkspaces || komorebi?.currentWorkspaces || [];
  const focused = glazewm?.focusedWorkspace?.name || komorebi?.focusedWorkspace?.name;
  
  if (!workspaces.length) return null;
  
  return (
    <div className="workspace-indicator">
      {workspaces.map((ws) => (
        <button
          key={ws.name}
          className={`workspace-btn ${ws.name === focused ? 'focused' : ''}`}
        >
          {ws.name}
        </button>
      ))}
      <style>{`
        .workspace-indicator {
          display: flex;
          gap: var(--spacing-xs);
        }
        .workspace-btn {
          background: var(--bg-secondary);
          border: 1px solid var(--border-color);
          border-radius: var(--radius-sm);
          padding: 2px 8px;
          font-size: var(--font-xs);
          font-weight: 600;
          color: var(--text-secondary);
          cursor: pointer;
          transition: all var(--transition-fast);
        }
        .workspace-btn:hover {
          background: var(--accent-secondary);
          color: white;
        }
        .workspace-btn.focused {
          background: var(--accent-primary);
          color: white;
          border-color: var(--accent-primary);
        }
      `}</style>
    </div>
  );
};

export default WorkspaceIndicator;