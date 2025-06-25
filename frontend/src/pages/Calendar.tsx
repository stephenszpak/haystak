import React from 'react';
import { useCalSync } from '../hooks/useCalSync';

export default function Calendar() {
  useCalSync();
  return <div>Calendar</div>;
}
