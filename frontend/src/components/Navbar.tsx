import React, { useEffect, useState } from 'react';
import { AppBar, Toolbar, Typography, Box } from '@mui/material';
import { User } from '../hooks/useCurrentUser';

export default function Navbar({ user }: { user: User | null }) {
  const [now, setNow] = useState(new Date());

  useEffect(() => {
    const id = setInterval(() => setNow(new Date()), 60000);
    return () => clearInterval(id);
  }, []);

  const time = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
  const date = now.toLocaleDateString('en-US');

  return (
    <AppBar position="static" sx={{ mb: 2 }}>
      <Toolbar>
        <Typography variant="h6" sx={{ flexGrow: 1 }}>
          {time} {date}
        </Typography>
        <Box sx={{ ml: 'auto' }}>
          <Typography>{user?.email}</Typography>
        </Box>
      </Toolbar>
    </AppBar>
  );
}
