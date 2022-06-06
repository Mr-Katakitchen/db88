const { pool } = require('../utils/database');

/* Controller to retrieve data from database */
exports.getProjects = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    /* create the connection, execute query, render data */
    pool.getConnection((err, conn) => {
        
        conn.promise().query("SELECT concat(first_name, ' ', last_name) AS researcher_name, title AS project_title, budget, started_on, ends_on FROM project INNER JOIN works_on ON works_on.proj_id = project.proj_id INNER JOIN researcher ON researcher.res_id = works_on.res_id WHERE researcher.res_id = 100 GROUP BY project.proj_id;")
        .then(([rows, fields]) => {
            res.render('end2.1.ejs', {
                pageTitle: "2nd Endpoint",
                projects: rows,
                messages: messages
            })
        })
        .then(() => pool.releaseConnection(conn))
        .catch(err => console.log(err))
    })

}