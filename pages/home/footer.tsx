import React from 'react';
import Link from 'next/link';
import { FaFacebook, FaTwitter, FaInstagram, FaLinkedin } from 'react-icons/fa';
import '@/styles/footer.css';

export default function Footer() {
    return (
        <footer className="footer">
            <div className="footer-container">
                <div className="footer-logo">
                    <h1>MiApp</h1>
                </div>
                <div className="footer-links">
                    {/* Enlaces internos usando el componente Link */}
                    <Link href="#about" legacyBehavior>
                        <a className="footer-link">About Us</a>
                    </Link>
                    <Link href="#services" legacyBehavior>
                        <a className="footer-link">Services</a>
                    </Link>
                    <Link href="#contact" legacyBehavior>
                        <a className="footer-link">Contact</a>
                    </Link>
                </div>
                <div className="footer-social">
                    {/* Enlaces externos usando el componente Link con legacyBehavior */}
                    <Link href="https://facebook.com" legacyBehavior>
                        <a className="social-icon" target="_blank" rel="noopener noreferrer">
                            <FaFacebook />
                        </a>
                    </Link>
                    <Link href="https://twitter.com" legacyBehavior>
                        <a className="social-icon" target="_blank" rel="noopener noreferrer">
                            <FaTwitter />
                        </a>
                    </Link>
                    <Link href="https://instagram.com" legacyBehavior>
                        <a className="social-icon" target="_blank" rel="noopener noreferrer">
                            <FaInstagram />
                        </a>
                    </Link>
                    <Link href="https://linkedin.com" legacyBehavior>
                        <a className="social-icon" target="_blank" rel="noopener noreferrer">
                            <FaLinkedin />
                        </a>
                    </Link>
                </div>
            </div>
            <div className="footer-bottom">
                <p>&copy; {new Date().getFullYear()} MiApp. All rights reserved.</p>
            </div>
        </footer>
    );
}
