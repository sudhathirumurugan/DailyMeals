document.addEventListener("DOMContentLoaded", function () {
    function initializeRating() {
        document.querySelectorAll(".stars").forEach(container => {
            let stars = container.querySelectorAll(".star");
            let hiddenInput = document.getElementById(container.dataset.field); // Hidden field selection

            stars.forEach((star, index) => {
                star.addEventListener("click", function (event) {
                    let clickPosition = event.offsetX / star.offsetWidth;
                    let isHalf = clickPosition < 0.5;
                    let newRating = index + (isHalf ? 0.5 : 1);

                    hiddenInput.value = newRating; // Store float value (e.g., 3.5)
                    updateStars(stars, newRating);
                });

                star.addEventListener("mouseover", function (event) {
                    let hoverIndex = index + (event.offsetX < star.offsetWidth / 2 ? 0.5 : 1);
                    updateStars(stars, hoverIndex);
                });

                container.addEventListener("mouseleave", function () {
                    updateStars(stars, parseFloat(hiddenInput.value)); // Restore saved rating
                });
            });

            // Restore stars from previously selected value
            let savedRating = parseFloat(hiddenInput.value);
            if (!isNaN(savedRating) && savedRating > 0) {
                updateStars(stars, savedRating);
            }
        });
    }

    function updateStars(stars, rating) {
        stars.forEach((star, i) => {
            if (i + 1 <= rating) {
                star.innerHTML = "&#9733;"; // Full star
                star.classList.add("checked");
            } else if (i + 0.5 <= rating) {
                star.innerHTML = "&#189;"; // Half star
                star.classList.add("checked-half");
            } else {
                star.innerHTML = "&#9734;"; // Empty star
                star.classList.remove("checked", "checked-half");
            }
        });
    }

    initializeRating();
});
