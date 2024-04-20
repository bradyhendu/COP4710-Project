'use client';

import React from 'react';

import { useEffect, useState } from 'react';

const page = ({params}) => {

  return (
    <div>
      <h1>Movie ID: {params.movieId}</h1>
      {/* Render your movie details here */}
    </div>
  )
}

export default page
