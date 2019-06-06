/* eslint no-param-reassign: off */
export default () => {

  const catchupForm = document.getElementById('catchup_form');

  if (catchupForm) {
    // BUTTONS
    const buttonsFriends = document.querySelectorAll('.modal-add-button-friend');
    const buttonsSpots = document.querySelectorAll('.modal-add-button-spot');

    const friendsAvatarsContainer = document.getElementById('chosen-friends-avatars-container');
    const spotImageContainer = document.getElementById('chosen-spot-image-container');

    const backgroundColor = '#C70039';

    let spotsSelected = 0;

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
          if (friendsAvatarsContainer.innerText === 'Choose Friends') {
            friendsAvatarsContainer.insertAdjacentHTML('beforeend', '<br>');
          }
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
          if (spotImageContainer.innerText === 'Choose Spot') {
            spotImageContainer.insertAdjacentHTML('beforeend', '<br>');
          }
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

    // CALENDAR
    // remove calendar links
    const calendarLinks = document.querySelectorAll('.calendar-heading a');
    calendarLinks.forEach((link) => {
      link.parentNode.removeChild(link);
    });

    let selectedDayElement = null;

    const hiddenDateInput = document.getElementById('date');
    const dateContainer = document.getElementById('chosen-date-container');

    const calendars = document.querySelectorAll('.simple-calendar');
    calendars.forEach((calendar) => {
      calendar.addEventListener('click', (event) => {
        const element = event.target;
        if (element.tagName === 'TD') {
          const title = element.parentNode.parentNode.parentNode.parentNode.querySelector('.calendar-heading').innerText;
          const [monthWord, year] = title.split(' ');
          const day = element.innerText;
          const month = new Date(Date.parse(`${monthWord} 1 ${year}`)).getMonth() + 1;

          element.classList.add('selected');

          if (selectedDayElement !== null) {
            selectedDayElement.classList.remove('selected');
          }

          selectedDayElement = element;
          hiddenDateInput.value = `${year}-${month}-${day}`;
          dateContainer.innerHTML = `Choose Date<br><span style="font-weight: bold; font-size: 1.5rem;">${day} ${monthWord} ${year}</span>`;
        }
      });
    });

    // TIME
    const hiddenTimeInput = document.getElementById('time');
    const timeContainer = document.getElementById('chosen-time-container');
    const timeSelector = document.querySelector('.time-selector');

    let selectedHourElement = null;
    let selectedMinuteElement = null;
    let selectedAMPMElement = null;

    timeSelector.addEventListener('click', (event) => {
      const element = event.target;
      if (element.classList.contains('hour')) {
        element.classList.add('selected');
        if (selectedHourElement !== null) {
          selectedHourElement.classList.remove('selected');
        }
        selectedHourElement = element;
      }

      if (element.classList.contains('minute')) {
        element.classList.add('selected');
        if (selectedMinuteElement !== null) {
          selectedMinuteElement.classList.remove('selected');
        }
        selectedMinuteElement = element;
      }

      if (element.classList.contains('ampm')) {
        element.classList.add('selected');
        if (selectedAMPMElement !== null) {
          selectedAMPMElement.classList.remove('selected');
        }
        selectedAMPMElement = element;
      }

      if (selectedHourElement !== null) {
        if (selectedMinuteElement !== null) {
          if (selectedAMPMElement !== null) {
            hiddenTimeInput.value = `${selectedHourElement.innerText}:${selectedMinuteElement.innerText}${selectedAMPMElement.innerText}`;
            timeContainer.innerHTML = `Choose Time<br><span style="font-weight: bold; font-size: 1.5rem;">${selectedHourElement.innerText}:${selectedMinuteElement.innerText}${selectedAMPMElement.innerText}</span>`;
          }
        }
      }
    });
  }
};
