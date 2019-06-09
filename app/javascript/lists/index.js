export default () => {
  const listMap = document.querySelector('.my-map-list');

  if (listMap && listMap.userCoordsAvailable) {
    window.mapboxMap.zoomTo(12, { duration: 2000 });
  }
};
