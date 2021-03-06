webshot = require("webshot")
module.exports = (app) ->
  app.get "/:username/tweet/:tweet.png", (req, res) ->
    url = ""
    opt =
      screenSize:
        width: 550
        height: 75

      shotSize:
        width: 550
        height: "all"

    if req.params.tweet is "last"
      url = "http://" + req.headers.host + "/" + req.params.username + "/last"
      webshot url, opt, (err, renderStream) ->
        img = ""
        renderStream.on "data", (data) ->
          img += data.toString("binary")

        renderStream.on "end", ->
          res.setHeader "Content-Type", "image/png"
          res.setHeader "Cache-Control", "public, max-age=300"
          res.setHeader "Expires", new Date(Date.now() + 300000).toUTCString()
          res.writeHead 200
          res.write img, "binary"
          res.end()
    else
      url = "http://" + req.headers.host + "/" + req.params.username + "/status/" + req.params.tweet
      webshot url, opt, (err, renderStream) ->
        img = ""
        renderStream.on "data", (data) ->
          img += data.toString("binary")

        renderStream.on "end", ->
          res.setHeader "Content-Type", "image/png"
          res.setHeader "Cache-Control", "public, max-age=604800"
          res.setHeader "Expires", new Date(Date.now() + 604800000).toUTCString()
          res.writeHead 200
          res.write img, "binary"
          res.end()
