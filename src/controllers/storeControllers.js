import * as storeServices from "../services/storeServices.js";

/**
 * * LIST ALL STORE PRODUCTS BY ID STORE
 */
export const listStoreProductsById = async (req, res) => {
  const { storeId } = req.params;
  try {
    const result = await storeServices.listStoreProductsById(storeId);
    res.status(result.status).send(result);
  } catch (error) {
    res.status(500).send({ status: error.status, error: error.message });
  }
};
