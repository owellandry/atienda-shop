import NextAuth from 'next-auth';
import GoogleProvider from 'next-auth/providers/google';

const handler = NextAuth({
  providers: [
    GoogleProvider({
      clientId: process.env.GOOGLE_CLIENT_ID as string,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET as string,
      authorization: {
        params: {
          redirect_uri: process.env.NEXTAUTH_URL + "/api/auth/callback/google"
        }
      }
    })
  ],
  callbacks: {
    async redirect({ url, baseUrl }) {
      // Permitir redirección solo si es segura (misma base URL)
      if (url.startsWith(baseUrl)) return url
      return baseUrl
    },
  }
});

export default handler;
