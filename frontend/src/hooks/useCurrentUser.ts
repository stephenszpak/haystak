import { useEffect, useState } from 'react';

export interface User {
  id: number;
  email: string;
}

export const useCurrentUser = () => {
  const [user, setUser] = useState<User | null>(null);
  const token = localStorage.getItem('token');

  useEffect(() => {
    if (!token) return;
    fetch(`${import.meta.env.VITE_API_URL}/api/me`, {
      headers: { Authorization: `Bearer ${token}` },
    })
      .then((res) => (res.ok ? res.json() : null))
      .then((u) => setUser(u))
      .catch(() => {});
  }, [token]);

  return user;
};
