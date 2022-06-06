const express = require('express');
const end2_1Controller = require('../controllers/end2.1');

const router = express.Router();

router.get('/', end2_1Controller.getProjects);

module.exports = router;