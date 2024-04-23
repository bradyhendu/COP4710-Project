'use client';

import Link from 'next/link';
import React, { useEffect, useState, useCallback,} from 'react';
import Rating from '@mui/material/Rating';

const Page = ({ params }) => {
    const [movie, setMovie] = useState({});
    const [open, setOpen] = useState(false);
    const [user, setUser] = useState({});
    const [movieRating, setMovieRating] = useState(0.0);
    const [formData, setFormData] = useState({
        rating: 3,
        review: '',
        movie_id: params.movieId,
    });
    const[movieReviews, setMovieReviews] = useState([]);
    const[movieActors, setMovieActors] = useState([]);
    const[warning, setWarning] = useState('');

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

    const fetchMovieReviews = useCallback(async () => {
        const response = await fetch(`http://localhost:8080/getreviews`, {
            method: 'POST',
            credentials: 'include',
            body: JSON.stringify({ movie_id: params.movieId }),
            headers: {
                'Content-Type': 'application/json',
            },
        });
        if (response.ok) {
            const data = await response.json();
            setMovieReviews(data);
        }
    }, [params.movieId]);

    const fetchUserDetails = useCallback(async () => {
        const response = await fetch('http://localhost:8080/user-details', {
            credentials: 'include',
        });
        if (response.ok) {
            const data = await response.json();
            setUser(data);
        }
    }, []);

    const fetchMovieRating = useCallback(async () => {
        const response = await fetch(`http://localhost:8080/getrating`, {
            method: 'POST',
            credentials: 'include',
            body: JSON.stringify({ movie_id: params.movieId }),
            headers: {
                'Content-Type': 'application/json',
            },
        });
        if (response.ok) {
            const data = await response.json();
            setMovieRating(data);
        } else {
            console.error('Failed to fetch movie rating');
        }
    }, [params.movieId]);

    const addReview = useCallback(async (event) => {
        event.preventDefault();
        const response = await fetch(`http://localhost:8080/addreview`, {
            method: 'POST',
            credentials: 'include',
            body: JSON.stringify(formData),
            headers: {
                'Content-Type': 'application/json',
            },
        });

        if (response.ok) {
            const data = await response.json();
            if(data.message === 'Review Added Successfully'){
                fetchMovieReviews();
                fetchMovieRating();
                setOpen(false);
            }else{
                setWarning(data.message);
            }
        } else {
            console.error('Failed to add review');
        }
    }, [formData, fetchMovieReviews, fetchMovieRating]);

    const handleChange = (event, newValue) => {
        const { name } = event.target;
        if (name === 'rating') {
            setFormData(prevState => ({ ...prevState, rating: newValue }));
        } else {
            const { value } = event.target;
            setFormData(prevState => ({ ...prevState, [name]: value }));
        }
    };

    const deleteReview = async (reviewId) => {
        console.log(reviewId);
        const response = await fetch(`http://localhost:8080/delete-review`, {
            method: 'POST',
            credentials: 'include',
            body: JSON.stringify({ review_id: reviewId }),
            headers: {
                'Content-Type': 'application/json',
            },
        });
        
        if (response.ok) {
            fetchMovieReviews();
            fetchMovieRating();
            setWarning('');
        } else {
            console.error('Failed to delete review');
        }
    }
    
    
    useEffect(() => {
        fetchMovieDetails();
        fetchMovieActors();
        fetchMovieReviews();
        fetchUserDetails();
        fetchMovieRating();
    }, [fetchMovieDetails, fetchMovieActors, fetchMovieReviews, fetchUserDetails, fetchMovieRating]); 

    return (
    <div className="flex items-center flex-col justify-center mt-10">
        <h1 className='text-5xl font-bold text-white text-center'>{movie.title}</h1>
        <div className='flex flex-col my-4 text-center '>
            <div className='flex flex-row justify-center items-center m-4 bg-primary rounded-md p-4'>
                <h4 className='text-white text-xl'>User's Average Rating: </h4>
                <Rating name='read-only' value={movieRating} precision={0.5} readOnly/>
            </div>
            <h4 className='text-white text-xl'>Genre(s): {movie.genres}</h4>
            <p className='text-white'>Duration: {movie.duration}, Released: {movie.release_date}</p>
        </div>
        <button onClick={() => setOpen(!open)} className='bg-primary hover:bg-secondary text-white hover:text-primary rounded-lg p-2 mt-4'>Add Review</button>
        {open && (
            <form onSubmit={addReview} className='flex flex-col justify-center items-center m-5 p-8 bg-primary rounded-md'>
                <Rating name="rating" value={formData.rating} defaultValue={3.0} precision={0.5} onChange={handleChange}/>
                <textarea name='review' value={formData.review} className='border-2 border-black rounded-lg p-2 m-4 text-black' placeholder='Add Review' onChange={handleChange}></textarea>
                <button type='submit' className='bg-secondary hover:bg-accent text-white hover:text-black rounded-lg p-2 m-4'>Submit Review</button>
                <p className='text-red-500'>{warning}</p>
            </form>
        )}
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
        <h2 className='text-3xl font-bold text-white mt-20'>Reviews</h2>
        <div className='flex flex-wrap justify-center items-center'>
            {movieReviews.map((review, index) => (
                <div key={index} className='m-4 p-4 bg-primary rounded-lg flex items-center flex-col space-y-1'>
                    <Rating name='read-only' value={review.rating} precision={0.5} readOnly/>
                    <p className='text-white'>{review.review}</p>
                    <p className='text-white'>By: {review.username}</p>
                    {user.username === review.username && (
                        <button className='bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded' onClick={() => deleteReview(review.review_id)}>Delete Review</button>
                    )}
                </div>
            ))}
        </div>

    </div>
    );
};

export default Page;