'use client';
import React, { useEffect, useState } from 'react';

const MyPage = () => {
  const [data, setData] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch('http://localhost:8080/api/data');
        const jsonData = await response.json();
        setData(jsonData);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, []);

  return (
    <div>
      {data ? <p>{(data as { message: string }).message}</p> : <p>Loading...</p>}
    </div>
  );
};

export default MyPage;
