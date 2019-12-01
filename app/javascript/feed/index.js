import { animateCSS, alwaysVisible, willHideAfterwards } from '../animate_css';

export default () => {

  const feed = document.querySelector('#feed-page');
  const searchSelect = document.querySelector('#spots-search');

  const searchPage = document.querySelector('#search-page');
  const exit = document.querySelector('#search-exit');

  const bringInSearch = (callback) => {
    animateCSS(searchPage, 'slideInRight', callback, alwaysVisible);
  };

  const takeOutSearch = (callback) => {
    animateCSS(searchPage, 'slideOutRight', callback, willHideAfterwards);
  };

  const bringInX = (callback) => {
    animateCSS(exit, 'fadeIn', callback, alwaysVisible);
  };

  const takeOutX = (callback) => {
    animateCSS(exit, 'fadeOut', callback, willHideAfterwards);
  };

  if (searchSelect) {
    searchSelect.addEventListener('click', () => {
        feed.classList.add('hidden');
        bringInSearch();
        bringInX();
    });
  };

  if (back) {
    exit.addEventListener('click', () => {
        feed.classList.remove('hidden');
        takeOutSearch();
        takeOutX();
    });
  }
};
