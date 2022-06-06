const { pool } = require('../utils/database');

/* Controller to retrieve data from database */
exports.getEvaluations = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    /* create the connection, execute query, render data */
    pool.getConnection((err, conn) => {
        
        conn.promise().query("SELECT concat(first_name,' ',last_name) AS researcher_name, title AS evaluated_project, started_on AS project_started_on, proj_id AS project_id, grade AS grade_given, date AS evaluation_date FROM evaluation WHERE res_id = 13 GROUP BY proj_id;")
        .then(([rows, fields]) => {
            res.render('end2.2.ejs', {
                pageTitle: "2nd Endpoint",
                evaluations: rows,
                messages: messages
            })
        })
        .then(() => pool.releaseConnection(conn))
        .catch(err => console.log(err))
    })

}