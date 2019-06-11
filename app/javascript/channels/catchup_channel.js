/* global App, Rails */
const catchupInviteForm = document.getElementById('catchup-invitation-form');
const catchupInvitationId = document.getElementById('catchup_invitation_id');
const receivedCatchupInvitationIds = [];

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
      const { catchup_id: catchupId } = data;
      if (catchupInviteForm && !receivedCatchupInvitationIds.includes(catchupId)) {
        receivedCatchupInvitationIds.push(catchupId);
        catchupInvitationId.value = catchupId;
        Rails.fire(catchupInviteForm, 'submit');
      }
    },
  });
};
