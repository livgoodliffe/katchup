const slideInSearch = () => {
  const feed = document.querySelector('#feed-page');
  const search_select = document.querySelector('#search-search form');

  const search_page = document.querySelector('#search-page');
  const back = document.querySelector('#search-back-button');

  const map_page = document.querySelector('#feed-map');
  const map_icon = document.querySelector('#map-icon');


    search_select.addEventListener('click', () => {
      search_page.classList.add('animated', 'slideInRight');
      search_page.classList.remove('hidden');

      feed.classList.add('hidden');
      back.classList.add('fas', 'fa-arrow-left', 'red-arrow', 'animated', 'slideInLeft');
    });

    back.addEventListener('click', () => {
      search_page.classList.add('animated', 'slideOutRight');
      search_page.classList.remove('slideOutRight');

      back.classList.remove('fas', 'fa-arrow-left', 'red-arrow', 'slideInLeft');
      search_page.classList.add('hidden');
      feed.classList.remove('hidden');
    })

    map_icon.addEventListener('click', () => {
      map_page.classList.add('animated', 'slideInRight');
      map_page.classList.remove('hidden');

      feed.classList.add('hidden');
      back.classList.add('fas', 'fa-arrow-left', 'red-arrow', 'animated', 'slideInLeft');
    })
};

export { slideInSearch };
