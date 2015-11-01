// Generated by CoffeeScript 1.10.0
(function() {
  var Cells, changeState, countLiveNeighbours, ctx, height, randomInit, size, tick, updateSquare, width;

  height = 800;

  width = 800;

  size = 15;

  ctx = document.getElementById("myCanvas").getContext("2d");

  ctx.fillStyle = 'rgb(0,0,255)';

  ctx.fillRect(0, 0, width, height);

  Cells = [];

  randomInit = function() {
    var A, a, color, k, results, thing, x, y;
    results = [];
    for (x = k = 0; k < 50; x = ++k) {
      Cells[x] = [];
      results.push((function() {
        var l, results1;
        results1 = [];
        for (y = l = 0; l < 50; y = ++l) {
          a = Math.random();
          if (a > 0.5) {
            thing = 'alive';
            color = 'rgb(0,0,100)';
          } else {
            thing = 'dead';
            color = 'rgb(0,0,0)';
          }
          ctx.fillStyle = color;
          ctx.fillRect(x + x * size, y + y * size, size, size);
          A = {
            'state': thing,
            'row': x,
            'column': y,
            'neighbors': 0
          };
          results1.push(Cells[x][y] = A);
        }
        return results1;
      })());
    }
    return results;
  };

  updateSquare = function(Cells) {
    var color, k, results, x, y;
    results = [];
    for (x = k = 0; k < 50; x = ++k) {
      results.push((function() {
        var l, results1;
        results1 = [];
        for (y = l = 0; l < 50; y = ++l) {
          if (Cells[x][y]['state'] === 'alive') {
            color = 'rgb(0,0,100)';
          } else if (Cells[x][y]['state'] === 'dead') {
            color = 'rgb(0,0,0)';
          }
          ctx.fillStyle = color;
          results1.push(ctx.fillRect(x + x * size, y + y * size, size, size));
        }
        return results1;
      })());
    }
    return results;
  };

  countLiveNeighbours = function(Cells, i, j) {
    var collb, colub, k, l, neighbors, ref, ref1, ref2, ref3, rowlb, rowub, x, y;
    neighbors = 0;
    rowlb = Math.max(j - 1, 0);
    rowub = Math.min(j + 1, 49);
    collb = Math.max(i - 1, 0);
    colub = Math.min(i + 1, 49);
    for (x = k = ref = collb, ref1 = colub; ref <= ref1 ? k <= ref1 : k >= ref1; x = ref <= ref1 ? ++k : --k) {
      for (y = l = ref2 = rowlb, ref3 = rowub; ref2 <= ref3 ? l <= ref3 : l >= ref3; y = ref2 <= ref3 ? ++l : --l) {
        if (!(x === i && y === j)) {
          if (Cells[x][y]['state'] === 'alive') {
            neighbors++;
          }
        }
      }
    }
    return Cells[i][j]['neighbors'] = neighbors;
  };

  changeState = function(Cells) {
    var i, j, k, results;
    results = [];
    for (i = k = 0; k < 50; i = ++k) {
      results.push((function() {
        var l, results1;
        results1 = [];
        for (j = l = 0; l < 50; j = ++l) {
          if (Cells[i][j]['state'] === 'alive' && Cells[i][j]['neighbors'] < 2) {
            Cells[i][j]['state'] = 'dead';
          }
          if (Cells[i][j]['state'] === 'alive' && Cells[i][j]['neighbors'] > 3) {
            Cells[i][j]['state'] = 'dead';
          }
          if (Cells[i][j]['state'] === 'dead' && Cells[i][j]['neighbors'] === 3) {
            results1.push(Cells[i][j]['state'] = 'alive');
          } else {
            results1.push(void 0);
          }
        }
        return results1;
      })());
    }
    return results;
  };

  tick = function() {
    var i, j, k, l;
    for (i = k = 0; k < 50; i = ++k) {
      for (j = l = 0; l < 50; j = ++l) {
        countLiveNeighbours(Cells, i, j);
      }
    }
    changeState(Cells);
    updateSquare(Cells);
    return setTimeout(tick, 100);
  };

  randomInit();

  tick();

}).call(this);