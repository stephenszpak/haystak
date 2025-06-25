import React, { useState } from 'react';
import JobCard from '../components/JobCard';
import { useSSE } from '../hooks/useSSE';
import { TextField, Button, Chip, Box } from '@mui/material';
import { useKeywords } from '../hooks/useKeywords';
import Navbar from '../components/Navbar';
import { useCurrentUser } from '../hooks/useCurrentUser';

export default function JobFeed() {
  const { keywords, addKeyword, removeKeyword } = useKeywords();
  const user = useCurrentUser();
  const [input, setInput] = useState('');
  const query = keywords.map((k) => k.word).join(',');
  const job = useSSE<any>(
    `${import.meta.env.VITE_API_URL}/api/jobs/stream?keywords=${encodeURIComponent(query)}`,
  );

  const handleAdd = () => {
    if (input.trim()) {
      addKeyword(input.trim());
      setInput('');
    }
  };

  return (
    <Box>
      <Navbar user={user} />
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
      <JobCard job={job} />
    </Box>
  );
}
