import { connectionDB } from "../databases/connectionDB.js";

const DB = await connectionDB();

/**
 * * ADD PRODUCTS TO THE CART
 */
export const addProductsToCart = async (data) => {
  const query = `INSERT INTO carritos (id_producto, id_tienda, id_user, cantidad) VALUES (?,?,?,?)`;
  const values = [
    data.id_producto,
    data.id_tienda,
    data.id_user || 1,
    data.cantidad,
  ];

  const result = await DB.query(query, values);
  return result;
};
