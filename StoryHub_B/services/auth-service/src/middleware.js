const jwt = require('jsonwebtoken');
require('dotenv').config();

function auth(req, res, next) {
    const header = req.headers.authorization;

    if (!header?.startsWith('Bearer '))
        return res.status(401).json({ message: 'Token belum dimasukkan.' });

    try {
        req.user = jwt.verify(header.split(' ')[1], process.env.JWT_SECRET);
        next();
    } catch {
        return res.status(401).json({ message: 'Token tidak sesuai atau sudah kadaluarsa.' });
    }
}

async function authGetFilter(req, res, next) {
    const header = req.headers.authorization;

    if (!header?.startsWith('Bearer ')) {
        req.user = null;
        return next();
    }

    try {
        const { data } = await axios.get(`${process.env.AUTH_SERVICE_URL}/verify`, {headers: {Authorization: header}});
        req.user = data.user;

    } catch (error) {
        req.user = null;
    }

    next();
}

function requireRole(...roles) {
    return (req, res, next) => {
        if (!roles.includes(req.user?.role))
            return res.status(403).json({ message: `Akses ditolak, role kamu harus: ${roles.join('/')}` });

        next();
    };
}

module.exports = {auth, authGetFilter, requireRole};