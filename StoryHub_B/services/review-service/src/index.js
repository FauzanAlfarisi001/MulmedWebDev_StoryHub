require('dotenv').config();
const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

app.use('/', require('./routes/review.routes'));
app.use('/', require('./routes/comment.routes'));
app.use((_, res) => res.status(404).json({ message: 'Endpoint/url/lainnya tidak ketemu' }));

app.listen(process.env.PORT, () => console.log(`Interaction service berjalan di port ${process.env.PORT}`));