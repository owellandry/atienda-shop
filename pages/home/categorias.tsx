import React from 'react';
import { FaPaintBrush, FaCode, FaCamera, FaMusic, FaFilm, FaEdit, FaPencilAlt, FaBook, FaCoffee, FaLaptop, FaGamepad, FaGift, FaTree, FaChartLine, FaDumbbell, FaApple } from 'react-icons/fa';
import '@/styles/categorias.css';

const categories = [
    { icon: <FaPaintBrush />, label: 'Diseño' },
    { icon: <FaCode />, label: 'Desarrollo' },
    { icon: <FaCamera />, label: 'Fotografía' },
    { icon: <FaMusic />, label: 'Música' },
    { icon: <FaFilm />, label: 'Cine' },
    { icon: <FaEdit />, label: 'Redacción' },
    { icon: <FaPencilAlt />, label: 'Ilustración' },
    { icon: <FaBook />, label: 'Literatura' },
    { icon: <FaCoffee />, label: 'Café' },
    { icon: <FaLaptop />, label: 'Tecnología' },
    { icon: <FaGamepad />, label: 'Videojuegos' },
    { icon: <FaGift />, label: 'Regalos' },
    { icon: <FaTree />, label: 'Naturaleza' },
    { icon: <FaChartLine />, label: 'Finanzas' },
    { icon: <FaDumbbell />, label: 'Fitness' },
    { icon: <FaApple />, label: 'Gastronomía' }
];

export default function CategoriesGrid() {
    return (
        <div className="container">
            <div className="categories-header">
                <h1 className="categories-title">Categorías</h1>
                <a href="#" className="view-all">VER TODO</a>
            </div>
            <div className="categories-grid">
                {categories.map((category, index) => (
                    <div className="category-item" key={index}>
                        <div className="category-icon">{category.icon}</div>
                        <div className="category-label">{category.label}</div>
                    </div>
                ))}
            </div>
        </div>
    );
}
