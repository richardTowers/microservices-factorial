const express = require('express')
const request = require('request-promise')
const morgan = require('morgan')
const app = express()

app.use(morgan('combined'))

app.get('/:inp', (req, res) => {
  let inp = parseInt(req.params.inp, 10)

  if (isNaN(inp) || inp <= 1) {
    request
      .get('http://base-factorial.apps.internal:8080')
      .then(body => {
        res.send(body)
      })
  } else {
    request
      .get(`http://factorial.apps.internal:8080/${inp - 1}`)
      .then(body => {
        let prec = parseInt(body, 10)
        res.send((inp * prec).toString())
      })
  }
})

app.listen(8080)
