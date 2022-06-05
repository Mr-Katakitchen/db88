const { pool } = require('../utils/database');

/* Controller to retrieve students from database */
exports.getFieldData = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    /* create the connection, execute query, render data */
    pool.getConnection((err, conn) => {
        
        /* execute query to get projects */
        let projectsPromise = new Promise((resolve, reject) => { 
            conn.promise()
            .query("SELECT scientific_field.title, project.title FROM field_project INNER JOIN scientific_field ON scientific_field.field_id = field_project.field_id INNER JOIN project ON project.proj_id = field_project.proj_id WHERE scientific_field.title = 'Epidemiology' and project.ends_on > sysdate() GROUP BY project.proj_id;")
            .then(([rows, fields]) => {
                projects = rows;
                resolve();
             })
            .then(() => pool.releaseConnection(conn))
            .catch(err => console.log(err))
        })

        /* execute query to get researchers */
        let researchersPromise = new Promise((resolve, reject) => { 
            conn.promise()
            .query("SELECT scientific_field.title, concat(first_name, ' ', last_name) AS researcher_name FROM field_project INNER JOIN scientific_field ON scientific_field.field_id = field_project.field_id INNER JOIN project ON project.proj_id = field_project.proj_id INNER JOIN works_on ON works_on.proj_id = project.proj_id INNER JOIN researcher ON researcher.res_id = works_on.res_id WHERE scientific_field.title = 'Epidemiology' and project.started_on >= adddate(sysdate(), INTERVAL -1 YEAR) GROUP BY researcher.res_id;")
            .then(([rows, fields]) => {
                researchers = rows;
                resolve();
             })
            .then(() => pool.releaseConnection(conn))
            .catch(err => console.log(err))
        })

        /* when queries promises finish render respective data */
        Promise.all([projectsPromise, researchersPromise]).then(() => {
            res.render('end3.ejs', {
                pageTitle: "3th Endpoint",
                projects,
                researchers,
                messages
            })
        });    
    })

}