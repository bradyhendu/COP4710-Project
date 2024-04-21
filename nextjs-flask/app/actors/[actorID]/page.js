'use client';

import Link from 'next/link';
import React, { useEffect, useState, useCallback } from 'react';

const Page = ({ params }) => {
    const [actor, setActor] = useState({});

    const[moviesofActor, setMoviesofActor] = useState([]);

    const fetchActorDetails = useCallback(async () => {
        const response = await fetch(`http://localhost:8080/actors/${params.actorID}`, {
            credentials: 'include',
        });
        if (response.ok) {
            const data = await response.json();
            setActor(data);
        } else {
            console.error('Failed to fetch actor details');
        }
    }, [params.actorID]); // Depend on params.actorID to recreate the function only when actorId changes

    const fetchMoviesofActor = useCallback(async () => {
        const response = await fetch('http://localhost:8080/getmoviesofactor', {
            method: 'POST', // Specify the method
            credentials: 'include',
            body: JSON.stringify({ actor_id: params.actorID }), // Send data in the body
            headers: {
                'Content-Type': 'application/json',
            },
        });
        if (response.ok) {
            const data = await response.json();
            setMoviesofActor(data);
        } else {
            console.error('Failed to fetch movies of actor');
        }
    }, [params.actorID]);
    
    
    useEffect(() => {
        fetchActorDetails();
        fetchMoviesofActor();
    }, [fetchActorDetails]); 

    return (
    <div className="flex items-center flex-col justify-center mt-20">
        <h1 className='text-5xl font-bold text-white'>{actor.name}</h1>
        <div className='flex flex-row mt-8'>
            <p className='text-white'>DoB: {actor.date_of_birth}, Acting Since: {actor.since}</p>
        </div>
        <h2 className='text-3xl font-bold text-white mt-20'>Movies {actor.name} Have Starred In:</h2>
        <div className='flex flex-wrap justify-center'>
            {moviesofActor.map((movie, index) => (
                <Link key={index} href={`/movies/${movie.movie_id}`}>
                    <div key={index} className='m-2 p-2 border-2 border-black rounded-lg bg-primary'>
                        <h2 className='text-2xl font-bold text-white'>{movie.movie_title}</h2>
                    </div>
                </Link>
            ))}
        </div>
    </div>
    );
};

export default Page;

