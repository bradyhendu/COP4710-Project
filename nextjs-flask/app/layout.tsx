'use client';
import React, {useEffect, useState} from 'react';

const MyPage = () => {
  const [data, setData] = useState<any>(null);

  useEffect(() => {
    fetch('http://127.0.0.1:5000/api/data')
      .then(response => response.json())
      .then(data => setData(data));
  }, []);

  return (
    <div>
      <h1>My Page</h1>
      <p>{data ? data.message : 'Loading...'}</p>
    </div>
  );
}

export default MyPage;
