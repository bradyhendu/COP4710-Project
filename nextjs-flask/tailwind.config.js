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
        'secondary': '#702936',
        'light': '#091118',
        'accent': '#cc5562',
        'dark': '#e9f0f7',
      }
      },
  },
  plugins: [],
};
