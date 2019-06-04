export default () => {
  const searchBox = document.getElementById('search');

  if (searchBox) {
    searchBox.addEventListener('keyup', (event) => {
      if (event.code !== 'Enter') {
        searchBox.form.submit();
      }
    });
  }
};
