import mapboxgl from 'mapbox-gl';

export default () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      // style: 'mapbox://styles/mapbox/streets-v10',
      style: 'mapbox://styles/mapbox/light-v9',
    });

    const markers = JSON.parse(mapElement.dataset.markers);

    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

      const markerStylingElement = document.createElement('div');
      markerStylingElement.className = 'map-marker';

      new mapboxgl.Marker(markerStylingElement)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(map);
    });

    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
  }
};
