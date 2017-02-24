var express = require('express');
var app = express();

app.get('/', (req, res) => {
  res.send('Hello, World! (V10)');
});

app.listen(3000, () => {
  console.log('Hello world app listening on port 3000');
});
