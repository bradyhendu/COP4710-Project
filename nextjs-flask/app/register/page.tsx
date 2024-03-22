import React from 'react'
import Link from 'next/link'

const Register = () => {
  return (
    <div className='flex flex-col items-center justify-center h-screen text-center'>
      <div className='bg-primary p-8 rounded-xl'>
        <h1 className="text-5xl font-bold">Create an account</h1>
        <p className='mt-2'>Already have an account? <Link href='/login' className='text-secondary hover:text-accent'>Login</Link></p>
        <form className='mt-6 flex flex-col items-center'>
          <input type='text' placeholder='Username' className='p-2 rounded-lg text-dark' />
          <input type='email' placeholder='Email' className='p-2 mt-2 rounded-lg text-dark' />
          <input type='password' placeholder='Password' className='p-2 mt-2 rounded-lg text-dark' />
          <input type='password' placeholder='Confirm Password' className='p-2 mt-2 rounded-lg text-dark' />
          <button type='submit' className='mt-6 bg-secondary hover:bg-accent text-white px-4 py-2 rounded-lg'>Register</button>
        </form>
      </div>
    </div>
  )
}

export default Register
