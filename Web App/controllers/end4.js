const { pool } = require('../utils/database');

/* Controller to retrieve students from database */
exports.getOrganizations = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    /* create the connection, execute query, render data */
    pool.getConnection((err, conn) => {
        
        conn.promise().query("SELECT org1.name AS organization_1, org2.name AS organization_2, org1.from_date AS base_date, max(org1.two_year_count) AS projects FROM biyearly_projects_per_org org1 INNER JOIN biyearly_projects_per_org org2 ON org1.org_id  <> org2.org_id WHERE org2.from_date > org1.from_date AND org2.tail_date < org1.from_date_plus_two AND org1.org_id < org2.org_id AND org1.two_year_count = org2.two_year_count AND (SELECT one_year_count FROM yearly_projects_per_org WHERE org_id = org1.org_id AND from_date = org1.from_date AND base_id = org1.base_id ) >= 10 AND (SELECT temp.one_year_count FROM yearly_projects_per_org temp WHERE temp.org_id = org1.org_id AND temp.from_date >= adddate(org1.from_date, INTERVAL 1 YEAR) AND temp.tail_date <= adddate(org1.from_date, INTERVAL 2 year) AND temp.one_year_count = (SELECT max(one_year_count) FROM yearly_projects_per_org WHERE org_id = org1.org_id AND from_date >= adddate(org1.from_date, INTERVAL 1 YEAR) AND temp.tail_date <= adddate(org1.from_date, INTERVAL 2 year)) GROUP BY temp.from_date ) >= 10 AND (SELECT one_year_count FROM yearly_projects_per_org WHERE org_id = org2.org_id AND from_date = org2.from_date AND base_id = org2.base_id ) >= 10 AND (SELECT temp.one_year_count FROM yearly_projects_per_org temp WHERE temp.org_id = org2.org_id AND temp.from_date >= adddate(org2.from_date, INTERVAL 1 YEAR) AND temp.tail_date <= adddate(org2.from_date, INTERVAL 2 year) AND temp.one_year_count = (SELECT max(one_year_count) FROM yearly_projects_per_org WHERE org_id = org2.org_id AND from_date >= adddate(org2.from_date, INTERVAL 1 YEAR) AND temp.tail_date <= adddate(org2.from_date, INTERVAL 2 year)) GROUP BY temp.from_date ) >= 10 GROUP BY org1.org_id, org2.org_id, org1.from_date ORDER BY projects desc;")
        .then(([rows, fields]) => {
            res.render('end4.ejs', {
                pageTitle: "4th Endpoint",
                organizations: rows,
                messages: messages
            })
        })
        .then(() => pool.releaseConnection(conn))
        .catch(err => console.log(err))
    })

}