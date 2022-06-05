const express = require('express');
const end3Controller = require('../controllers/end3');

const router = express.Router();

router.get('/', end3Controller.getFieldData);

module.exports = router;