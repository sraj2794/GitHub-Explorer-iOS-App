# GitHub-Explorer-iOS-App
GitHub Explorer is a mobile application designed to help users explore popular repositories on GitHub for their favorite programming languages. The app allows users to search for repositories, sort them based on various criteria, and view detailed information about each repository, including top contributors, issues, and comments.

# Functionalities
- **Search**: Users can enter a programming language of their choice.
- **Repository List**: The app fetches a list of popular repositories for the entered programming language from the GitHub API and presents it to the user. Users can sort repositories based on stars, forks, help-wanted-issues, or recent updates.
- **Repository Details**: Tapping on a repository in the list displays a detailed screen with information about the repository, including top contributors, top issues, and top comments.
- **Unlimited Repository Display**: The number of repositories users can see is not limited.
- **Design Pattern**: The app follows the MVVM design pattern for better organization and scalability.

# Non-functional Requirements
- **Compatibility**: The app is optimized for iOS 13.0+ Xcode 13.0+ Swift 5.0+.
- **Data Source**: Data is fetched from the GitHub API to ensure accuracy and up-to-date information.
- **UI/UX**: The user interface and experience are designed to be intuitive and user-friendly.
- **CollectionView**: The repository list is displayed using a CollectionView, with each cell showing the avatar image, repository name, and description.
- **Detail Screen**: Detailed repository information, including top contributors and issues, is displayed on a separate screen.
- **Implementation Details**:
  - **Design Principles**: The app adheres to the SOLID principles for robust and maintainable code.
  - **Tests**: Unit tests and UI tests are implemented to ensure the reliability and stability of the app.
  - **Code Readability**: The codebase is written with readability and maintainability in mind, making it easy for developers to understand and modify.

# Screenshots
<div style="display: flex; flex-wrap: wrap;">
  <img src="https://github.com/sraj2794/GitHub-Explorer-iOS-App/assets/41502704/876787cf-cc52-4786-b9cb-fa8f3bd04ade" width="200" height="400" style="margin-right: 10px;">
  <img src="https://github.com/sraj2794/GitHub-Explorer-iOS-App/assets/41502704/45c196ad-c8e8-4590-b13b-670d5b661cd6" width="200" height="400" style="margin-right: 10px;">
  <img src="https://github.com/sraj2794/GitHub-Explorer-iOS-App/assets/41502704/52c2ce3c-e8aa-4911-963f-542f86878a55" width="200" height="400" style="margin-right: 10px;">
  <img src="https://github.com/sraj2794/GitHub-Explorer-iOS-App/assets/41502704/10af9e38-ad70-46d2-a362-9c8fc20f7ab8" width="200" height="400" style="margin-right: 10px;">
</div>

# How to Use
To use the GitHub Explorer app:

1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Build and run the app on your iOS device or simulator.
4. Enter a programming language in the search bar to explore popular repositories on GitHub.
5. Tap on a repository to view detailed information, including top contributors and issues.

# References
- [GitHub API Documentation](https://docs.github.com/en/rest)
- [GitHub API Endpoint](https://api.github.com)

# Credits
GitHub Explorer is developed by Raj Shekhar. If you have any questions or feedback, please contact us at sraj2794@gmail.com.

# License
This project is licensed under the * License.

