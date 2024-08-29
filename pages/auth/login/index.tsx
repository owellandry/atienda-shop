import React from 'react';
import { Button, Image } from '@nextui-org/react';
import { FaGoogle, FaFacebookF, FaApple } from 'react-icons/fa';
import '../../../styles/LoginPage.css';
import ImgLogin from '@/assets/images/LoginImages.jpg';

export default function LoginPage() {
  return (
    <div className="login-container">
      <div className="illustration">
        <Image src={ImgLogin.src} alt="Illustration" width={400} height={400} />
      </div>
      <div className="login-form">
        <h2>INICIAR SESION</h2>
        <form>
          <div className="inputGroup">
            <label htmlFor="email">Correo electrónico</label>
            <input type="email" id="email" placeholder="daniel21fisher@gmail.com" />
          </div>
          <div className="inputGroup">
            <label htmlFor="password">Contraseña</label>
            <input type="password" id="password" placeholder="••••••••" />
          </div>
          <div className="options">
            <a href="#" className="forgot-password">¿Has olvidado tu contraseña?</a>
          </div>
          <Button type="submit" className="login-button" color="primary" >
            INICIAR SESION
          </Button>
        </form>
        <div className="divider">
          <span>O continuar con</span>
        </div>
        <div className="social-login">
          <Button className="google"><FaGoogle /></Button>
          <Button className="facebook"><FaFacebookF /></Button>
          <Button className="apple"><FaApple /></Button>
        </div>
        <div className="signup-link">
          <span>No tienes cuenta? <a href="/register">Regístrate aquí</a></span>
        </div>
      </div>
    </div>
  );
}
