/* global App, Rails */
const catchupInviteForm = document.getElementById('catchup-invitation-form');
const catchupInvitationId = document.getElementById('catchup_invitation_id');
const guestResponseForm = document.getElementById('guest-response-form');
const guestResponseId = document.getElementById('guest_response_id');
const receivedCatchupInvitationIds = [];
const receivedGuestUpdateIds = [];

const displayNavbarBadge = () => {
  const catchupNavbarBadge = document.getElementById('catchup-navbar-badge');
  if (catchupNavbarBadge) {
    catchupNavbarBadge.classList.remove('hidden');
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
      displayNavbarBadge();
      const { guest_id: guestId, catchup_id: catchupId } = data;

      if (catchupId !== undefined) {
        if (catchupInviteForm && !receivedCatchupInvitationIds.includes(catchupId)) {
          console.log(`received catchup invite for catchup_id ${catchupId} (should only see once per reload)`);
          receivedCatchupInvitationIds.push(catchupId);
          catchupInvitationId.value = catchupId;
          Rails.fire(catchupInviteForm, 'submit'); // get catchup invite card
        }
      } else if (guestId !== undefined) {
        if (guestResponseForm && !receivedGuestUpdateIds.includes(guestId)) {
          console.log(`received guest status update for guest_id ${guestId} (should only see once per reload)`);
          receivedGuestUpdateIds.push(guestId);
          guestResponseId.value = guestId;
          Rails.fire(guestResponseForm, 'submit'); // get guest response card
        }
      }
    },
  });
};
