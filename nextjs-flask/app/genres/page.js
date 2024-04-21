'use client';
import React, {useEffect, useState, useCallback} from 'react'
import Link from 'next/link'


const Genres = () => {
  const [movies, setMovies] = useState([]);
  const [formData, setFormData] = useState({
    movie_genre: '',
  });

  const handleChange = (event) => {
    const { name, value } = event.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    const response = await fetch('http://localhost:8080/getmoviegenre', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      credentials: 'include',
      body: JSON.stringify(formData),
    });

    if (response.ok) {
      const data = await response.json();
      setMovies(data);
    } else {
      console.error('Failed to Fetch Movies of Specified Genre');
    }
  };

  return (
    <div className="flex items-center flex-col justify-center mt-20">
      <h1 className='text-5xl font-bold text-white'>Do You Know What Genre You Like?</h1>
      <form onSubmit={handleSubmit}>
        <input 
          type="text"
          name = "movie_genre"
          placeholder="Search Your Favorite Genre"
          className="border-2 border-black rounded-lg p-2 m-2 text-black"
          value = {formData.movie_genre}
          onChange={handleChange}
        />
        <button type="submit" className="bg-secondary hover:bg-mnuted text-white hover:text-secondary rounded-lg py-2">Search Genre</button>
      </form>
      <div className="flex flex-wrap justify-center">
        {movies.map((movie, index) => (
          <div key={index} className="m-2 p-2 border-2 border-black rounded-lg bg-primary">
            <Link href={`/movies/${movie.movie_id}`}> 
                <h2 className="text-2xl font-bold text-white">{movie.movie_title}</h2>
            </Link>
          </div>
        ))}
      </div>
    </div>

  )
}

export default Genres;

