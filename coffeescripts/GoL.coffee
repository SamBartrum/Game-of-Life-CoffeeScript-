# My first program written in CoffeeScript
# It could be more efficient and less verbose but this solution is quick enough

# THE GAME OF LIFE

# A living cell will die due to under-population if it has fewer than two living neighbors.
# A living cell with two or three living neighbors lives on to the next generation.
# A living cell with more than three living neighbors dies due to overcrowding.
# A dead cell with exactly three living neighbors becomes a living cell due to reproduction.



height = 800
width = 800
# size = 15
size = 10
nocells = 73

ctx = document.getElementById("myCanvas").getContext("2d")

ctx.fillStyle = 'rgb(0,0,255)'
ctx.fillRect 0, 0, width, height

Cells = []


randomInit = ->      # Generates a random distribution of alive and dead cells
  for x in [0...nocells]
    Cells[x] =[]
    for y in [0...nocells]
      a = Math.random()
      if a > 0.5
        thing = 'alive'
        color = 'rgb(0,0,100)'
      else
        thing = 'dead'  
        color = 'rgb(0,0,0)'

      ctx.fillStyle = color
      ctx.fillRect x + x * size, y + y * size, size, size  

      A = {
        'state': thing
        'row' : x
        'column': y
        'neighbors': 0
      }
      Cells[x][y] = A
  
  
updateSquare = (Cells)->   # Function to redraw cells depending upon their state

  for x in [0...nocells]
    for y in [0...nocells]
      if Cells[x][y]['state'] == 'alive'
        color = 'rgb(0,0,100)'
      else if Cells[x][y]['state'] == 'dead'
        color = 'rgb(0,0,0)' 
      ctx.fillStyle = color
      ctx.fillRect x + x * size, y + y * size, size, size    


countLiveNeighbours = (Cells,i,j) ->   # Function to count the nearest live neighbours of a given cell
  neighbors = 0
  rowlb = Math.max j-1,0      # This both avoid boundary condition issues and means we only search over the 9 by 9 grid surrounding the cell of interest
  rowub = Math.min j+1,nocells-1
  collb = Math.max i-1,0
  colub = Math.min i+1,nocells-1

  for x in [collb..colub]
    for y in [rowlb..rowub]
      if not (x == i and y== j)
        if Cells[x][y]['state'] == 'alive'
          neighbors++
  Cells[i][j]['neighbors'] = neighbors  # Updates the neighbours key for the cell object


changeState = (Cells)->    # This function changes the states of the cells after the neighbours have been calculated
  for i in [0...nocells]
    for j in [0...nocells]
      
      if Cells[i][j]['state'] == 'alive' and Cells[i][j]['neighbors'] < 2
        Cells[i][j]['state'] = 'dead'

      
      if Cells[i][j]['state'] == 'alive' and Cells[i][j]['neighbors'] > 3 
        Cells[i][j]['state'] = 'dead'  


      if Cells[i][j]['state'] == 'dead' and Cells[i][j]['neighbors'] == 3
        Cells[i][j]['state'] = 'alive'

      
      
 tick = ->     # This function loops with a slight delay, computing the nearest live neighbours, changing their states and then redrawing the cells
    for i in [0...nocells]
      for j in [0...nocells]
        countLiveNeighbours(Cells,i,j)
    changeState(Cells)    
    updateSquare(Cells)    

    setTimeout(tick, 100)

thing = -> 
  alert "hi"


randomInit()    # Just getting things going

tick()














