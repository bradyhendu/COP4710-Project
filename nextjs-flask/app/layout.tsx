import './globals.css'
import { Inter } from 'next/font/google'

import Navbar from "../components/Navbar";

const inter = Inter({ subsets: ['latin'] })

export const metadata = {
  title: 'CineFan',
  description: 'Cinefan is a movie recommendation app.',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className={'w-full ' + inter.className}>
        <Navbar />
        {children}
      </body>
    </html>
  )
}
