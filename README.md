# iOS App Development & ML Portfolio

> 🚧 **Work in Progress** — This repo is actively being built out as part of a summer learning program. Not all projects are complete.

A collection of Swift/SwiftUI iOS apps and a Core ML image classifier, developed while working through Apple's [Develop in Swift curriculum](https://www.apple.com/education/docs/develop-in-swift-explorations.pdf).

---

## Repository Structure

```
ios-app-dev-ml-portfolio/
├── Swift Guides/          # Playground exercises from the Develop in Swift curriculum
│   ├── 1-Values/
│   ├── 2-Algorithms/
│   ├── 3-Organizing Data/
│   └── 4-Building Apps/
├── firstFlashlightApp/    # First SwiftUI app
├── Flags/                 # Flag rendering app
├── MicroAdventures/       # Map-based adventure discovery app
└── ObjectClassifier/      # Core ML image classifier + iOS app
```

---

## Projects

### Swift Guides

Playground-based exercises from Apple's Develop in Swift Explorations curriculum, organized into four units:

- **1 – Values** — variables, types, strings, and basic Swift syntax
- **2 – Algorithms** — functions, control flow, and a QuestionBot app build
- **3 – Organizing Data** — structs, arrays, and a BouncyBall app build
- **4 – Building Apps** — app components, UIKit elements, and an ElementQuiz build

---

### firstFlashlightApp

A minimal SwiftUI app — the first one built in this program. Tapping a button changes the background color to simulate a flashlight. Simple proof-of-concept for SwiftUI state and layout basics.

**Stack:** SwiftUI, `@State`

---

### Flags

A SwiftUI app that renders country flags using colored shapes and images. Currently includes Denmark, Germany, Mexico, and the UAE, each implemented as a separate Swift view.

**Stack:** SwiftUI

---

### MicroAdventures *(proof of concept)*

A SwiftUI + MapKit app built as a hands-on experiment with agentic coding in Xcode, following Apple's **[Discovering Coding Intelligence](https://developer.apple.com/tutorials/discovering-coding-intelligence)** tutorial on the Apple Developer website. The app itself — a map-based adventure discovery UI with category and effort-level filters — was not the end goal; exploring what agentic coding in Xcode can do was. Not intended to be developed further.

**Stack:** SwiftUI, MapKit

---

### ObjectClassifier

An end-to-end Core ML image classification pipeline, from dataset → trained model → deployed iOS app.

#### Model

- **Architecture:** Image classifier trained in Create ML
- **Classes:** Headphones, Pencil, Water Bottle
- **Output:** `ObjectClassifier.mlmodel`

#### Dataset

Training and testing images were sourced from **[images.cv](https://images.cv)**.

| Split    | Headphones | Pencil | Water Bottle | Total |
|----------|-----------|--------|--------------|-------|
| Training | 469       | 322    | 890          | 1,681 |
| Testing  | 115       | 73     | 212          | 400   |

Images are organized by class under `ObjectClassiferTraining/` and `ObjectClassifierTesting/`.

#### ObjectHelperAI App

A SwiftUI iOS app that uses the trained model for on-device inference.

- User selects a photo from their library via `PhotosPicker`
- Image is run through `ObjectClassifier.mlmodel` using Vision + CoreML
- App displays the predicted class and confidence percentage

**Stack:** SwiftUI, Core ML, Vision, PhotosUI

---

## Tech

- **Language:** Swift
- **Frameworks:** SwiftUI, MapKit, Core ML, Vision, PhotosUI
- **ML Tooling:** Create ML (Apple), images.cv (dataset)
- **Xcode version:** tested on Xcode 16+

---

## Credits

- **ObjectClassifier training & testing data** — images sourced from [images.cv](https://images.cv), a computer vision dataset platform. Classes used: Headphones, Pencil, Water Bottle.

---

## Status

| Project            | Status         |
|--------------------|----------------|
| Swift Guides       | ✅ Complete     |
| firstFlashlightApp | ✅ Complete     |
| Flags              | ✅ Complete     |
| MicroAdventures    | 🧪 Proof of Concept |
| ObjectClassifier   | ✅ Model trained, app functional |
