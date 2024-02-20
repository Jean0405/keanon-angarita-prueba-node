import mysql2 from "mysql2/promise";
import { database } from "../config/environments.js";

export async function connectionDB() {
  try {
    //initialize connection
    let connection = undefined;
    //make connection
    connection = mysql2.createPool(database);
    return connection;
  } catch (error) {
    throw new Error("Error creating db connection");
  }
}
