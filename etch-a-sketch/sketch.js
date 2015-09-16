$(document).ready(function()
{
  // init black square
  $('#gridContainer').append('<div class = "gridSquare"></div>');
  $('.gridSquare').css({
    'width': $('#gridContainer').width(),
    'height': $('#gridContainer').width()
  });

  function createGrid () {
    // remove pre-existing squares
    $('div.gridSquare').remove();
    $('div.newRow').remove();

    var squares = prompt('Enter the number of squares:'); // prompt user for grid size
    var size = $('#gridContainer').width() / squares -2 // find size of squares

    for (i = 0; i < squares; i++) {
      for (j = 0; j < squares; j++) {
        $('#gridContainer').append('<div class = "gridSquare"></div>');
      }
      $('#gridContainer').append('<div class = "newRow"></div>');
    }

    // create squares in container
    $('.gridSquare').css({
      'width': size,
      'height': size
    });
  }

  function getRandomColor() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
  }

  // call random color function
  $('#colors').on('click', function()
  {
    createGrid();

    $('.gridSquare').on('mouseenter', function()
    {
      $(this).css({'background-color': getRandomColor})
    })
  });

  // decrease opacity
  $('#mosaic').on('click', function()
  {
    createGrid();
    $('.gridSquare').on('mouseenter', function()
    {
      var currentOpacity = $(this).css('opacity');
      $(this).css({'opacity': currentOpacity - 0.1})
    })
  });

  // fade
  $('#trail').on('click', function()
  {
    createGrid();
    $('.gridSquare').on('mouseenter', function()
    {
      $(this).fadeTo('fast', 0)

      // return back to black
      $(this).on('mouseleave', function()
      {
        $(this).fadeTo('fast',1)
      })
    })
  });
});
