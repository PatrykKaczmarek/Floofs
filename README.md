## Floofs - exceptionally fluffy pets browser 🐾

> [flüf]. Noun. Definition: A pet with fluffy, cloudlike fur; the fur of an exceptionally fluffy pet


## Authors

* Patryk Kaczmarek
	* [Github](https://github.com/PatrykKaczmarek)
	* [LinkedIn](https://www.linkedin.com/in/patryk-kaczmarek-ios/)

## Tools & Services

* Tools:
  * [Xcode 14.3](https://developer.apple.com/download/) with latest iOS SDK

## Project Setup

### Prerequisites

Things you need to have installed before start working with a project.

* [Homebrew](https://brew.sh)

### Instalation

1. Clone repository:

  ```bash
  # over https:
  git clone https://github.com/PatrykKaczmarek/Floofs.git
  # or over SSH:
  git clone git@github.com:PatrykKaczmarek/Floofs.git
  ```

2. Install project's development tools:

  ```bash
  sh bootstrap.sh
  ```

3. Go to `{SRCROOT}/Floofs/App/` and duplicate `AppConfig.sample.plist`. Change its name to `AppConfig.plist`. Open it and use appropriate config values. Alternatively paste `AppConfig.plist` receivedby the author.

	> ⚠️ `AppConfig.plist` is added to `.gitignore` so you won't accidentally push it to the repository.


4. Open `Floofs.xcodeproj` file and build the project.

## Coding guidelines

- Respect Swift [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- The code must be readable and self-explanatory - full variable names, meaningful methods, etc.
- Don't leave any commented-out code.

## Project structure

The project consists of several targets:

- `APILayer` - a generic framework for handling REST requests and responses
- `CatsAPI` - a framework using [Cat API](https://thecatapi.com/) to retrieve cats' data and serve it to the host application. Uses `APILayer`.
- `DogsAPI` - a framework using [Dog API](https://dog.ceo/dog-api/) to retrieve dogs' data and serve it to the host application. Uses `APILayer`.
- `Floofs` - the main (host) app displaying `Floofs`!

## Technicalities

- **Separation of Concerns:** API part has been divided into 3 parts: generic `APILayer` that is being used by `DogsAPI` and `CatsAPI` frameworks. It strongly separates API services' logic and, at the same time, removes a lot of repetitions. Additionally, it allows using `open` and `public` access control modifiers to distinguish interface visibility even more.
- **Extendability:** using a generic-first approach, `Cat` and `Dog` models conform to `Pet` protocol, so the app can display type-erased models leveraging the same UI components. So maybe the user will see more floofs in the future? Who knows...
- **Repetitions Reduction:** leveraging caching mechanism, the app can remember and restore data without the neccessity of retrieving them from the API again:
	- **Model Caching** - `Cat` and `Dog` models are unique across the app. It means, when they change, old models are replaced by new models so the newly fetched data is stored for later usage.
	- **Image Caching** - `Kingfisher` framework takes care of memory and disk caches to reduce network usage.
- **Data Transfer Reduction:** - the app uses pagination to obtain cats' images in chunks, to fetch only data that will be visible to the user. Unfortunately `DogsAPI` does not support pagination.
- **Reliably Performant and Responsive:** multithreading allows to keep the app responsive and performant even when scrolling fast through the images gallery.
- **Launch Prerequisites Validation:** the app during launch time, checks whether the project has been setup according to this README. If `AppConfig` is missing, then displays the appropriate error message by redirecting the user to `AppLaunchFailureScene`.

## Roadmap

- [ ] **Search:** find your Floof faster 🏎️
- [ ] **Favorite images:** mark images you like the most ⭐️
- [ ] **Home Screen Widget:** display Floofs on your Springboard 📱
- [ ] **Dark mode support:** see better your Floofs in dim light situations, particularly at night 🌙
- [ ] **Error handling:** be informed when something goes wrong 5️⃣0️⃣0️⃣
- [ ] **Zoom view:** magnify the image 🔎 and share it
- [ ] **Increase test coverage:** never be surprised by 🐛🐛🐛
- [ ] **SwiftUI support:** see Floofs app written in the brand new, shiny UI framework ✨
- [ ] **Documentation:** read well documented interfaces 📕📗📘
- [ ] **Security:** improve security by changing a way how `AppConfig.plist` is stored 🔐

## Credentials

### API

- [Dog API](https://dog.ceo/dog-api/)
- [Cat API](https://thecatapi.com/)

### Icons created by logisstudio - Flaticon

<a href="https://www.flaticon.com/free-icons/paw"><img src="Floofs/Assets.xcassets/paw.imageset/paw.png" style="background-color:white;" align="left" height="48" width="48"></a>

<a href="https://www.flaticon.com/free-icons/cat"><img src="Floofs/Assets.xcassets/cat_deselected.imageset/cat_deselected@3x.png" style="background-color:white;" align="left" height="48" width="48"></a>

<a href="https://www.flaticon.com/free-icons/cat"><img src="Floofs/Assets.xcassets/cat_selected.imageset/cat_selected@3x.png" style="background-color:white;" align="left" height="48" width="48"></a>

<a href="https://www.flaticon.com/free-icons/dog"><img src="Floofs/Assets.xcassets/dog_deselected.imageset/dog_deselected@3x.png" style="background-color:white;" align="left" height="48" width="48"></a>

<a href="https://www.flaticon.com/free-icons/dog"><img src="Floofs/Assets.xcassets/dog_selected.imageset/dog_selected@3x.png" style="background-color:white;" align="left" height="48" width="48"></a>