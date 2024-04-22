'use client';
import React, { useState, useEffect} from 'react';
import AppBar from '@mui/material/AppBar';
import Box from '@mui/material/Box';
import Toolbar from '@mui/material/Toolbar';
import IconButton from '@mui/material/IconButton';
import Typography from '@mui/material/Typography';
import Menu from '@mui/material/Menu';
import MenuIcon from '@mui/icons-material/Menu';
import Container from '@mui/material/Container';
import Button from '@mui/material/Button';
import AccountCircle from '@mui/icons-material/AccountCircle';
import MenuItem from '@mui/material/MenuItem';
import Link from 'next/link';
import LocalMoviesIcon from '@mui/icons-material/LocalMovies';

const pages = ['movies', 'actors', 'genres'];

function Navbar() {
  const [auth, setAuth] = useState(false);
  const [anchorElNav, setAnchorElNav] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [username, setUsername] = useState('');

  const handleOpenNavMenu = (event) => {
    setAnchorElNav(event.currentTarget);
  };

  const handleCloseNavMenu = () => {
    setAnchorElNav(null);
  };

  const handleLogout = async () => {
    try {
      const response = await fetch('http://localhost:8080/logout', {
        method: 'POST',
        credentials: 'include',
      });
      const data = await response.json();
      if (data.message === 'success') {
        setAuth(false);
        setUsername('');
      }
    } catch (error) {
      console.error('An error occurred while logging out:', error);
    }
  };

  const fetchUser = async () => {
    try {
      const response = await fetch('http://localhost:8080/check_session',{
        credentials: 'include',
      });
      const data = await response.json();
      if (data.username) {
        setAuth(true);
        setUsername(data.username);
      }else{
        setAuth(false);
      }
      setIsLoading(false);
    } catch (error) {
      console.error('An error occurred while fetching user data:', error);
    }
  };

  useEffect(() => {
    fetchUser();
  }, []);

  return (
    <AppBar position="static">
      <Container maxWidth="xl">
        <Toolbar disableGutters>
          {isLoading ? (
            <Typography>Loading...</Typography>
          ) : (
            <>
              <LocalMoviesIcon sx={{ display: { xs: 'none', md: 'flex' }, mr: 1 }} />
              <Link href="/">
                <Typography
                  variant="h6"
                  noWrap
                  component="a"
                  href="#app-bar-with-responsive-menu"
                  sx={{
                    mr: 2,
                    display: { xs: 'none', md: 'flex' },
                    fontFamily: 'monospace',
                    fontWeight: 700,
                    letterSpacing: '.3rem',
                    color: 'inherit',
                    textDecoration: 'none',
                  }}
                >
                  CINEFAN
                </Typography>
              </Link>

              <Box sx={{ flexGrow: 1, display: { xs: 'flex', md: 'none' } }}>
                <IconButton
                  size="large"
                  aria-label="account of current user"
                  aria-controls="menu-appbar"
                  aria-haspopup="true"
                  onClick={handleOpenNavMenu}
                  color="inherit"
                >
                  <MenuIcon />
                </IconButton>
                <Menu
                  id="menu-appbar"
                  anchorEl={anchorElNav}
                  anchorOrigin={{
                    vertical: 'bottom',
                    horizontal: 'left',
                  }}
                  keepMounted
                  transformOrigin={{
                    vertical: 'top',
                    horizontal: 'left',
                  }}
                  open={Boolean(anchorElNav)}
                  onClose={handleCloseNavMenu}
                  sx={{
                    display: { xs: 'block', md: 'none' },
                  }}
                >
                  {pages.map((page) => (
                    <MenuItem key={page} onClick={handleCloseNavMenu}>
                      <Typography textAlign="center"><Link href={'/' + page}>{page}</Link></Typography>
                    </MenuItem>
                  ))}
                </Menu>
              </Box>
              <Link href="/">
                <Typography
                  variant="h5"
                  noWrap
                  component="a"
                  href="#app-bar-with-responsive-menu"
                  sx={{
                    mr: 2,
                    display: { xs: 'flex', md: 'none' },
                    flexGrow: 1,
                    fontFamily: 'monospace',
                    fontWeight: 700,
                    letterSpacing: '.3rem',
                    color: 'inhert',
                    textDecoratioin: 'none',
                  }}
                >
                  CINEFAN
                </Typography>
              </Link>
              <Box sx={{ flexGrow: 1, display: { xs: 'none', md: 'flex' } }}>
                {pages.map((page) => (
                  <Button
                    key={page}
                    onClick={handleCloseNavMenu}
                    sx={{ my: 2, color: 'white', display: 'block' }}
                  >
                    <Link href={'/' + page}>{page}</Link>
                  </Button>
                ))}
              </Box>
              {auth ? (
                <div>
                  <Link href='/user'>
                    {username}'s Profile
                  </Link>
                  <Link href="/login">
                    <button className='m-2 bg-primary hover:bg-red-600 hover:text-dark text-muted py-2 px-4 rounded' onClick={handleLogout}>Logout</button>
                  </Link>
                </div>
              ) : (
                <div>
                  <Link href="/login">
                    <button className='m-2 bg-primary hover:bg-secondary hover:text-dark text-muted py-2 px-4 rounded'>Login</button>
                  </Link>
                  <Link href="/register">
                    <button className='m-2 bg-primary hover:bg-secondary hover:text-dark text-muted py-2 px-4 rounded'>Register</button>
                  </Link>
                </div>
              )}
            </>
          )}
        </Toolbar>
      </Container>
    </AppBar>
  );
}

export default Navbar;
