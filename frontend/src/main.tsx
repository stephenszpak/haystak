import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Dashboard from './pages/Dashboard';
import Calendar from './pages/Calendar';
import JobFeed from './pages/JobFeed';
import { ColorModeProvider } from './theme/ColorModeContext';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <ColorModeProvider>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Dashboard />} />
          <Route path="/calendar" element={<Calendar />} />
          <Route path="/jobs" element={<JobFeed />} />
        </Routes>
      </BrowserRouter>
    </ColorModeProvider>
  </React.StrictMode>
);
