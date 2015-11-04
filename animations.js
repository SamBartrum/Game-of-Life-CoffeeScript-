$(document).ready(	function(){

  $('.one').hover(	function(){
      $(this).data('bgcolor', $(this).css('background-color')).css('background-color', 'rgb(0,0,200');
    },
    function(){
      $(this).css('background-color', $(this).data('bgcolor'));
    }
  );

  $('#title').hover(	function(){
      $(this).data('textcolor', $(this).css('color')).css('color', 'rgb(250,0,0');
    },
    function(){
      $(this).css('color', $(this).data('textcolor'));
    }
  );


  $('#Reset').click(	function(){
  	thing();

  });




});

