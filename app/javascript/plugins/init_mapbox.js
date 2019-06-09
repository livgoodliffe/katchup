import mapboxgl from 'mapbox-gl';

const makeMarkers = (map, mapElement, bounds, markerType, markerStyle) => {
  const markerJson = mapElement.dataset[markerType];

  if (markerJson === undefined || markerJson === 'null' || markerJson === '[]') return 0;
  const markers = JSON.parse(mapElement.dataset[markerType]);
  markers.forEach((marker) => {


    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);



    const markerStylingElement = document.createElement('div');
    markerStylingElement.className = markerStyle;

    // user avatar section
    const userAvatarUrl = mapElement.dataset.markerUserAvatar;
    if (markerType === 'markerUser' && userAvatarUrl !== '') {
      markerStylingElement.style.backgroundImage = `url('${userAvatarUrl}')`;
    }

    new mapboxgl.Marker(markerStylingElement)
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      .addTo(map);
  });

  if (bounds !== null) markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));

  return markers.length;
};

export default () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

    const mapOptions = {
      container: 'map',
      style: 'mapbox://styles/mapbox/light-v9',
    };

    // see if user coords are available
    let userCoordsAvailable = false;
    if (mapElement.dataset.markerUser !== undefined && mapElement.dataset.markerUser !== 'null' && mapElement.dataset.markerUser !== '[]') {
      const [userMarker] = JSON.parse(mapElement.dataset.markerUser);
      userCoordsAvailable = true;
      mapOptions.center = [userMarker.lng, userMarker.lat];
      mapOptions.zoom = 7;
    }

    const map = new mapboxgl.Map(mapOptions);
    window.mapboxMap = map;
    window.mapboxMap.userCoordsAvailable = userCoordsAvailable;
    let bounds = null;
    if (!userCoordsAvailable) bounds = new mapboxgl.LngLatBounds();

    // dataset attribute are camelcased by browser
    let markers = 0;
    markers += makeMarkers(map, mapElement, bounds, 'markers', 'map-marker');
    markers += makeMarkers(map, mapElement, bounds, 'markersFavourite', 'map-marker-favourite');
    markers += makeMarkers(map, mapElement, bounds, 'markersWishlist', 'map-marker-wishlist fas');
    markers += makeMarkers(map, mapElement, bounds, 'markersSpots', 'map-marker');
    markers += makeMarkers(map, mapElement, bounds, 'markerUser', 'map-marker-user');
    if (!userCoordsAvailable) {
      if (markers > 0) map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
    }
  }
};
