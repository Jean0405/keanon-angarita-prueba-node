import { Router } from "express";
import * as storeControllers from "../../controllers/storeControllers.js";

const v1StoreRoutes = Router();

v1StoreRoutes.get(
  "/:storeId/catalogue",
  storeControllers.listStoreProductsById
);

export default v1StoreRoutes;
