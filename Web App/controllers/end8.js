const { pool } = require('../utils/database');

/* Controller to retrieve students from database */
exports.getResearchers = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    /* create the connection, execute query, render data */
    pool.getConnection((err, conn) => {
        
        conn.promise().query("SELECT concat(first_name, ' ', last_name) AS researcher_name, projects FROM taskless_proj_count_per_res WHERE projects >= 5;")
        .then(([rows, fields]) => {
            res.render('end8.ejs', {
                pageTitle: "8th Endpoint",
                researchers: rows,
                messages: messages
            })
        })
        .then(() => pool.releaseConnection(conn))
        .catch(err => console.log(err))
    })

}