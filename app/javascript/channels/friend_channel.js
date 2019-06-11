/* global App */

export default () => {
  console.log('friend client side websockets');
  App.cable.subscriptions.create({ channel: 'FriendChannel', room: `friend` }, {
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
        <span class="message">${data.message}</span>
      </article>
    `;
    },
  });
};
