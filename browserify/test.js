var expect = require('chai').expect;

describe('browserify', function () {
  it('should work', function () {
    try {
    var mod = require('./build.out.js');
      expect(mod.msg).eql('Hello world');
    } catch (e) {
      e.stack=''; throw e;
    }
  });
});
