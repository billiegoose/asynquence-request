# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).
This changelog is modeled on <http://keepachangelog.com/>.

## [Unreleased][head]
### Changed
- Fiddling with .travis.yml
- Adding more mocha tests

## [1.0.2].2015-05-08
### Fixed?
- For some reason, 1.0.1 is published, but the tarball is 404.
Re-publishing.

## [1.0.1].2015-05-08
### Fixed
- A bug where HTTP 3xx response codes would throw errors. Note that
this is rare since 'request' follows redirects for you anyway.
The library is only 1 day old, surely no one is relying on this
behavior.

## 1.0.0.2015-05-07
### Added
- Initial release

[head]: https://github.com/wmhilton/asynquence-request/compare/v1.0.2...HEAD
[1.0.2]: https://github.com/wmhilton/asynquence-request/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/wmhilton/asynquence-request/compare/v1.0.0...v1.0.1
