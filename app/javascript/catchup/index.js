/* eslint no-param-reassign: off */

var submitReady = false;

const errorMessages = (selectionStatus) => {
  const friendError = document.getElementById('friend-missing-error');
  const spotError = document.getElementById('spot-missing-error');
  const dateError = document.getElementById('date-missing-error');
  const timeError = document.getElementById('time-missing-error');
  if (selectionStatus.friend === true) {
    friendError.style.visibility = 'hidden';
  } else {
    friendError.style.visibility = 'visible';
  }
  if (selectionStatus.spot === true) {
    spotError.style.visibility = 'hidden';
  } else {
    spotError.style.visibility = 'visible';
  }
  if (selectionStatus.date === true) {
    dateError.style.visibility = 'hidden';
  } else {
    dateError.style.visibility = 'visible';
  }
  if (selectionStatus.time === true) {
    timeError.style.visibility = 'hidden';
  } else {
    timeError.style.visibility = 'visible';
  }
};

const readyToSubmitCheck = (selectionStatus) => {
  errorMessages(selectionStatus);

  const status = Object.keys(selectionStatus)
    .reduce((acc, value) => (acc && selectionStatus[value]), true);

  if (status === true) {
    submitReady = true;
  } else {
    submitReady = false;
  }
};

const friends = (selectionStatus) => {
  const buttonsFriends = document.querySelectorAll('.modal-add-button-friend');
  const friendsAvatarsContainer = document.getElementById('chosen-friends-avatars-container');
  let friendsSelected = 0;

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
        friendsSelected -= 1;
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
        friendsSelected += 1;
      }
      if (friendsSelected === 0) {
        selectionStatus.friend = false;
      } else {
        selectionStatus.friend = true;
      }
      readyToSubmitCheck(selectionStatus);
    });
  });
};

const spot = (selectionStatus) => {
  const buttonsSpots = document.querySelectorAll('.modal-add-button-spot');
  const spotImageContainer = document.getElementById('chosen-spot-image-container');
  let spotsSelected = 0;

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
        selectionStatus.spot = true;
      } else if (hiddenInput.value === 'true') {
        hiddenInput.value = false;
        // remove image from container
        const containerSpotImage = document.getElementById(button.id.replace('button', 'container'));
        containerSpotImage.parentNode.removeChild(containerSpotImage);
        button.innerHTML = '<i class="fas fa-plus-circle"></i>';
        spotsSelected -= 1;
        selectionStatus.spot = false;
      }
      if (spotsSelected === 1) {
        selectionStatus.spot = true;
      } else {
        selectionStatus.spot = false;
      }
      readyToSubmitCheck(selectionStatus);
    });
  });
};

const calendar = (selectionStatus) => {
  // CALENDAR
  // remove calendar links
  const calendarLinks = document.querySelectorAll('.calendar-heading a');
  calendarLinks.forEach((link) => {
    link.parentNode.removeChild(link);
  });

  // remove table striping
  const stripedTables = document.querySelectorAll('.table-striped');
  stripedTables.forEach((table) => {
    table.classList.remove('table-striped');
  });

  let selectedDayElement = null;

  const hiddenDateYearInput = document.getElementById('date_year');
  const hiddenDateMonthInput = document.getElementById('date_month');
  const hiddenDateDayInput = document.getElementById('date_day');

  const dateContainer = document.getElementById('chosen-date-container');

  const calendarSelection = document.querySelectorAll('.simple-calendar');

  calendarSelection.forEach((calendar) => {
    calendar.addEventListener('click', (event) => {
      const element = event.target;
      if (element.tagName === 'TD') {
        if (element === selectedDayElement) {
          selectedDayElement = null;
          element.classList.remove('selected');
          selectionStatus.date = false;
          dateContainer.innerHTML = '<i class="fal fa-calendar mr-2"></i> Date';
        } else {
          const title = element.parentNode.parentNode.parentNode.parentNode.querySelector('.calendar-heading').innerText;
          const [monthWord, year] = title.split(' ');
          const day = element.innerText;
          const date = new Date(Date.parse(`${monthWord} ${day} ${year}`));
          const month = date.getMonth() + 1;

          element.classList.add('selected');

          if (selectedDayElement !== null) {
            selectedDayElement.classList.remove('selected');
          }

          selectedDayElement = element;
          hiddenDateYearInput.value = year;
          hiddenDateMonthInput.value = month;
          hiddenDateDayInput.value = day;
          dateContainer.innerHTML = `<i class="fal fa-calendar mr-2"></i> Date<br>\
                                     <span style="font-weight: bold; font-size: 1.5rem;">\
                                     ${date.toLocaleDateString('en', { weekday: 'long' })} \
                                     ${day} \
                                     ${date.toLocaleDateString('en', { month: 'short' })} \
                                     ${year}\
                                     </span>`;
          selectionStatus.date = true;
        }
        readyToSubmitCheck(selectionStatus);
      }
    });
  });
};

const time = (selectionStatus) => {

  // TIME
  const hiddenTimeHourInput = document.getElementById('time_hour');
  const hiddenTimeMinuteInput = document.getElementById('time_minute');
  const hiddenTimeAMPMInput = document.getElementById('time_ampm');

  const timeContainer = document.getElementById('chosen-time-container');

  const timeSelection = document.querySelector('.time-selector');

  let selectedHourElement = null;
  let selectedMinuteElement = null;
  let selectedAMPMElement = null;
  let timeReady = false;

  timeSelection.addEventListener('click', (event) => {
    const element = event.target;

    if (element.classList.contains('hour')) {
      if (element === selectedHourElement) {
        selectedHourElement = null;
        element.classList.remove('selected');
      } else {
        element.classList.add('selected');
        if (selectedHourElement !== null) {
          selectedHourElement.classList.remove('selected');
        }
        selectedHourElement = element;
      }
    }

    if (element.classList.contains('minute')) {
      if (element === selectedMinuteElement) {
        selectedMinuteElement = null;
        element.classList.remove('selected');
      } else {
        element.classList.add('selected');
        if (selectedMinuteElement !== null) {
          selectedMinuteElement.classList.remove('selected');
        }
        selectedMinuteElement = element;
      }
    }

    if (element.classList.contains('ampm')) {
      if (element === selectedAMPMElement) {
        selectedAMPMElement = null;
        element.classList.remove('selected');
      } else {
        element.classList.add('selected');
        if (selectedAMPMElement !== null) {
          selectedAMPMElement.classList.remove('selected');
        }
        selectedAMPMElement = element;
      }
    }

    timeReady = selectedHourElement && selectedMinuteElement && selectedAMPMElement;

    if (timeReady) {
      hiddenTimeHourInput.value = selectedHourElement.innerText;
      hiddenTimeMinuteInput.value = selectedMinuteElement.innerText;
      hiddenTimeAMPMInput.value = selectedAMPMElement.innerText;

      timeContainer.innerHTML = `<i class="fal fa-clock mr-1"></i> When?<br><span style="font-weight: bold; font-size: 1.5rem;">${selectedHourElement.innerText}:${selectedMinuteElement.innerText}${selectedAMPMElement.innerText}</span>`;
      selectionStatus.time = true;
    } else {
      timeContainer.innerHTML = '<i class="fal fa-clock mr-1"></i> When?';
      selectionStatus.time = false;
    }
    readyToSubmitCheck(selectionStatus);
  });
};

export default () => {
  // sliding underline on headers
  const catchupPage = document.getElementById('catchup-page');
  const movingUnderline = document.getElementById('moving-underline');
  const myCatchupHeader = document.getElementById('my-catchup-header');
  const catchupInvitationContent = document.getElementById('catchup-invitation-content');
  const guestResponseContent = document.getElementById('guest-response-content');

  if (catchupPage) {
    if (!movingUnderline) {
      myCatchupHeader.insertAdjacentHTML('beforeend', '<div id="moving-underline"></div>');
    } else if (catchupInvitationContent) {
      movingUnderline.classList.add('right');
    } else if (guestResponseContent) {
      movingUnderline.classList.add('left');
    }
  }

  const catchupForm = document.getElementById('catchup_form');

  if (catchupForm) {
    // Submission Handling
    const submitButton = document.getElementById('catchup-submit-button');
    submitButton.addEventListener('click', (event) => {
      if (!submitReady) {
        event.preventDefault();
        document.getElementById('summaryModalButton').click();
      }
    });

    // BUTTONS
    const selectionStatus = {
      friend: false,
      spot: false,
      date: false,
      time: false,
    };

    friends(selectionStatus);
    spot(selectionStatus);
    calendar(selectionStatus);
    time(selectionStatus);
  }
};
