
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

// 이메일 중복확인
app.post('/auth/duplicated_check', (req, res) => {
    var email = req.body.email;
    var res_code = false;
    connection.query('select * from Users where email = ?', [email], function(error, results, fields) {
        if(error) throw error;
        if(results.length > 0) {
            // 이메일 중복
            res_code = true
            res.send(res_code)

        } else {
            // 이메일 중복 아님 
            // false
            res.send(res_code);

        }
    })
})

app.post('/auth/signup', (req, res) => {
    var email = req.body.email;
    var pw = req.body.password;
    var name = req.body.name;
    var birth = req.body.birth;
    var res_code = false;
    console.log(email);
    console.log(pw);
    console.log(name);
    console.log(birth);
    connection.query('insert into Users (email, password, username, birth) values (?, ?, ?, ?)', [email, pw, name, birth], function(error, results, fileds) {
        if(error) throw error;
        console.log(results);
        if(results > 0) {
            res_code = true;
            res.send(res_code);
        } else {
            res.send(res_code);
            console.log('success');
        }
        return res_code;
    });

})

app.listen(app.get('port'), () => {
    console.log('Express server listening on port ' + app.get('port'));
});
