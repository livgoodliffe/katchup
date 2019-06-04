/* global Rails  */
export default () => {
  const searchBox = document.getElementById('search');

  if (searchBox) {
    searchBox.addEventListener('keyup', (event) => {
      if (event.code !== 'Enter') {
        Rails.fire(searchBox.form, 'submit');
      }
    });
  }
};
