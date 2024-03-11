import './globals.css'
import { Inter } from 'next/font/google'

import Navbar from "../components/Navbar";
import ThemeWrapper from "../components/theme";

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
      <body className={inter.className}>
        <Navbar />
        {children}
      </body>
    </html>
  )
}
