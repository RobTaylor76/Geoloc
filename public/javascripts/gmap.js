var map;
var tmp_marker = null;
var defaults = {
	zoom : 16,
	latitude : 54.968455496864586,
  longitude : -1.6067519187927246};


var infowindow = new google.maps.InfoWindow(
    {
      size: new google.maps.Size(150,50)
    }); 

$(document).ready(function () {

  var lat = $('#location_latitude').val();
  var long = $('#location_longitude').val();

  if (!!lat && !!long)  {
     createMap(lat , long);

  } else {

    if (navigator && navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(geo_success, geo_error );
    } else {
      alert('Geolocation not supported.');
    }
  }
});

function geo_success(position) {

  createMap( position.coords.latitude,position.coords.longitude);

}

function geo_error(err) {
  if (err.code == 1) {
    alert('Location information denied by user.');
  } else if (err.code == 2) {
    alert('Location information is unavailable.');
  } else if (err.code == 3) {
    alert('Location information timed out.');
  } else {
    alert('An unknown error occurred.');
  }
  createMap(defaults.latitude , defaults.longitude);
}

function createMapOptions (lat,long,zoom) {
    var loc = new google.maps.LatLng(lat, long);
    var myOptions = {
      zoom: zoom,
      center: loc,
      mapTypeId: google.maps.MapTypeId.ROADMAP};
    
  return myOptions;
}

/*
create map takes  lat , long and zoom params… zoom is optional… defaults to defaults.zoom
*/
function createMap( lat , long , zoom )
{

   if ( zoom === undefined ) {
      zoom = defaults.zoom ;
   }
  myOptions  = createMapOptions(lat, long, zoom );

  map = new google.maps.Map(document.getElementById("map"), myOptions);

  google.maps.event.addListener(map, 'click', function() {
    infowindow.close();
  });
  google.maps.event.addListener(map, 'click', function(event) {

    if (tmp_marker) {
      tmp_marker.setMap(null);
      tmp_marker = null;
    }
    tmp_marker = createMarker(event.latLng, "name", "<b>Location</b><br>"+event.latLng ,map);
// when a marker is created… the form fields are updated to reflect the new position
    $('#location_latitude').val(event.latLng.lat()).change();
    $('#location_longitude').val(event.latLng.lng()).change();

  }); 

  createMarker(myOptions.center, "name", "<b>Location</b><br>"+myOptions.center, map)
  
  $('#location_latitude').val(myOptions.center.lat()).change();
  $('#location_longitude').val(myOptions.center.lng()).change();

}

/*
When map is clicked a new marker is created.
*/
function createMarker(latlng, name, html, map) {
  var contentString = html;
  var marker = new google.maps.Marker({
    position: latlng,
    map: map,
    zIndex: Math.round(latlng.lat()*-100000)<<5
  });
  google.maps.event.addListener(marker, 'click', function() {
    infowindow.setContent(contentString);
    infowindow.open(map,marker);
  });
  google.maps.event.trigger(marker, 'click');
  return marker;
} 
  
