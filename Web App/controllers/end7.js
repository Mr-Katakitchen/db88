const { pool } = require('../utils/database');

/* Controller to retrieve data from database */
exports.getExec = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    /* create the connection, execute query, render data */
    pool.getConnection((err, conn) => {
        
        conn.promise().query("SELECT concat(executive.first_name, ' ', executive.last_name) AS executive_name, organization.name AS company_name, sum(project.budget) AS total_fund FROM executive INNER JOIN project ON project.exec_id = executive.exec_id INNER JOIN organization ON organization.org_id = project.org_id INNER JOIN company ON organization.org_id = company.org_id GROUP BY executive.exec_id, company.org_id ORDER BY total_fund DESC LIMIT 5;")
        .then(([rows, fields]) => {
            res.render('end7.ejs', {
                pageTitle: "7th Endpoint",
                exec_comp: rows,
                messages: messages
            })
        })
        .then(() => pool.releaseConnection(conn))
        .catch(err => console.log(err))
    })

}