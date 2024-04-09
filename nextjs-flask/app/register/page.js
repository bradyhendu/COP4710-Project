'use client'
import React, {useState} from 'react'
import Link from 'next/link'

const Register = () => {
  const [formData, setFormData] = useState({
    username: '',
    email: '',
    password: '',
    confirmPassword: ''
  })

  const handleChange = (event) => {
    const {name, value} = event.target
    setFormData({...formData, [name]: value})
  }

  const handleSubmit = (event) => {
    event.preventDefault()
    console.log(formData)

    const response = fetch('http://localhost:3000/register', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      credentials: 'include',
      body: JSON.stringify(formData)
    })

    if (response.ok) {
      console.log('Account created successfully')
    }else {
      console.log('Failed to create account')
    }
  }

  return (
    <div className='flex flex-col items-center justify-center h-screen text-center'>
      <div className='bg-primary p-8 rounded-xl'>
        <h1 className="text-5xl font-bold">Create an account</h1>
        <p className='mt-2'>Already have an account? <Link href='/login' className='text-secondary hover:text-accent'>Login</Link></p>
        <form className='mt-6 flex flex-col items-center' onSubmit={handleSubmit}>
          <label htmlFor='username'>Username</label>
          <input type='text' placeholder='Username' className='p-2 rounded-lg text-dark' name='username' value={formData.username} onChange={handleChange}/>
          <label htmlFor='email' className='mt-2'>Email</label>
          <input type='email' placeholder='Email' className='p-2  rounded-lg text-dark' name='email' value={formData.email} onChange={handleChange}/>
          <label htmlFor='password' className='mt-2'>Password</label>
          <input type='password' placeholder='Password' className='p-2 rounded-lg text-dark' name='password' value={formData.password} onChange={handleChange}/>
          <label htmlFor='confirmPassword' className='mt-2'>Confirm Password</label>
          <input type='password' placeholder='Confirm Password' className='p-2 rounded-lg text-dark' name='confirmPassword' value={formData.confirmPassword} onChange={handleChange}/>
          <button type='submit' className='mt-6 bg-secondary hover:bg-accent text-white px-4 py-2 rounded-lg'>Register</button>
        </form>
      </div>
    </div>
  )
}

export default Register
