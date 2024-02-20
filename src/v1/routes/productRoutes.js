import { Router } from "express";
import * as productControllers from "../../controllers/productControllers.js";

const v1ProductsRoutes = Router();

v1ProductsRoutes.post("/", productControllers.createNewProduct);
v1ProductsRoutes.post("/addToStore", productControllers.addProductToStore);

export default v1ProductsRoutes;
