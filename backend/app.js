
import express from 'express';
import mysql from 'mysql2';
import dbconfig from './database.js';
const connection = mysql.createConnection(dbconfig);

const app = express();
const router = express.Router();

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

// 로그인
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

// 가수 그룹명(or 이름)으로 검색
app.get('/artists/search/name', (req, res) => {

    console.log(req.query.team);
    var singer = req.query.team;
    var res_code = false;
    
    connection.query('select * from Artists where singer = ?', [singer], function(error, results, fields) {
        if(error) throw error;
        console.log(results);
        if(results > 0) {
            // 결과가 있을 때
            res_code = true;
            res.send(res_code);
            console.log(fields);
        } else {
            res_code = false;
        }
    })

})

// 가수 전체 조회 
app.get('/artists/search/all', (req, res) => {

    connection.query('select singer, image_path from Artists', (error, fields)  => {
        if(error) throw error;
        console.log('Team info is: ', fields);
        res.json(fields);

    })

})

// 좋아하는 아티스트 선택 하는 api
app.post('/artists/choose', (req, res) => {
    var user_email = req.body.user_email;
    var f_artist = req.body.f_artist;
    var res_code = false;
    connection.query('insert into Fandom (user_email, f_artist) values (? , (select id from Artists where singer = ?))', [user_email, f_artist], function(error, results, fields) {
        if(error) throw error;
        console.log("results: " + results);
        console.log("fields: " + fields);
        if(results > 0) {
            res_code = true;
            res.send(res_code);
        }
        else {
            res.send(res_code);
        }
        return res_code;

    });


})


// app.get('/auth/login', (req, res) => {
//     connection.query('select * from Users', (error, rows) => {
//         if(error) throw error;
//         console.log('User info is:', rows);
//         res.send(rows);

//     });
// });

// 컬러코드 대문자로 출력
// select upper(color_code) from Fandom where singer='NCT';

// 이메일 중복확인력
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

// 계정 생성
app.post('/auth/signup', (req, res) => {
    var email = req.body.email;
    var pw = req.body.password;
    var name = req.body.name;
    var birth = req.body.birth;
    var res_code = false;
    
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


// user image 정보 가져오기
app.get('/api/users/avatar', (req, res) => {
    
    var email = req.body.email;
    connection.query('select image from Users where email = ?', [email], function(error, results, fileds) {
        if(error) throw error;
        console.log('user image info: ', fileds);
        res.json(fileds);
    })
});

// 사용자 프로필 사진 업데이트
app.post('/api/user/upd', (req, res) => {
    
    var email = req.body.user_email;
    var image_path = req.body.img_path;

    connection.query('update set Users image= ? where email = ?', [email, image_path], function(error, results, fields) {
        if(error) throw error;
    })
})

app.listen(app.get('port'), () => {
    console.log('Express server listening on port ' + app.get('port'));
});
