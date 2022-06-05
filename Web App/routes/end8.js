const express = require('express');
const end8Controller = require('../controllers/end8');

const router = express.Router();

router.get('/', end8Controller.getResearchers);

module.exports = router;