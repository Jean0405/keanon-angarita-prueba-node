import "dotenv/config";

export const server = {
  PORT: process.env.PORT || 3300,
  HOSTNAME: process.env.HOST || "127.25.25.27",
};

export const database = {
  hostname: process.env.BD_HOSTNAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
  port: process.env.DB_PORT,
};
