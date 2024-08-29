import type { AppProps } from "next/app";
import Head from 'next/head';
import Favicon from '../public/favicon.ico';

import { NextUIProvider } from "@nextui-org/system";
import { ThemeProvider as NextThemesProvider } from "next-themes";
import { useRouter } from "next/router";

import { fontSans, fontMono } from "@/config/fonts";
import "@/styles/globals.css";

export default function App({ Component, pageProps }: AppProps) {
  const router = useRouter();

  return (
    <div>
      <Head>
        <title>Mi Aplicación</title>
        <meta name="description" content="Descripción de mi aplicación." />
        <link rel="shortcut icon" href={Favicon.src} type="image/x-icon" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
      </Head> 

      <NextUIProvider navigate={router.push}>
        <NextThemesProvider>
          <Component {...pageProps} />
        </NextThemesProvider>
      </NextUIProvider>
    </div>
  );
}

export const fonts = {
  sans: fontSans.style.fontFamily,
  mono: fontMono.style.fontFamily,
};
