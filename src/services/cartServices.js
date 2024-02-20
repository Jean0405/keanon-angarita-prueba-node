import * as cartModels from "../models/cartsModels.js";

/**
 * * ADD PRODUCTS TO THE CART
 */
export const addProductsToCart = async (data) => {
  await cartModels.addProductsToCart(data);
  return {
    status: 200,
    message: `Product added to the cart`,
  };
};
