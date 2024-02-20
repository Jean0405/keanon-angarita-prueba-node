console.clear();
import express from "express";
import routesVersioning from "express-routes-versioning";

// VERSION 1.0.0 ENDPOINTS
import V1 from "./v1/index.js";

// CREATE EXPRESS APLICATION
const APP = express();
const VERSION = routesVersioning();

// EXPRESS MIDDLEWARES
APP.use(express.json());

//ROUTES
APP.use(
  "/",
  VERSION({
    "1.0.0": V1,
  })
);

export default APP;
