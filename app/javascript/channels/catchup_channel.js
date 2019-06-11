/* global App, Rails */
const catchupInviteForm = document.getElementById('catchup-invitation-form');
const catchupInvitationId = document.getElementById('catchup_invitation_id');
const receivedCatchupInvitationIds = [];

const displayNavbarBadge = () => {
  document.getElementById('catchup-navbar-badge').classList.remove('hidden');
  // App.catchupChannel.send({ message: 'sending back from client' });
};

export default () => {
  console.log('catchup client side websockets');

  App.catchupChannel = App.cable.subscriptions.create({
    channel: 'CatchupChannel',
    room: 'catchup',
  }, {

    connected() {
      if (catchupInviteForm) {
        const sendListRequest = () => this.send({ request: 'list' });
        sendListRequest();
        setInterval(sendListRequest, 5000);
      }
    },

    received(data) {
      const { catchup_id: catchupId } = data;

      console.log('received data', data);

      if (data.message === 'alert') {
        displayNavbarBadge();
      } else if (catchupInviteForm && !receivedCatchupInvitationIds.includes(catchupId)) {
        receivedCatchupInvitationIds.push(catchupId);
        catchupInvitationId.value = catchupId;
        Rails.fire(catchupInviteForm, 'submit');
      }
      // this.appendLine(data);
    },

    // appendLine(data) {
    //   const html = this.createLine(data);
    //   const element = document.getElementById('catchup-invites');
    //   if (element) {
    //     element.insertAdjacentHTML('beforeend', html);
    //   }
    // },

    // createLine(data) {
    //   return `
    //   <article class="chat-line">
    //     <span class="message">You have been invited to catchup with id ${data.catchup_id}</span>
    //   </article>
    // `;
    // },
  });
};
