// Generated by CoffeeScript 1.6.3
/*
Transforms `yield(foo(params), resume())` into `yield foo(params, resume())`
*/


(function() {
  var markGenerators, unwrapYield;

  unwrapYield = function(input) {
    var char, i, level, level_down_chars, level_up_chars, output, pos, pos_end, pos_last_comma;
    level_up_chars = ['[', '('];
    level_down_chars = [']', ')'];
    output = '';
    pos_end = 0;
    while (~(pos = input.indexOf('yield(', pos_end))) {
      output += input.slice(pos_end, pos);
      output += 'yield ';
      level = 1;
      pos_last_comma = null;
      i = pos + 6;
      while (char = input[i++]) {
        if (~level_up_chars.indexOf(char)) {
          level++;
        } else if (~level_down_chars.indexOf(char)) {
          level--;
        }
        if (char === ',') {
          pos_last_comma = i - 1;
        }
        if (level === 0) {
          pos_end = i - 1;
          break;
        }
      }
      output += input.slice(pos + 6, pos_last_comma);
      output += input.slice(pos_last_comma, pos_end - 1);
    }
    output += input.slice(pos_end);
    return output;
  };

  /*
  Transforms `function() { yield 1; }` into `function*() { yield 1; }`.
  */


  markGenerators = function(input) {
    var char, double_yield, i, level, level_down_chars, level_up_chars, output, pos, pos_end, pos_previous, search_fuction;
    output = '';
    level_up_chars = ['{'];
    level_down_chars = ['}'];
    pos_end = 0;
    pos_previous = 0;
    while (~(pos = input.indexOf('yield ', pos_previous + 1))) {
      level = 0;
      search_fuction = false;
      i = pos;
      double_yield = false;
      while (char = input[i--]) {
        if (!search_fuction) {
          if (~level_up_chars.indexOf(char)) {
            level--;
          } else if (~level_down_chars.indexOf(char)) {
            level++;
          }
          if (level === -1) {
            search_fuction = true;
          }
          if ((input.slice(i, i + 6)) === 'yield ') {
            double_yield = pos;
          }
          if (double_yield) {
            break;
          }
        } else {
          if ((input.slice(i + 1, i + 9)) === 'function') {
            pos_end = i + 1;
            break;
          }
        }
      }
      if (double_yield) {
        output += input.slice(pos_previous, pos);
      } else {
        output += input.slice(pos_previous, pos_end);
        output += "function*";
        output += input.slice(pos_end + 8, pos);
      }
      pos_previous = pos;
    }
    output += input.slice(pos_previous);
    return output;
  };

  module.exports = {
    markGenerators: markGenerators,
    unwrapYield: unwrapYield
  };

}).call(this);