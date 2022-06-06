const { pool } = require('../utils/database');

/* Controller to retrieve data from database */
exports.getResearchers = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    /* create the connection, execute query, render data */
    pool.getConnection((err, conn) => {
        
        conn.promise().query("SELECT concat(first_name,' ',last_name) AS researcher_name FROM researcher INNER JOIN works_on ON researcher.res_id = works_on.res_id INNER JOIN project ON project.proj_id = works_on.proj_id AND project.proj_id = 233 GROUP BY researcher.res_id;")
        .then(([rows, fields]) => {
            res.render('end1.ejs', {
                pageTitle: "1st Endpoint",
                researchers: rows,
                messages: messages
            })
        })
        .then(() => pool.releaseConnection(conn))
        .catch(err => console.log(err))
    })

}