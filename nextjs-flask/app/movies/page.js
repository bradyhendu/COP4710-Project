'use client';
import React, {useEffect, useState, useCallback} from 'react'
import Link from 'next/link'


const Movies = () => {
  const [movies, setMovies] = useState([]);
  const [searchTerm, setSearchTerm] = useState(''); // State to hold the search term

  //Pulls all movies from the database
  const fetchMovies = useCallback(async () => {
    const response = await fetch('http://localhost:8080/getmovies', {
      credentials: 'include',
    });
    if (response.ok) {
      const data = await response.json();
      setMovies(data);
      console.log(data);
    } else {
      console.error('Failed to fetch movies');
    }
  }, []);

  useEffect(() => {
    fetchMovies();
  }, [fetchMovies]);
  
  //handle search term
  const handleSearchChange = (e) => {
    setSearchTerm(e.target.value);
  };

  const filteredMovies = movies.filter((movie) => {
    return movie.movie_title.toLowerCase().includes(searchTerm.toLowerCase());
  }
  );
   

  return (
    <div className="flex items-center flex-col justify-center mt-20">
      <h1 className='text-5xl font-bold text-white'>Wanna Watch a Movie?</h1>
      <div>
        <input type="text" placeholder="Search for a movie" className="border-2 border-black rounded-lg p-2 m-2 text-black" onChange={handleSearchChange}/>
      </div>
      <div className="flex flex-wrap justify-center">
        {filteredMovies.map((movie, index) => (
          <div key={index} className="m-2 p-2 border-2 border-black rounded-lg bg-primary">
            <Link href={`/movies/${movie.movie_id}`}> 
                <h2 className="text-2xl font-bold text-white">{movie.movie_title}</h2>
                <p className="text-white">{movie.movie_id}</p>
            </Link>
          </div>
        ))}
      </div>
    </div>

  )
}

export default Movies
