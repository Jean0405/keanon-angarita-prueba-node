import { Router } from "express";
import v1ProductsRoutes from "./routes/productRoutes.js";
import v1StoreRoutes from "./routes/storeRoutes.js";
import v1CartRoutes from "./routes/cartRoutes.js";

const V1 = Router();

V1.use("/product", v1ProductsRoutes);
V1.use("/store", v1StoreRoutes);
V1.use("/cart", v1CartRoutes);

export default V1;
