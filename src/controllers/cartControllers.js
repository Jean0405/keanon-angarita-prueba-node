import * as cartServices from "../services/cartServices.js";

/**
 * * ADD PRODUCTS TO THE CART
 */
export const addProductsToCart = async (req, res) => {
  try {
    const result = await cartServices.addProductsToCart(req.body);
    res.status(result.status).send(result);
  } catch (error) {
    res.status(500).send({ status: error.status, error: error.message });
  }
};
