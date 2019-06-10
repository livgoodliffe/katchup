/* global App */

export default () => {
  console.log('catchup client side websockets');
  App.cable.subscriptions.create({ channel: 'CatchupChannel', room: `catchup` }, {
    received(data) {
      document.getElementById('catchup-navbar-badge').classList.remove('hidden');

      console.log('received data', data);
      this.appendLine(data);
    },

    appendLine(data) {
      const html = this.createLine(data);
      // const element = document.querySelector("[data-chat-room='Best Room']");
      const element = document.getElementById('catchup-chat-messages');
      if (element) {
        element.insertAdjacentHTML('beforeend', html);
      }
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
