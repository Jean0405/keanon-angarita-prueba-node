import { Router } from "express";
import * as cartControllers from "../../controllers/cartControllers.js";

const v1CartRoutes = Router();

v1CartRoutes.post("/", cartControllers.addProductsToCart);

export default v1CartRoutes;
