import React from "react";
import Home from "./home/header";
import Recientes from "./home/cardsRecientes";
import Categoria from "./home/categorias";
import Destacadas from "./home/cardsDestacadas";
import Footer from "./home/footer";
import Top from "./home/tiendasTop";

export default function App() {
  return (
    <>
      <Home />
      <Destacadas />
      <Categoria />
      <Recientes />
      <div style={{ marginTop: "400px"}}></div>
      <Top />
      <div style={{ marginBottom: "300px"}}></div>
      <Footer />
    </>
  );
}
