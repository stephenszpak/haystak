import React from 'react';
import JobCard from '../components/JobCard';
import { useSSE } from '../hooks/useSSE';

export default function JobFeed() {
  const job = useSSE<any>(`/api/jobs/stream`);
  return <JobCard job={job} />;
}
