/* global App */

export default () => {

  const friendRequest = () => {
    console.log('friend client side js loaded');
    App.cable.subscriptions.create({ channel: 'FriendChannel', room: 'friend_${userID}' }, {
      received(data) {
        document.getElementById('#notification').classList.remove('hidden')
        console.log('received data', data);
        this.appendLine(data);
      },

      appendLine(data) {
        const html = this.createLine(data);
        // const element = document.querySelector("[data-chat-room='Best Room']");
        const element = document.getElementById('#notification');
        element.insertAdjacentHTML('beforeend', html);
      },

      createLine(data) {
        return `
      <article class="chat-line">
        <span class="speaker">${data.sent_by}</span>
        <span class="body">${data.body}</span>
      </article>
    `;
      },
    });
  }
};
