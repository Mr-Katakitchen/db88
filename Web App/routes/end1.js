const express = require('express');
const end1Controller = require('../controllers/end1');

const router = express.Router();

router.get('/', end1Controller.getResearchers);

module.exports = router;