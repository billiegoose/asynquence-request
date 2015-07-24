# asynquence-request [![Build Status](https://travis-ci.org/wmhilton/asynquence-request.svg?branch=master)](https://travis-ci.org/wmhilton/asynquence-request)
This is a Node.js wrapper / plugin that makes using [request][request] easier with the [*asynquence*][asynquence] library.
If you haven't heard of the *asynquence* library, you should [check it out][asynquence2]. It's like Promises on steroids.

[![NPM](https://nodei.co/npm/asynquence-request.png)](https://nodei.co/npm/asynquence-request/)

[asynquence]: http://www.npmjs.org/package/asynquence
[request]: http://www.npmjs.org/package/request
[asynquence2]: http://davidwalsh.name/asynquence-part-1

## Example usage
In order to avoid depending on any specific versions of *request* or *asyncquence*, this module does not directly depend on them. (To be technical, they are `peerDependencies`.) You require them yourself and pass them into the module function like so:

```coffeescript
ASQ = require 'asynquence'
request = require 'request'
require('asynquence-request')(ASQ, request)
```
This extends `ASQ` with the following plugins which directly correspond to their *request* counterpart: `get`, `head`, `post`, `put`, `patch`, `del`. Here's a fictional example usage of a REST API:

```coffeescript
ASQ = require 'asynquence'
request = require 'request'

# We can pass in a modified version of 'request' such as the kind returned by 'request.defaults'
req = request.defaults
  baseUrl: 'http://petstore.swagger.io/v2/'
  json: true
  headers: 'Authorization': 'Bearer special-key'

require('asynquence-request')(ASQ, req)

ASQ()
# You can either pass in a request options literal...
.post
  url: 'pet'
  json: 
    id: 42
    name: "doggie"
.val (response, body) ->
  console.log "Created pet with id: #{body.id}"
  return body.id
# Or you can pass in a function that will return a request options literal.
.del (id) -> "pet/#{id}"
# Every request returns two parameters: response and body
.then (done, response, body) ->
  console.log "HTTP Status: #{response.statusCode}"
  setTimeout done, 1000
.get "pet/42"
# HTTP Errors (status codes >= 400) conveniently throw an error for you
.or (err) ->
  if err.name is "404 Error"
    console.log "Who deleted Fido?!?!"
    console.log err.stack
```

## TODO
- cookie jar
- more unit tests
