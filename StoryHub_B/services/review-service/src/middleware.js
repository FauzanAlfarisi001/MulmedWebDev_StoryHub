const axios = require('axios');
require('dotenv').config();

async function auth(req, res, next) {
    const header = req.headers.authorization;

    if (!header?.startsWith('Bearer '))
        return res.status(401).json({ message: 'Token belum dimasukkan.' });

    try {
        const { data } = await axios.get(`${process.env.AUTH_SERVICE_URL}/verify`, {headers: { Authorization: header }});
        req.user = data.user;
        next();
    } catch { res.status(401).json({ message: 'Token tidak sesuai.' }); }
}

module.exports = { auth };