const mysql = require('mysql2');

/* create connection and export it */
const pool = mysql.createPool({
    host: "localhost",
    port: "3306",
    user: "root",
    password: "",
    database: "elidek",
});

module.exports = { pool };