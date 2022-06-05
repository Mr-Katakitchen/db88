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

        /* execute query to get number_of_organizations */
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

        /* when queries promises finish render respective data */
        Promise.all([projectsPromise, researchersPromise, organizationsPromise, fieldsPromise]).then(() => {
            res.render('landing.ejs', {
                pageTitle: "Main Page",
                number_of_projects,
                number_of_researchers,
                number_of_organizations,
                field_list,
                messages
            })
        });

    })
}

// app.getFields('/', function(req, res) {
//     conn.query('SELECT * FROM scientific_field', function(err, rows) {
//         res.render('index', {
//             field: rows
//         });
//     });
// }
// );

                // /* Controller to render data shown in create student page */
                // exports.getCreateStudent = (req, res, next) => {
                //     res.render('create_student.ejs', {
                //         pageTitle: "Student Creation Page"
                //     })
                // }