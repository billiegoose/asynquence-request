# asynquence-request

# Pardon the pun
addVerb = (request) ->
  return (api) ->
    # console.log arguments
    return (options) ->
      # console.log arguments
      api.then (done) ->
        args = arguments
        switch typeof options
          when "function"
            results = Array::slice.call(arguments,1)
            options = options.apply(null, results)
          when "string", "object"
          else
            return done.fail Error "Invalid argument to ASQ.get"
        request(options, done.errfcb)
      .then throwStatus
      return api


throwStatus = (done, response, body) ->
  if not response?
    return done.fail( Error "Missing response" )
  if response.statusCode >= 300
    e = new Error
    e.name = "#{response.statusCode} Error"
    e.message = body
    return done.fail(e)
  return done(response, body)


module.exports = (ASQ, request) ->
  verbs = ['get', 'head', 'post', 'put', 'patch', 'del']
  for verb in verbs
    ASQ.extend verb, addVerb(request[verb])
