const express = require('express');
const end5Controller = require('../controllers/end5');

const router = express.Router();

router.get('/', end5Controller.getFields);

module.exports = router;