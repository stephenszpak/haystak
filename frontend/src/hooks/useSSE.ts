import { useEffect, useState } from 'react';

export const useSSE = <T>(url: string) => {
  const [data, setData] = useState<T | null>(null);
  useEffect(() => {
    const evtSource = new EventSource(url);
    evtSource.onmessage = (e) => {
      const parsed = JSON.parse(e.data);
      console.log('SSE payload:', parsed);
      setData(parsed);
    };
    return () => evtSource.close();
  }, [url]);
  return data;
};
