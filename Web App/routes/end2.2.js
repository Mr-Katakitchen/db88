const express = require('express');
const end2_2Controller = require('../controllers/end2.2');

const router = express.Router();

router.get('/', end2_2Controller.getEvaluations);

module.exports = router;