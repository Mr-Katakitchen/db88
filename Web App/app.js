const express = require('express');
const path = require('path');
const session = require('express-session');
const flash = require('connect-flash');

require('custom-env').env('localhost');

/* ROUTES and how to import routes */
const layout = require('./routes/layout');
const endpoint1 = require('./routes/end1');
const endpoint2_1 = require('./routes/end2.1');
const endpoint2_2 = require('./routes/end2.2');
const endpoint3 = require('./routes/end3');
const endpoint4 = require('./routes/end4');
const endpoint5 = require('./routes/end5');
const endpoint6 = require('./routes/end6');
const endpoint7 = require('./routes/end7');
const endpoint8 = require('./routes/end8');
/* end of ROUTES and how to import routes */

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'ejs');
app.set('views', 'views');

app.use(flash());

app.use(session({
    secret: "ThisShouldBeSecret",
    resave: false,
    saveUninitialized: false
}));

/* Routes used by the project */
app.use('/', layout);
app.use('/end1', endpoint1);
app.use('/end2.1', endpoint2_1);
app.use('/end2.2', endpoint2_2);
app.use('/end3', endpoint3);
app.use('/end4', endpoint4);
app.use('/end5', endpoint5);
app.use('/end6', endpoint6);
app.use('/end7', endpoint7);
app.use('/end8', endpoint8);
/* End of routes used by the project */

// In case of an endpoint does not exist must return 404.html
app.use((req, res, next) => { res.status(404).render('404.ejs', { pageTitle: '404' }) })

module.exports = app;