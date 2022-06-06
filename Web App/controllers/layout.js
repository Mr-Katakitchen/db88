const { pool } = require('../utils/database');

/* Controller to render data shown in landing page */
exports.getLanding = (req, res, next) => {

    /* check for messages in order to show them when rendering the page */
    let messages = req.flash("messages");
    if (messages.length == 0) messages = [];

    let number_of_projects, number_of_researchers, number_of_organizations;

    /* create the connection */
    pool.getConnection((err, conn) => {

        /* execute query to get number_of_projects */
        let projectsPromise = new Promise((resolve, reject) => {
            conn.promise()
            .query("SELECT COUNT(*) AS total FROM project")
            .then(([rows, fields]) => {
                number_of_projects = rows[0].total;
                resolve();
             })
            .then(() => pool.releaseConnection(conn))
            .catch(err => console.log(err))
        })

        /* execute query to get number_of_researchers */
        let researchersPromise = new Promise((resolve, reject) => { 
            conn.promise()
            .query("SELECT COUNT(*) AS total FROM researcher")
            .then(([rows, fields]) => {
                number_of_researchers = rows[0].total;
                resolve();
             })
            .then(() => pool.releaseConnection(conn))
            .catch(err => console.log(err))
        })

        /* execute query to get number_of_organizations */
        let organizationsPromise = new Promise((resolve, reject) => { 
            conn.promise()
            .query("SELECT COUNT(*) AS total FROM organization")
            .then(([rows, fields]) => {
                number_of_organizations = rows[0].total;
                resolve();
             })
            .then(() => pool.releaseConnection(conn))
            .catch(err => console.log(err))
        })

        /* execute query to get scientific fields */
        let fieldsPromise = new Promise((resolve, reject) => { 
            conn.promise()
            .query("SELECT title FROM scientific_field")
            .then(([rows, fields]) => {
                field_list = rows;
                resolve();
             })
            .then(() => pool.releaseConnection(conn))
            .catch(err => console.log(err))
        })

        /* execute query to get researcher */
        let resNamePromise = new Promise((resolve, reject) => { 
            conn.promise()
            .query("SELECT concat(first_name, ' ', last_name) AS name FROM researcher")
            .then(([rows, fields]) => {
                researcher_list = rows;
                resolve();
             })
            .then(() => pool.releaseConnection(conn))
            .catch(err => console.log(err))
        })

        /* execute query to get program */
        let programPromise = new Promise((resolve, reject) => { 
            conn.promise()
            .query("SELECT title FROM program")
            .then(([rows, fields]) => {
                program_list = rows;
                resolve();
             })
            .then(() => pool.releaseConnection(conn))
            .catch(err => console.log(err))
        })

        /* execute query to get project */
        let projPromise = new Promise((resolve, reject) => { 
            conn.promise()
            .query("SELECT project.title AS project_title, project.proj_id as project_id, started_on, datediff(ends_on, started_on) AS duration_in_days, concat(first_name,' ',last_name) AS executive_name FROM project INNER JOIN program ON project.prog_id = program.prog_id AND program.prog_id = 29 INNER JOIN executive ON executive.exec_id = project.exec_id WHERE ends_on > sysdate() GROUP BY proj_id;")
            .then(([rows, fields]) => {
                project_list = rows;
                resolve();
             })
            .then(() => pool.releaseConnection(conn))
            .catch(err => console.log(err))
        })

        /* when queries promises finish render respective data */
        Promise.all([projectsPromise, researchersPromise, organizationsPromise, fieldsPromise, resNamePromise, programPromise, projPromise]).then(() => {
            res.render('landing.ejs', {
                pageTitle: "Main Page",
                number_of_projects,
                number_of_researchers,
                number_of_organizations,
                field_list,
                researcher_list,
                project_list,
                messages
            })
        });

    })
}