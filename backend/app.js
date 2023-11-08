// const express = require('express')
// const app = express()
// const port = 3000

// app.get('/', (req, res) => {
//     res.send('Hello world!')
// })

// app.listen(port, () => {
//     console.log(`Example app listening on port ${port}`)
// })

import { area, circumference } from './circle.js';

console.log(`지름이 4인 원의 면적 : ${area(4)}`);
console.log(`지름이 4인 원의 면적 : ${circumference(4)}`);