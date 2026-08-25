/*Node.js program
      ↓
Create HTTP server
      ↓
Listen on port 3000
      ↓
Browser → localhost:3000
      ↓
"Hello World" */


const http = require("http");

const server = http.createServer((req,res)=>{
    res.end("Hello world from Node.js!")
})


server.listen(3000, ()=>{
    console.log("Node js server running on port 3000");
});