import express from "express";
import mysql from "mysql2";
import dbconfig from "./database.js";
import multer from "multer";
import path from "path";

const connection = mysql.createConnection(dbconfig);

// const upload = multer({ dest: 'uploads/' });
const app = express();
const router = express.Router();
const __dirname = path.resolve();

app.use(express.static("public"));
// express body parser 대신
// app.use(express.json());
// app.use(express.urlencoded( {extended : false }));

app.use(
  express.json({
    limit: "500mb",
  })
);
app.use(
  express.urlencoded({
    limit: "500mb",
    extended: false,
  })
);

app.set("port", process.env.PORT || 3000);

app.get("/", (req, res) => {
  res.send("root");
});

// 로그인
app.post("/auth/signin", (req, res) => {
  var email = req.body.email;
  var pw = req.body.password;
  var res_code = false;

  connection.query(
    "select * from Users where email = ? and password = ?",
    [email, pw],
    function (error, results, fields) {
      if (error) throw error;
      if (results.length > 0) {
        console.log(results);
        res_code = true;
        res.send(res_code);
      } else {
        res.send(res_code);
        console.log("do not exist info");
      }
    }
  );
});

// 가수 그룹명(or 이름)으로 검색
app.get("/artists/search/name", (req, res) => {
  console.log(req.query.team);
  var singer = req.query.team;
  var res_code = false;

  connection.query(
    "select * from Artists where singer = ?",
    [singer],
    function (error, results, fields) {
      if (error) throw error;
      console.log(results);
      if (results.length > 0) {
        // 결과가 있을 때
        res_code = true;
        res.send(res_code);
        console.log(fields);
      } else {
        res_code = false;
      }
    }
  );
});

// 가수 전체 조회
app.get("/artists/search/all", (req, res) => {
  connection.query(
    "select singer, image_path from Artists",
    (error, fields) => {
      if (error) throw error;
      console.log("Team info is: ", fields);
      res.json(fields);
    }
  );
});

// 좋아하는 아티스트 선택 하는 api
app.post("/artists/choose", (req, res) => {
  var user_email = req.body.user_email;
  var f_artist = req.body.f_artist;
  var res_code = false;
  connection.query(
    "insert into Fandom (user_email, f_artist) values (? , (select id from Artists where singer = ?))",
    [user_email, f_artist],
    function (error, results, fields) {
      if (error) throw error;
      console.log("results: " + results);
      console.log("fields: " + fields);
      if (results > 0) {
        res_code = true;
        res.send(res_code);
      } else {
        res.send(res_code);
      }
      return res_code;
    }
  );
});

// 컬러코드 대문자로 출력
// select upper(color_code) from Fandom where singer='NCT';

// 이메일 중복확인력
app.post("/auth/duplicated_check", (req, res) => {
  var email = req.body.email;
  var res_code = false;
  connection.query(
    "select * from Users where email = ?",
    [email],
    function (error, results, fields) {
      if (error) throw error;
      if (results.length > 0) {
        // 이메일 중복
        res_code = true;
        res.send(res_code);
      } else {
        // 이메일 중복 아님
        // false
        res.send(res_code);
      }
    }
  );
});

// 계정 생성
app.post("/auth/signup", (req, res) => {
  var email = req.body.email;
  var pw = req.body.password;
  var name = req.body.name;
  var birth = req.body.birth;
  var res_code = false;

  connection.query(
    "insert into Users (email, password, username, birth) values (?, ?, ?, ?)",
    [email, pw, name, birth],
    function (error, results, fileds) {
      if (error) throw error;
      console.log(results);
      if (results > 0) {
        res_code = true;
        res.send(res_code);
      } else {
        res.send(res_code);
        console.log("success");
      }
      return res_code;
    }
  );
});

// user image 정보 가져오기
app.get("/api/users/avatar", (reqres) => {
  var email = req.body.email;
  connection.query(
    "select image from Users where email = ?",
    [email],
    function (error, results, fileds) {
      if (error) throw error;
      console.log("user image info: ", fileds);
      res.json(fileds);
    }
  );
});

// 이미지를 저장할 디렉토리
const uploadDir = path.join(__dirname, "./public/images/users/");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    const today = new Date();

    const year = today.getFullYear(); // 2023
    const month = (today.getMonth() + 1).toString().padStart(2, "0"); // 06
    const day = today.getDate().toString().padStart(2, "0"); // 18

    const dateString = year + month + day; 
    cb(
      null,
    //   file.fieldname + "-" + dateString + path.extname(file.originalname)
      req.query.user_email + path.extname(file.originalname)
    );
  },
});

const upload = multer({ storage: storage});

// 사용자 프로필 사진 업데이트
app.post("/api/user/upd", upload.single("image"), (req, res) => {
  var res_code = false;
  var email = req.query.user_email;

  console.log("email: ", req.query.user_email);

  if (!req.file) {
    return res.statusCode(400).send("No file uploaded");
  }
//   var upd_filename = email + "-" + dateString + path.extname(file.originalname);
  const imagePath = path.join(uploadDir, email + path.extname(req.file.originalname));

//   const byteLength = Buffer.from(imagePath, "utf-8").length;

  connection.query(
    "update Users set image= ? where email = ?",
    [imagePath, email],
    function (error, results, fields) {
      res_code = true;
      if (error) throw error;
      res.status(200).end();
    }
  );
});

app.listen(app.get("port"), () => {
  console.log("Express server listening on port " + app.get("port"));
});
