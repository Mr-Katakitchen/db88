const express = require('express');
const end6Controller = require('../controllers/end6');

const router = express.Router();

router.get('/', end6Controller.getResearchers);

module.exports = router;