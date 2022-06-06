const { pool } = require('../utils/database');

/* Controller to retrieve data from database */
exports.getFields = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    /* create the connection, execute query, render data */
    pool.getConnection((err, conn) => {
        
        conn.promise().query("SELECT title1 AS field1, title2 AS field2, count(proj_id) AS  projects FROM field_pair WHERE id1 > id2 GROUP by id1, id2 ORDER BY projects DESC, id1 desc LIMIT 3;")
        .then(([rows, fields]) => {
            res.render('end5.ejs', {
                pageTitle: "5th Endpoint",
                field_list: rows,
                messages: messages
            })
        })
        .then(() => pool.releaseConnection(conn))
        .catch(err => console.log(err))
    })

}