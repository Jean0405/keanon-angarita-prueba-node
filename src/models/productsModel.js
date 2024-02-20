import { connectionDB } from "../databases/connectionDB.js";

const DB = await connectionDB();

/**
 * * ADD A NEW PRODUCT MODEL
 */
export const createNewProduct = async (product) => {
  const query = `INSERT INTO productos (nombre, barcode, presentacion) VALUES (?,?,?)`;
  const values = [product.name, product.barcode, product.presentation];

  const result = await DB.query(query, values);
  return result;
};

/**
 * * FIND PRODUCT BY BARCODE
 */
export const findProductByBarcode = async (barcode) => {
  const query = `SELECT * FROM productos WHERE barcode = ?`;
  const values = [barcode];

  const [rows] = await DB.query(query, values);
  return rows;
};

/**
 * * ADD PRODUCT TO A STORE
 */
export const addProductToStore = async (data) => {
  const query = `INSERT INTO tiendas_productos (id_producto, id_tienda, valor, compra_maxima) VALUES(?,?,?,?)`;
  const values = [
    data.id_product,
    data.id_store,
    data.value,
    data.max_purchase,
  ];

  const result = await DB.query(query, values);
  return result;
};
