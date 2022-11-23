import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../Home";
import MediaGallery from "../MediaGallery";

export default (
  <Router>
    <Routes>
      <Route path="/" element={<MediaGallery path="asdas" filesPath="asdasda" groupsPath="asdasdasda"/>} />
    </Routes>
  </Router>
);
