
import express from 'express';
import mysql from 'mysql2';
import dbconfig from './database.js';
const connection = mysql.createConnection(dbconfig);

const app = express();

// express body parser 대신 
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
app.post('/auth/signin', (req, res) => {
    var email = req.body.email;
    var pw = req.body.password;
    console.log(email);
    console.log(pw);
    connection.query('select * from Users where email = ? and password = ?', [email, pw], function(error, results, fields) {
        if(error) throw error;
        if(results.length > 0) {
            console.log('success');
            console.log(results)
            res.send(results)
        } else {
            res.send('로그인 실패');
        }
    })

})

app.post('/auth/singup', (req, res, next) => {
    var email = req.email;
    var pw = req.pw;
    var name = req.name;
    var res_code = 1;
    console.log(email);
    console.log(pw);
    console.log(name);
    connection.query('insert into Users (email, pw, name) values (?, ?, ?)', [email, pw, name], function(error, results, fileds) {
        if(error) throw error;
        console.lof(results);
        // if(results > 0) {
        //     console.log('success');
        // } else {
        //     res_code = 0;
        // }
        // return res_code;
    });

})

app.listen(app.get('port'), () => {
    console.log('Express server listening on port ' + app.get('port'));
});
