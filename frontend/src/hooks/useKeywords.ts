import { useEffect, useState } from 'react';

export interface Keyword {
  id: number;
  word: string;
}

export const useKeywords = () => {
  const [keywords, setKeywords] = useState<Keyword[]>([]);
  const token = localStorage.getItem('token');

  useEffect(() => {
    if (!token) return;
    fetch(`${import.meta.env.VITE_API_URL}/api/keywords`, {
      headers: { Authorization: `Bearer ${token}` },
    })
      .then((res) => res.ok ? res.json() : [])
      .then(setKeywords)
      .catch(() => {});
  }, [token]);

  const addKeyword = async (word: string) => {
    if (!token) return;
    const res = await fetch(`${import.meta.env.VITE_API_URL}/api/keywords`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`,
      },
      body: JSON.stringify({ word }),
    });
    if (res.ok) {
      const kw = await res.json();
      setKeywords((prev) => [...prev, kw]);
    }
  };

  const removeKeyword = async (id: number) => {
    if (!token) return;
    const res = await fetch(`${import.meta.env.VITE_API_URL}/api/keywords/${id}`, {
      method: 'DELETE',
      headers: { Authorization: `Bearer ${token}` },
    });
    if (res.ok) {
      setKeywords((prev) => prev.filter((k) => k.id !== id));
    }
  };

  return { keywords, addKeyword, removeKeyword };
};
