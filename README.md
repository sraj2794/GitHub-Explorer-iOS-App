# GitHub-Explorer-iOS-App
GitHub Explorer is a mobile application designed to help users explore popular repositories on GitHub for their favorite programming languages. The app allows users to search for repositories, sort them based on various criteria, and view detailed information about each repository, including top contributors, issues, and comments.

# Functionalities
Search: Users can enter a programming language of their choice.
Repository List: The app fetches a list of popular repositories for the entered programming language from the GitHub API and presents it to the user. Users can sort repositories based on stars, forks, help-wanted-issues, or recent updates.
Repository Details: Tapping on a repository in the list displays a detailed screen with information about the repository, including top contributors, top issues, and top comments.
Unlimited Repository Display: The number of repositories users can see is not limited.
Design Pattern: The app follows the MVVM/VIPER design pattern for better organization and scalability.
# Non-functional Requirements
Compatibility: The app is optimized for both phones and iPads.
Data Source: Data is fetched from the GitHub API to ensure accuracy and up-to-date information.
UI/UX: The user interface and experience are designed to be intuitive and user-friendly.
CollectionView: The repository list is displayed using a CollectionView, with each cell showing the avatar image, repository name, and description.
Detail Screen: Detailed repository information, including top contributors and issues, is displayed on a separate screen.
Implementation Details
Design Principles: The app adheres to the SOLID principles for robust and maintainable code.
Tests: Unit tests and UI tests are implemented to ensure the reliability and stability of the app.
Code Readability: The codebase is written with readability and maintainability in mind, making it easy for developers to understand and modify.
# How to Use
To use the GitHub Explorer app:

Clone the repository to your local machine.
Open the project in Xcode.
Build and run the app on your iOS device or simulator.
Enter a programming language in the search bar to explore popular repositories on GitHub.
Tap on a repository to view detailed information, including top contributors and issues.
# References
GitHub API Documentation
GitHub API Endpoint
Credits
GitHub Explorer is developed by Raj Shekhar. If you have any questions or feedback, please contact us at sraj2794@gmail.com.

# License
This project is licensed under the * License.
