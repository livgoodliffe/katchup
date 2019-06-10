/* global App */

export default () => {
  const catchupPage = document.querySelector('#catchup-page');

  if (catchupPage) {
    console.log('client side js loaded');
    App.cable.subscriptions.create({ channel: 'CatchupChannel', room: 'Room' }, {
      received(data) {
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
        <span class="speaker">${data.sent_by}</span>
        <span class="body">${data.body}</span>
      </article>
    `;
      },
    });
  }
};
