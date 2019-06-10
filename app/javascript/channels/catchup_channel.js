/* global App */

export default () => {
  console.log('catchup client side websockets');
  const userId = document.querySelector('body').dataset.userid;

  if (userId !== null) {
    App.cable.subscriptions.create({ channel: 'CatchupChannel', room: `catchup_${userId}` }, {
      received(data) {
        document.getElementById('catchup-navbar-badge').classList.remove('hidden');
        console.log('received data', data);
        this.appendLine(data);
      },

      appendLine(data) {
        const html = this.createLine(data);
        // const element = document.querySelector("[data-chat-room='Best Room']");
        const element = document.querySelector('#catchup-chat-messages');
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
  }
};
