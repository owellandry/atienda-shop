import React from "react";
import { Button, Image } from "@nextui-org/react";
import { FaShareAlt, FaHeart, FaShoppingCart } from "react-icons/fa";
import { ImUser } from "react-icons/im";
import '@/styles/cards.css';

const featuredData = [
    {
        imgSrc: "https://app.requestly.io/delay/5000/https://nextui-docs-v2.vercel.app/images/hero-card-complete.jpeg",
        name: "NombreLargoEjemplo1",
        category: "CategoríaLargaEjemplo1"
    },
    {
        imgSrc: "https://app.requestly.io/delay/5000/https://nextui-docs-v2.vercel.app/images/hero-card-complete.jpeg",
        name: "NombreLargoEjemplo1",
        category: "CategoríaLargaEjemplo1"
    },
    {
        imgSrc: "https://app.requestly.io/delay/5000/https://nextui-docs-v2.vercel.app/images/hero-card-complete.jpeg",
        name: "NombreLargoEjemplo1",
        category: "CategoríaLargaEjemplo1"
    },
    {
        imgSrc: "https://i.pinimg.com/originals/8b/45/8c/8b458cff3eaad5a21d9d1832812aa1c0.jpg",
        name: "NombreLargoEjemplo1",
        category: "CategoríaLargaEjemplo1"
    },
    {
        imgSrc: "https://thumbs.dreamstime.com/b/blue-white-paint-background-thick-brush-strokes-texture-oil-painted-design-abstract-art-223822745.jpg",
        name: "NombreLargoEjemplo1",
        category: "CategoríaLargaEjemplo1"
    },
    {
        imgSrc: "https://app.requestly.io/delay/5000/https://nextui-docs-v2.vercel.app/images/hero-card-complete.jpeg",
        name: "NombreLargoEjemplo1",
        category: "CategoríaLargaEjemplo1"
    },

];

export default function Destacadas() {
    return (
        <div className="container">
            <div className="header">
                <h1 className="title">Destacadas</h1>
                <h3 className="view-all">VER TODO</h3>
            </div>
            <div className="cards-wrapper">
                {featuredData.map((card, index) => (
                    <div className="card" key={index}>
                        <div className="image-wrapper">
                            <Image
                                width={300}
                                height={200}
                                alt={`Card Image ${index + 1}`}
                                src={card.imgSrc}
                            />
                            <div className="profile-overlay">
                                <ImUser className="profile-icon" />
                                <div className="profile-menu">
                                    <div className="profile-info">
                                        <p className="profile-name">{card.name}</p>
                                        <p className="profile-category">{card.category}</p>
                                    </div>
                                    <div className="profile-actions">
                                        <Button className="view-profile-button">Ver Perfil</Button>
                                    </div>
                                </div>
                            </div>
                            <div className="icons-overlay">
                                <Button color="primary" className="card-button">
                                    <FaShareAlt />
                                </Button>
                                <Button color="success" className="card-button">
                                    <FaHeart />
                                </Button>
                                <Button color="warning" className="card-button">
                                    <FaShoppingCart />
                                </Button>
                            </div>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}
