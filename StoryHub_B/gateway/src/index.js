require('dotenv').config();
const express = require('express');
const morgan = require('morgan');
const rateLimit = require('express-rate-limit');
const cors = require('cors');
const { createProxyMiddleware } = require('http-proxy-middleware');
const app = express();
const PORT = process.env.PORT || 4097;

app.use(cors());
app.use(morgan('combined')); 

app.use(rateLimit({
    windowMs: 60 * 1000,
    max: 5000,
    message: { message: 'Terlalu banyak req, coba lagi 1 menit lagi kedepan.' }
}));

function proxy(target, basePath) {
    return createProxyMiddleware({
        target,
        changeOrigin: true,

        pathRewrite: (path, req) => {
            return basePath + path;
        },

        on: {
            error: (err, _req, res) =>
                res.status(502).json({
                    message: 'Service tidak ada.',
                    error: err.message
                })
        }
    });
}

app.use('/login', proxy(process.env.AUTH_URL, '/login'));
app.use('/register', proxy(process.env.AUTH_URL, '/register'));
app.use('/users', proxy(process.env.AUTH_URL, '/users'));

app.use('/arts', proxy(process.env.ART_URL, '/arts'));
app.use('/chapters', proxy(process.env.ART_URL, '/chapters'));
app.use('/novel', proxy(process.env.ART_URL, '/novel'));
app.use('/comic', proxy(process.env.ART_URL, '/comic'));
app.use('/genre', proxy(process.env.ART_URL, '/genre'));
app.use('/tag', proxy(process.env.ART_URL, '/tag'));
app.use('/mood', proxy(process.env.ART_URL, '/mood'));
app.use('/bookmark', proxy(process.env.ART_URL, '/bookmark'));

app.use('/image', createProxyMiddleware({
    target: process.env.ART_URL,
    changeOrigin: true,
    on: {
        error: (err, _req, res) => res.status(502).json({message: 'Service tidak ada.', error: err.message})
    }
}));

// app.use('/interaksi', proxy(process.env.REVIEW_URL, '/'));

app.use('/interaksi', createProxyMiddleware({
    target: process.env.REVIEW_URL,
    changeOrigin: true,
    pathRewrite: { '^/interaksi': '' },
    on: { error: (err, _req, res) => res.status(502).json({message: 'Service tidak ada.', error: err.message}) }
}));

app.listen(PORT, () => console.log(`API gateway berjalan di port ${PORT}`));