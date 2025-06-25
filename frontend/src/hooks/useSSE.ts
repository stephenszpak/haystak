import { useEffect, useState } from 'react';

export const useSSE = <T>(url: string) => {
  const [data, setData] = useState<T | null>(null);
  useEffect(() => {
    const evtSource = new EventSource(url);
    evtSource.onmessage = (e) => setData(JSON.parse(e.data));
    return () => evtSource.close();
  }, [url]);
  return data;
};
