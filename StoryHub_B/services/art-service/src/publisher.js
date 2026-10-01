const amqp = require('amqplib');
require('dotenv').config();

let channel;

async function getChannel() {
    if (channel) 
        return channel;

    const conn = await amqp.connect(process.env.RABBITMQ_URL);
    channel = await conn.createChannel();
    await channel.assertExchange('novel_events', 'topic', { durable: true });
    
    return channel;
}

async function publish(routingKey, data) {
    try {
        const ch = await getChannel();
        ch.publish('novel_events', routingKey, Buffer.from(JSON.stringify(data)), {persistent: true});
        console.log(`[MQ] Mempublish: ${routingKey}`, data);
    } catch (e) {
        console.error('[MQ] Publish gagal:', e.message);
    }
}

module.exports = {publish};