import * as productServices from "../services/productServices.js";

/**
 * * ADD A NEW PRODUCT CONTROLLER
 */
export const createNewProduct = async (req, res) => {
  try {
    const result = await productServices.createNewProduct(req.body);
    res.status(result.status).send(result);
  } catch (error) {
    res.status(500).send({ status: error.status, error: error.message });
  }
};

/**
 * * ADD PRODUCT TO A STORE
 */
export const addProductToStore = async (req, res) => {
  try {
    const result = await productServices.addProductToStore(req.body);
    res.status(result.status).send(result);
  } catch (error) {
    res.status(500).send({ status: error.status, error: error.message });
  }
};
