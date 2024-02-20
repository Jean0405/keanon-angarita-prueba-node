import * as productModels from "../models/productsModel.js";

/**
 * * ADD A NEW PRODUCT SERVICE
 */
export const createNewProduct = async (product) => {
  const existingProduct = await productModels.findProductByBarcode(
    product.barcode
  );
  // Validate if product already exists
  if (existingProduct.length > 0) {
    return {
      status: 400,
      message: `Product already exists with this barcode (${product.barcode})`,
    };
  }

  await productModels.createNewProduct(product);
  return { status: 200, message: "Product added" };
};

/**
 * * ADD PRODUCT TO A STORE
 */
export const addProductToStore = async (data) => {
  await productModels.addProductToStore(data);
  return {
    status: 200,
    message: `Product ${data.id_product} added to store ${data.id_store}`,
  };
};
