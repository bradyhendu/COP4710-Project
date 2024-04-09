import React from 'react';
import Link from 'next/link';

const MyPage = () => {

  return (
    <div className='bg-hero-pattern  flex flex-col items-center justify-center h-screen text-center'>
      <div className='bg-primary p-12 rounded-xl'>
        <h1 className="text-5xl font-bold">Welcome to <span className='text-secondary'>CineFan</span></h1>
        <p className='mt-6'>The place for all your movie needs</p>
        <Link href='/register'>
          <button className='mt-6 bg-secondary hover:bg-accent text-white px-4 py-2 rounded-lg'>Get Started</button>
        </Link>
      </div>
    </div>
  );
};

export default MyPage;
