var expect = require('chai').expect;

describe('browserify', function () {
  it('should work', function () {
    var mod = require('./build.out.js');
    expect(mod).eql('Hello world');
  });
});
