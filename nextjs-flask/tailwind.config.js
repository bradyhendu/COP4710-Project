/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      backgroundImage: {
        'hero-pattern': "url('../images/movies.jpg')",
      },
      colors: {
        'primary': '#1976D2',
        'secondary': '#D27519',
        'light': '#091118',
        'accent': '#689BCE',
        'dark': '#010104',
      }
      },
  },
  plugins: [],
};
