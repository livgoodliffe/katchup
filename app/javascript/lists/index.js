// import { animateCSS, alwaysVisible, willHideAfterwards } from '../animate_css';

export default () => {
  const wishlist = document.querySelector('#want_to_try_list');
  const wishlistSelect = document.querySelector('#want_to_try_button');

  const favourites = document.querySelector('#been_there_list');
  const favouritesSelect = document.querySelector('#been_there_button');

  const movingUnderline = document.getElementById('moving-underline');

  if (wishlistSelect) {
    wishlistSelect.addEventListener('click', () => {
      favourites.classList.add('hidden');
      wishlist.classList.remove('hidden');
      wishlistSelect.classList.add('underline-active');
      favouritesSelect.classList.remove('underline-active');
      movingUnderline.classList.remove('right');
    });
  }

  if (favouritesSelect) {
    favouritesSelect.addEventListener('click', () => {
      favourites.classList.remove('hidden');
      wishlist.classList.add('hidden');
      wishlistSelect.classList.remove('underline-active');
      favouritesSelect.classList.add('underline-active');
      movingUnderline.classList.add('right');
    });
  }
};
