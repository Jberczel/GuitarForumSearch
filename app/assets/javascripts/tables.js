$(".posts.index").ready(function() {
  $("#guitars").dataTable( {
    "ordering": false
  });
  $(".search").fadeIn(3000);
  $('#guitars').on('search.dt', updateLinks);
})

$(".gears.index").ready(function() {
  $("#gear").dataTable( {
    "ordering": false
  });
  $(".search").fadeIn(3000);
  $('#gear').on('search.dt', updateLinks);
})

$(".larrivees.index").ready(function() {
  $("#larrivee").dataTable( {
    "ordering": false
  });
  $(".search").fadeIn(3000);
  $('#larrivee').on('search.dt', updateLinks);
})

$(".martins.index").ready(function() {
  $("#martin").dataTable( {
    "ordering": false
  });
  $(".search").fadeIn(3000);
  $('#martin').on('search.dt', updateLinks);
})


$(".blueridges.index").ready(function() {
  $("#blueridge").dataTable( {
    "ordering": false
  });
  $(".search").fadeIn(3000);
  $('#blueridge').on('search.dt', updateLinks);
})


function updateLinks() {
  var value = $('.dataTables_filter input').val()
  //value = encodeURIComponent(value);
  $('.reverb-link').attr("href", "https://reverb.com/marketplace?query=" + value)
  $('.ebay-link').attr("href", "http://www.ebay.com/sch/?&_nkw=" + value)
  $('.auction-links').visible();
  //console.log(value); // <-- the value
}
