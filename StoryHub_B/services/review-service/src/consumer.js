const amqp = require('amqplib');
const db = require('./db');
require('dotenv').config();

async function startConsumer() {
    try {
        const conn = await amqp.connect(process.env.RABBITMQ_URL);

        const channel = await conn.createChannel();

        // buat exchange (nama exchange, tipe exchange, exchange tetap ada saat server restart?)
        await channel.assertExchange('novel_events', 'topic', {durable: true});

        // buat queue (nama queue, queue tetap ada saat server restart?)
        const q = await channel.assertQueue('interaction_queue', {durable: true});

        // kirim ke interaction queue (q)
        await channel.bindQueue(q.queue, 'novel_events', 'novel.created');
        await channel.bindQueue(q.queue, 'novel_events', 'chapter.published');

        // terima 1 pesan dulu sebelum pesan lain selesai 
        channel.prefetch(1);

        channel.consume(q.queue, async (msg) => {
            // kalau gak ada pesan, keluar
            if (!msg) return;

            try {
                // pesan diubah jadi json
                const event = JSON.parse(msg.content.toString());

                // ambil routing, buat lihat jenis event
                const routingKey = msg.fields.routingKey;

                if (routingKey === 'novel.created') {
                    await db.query(
                        'INSERT INTO notifications (user_id, type, message) VALUES (?,?,?)',
                        [event.author_id, 'novel_created', `Novel baru kamu "${event.title}" berhasil dipublikasikan!!`]
                    );
                }

                if (routingKey === 'chapter.published') {
                    await db.query(
                        'INSERT INTO notifications (user_id, type, message) VALUES (?,?,?)',
                        [event.author_id, 'chapter_published', `Chapter baru berhasil ditambah ke novel "${event.title}"`]
                    );
                }

                // tanda pesan sudah selesai, hapus pesan dari queue
                channel.ack(msg);
            } catch (e) {
                console.error('[MQ] Error:', e.message);

                // masukkin lagi ke queue
                channel.nack(msg, false, true);
            }
        });

        conn.on('error', (e) => {
            console.error('[MQ] Koneksi error:', e.message);

            // kalau error, ulang lagi 7 detik kedepan
            setTimeout(startConsumer, 7000);
        });

    } catch (e) {
        console.error('[MQ] Gagal konek rabbitmq.', e.message);
        setTimeout(startConsumer, 7000);
    }
}

module.exports = { startConsumer };