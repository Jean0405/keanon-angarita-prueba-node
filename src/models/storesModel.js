import { connectionDB } from "../databases/connectionDB.js";

const DB = await connectionDB();

/**
 * * LIST ALL STORE PRODUCTS BY ID STORE
 */
export const listStoreProductsById = async (storeId) => {
  const query = `SELECT s.id_producto, s.id_tienda, p.nombre, p.presentacion, p.barcode, s.valor 
  FROM tiendas_productos as s
      INNER JOIN tiendas as t ON s.id_tienda = t.id
      INNER JOIN productos as p ON s.id_producto = p.id
  WHERE
      s.id_tienda = 4`;
  const values = [storeId];

  const [rows] = await DB.query(query, values);
  return rows;
};

