document.addEventListener('DOMContentLoaded', () => {
    // View More / View Less functionality
    const viewMoreButtons = document.querySelectorAll('.view-more');

    viewMoreButtons.forEach(button => {
        button.addEventListener('click', (event) => {
            const card = event.target.closest('.card');
            const comments = card ? card.querySelector('.comments') : null;

            if (comments) {
                comments.classList.toggle('visible');
                card.classList.toggle('expanded');
                event.target.textContent = comments.classList.contains('visible') ? 'View Less' : 'View More';
            }
        });
    });

    // Calendar dropdown functionality
    const calendarIcon = document.querySelector('.calendar-icon');
    const calendarDropdown = document.querySelector('.calendar-dropdown');

    if (calendarIcon && calendarDropdown) {
        calendarIcon.addEventListener('click', () => {
            calendarDropdown.classList.toggle('show');
        });

        document.addEventListener('click', (event) => {
            if (!calendarIcon.contains(event.target) && !calendarDropdown.contains(event.target)) {
                calendarDropdown.classList.remove('show');
            }
        });
    }

    // Sidebar toggle functionality
    const menuToggle = document.querySelector(".menu-toggle");
    const closeBtn = document.querySelector(".close-btn");
    const sidebar = document.querySelector(".sidebar");

    if (menuToggle && sidebar) {
        menuToggle.addEventListener("click", () => {
            sidebar.classList.toggle("active"); // Show/hide sidebar
        });
    }

    if (closeBtn && sidebar) {
        closeBtn.addEventListener("click", () => {
            sidebar.classList.remove("active"); // Hide sidebar
        });
    }

    // Flatpickr calendar initialization
    const datePicker = document.getElementById("datePicker");
    const datePickerIcon = document.getElementById("datePickerIcon");

    if (datePicker && datePickerIcon) {
        const calendar = flatpickr(datePicker, {
            allowInput: true,
            dateFormat: "Y-m-d",
            defaultDate: datePicker.value || new Date(),
            disableMobile: true,
            maxDate: "today",
            appendTo: document.body, // Ensure calendar is positioned properly
            onOpen: function (selectedDates, dateStr, instance) {
                if (instance.calendarContainer) {
                    let calendarContainer = instance.calendarContainer;
                    calendarContainer.style.transform = "scale(1)";
                    calendarContainer.style.transformOrigin = "top right"; // Adjust position
                }
            }
        });

        datePickerIcon.addEventListener("click", (event) => {
            event.preventDefault();
            datePicker.focus();
            calendar.open();
        });
    }
});
