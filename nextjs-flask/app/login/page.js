'use client'
import React, {useState} from 'react'
import Link from 'next/link'

const Login = () => {
  const [formData, setFormData] = useState({
    username: '',
    password: ''
  })

  const handleChange = (event) => {
    const {name, value} = event.target
    setFormData({...formData, [name]: value})
  }

  const handleSubmit = (event) => {
    event.preventDefault()
    console.log(formData)

    const response = fetch('http://localhost:3000/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      credentials: 'include',
      body: JSON.stringify(formData)
    })

    if (response.ok) {
      console.log('Logged in successfully')
    }else {
      console.log('Failed to login')
    }
  }

  return (
    <div className='flex flex-col items-center justify-center h-screen text-center'>
      <div className='bg-primary p-8 rounded-xl'>
        <h1 className="text-5xl font-bold">Welcome Back!</h1>
        <p className='mt-2'>Need an account? <Link href='/register' className='text-secondary hover:text-accent'>Register</Link></p>
        <form className='mt-6 flex flex-col items-center' onSubmit={handleSubmit}>
          <label htmlFor='username'>Username</label>
          <input type='text' placeholder='Username' className='p-2 rounded-lg text-dark' name='username' value={formData.username} onChange={handleChange}/>
          <label htmlFor='password' className='mt-2'>Password</label>
          <input type='password' placeholder='Password' className='p-2 rounded-lg text-dark' name='password' value={formData.password} onChange={handleChange} />
          <button type='submit' className='mt-6 bg-secondary hover:bg-accent text-white px-4 py-2 rounded-lg'>Register</button>
        </form>
      </div>
    </div>
  )
}

export default Login
