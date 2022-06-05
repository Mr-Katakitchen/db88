const express = require('express');
const end7Controller = require('../controllers/end7');

const router = express.Router();

router.get('/', end7Controller.getExec);

module.exports = router;