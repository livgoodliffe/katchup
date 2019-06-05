import mapboxgl from 'mapbox-gl';

const makeMarkers = (map, mapElement, bounds, markerType, markerStyle) => {
  if (mapElement.dataset[markerType] === undefined) return;

  const markers = JSON.parse(mapElement.dataset[markerType]);

  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

    const markerStylingElement = document.createElement('div');
    markerStylingElement.className = markerStyle;

    new mapboxgl.Marker(markerStylingElement)
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      .addTo(map);
  });

  markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
};

export default () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

    const map = new mapboxgl.Map({
      container: 'map',
      // style: 'mapbox://styles/mapbox/streets-v10',
      style: 'mapbox://styles/mapbox/light-v9',
    });

    const bounds = new mapboxgl.LngLatBounds();

    // dataset attribute are camelcased by browser
    makeMarkers(map, mapElement, bounds, 'markers', 'map-marker');
    makeMarkers(map, mapElement, bounds, 'markersFavourite', 'map-marker-favourite');
    makeMarkers(map, mapElement, bounds, 'markersWishlist', 'map-marker-wishlist');

    map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
  }
};
