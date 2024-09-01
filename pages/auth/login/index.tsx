import React, { useEffect } from 'react';
import { useSession, signIn } from 'next-auth/react';
import { useRouter } from 'next/router';
import { Button, Image } from '@nextui-org/react';
import { FaGoogle, FaFacebookF, FaApple } from 'react-icons/fa';
import '../../../styles/LoginPage.css';
import ImgLogin from '@/assets/images/LoginImages.jpg';

export default function LoginPage() {
  const { data: session, status } = useSession();
  const router = useRouter();

  useEffect(() => {
    if (status === 'authenticated') {
      router.push('/'); // Redirige al usuario a la página principal si ya está autenticado
    }
  }, [status, router]);

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
          <Button onClick={() => signIn('credentials')} type="submit" className="login-button" color="primary" >
            INICIAR SESION
          </Button>
        </form>
        <div className="divider">
          <span>O continuar con</span>
        </div>
        <div className="social-login">
          <Button onClick={() => signIn('google')} className="google"><FaGoogle /></Button>
          <Button onClick={() => signIn('facebook')} className="facebook"><FaFacebookF /></Button>
          <Button onClick={() => signIn('apple')} className="apple"><FaApple /></Button>
        </div>
        <div className="signup-link">
          <span>No tienes cuenta? <a href="/register">Regístrate aquí</a></span>
        </div>
      </div>
    </div>
  );
}
