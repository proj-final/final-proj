import './App.css';
import Navbar from './Components/HomePage/1-Navbar.jsx/Navbar';
import Hero from "./Components/HomePage/2-HeroSection/Hero";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";


const LayoutWithNavbarAndHero = ({ children }) => {
  return (
    <>
      <Navbar 
      />
      <Hero />
      {children}
    </>
  );
};



function App() {
  return(
    <Router>
      <Routes>
        <Route  path="/" element={<LayoutWithNavbarAndHero />}   />
      </Routes>
    </Router>
  )
}

export default App;
