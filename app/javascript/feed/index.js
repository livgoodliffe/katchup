const slideInSearch = () => {
  const feed = document.querySelector('#feed-page');
  const feed_select = document.querySelector('#feed-page-selector');
  const search = document.querySelector('#search-page');
  const back = document.querySelector('#search-back-button');

    feed_select.addEventListener('click', () => {
      search.classList.add('animated', 'slideInRight');
      feed.classList.add('hidden')
      search.classList.remove('hidden');
    });

    back.addEventListener('click', () => {
      feed.classList.add('animated', 'slideOutRight');
      search.classList.add('hidden')
      feed.classList.remove('hidden');

    })
};

export { slideInSearch };
