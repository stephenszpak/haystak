import React from 'react';
import { Card, CardContent, Grid } from '@mui/material';
import JobFeed from './JobFeed';
import Calendar from './Calendar';
import Navbar from '../components/Navbar';
import { useCurrentUser } from '../hooks/useCurrentUser';

export default function Dashboard() {
  const user = useCurrentUser();
  return (
    <>
      <Navbar user={user} />
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
    </>
  );
}
