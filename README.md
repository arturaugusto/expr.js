expr.js
=======

expr.js is a parser generated with [jison](http://zaach.github.io/jison/), modified to accept an json as argument and safe evaluate simple aritmetic and logical expressions.

How to use
=======

Inlcude expr.js on your page
```html
<script src="expr.js"></script>
```

Then you can evaluate expressions like this:

```javascript
expr.parse('2*2 + bar.foo', {"bar":{"foo":38}}); // 42
expr.parse('x = y + " " + x = z', {"x": "abc", "y": "123", "z": "abc"}); // false true
expr.parse('(x and (y or 0)) = 1', {"x": 0, "y": 1});// false
```
Note that the "=" is and comparative operator

License
=======

MIT
