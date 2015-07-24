#!/usr/bin/env coffee
expect = require('chai').expect

ASQ = require 'asynquence'
request = require 'request'

require('..')(ASQ, request)

describe 'Dependencies', ->
  it 'ASQ', ->
    expect(ASQ).to.exist
  it 'request', ->
    expect(request).to.exist

describe 'Plugin API', ->
  it 'should load/exist', ->
    expect(ASQ().get).to.exist
    expect(ASQ().head).to.exist
    expect(ASQ().post).to.exist
    expect(ASQ().put).to.exist
    expect(ASQ().patch).to.exist
    expect(ASQ().del).to.exist

describe 'Test calls', ->
  # Tolerate some network latency
  this.timeout 5000
  it 'ASQ.get()', (done) ->
    ASQ()
    .get('http://httpbin.org/get')
    .val (response, body) ->
      expect(response.statusCode).to.equal(200)
      expect(JSON.parse(body)).to.exist
      done()
  it 'ASQ.get() 404', (done) ->
    ASQ()
    .get('http://httpbin.org/food')
    .or (err) ->
      expect(err.name).to.equal('404 Error')
      done()
  it 'ASQ.post()', (done) ->
    ASQ()
    .post
      url: 'http://httpbin.org/post'
      json: "abc"
    .val (response, body) ->
      expect(response.statusCode).to.equal(200)
      expect(body).to.be.an('object')
      expect(body.json).to.equal("abc")
      done()
