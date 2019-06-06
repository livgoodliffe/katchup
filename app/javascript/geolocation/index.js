/* global Rails  */

const sendCoordsToRails = ({ lat, lng }) => {
  console.log('send coords to rails');
  const userLatitude = document.getElementById('user_latitude');
  const userLongitude = document.getElementById('user_longitude');
  userLatitude.value = lat;
  userLongitude.value = lng;
  console.log(lat, lng);
  Rails.fire(userLatitude.form, 'submit');
};

export default () => {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition((position) => {
      const pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude,
      };
      console.log(`position: latitude(${pos.lat}) longitude(${pos.lng})`);
      sendCoordsToRails(pos);
    });
  }
};
