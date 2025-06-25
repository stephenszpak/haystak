import React from 'react';
import { Card, CardContent, Typography, Link } from '@mui/material';

export default function JobCard({ job }: { job: any }) {
  if (!job) return null;
  return (
    <Card sx={{ mb: 2 }}>
      <CardContent>
        <Typography variant="h6">
          <Link href={job.url} target="_blank" rel="noopener noreferrer">
            {job.title}
          </Link>
        </Typography>
        <Typography variant="subtitle2">{job.company}</Typography>
        {job.location && (
          <Typography variant="body2" color="text.secondary">
            {job.location}
          </Typography>
        )}
        {job.summary && (
          <Typography variant="body2" sx={{ mt: 1 }}>
            {job.summary}
          </Typography>
        )}
      </CardContent>
    </Card>
  );
}
