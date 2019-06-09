const slideInSearch = () => {
  const feed = document.querySelector('#feed-page');
  const searchSelect = document.querySelector('#search-search form');

  const searchPage = document.querySelector('#search-page');
  const back = document.querySelector('#search-back-button');

  const mapPage = document.querySelector('#map');
  const mapIcon = document.querySelector('#map-icon');


  if (searchSelect) {
    searchSelect.addEventListener('click', () => {
      searchPage.classList.add('animated', 'slideInRight');
      searchPage.classList.remove('hidden');

      feed.classList.add('hidden');
      back.classList.add('fas', 'fa-arrow-left', 'red-arrow', 'animated', 'slideInLeft');
    });
  };

  if (back) {
    back.addEventListener('click', () => {
      searchPage.classList.add('animated', 'slideOutRight');
      searchPage.classList.remove('slideOutRight');

      back.classList.remove('fas', 'fa-arrow-left', 'red-arrow', 'slideInLeft');
      searchPage.classList.add('hidden');
      feed.classList.remove('hidden');
    });
  };

  if (mapIcon) {
    mapIcon.addEventListener('click', () => {
      mapPage.classList.add('animated', 'slideInRight');
      mapPage.classList.remove('hidden');

      feed.classList.add('hidden');
      back.classList.add('fas', 'fa-arrow-left', 'red-arrow', 'animated', 'slideInLeft');
    });
  };
};

export { slideInSearch };
