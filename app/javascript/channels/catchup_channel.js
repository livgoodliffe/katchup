/* global App, Rails */
const catchUpPage = document.getElementById('catchup-page');
const catchupInviteForm = document.getElementById('catchup-invitation-form');
const catchupInvitationId = document.getElementById('catchup_invitation_id');
const guestResponseForm = document.getElementById('guest-response-form');
const guestResponseId = document.getElementById('guest_response_id');

const myCatchupBadge = document.getElementById('my-catchup-badge');
const otherCatchupBadge = document.getElementById('other-catchup-badge');
const navbarCatchupBadge = document.getElementById('navbar-catchup-badge');

const receivedCatchupInvitationIds = [];
const receivedGuestUpdateIds = [];

const displayBadge = (type) => {
  switch (type) {
    case 'navbar':
      if (navbarCatchupBadge) {
        navbarCatchupBadge.classList.remove('hidden');
      }
      break;
    case 'mine':
      if (myCatchupBadge) {
        myCatchupBadge.classList.remove('hidden');
      }
      break;
    case 'other':
      if (otherCatchupBadge) {
        otherCatchupBadge.classList.remove('hidden');
      }
      break;
    default:
      break;
  }
};

export default () => {
  App.catchupChannel = App.cable.subscriptions.create({
    channel: 'CatchupChannel',
    room: 'catchup',
  }, {

    connected() {
      const sendListRequest = () => this.send({ request: 'list' });
      sendListRequest();
      setInterval(sendListRequest, 5000);
    },

    received(data) {
      displayBadge('navbar');
      const { guest_id: guestId, catchup_id: catchupId } = data;

      if (catchupId !== undefined) {
        if (catchUpPage) displayBadge('other');
        if (catchupInviteForm && !receivedCatchupInvitationIds.includes(catchupId)) {
          receivedCatchupInvitationIds.push(catchupId);
          catchupInvitationId.value = catchupId;
          Rails.fire(catchupInviteForm, 'submit'); // get catchup invite card
        }
      } else if (guestId !== undefined) {
        if (catchUpPage) displayBadge('mine');
        if (guestResponseForm && !receivedGuestUpdateIds.includes(guestId)) {
          receivedGuestUpdateIds.push(guestId);
          guestResponseId.value = guestId;
          Rails.fire(guestResponseForm, 'submit'); // get guest response card
        }
      }
    },
  });
};
