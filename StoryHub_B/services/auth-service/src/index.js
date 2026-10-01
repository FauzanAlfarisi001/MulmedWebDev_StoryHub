require('dotenv').config();
const express = require('express');
const cors = require('cors');
const app = express();
const path = require('path');

app.use(cors());
app.use(express.json());
app.use('/image', express.static(path.join(__dirname, '../../../image')));
app.use('/', require('./routes'));
app.use((_, res) => res.status(404).json({ message: 'Endpoint/url/lainnya tidak ketemu' }));

app.listen(process.env.PORT, () => console.log(`Auth service berjalan di port ${process.env.PORT}`));