'use client';
import React, {useState, useEffect, useCallback} from 'react';
import Link from 'next/link';


const User = () => {
  const [movies, setMovies] = useState([])
  const [user, setUser] = useState({})
  const [recommendedMovies, setRecommendedMovies] = useState([])

  const fetchReviewedMovies = useCallback(async () => {
    const response = await fetch('http://localhost:8080/user-reviewed-movies', {
      credentials: 'include',
    });
    if (response.ok) {
      const data = await response.json();
      setMovies(data)
    }
  }, []);

  const fetchUserDetails = useCallback(async () => {
    const response = await fetch('http://localhost:8080/user-details', {
      credentials: 'include',
    });
    if (response.ok) {
      const data = await response.json();
      setUser(data)
    }
  }, []);

  const fetchRecommendedMovies = useCallback(async () => {
    const response = await fetch('http://localhost:8080/recommendations', {
      credentials: 'include',
    });
    if (response.ok) {
      const data = await response.json();
      setRecommendedMovies(data)
    }
  }, []);
  
  useEffect(() => {
    fetchReviewedMovies()
    fetchUserDetails()
  }, [fetchReviewedMovies, fetchUserDetails])

  return (
    <div className='flex flex-col justify-center items-center mt-10 text-center'>
      <h1 className='text-5xl font-bold text-white'>Welcome, {user.first_name}</h1>
      <h2 className='text-3xl font-bold text-white mt-10'>Here are the movies you've reviewed:</h2>
      {movies.length === 0 ? (
        <div className="text-white mt-5">
          No reviews yet, go <Link href="/movies" className='text-primary hover:text-secondary'>here</Link> to find movies.
        </div>
      ) : (
        <div className="flex flex-wrap justify-center text-left">
          {movies.map((movie, index) => (
            <div key={index} className="m-2 p-2 border-2 border-black rounded-lg bg-primary">
              <Link href={`/movies/${movie.movie_id}`}> 
                  <h2 className="text-2xl font-bold text-white">{movie.title}</h2>
                  <p className='text-white'>{movie.genres}</p>
              </Link>
            </div>
          ))}
        </div>
      )}
      <h2 className='text-3xl font-bold text-white mt-10'>Looking for new movies? Here's our recomendations:</h2>
    </div>
  )
}

export default User
