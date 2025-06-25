import React from 'react';
import JobCard from '../components/JobCard';
import { useSSE } from '../hooks/useSSE';

export default function JobFeed() {
  const job = useSSE<any>(`${import.meta.env.VITE_API_URL}/api/jobs/stream`);
  return <JobCard job={job} />;
}
