import React from 'react';
import { Card, CardContent, Grid } from '@mui/material';
import JobFeed from './JobFeed';
import Calendar from './Calendar';

export default function Dashboard() {
  return (
    <Grid container spacing={2} sx={{ mt: 2 }}>
      <Grid item xs={12} md={6}>
        <Card>
          <CardContent>
            <JobFeed />
          </CardContent>
        </Card>
      </Grid>
      <Grid item xs={12} md={6}>
        <Card>
          <CardContent>
            <Calendar />
          </CardContent>
        </Card>
      </Grid>
    </Grid>
  );
}
