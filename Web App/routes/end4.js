const express = require('express');
const end4Controller = require('../controllers/end4');

const router = express.Router();

router.get('/', end4Controller.getOrganizations);

module.exports = router;