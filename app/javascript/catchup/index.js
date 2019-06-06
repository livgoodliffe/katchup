/* eslint no-param-reassign: off */

export default () => {
  let spotsSelected = 0;
  const catchupForm = document.getElementById('catchup_form');

  if (catchupForm) {
    const buttonsFriends = document.querySelectorAll('.modal-add-button-friend');
    const buttonsSpots = document.querySelectorAll('.modal-add-button-spot');

    const friendsAvatarsContainer = document.getElementById('chosen-friends-avatars-container');
    const spotImageContainer = document.getElementById('chosen-spot-image-container');

    buttonsFriends.forEach((button) => {
      button.addEventListener('click', (event) => {
        // prevent form submission
        event.preventDefault();

        const hiddenInput = document.getElementById(button.id.replace('button_', ''));

        if (hiddenInput.value === 'true') {
          hiddenInput.value = false;
          // remove image from container
          const containerFriendAvatar = document.getElementById(button.id.replace('button', 'container'));
          containerFriendAvatar.parentNode.removeChild(containerFriendAvatar);
          button.innerHTML = '<i class="fas fa-plus-circle"></i>';
        } else {
          // set hidden rails form input to true
          hiddenInput.value = true;
          // put friends image into selected friend images container
          const imageUrl = document.getElementById(button.id.replace('button', 'image')).src;
          friendsAvatarsContainer.insertAdjacentHTML('beforeend', `<img id='${button.id.replace('button', 'container')}' class='chosen-friend-avatar' src='${imageUrl}'>`);
          button.innerHTML = '<i class="far fa-check-circle"></i>';
        }
      });
    });

    buttonsSpots.forEach((button) => {
      button.addEventListener('click', (event) => {
        // prevent form submission
        event.preventDefault();

        const hiddenInput = document.getElementById(button.id.replace('button_', ''));

        if (spotsSelected === 0) {
          // set hidden rails form input to true
          hiddenInput.value = true;

          // put spots image into spots image container
          const imageUrl = document.getElementById(button.id.replace('button', 'image')).src;
          spotImageContainer.insertAdjacentHTML('beforeend', `<img id='${button.id.replace('button', 'container')}' class="chosen-spot-image" src='${imageUrl}'>`);
          button.innerHTML = '<i class="far fa-check-circle"></i>';
          spotsSelected += 1;
        } else if (hiddenInput.value === 'true') {
          hiddenInput.value = false;
          // remove image from container
          const containerSpotImage = document.getElementById(button.id.replace('button', 'container'));
          containerSpotImage.parentNode.removeChild(containerSpotImage);
          button.innerHTML = '<i class="fas fa-plus-circle"></i>';
          spotsSelected -= 1;
        }
      });
    });
  }
};
