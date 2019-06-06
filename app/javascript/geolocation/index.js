/* global Rails  */

const sendCoordsToRails = ({ lat, lng }) => {
  const userLatitude = document.getElementById('user_latitude');
  const userLongitude = document.getElementById('user_longitude');
  userLatitude.value = lat;
  userLongitude.value = lng;
  Rails.fire(userLatitude.form, 'submit');
};

export default () => {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition((position) => {
      const pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude,
      };
      sendCoordsToRails(pos);
    });
  }
};
