import React, { useState, useEffect } from 'react';
import JobCard from '../components/JobCard';
import { useSSE } from '../hooks/useSSE';
import { TextField, Button, Chip, Box } from '@mui/material';
import { useKeywords } from '../hooks/useKeywords';

export default function JobFeed() {
  const { keywords, addKeyword, removeKeyword } = useKeywords();
  const [input, setInput] = useState('');
  const query = keywords.map((k) => k.word).join(',');
  const newJob = useSSE<any>(
    `${import.meta.env.VITE_API_URL}/api/jobs/stream?keywords=${encodeURIComponent(query)}`,
  );

  const [jobs, setJobs] = useState<any[]>([]);
  const [index, setIndex] = useState(0);

  // Reset job list when the query changes
  useEffect(() => {
    setJobs([]);
    setIndex(0);
  }, [query]);

  // Append new jobs from SSE
  useEffect(() => {
    if (newJob) {
      setJobs((prev) => [...prev, newJob]);
    }
  }, [newJob]);

  // Cycle through jobs every 5 seconds
  useEffect(() => {
    if (jobs.length === 0) return;
    const timer = setInterval(() => {
      setIndex((prev) => (prev + 1) % jobs.length);
    }, 5000);
    return () => clearInterval(timer);
  }, [jobs]);

  const handleAdd = () => {
    if (input.trim()) {
      addKeyword(input.trim());
      setInput('');
    }
  };

  return (
    <Box>
      <Box sx={{ display: 'flex', mb: 1 }}>
        <TextField
          label="Keyword"
          value={input}
          onChange={(e) => setInput(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === 'Enter') {
              e.preventDefault();
              handleAdd();
            }
          }}
          fullWidth
        />
        <Button sx={{ ml: 1 }} variant="contained" onClick={handleAdd}>
          Add Keyword
        </Button>
      </Box>
      <Box sx={{ mb: 2 }}>
        {keywords.map((k) => (
          <Chip key={k.id} label={k.word} onDelete={() => removeKeyword(k.id)} sx={{ mr: 1, mb: 1 }} />
        ))}
      </Box>
      <JobCard job={jobs[index]} />
    </Box>
  );
}
