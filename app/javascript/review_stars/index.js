export default () => {
  const reviewStars = document.querySelectorAll('#review-form-stars i');
  const reviewRating = document.getElementById('review_rating');

  if (reviewStars) {
    reviewStars.forEach((listenerStar, index) => {
      listenerStar.addEventListener('click', () => {
        reviewStars.forEach((clickedStar, i) => {
          if (i <= index) {
            clickedStar.classList.remove('far');
            clickedStar.classList.add('fas');
          } else {
            clickedStar.classList.remove('fas');
            clickedStar.classList.add('far');
          }
          reviewRating.value = index + 1;
        });
      });
    });
  }
};
