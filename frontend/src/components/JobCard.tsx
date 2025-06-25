import React from 'react';
import { Card, CardContent, Typography } from '@mui/material';

export default function JobCard({ job }: { job: any }) {
  if (!job) return null;
  return (
    <Card sx={{ mb: 2 }}>
      <CardContent>
        <Typography variant="h6">{job.title}</Typography>
        <Typography variant="subtitle2">{job.company}</Typography>
      </CardContent>
    </Card>
  );
}
