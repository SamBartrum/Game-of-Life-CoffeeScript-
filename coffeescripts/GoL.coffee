# My first program written in CoffeeScript
# It could be more efficient and less verbose but this solution is quick enough

# THE GAME OF LIFE

# A living cell will die due to under-population if it has fewer than two living neighbors.
# A living cell with two or three living neighbors lives on to the next generation.
# A living cell with more than three living neighbors dies due to overcrowding.
# A dead cell with exactly three living neighbors becomes a living cell due to reproduction.


class GameOfLife

  size: 15
  nocells: 50
  ticktime: 100
  canvas: null
  ctx: null


  constructor:->
    
    @makeCanvas()
    @makeDrawingContext()

    @randomInit()
    @tick()


  makeCanvas:->
    
    @canvas = document.createElement 'canvas'
    document.body.appendChild @canvas
    @canvas.height = @nocells * @size + @nocells
    @canvas.width = @nocells * @size + @nocells

  makeDrawingContext:->
    
    @ctx = @canvas.getContext("2d")
    @ctx.fillStyle = 'rgb(0,0,255)'  
    @ctx.fillRect 0, 0, @canvas.width, @canvas.height



  randomInit: ->      # Generates a random distribution of alive and dead cells
    
    @cells = []
    for x in [0...@nocells]
      @cells[x] =[]
      for y in [0...@nocells]
        a = Math.random()
        if a > 0.5
          thing = 'alive'
          color = 'rgb(0,0,100)'
        else
          thing = 'dead'  
          color = 'rgb(0,0,0)'

        @ctx.fillStyle = color
        @ctx.fillRect x + x * @size, y + y * @size, @size, @size  

        A = {
          'state': thing
          'row' : x
          'column': y
          'neighbors': 0
        }
        @cells[x][y] = A
    
    
  updateSquare: ->   # Function to redraw cells depending upon their state
    
    for x in [0...@nocells]
      for y in [0...@nocells]
        if @cells[x][y]['state'] == 'alive'
          color = 'rgb(0,0,100)' 
        else if @cells[x][y]['state'] == 'dead'
          color = 'rgb(0,0,0)' 
        
        @ctx.fillStyle = color
        @ctx.fillRect x + x * @size, y + y * @size, @size, @size   


  countLiveNeighbours: (i,j) ->   # Function to count the nearest live neighbours of a given cell
    
    neighbors = 0
    rowlb = Math.max j-1,0      # This both avoid boundary condition issues and means we only search over the 9 by 9 grid surrounding the cell of interest
    rowub = Math.min j+1,@nocells-1
    collb = Math.max i-1,0
    colub = Math.min i+1,@nocells-1

    for x in [collb..colub]
      for y in [rowlb..rowub]
        if not (x == i and y== j)
          if @cells[x][y]['state'] == 'alive'
            neighbors++
    @cells[i][j]['neighbors'] = neighbors  # Updates the neighbours key for the cell object



  changeState: ->    # This function changes the states of the cells after the neighbours have been calculated

    for i in [0...@nocells]
      for j in [0...@nocells]
        
        if @cells[i][j]['state'] == 'alive' and @cells[i][j]['neighbors'] < 2
          @cells[i][j]['state'] = 'dead'
       
        
        if @cells[i][j]['state'] == 'alive' and @cells[i][j]['neighbors'] > 3 
          @cells[i][j]['state'] = 'dead' 
  

        if @cells[i][j]['state'] == 'dead' and @cells[i][j]['neighbors'] == 3
          @cells[i][j]['state'] = 'alive'


        
        
  tick: =>     # This function loops with a slight delay, computing the nearest live neighbours, changing their states and then redrawing the cells
    
    for i in [0...@nocells]
      for j in [0...@nocells]
        @countLiveNeighbours(i,j)
    
    @changeState()   
    @updateSquare()  


    setTimeout(@tick, @ticktime)
    
   



window.GameOfLife = GameOfLife















