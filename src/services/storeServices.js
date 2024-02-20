import * as storeModels from "../models/storesModel.js";

/**
 * * LIST ALL STORE PRODUCTS BY ID STORE
 */
export const listStoreProductsById = async (storeId) => {
  const result = await storeModels.listStoreProductsById(Number(storeId));

  return {
    status: 200,
    message: "Correctly obtained catalog",
    products: result,
  };
};
