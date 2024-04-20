'use client';

import Link from 'next/link';
import React, { useEffect, useState, useCallback } from 'react';

const Page = ({ params }) => {
    const [movie, setMovie] = useState({});

    const[movieActors, setMovieActors] = useState([]);

    const fetchMovieDetails = useCallback(async () => {
        const response = await fetch(`http://localhost:8080/movies/${params.movieId}`, {
            credentials: 'include',
        });
        if (response.ok) {
            const data = await response.json();
            setMovie(data);
        } else {
            console.error('Failed to fetch movie details');
        }
    }, [params.movieId]); // Depend on params.movieId to recreate the function only when movieId changes

    const fetchMovieActors = useCallback(async () => {
        const response = await fetch(`http://localhost:8080/getactorsofmovie`, {
            method: 'POST', // Specify the method
            credentials: 'include',
            body: JSON.stringify({ movie_id: params.movieId }), // Send data in the body
            headers: {
                'Content-Type': 'application/json',
            },
        });
        if (response.ok) {
            const data = await response.json();
            setMovieActors(data);
        } else {
            console.error('Failed to fetch movie actors');
        }
    }, [params.movieId]);
    
    
    useEffect(() => {
        fetchMovieDetails();
        fetchMovieActors();
    }, [fetchMovieDetails]); 

    return (
    <div className="flex items-center flex-col justify-center mt-20">
        <h1 className='text-5xl font-bold text-white'>{movie.title}</h1>
        <div className='flex flex-row mt-8'>
            <p className='text-white'>Duration: {movie.duration}, Released: {movie.release_date}</p>
        </div>
        <h2 className='text-3xl font-bold text-white mt-20'>Actors</h2>
        <div className='flex flex-wrap justify-center'>
            {movieActors.map((actor, index) => (
                <Link key={index} href={`/actors/${actor.actor_id}`}>
                    <div key={index} className='m-2 p-2 border-2 border-black rounded-lg bg-primary'>
                        <h2 className='text-2xl font-bold text-white'>{actor.actor_name}</h2>
                    </div>
                </Link>
            ))}
        </div>
    </div>
    );
};

export default Page;

