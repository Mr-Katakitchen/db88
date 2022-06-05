const { pool } = require('../utils/database');

/* Controller to retrieve students from database */
exports.getResearchers = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    /* create the connection, execute query, render data */
    pool.getConnection((err, conn) => {
        
        conn.promise().query("SELECT concat(first_name, ' ', last_name) AS researcher_name, age, projects FROM proj_count_per_res WHERE projects = (SELECT max(projects) FROM proj_count_per_res WHERE birthdate > adddate(sysdate(), INTERVAL -40 YEAR)) AND birthdate > adddate(sysdate(), INTERVAL -40 YEAR) ORDER BY age;")
        .then(([rows, fields]) => {
            res.render('end6.ejs', {
                pageTitle: "6th Endpoint",
                researchers: rows,
                messages: messages
            })
        })
        .then(() => pool.releaseConnection(conn))
        .catch(err => console.log(err))
    })

}