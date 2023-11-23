
import express from 'express';
import mysql from 'mysql2';
import dbconfig from './database.js';
const connection = mysql.createConnection(dbconfig);

const app = express();

app.use(express.json());
app.use(express.urlencoded( {extended : false }));

app.set('port', process.env.PORT || 3000);

app.get('/', (req, res) => {
    res.send('root');
})

// app.get('/auth/login', (req, res) => {
//     connection.query('select * from Users', (error, rows) => {
//         if(error) throw error;
//         console.log('User info is:', rows);
//         res.send(rows);

//     });
// });
app.post('/auth/login', (req, res) => {
    var email = req.body.email;
    var pw = req.body.password;
    console.log(email);
    console.log(pw);
    connection.query('select * from Users where email = ? and password = ?', [email, pw], function(error, results, fields) {
        if(error) throw error;
        if(results.length > 0) {
            console.log('success');
            res.redirect('')
        } else {
            console.log('login failed');
        }
    })

})

app.listen(app.get('port'), () => {
    console.log('Express server listening on port ' + app.get('port'));
});