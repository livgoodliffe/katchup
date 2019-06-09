export default () => {
  const listMap = document.querySelector('.my-map-list');

  if (listMap) {
    window.mapboxMap.zoomTo(12, { duration: 2000 });
  }
};
