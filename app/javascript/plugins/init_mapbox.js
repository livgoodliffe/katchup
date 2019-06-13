import mapboxgl from 'mapbox-gl';

window.toggleSpotMarkers = () => {
  document.querySelectorAll('.map-marker').forEach((marker) => {
    marker.classList.toggle('hidden-marker');
  });
  document.querySelector('.map-marker-header').classList.toggle('transparent-marker-header');
};

window.toggleWishlistMarkers = () => {
  document.querySelectorAll('.map-marker-wishlist').forEach((marker) => {
    marker.classList.toggle('hidden-marker');
  });
  document.querySelector('.map-marker-wishlist-header').classList.toggle('transparent-marker-header');
};

window.toggleFavouriteMarkers = () => {
  document.querySelectorAll('.map-marker-favourite').forEach((marker) => {
    marker.classList.toggle('hidden-marker');
  });
  document.querySelector('.map-marker-favourite-header').classList.toggle('transparent-marker-header');
};

const infoWindowEl = document.getElementById('info-map-window');

const clearActiveMarkers = () => {
  const activeMarkers = document.querySelectorAll('.map-marker-active');
  activeMarkers.forEach((marker) => {
    marker.classList.remove('map-marker-active');
  });
}

const makeMarkers = (map, mapElement, bounds, markerType, markerStyle) => {
  const markerJson = mapElement.dataset[markerType];

  if (markerJson === undefined || markerJson === 'null' || markerJson === '[]') return 0;
  const markers = JSON.parse(mapElement.dataset[markerType]);
  markers.forEach((marker) => {


    // const popup = new mapboxgl.Popup({closeButton: true}).setHTML(marker.infoWindow);


    const markerStylingElement = document.createElement('div');
    markerStylingElement.className = markerStyle;

    // user avatar section
    const userAvatarUrl = mapElement.dataset.markerUserAvatar;
    if (markerType === 'markerUser' && userAvatarUrl !== '') {
      markerStylingElement.style.backgroundImage = `url('${userAvatarUrl}')`;
    }

    markerStylingElement.addEventListener('click', () => {
      clearActiveMarkers();

      infoWindowEl.innerHTML = marker.infoWindow;
      infoWindowEl.classList.remove('info-map-window-closed');

      markerStylingElement.classList.add('map-marker-active');
    });

    new mapboxgl.Marker(markerStylingElement)
      .setLngLat([marker.lng, marker.lat])
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
      zoom: 1
    };

    // see if user coords are available
    let userCoordsAvailable = false;
    if (mapElement.dataset.markerUser !== undefined && mapElement.dataset.markerUser !== 'null' && mapElement.dataset.markerUser !== '[]') {
      const [userMarker] = JSON.parse(mapElement.dataset.markerUser);
      userCoordsAvailable = true;
      mapOptions.center = [userMarker.lng, userMarker.lat];
    }

    const map = new mapboxgl.Map(mapOptions);
    window.mapboxMap = map;
    window.mapboxMap.userCoordsAvailable = userCoordsAvailable;
    window.mapboxMap.zoomTo(12);
    let bounds = null;
    if (!userCoordsAvailable) bounds = new mapboxgl.LngLatBounds();

    // dataset attribute are camelcased by browser
    let markers = 0;
    markers += makeMarkers(map, mapElement, bounds, 'markers', 'map-marker');
    markers += makeMarkers(map, mapElement, bounds, 'markersFavourite', 'map-marker-favourite');
    markers += makeMarkers(map, mapElement, bounds, 'markersWishlist', 'map-marker-wishlist');
    markers += makeMarkers(map, mapElement, bounds, 'markersSpots', 'map-marker');
    markers += makeMarkers(map, mapElement, bounds, 'markerUser', 'map-marker-user');
    if (!userCoordsAvailable) {
      if (markers > 0) map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
    }

    map.on('click', (e) => {
      // If a user clicks on the map, close the info window.
      if (e.originalEvent.target.classList.contains('mapboxgl-canvas')) {
        infoWindowEl.classList.add('info-map-window-closed');
        clearActiveMarkers();
      }
    })
  }
};
