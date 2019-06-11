// function thumbnailLoader() {
//   const reviewLabel = document.querySelector('.new_review label.file');
//   const file = document.getElementById('review_image').files[0];
//   const reader = new FileReader();
//   reader.onload = (e) => {
//     const image = document.createElement('img');
//     image.style.width = '100%';
//     image.style.height = '100%';
//     image.src = e.target.result;
//     document.body.appendChild(image);
//     reviewLabel.innerHTML = '';
//     reviewLabel.appendChild(image);
//   };
//   reader.readAsDataURL(file);
// }

export const reviewImageHandler = () => {
  const reviewLabel = document.querySelector('.new_review label.file');
  // const reviewImageInput = document.getElementById('review_image');

  if (reviewLabel) {
    reviewLabel.innerHTML = '<p><i class="fas fa-camera"></i></p><p class="review-photo-text">Add Photo</p>';
    reviewLabel.classList.add('d-flex', 'flex-column', 'align-items-center', 'justify-content-center');
    reviewLabel.classList.remove('hide-review-label');
  }

  // reviewImageInput.addEventListener('change', () => { thumbnailLoader(); });
};

export const reviewStarsHandler = () => {
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
