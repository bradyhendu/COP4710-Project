'use client';
import React, {useEffect, useState, useCallback} from 'react'
import Link from 'next/link'
const Actors = () => {
  const [actors, setActors] = useState([]);
  const [searchTerm, setSearchTerm] = useState(''); // State to hold the search term

  //Pulls all actors from the database
  const fetchActors = useCallback(async () => {
    const response = await fetch('http://localhost:8080/getactors', {
      credentials: 'include',
    });
    if (response.ok) {
      const data = await response.json();
      setActors(data);
      console.log(data);
    } else {
      console.error('Failed to fetch actors');
    }
  }, []);

  useEffect(() => {
    fetchActors();
  }, [fetchActors]);

  //handle search term
  const handleSearchChange = (e) => {
    setSearchTerm(e.target.value);
  };

  const filteredActors = actors.filter((actor) => {
    return actor.actor_name.toLowerCase().includes(searchTerm.toLowerCase());
  }
  );

  return (
    <div className="flex items-center flex-col justify-center mt-20">
      <h1 className='text-5xl font-bold text-white'>Have a favorite actor?</h1>
      <div>
        <input type="text" placeholder="Search for an actor" className="border-2 border-black rounded-lg p-2 m-2 text-black" onChange={handleSearchChange}/>
      </div>
      <div className="flex flex-wrap justify-center">
        {filteredActors.map((actor, index) => (
          <div key={index} className="m-2 p-2 border-2 border-black rounded-lg bg-primary">
            <Link href={`/actors/${actor.actor_id}`}> 
                <h2 className="text-2xl font-bold text-white">{actor.actor_name}</h2>
            </Link>
          </div>
        ))}
      </div>
    </div>
  )
}

export default Actors
