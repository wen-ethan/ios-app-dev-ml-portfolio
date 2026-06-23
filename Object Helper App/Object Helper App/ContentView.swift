//
//  ContentView.swift
//  Object Helper App
//
//  Created by 27 BGCC Loan Library on 6/23/26.
//

import SwiftUI
import PhotosUI
import Vision
import CoreML
import AVFoundation
struct ContentView: View {
@State private var selectedItem: PhotosPickerItem?
@State private var selectedImage: UIImage?
@State private var resultText = "Choose a photo to identify an object."
@State private var isAnalyzing = false
let speaker = AVSpeechSynthesizer()
var body: some View {
VStack(spacing: 24) {
Text("Object Helper")
.font(.largeTitle)
.bold()
.accessibilityAddTraits(.isHeader)
if let selectedImage {
Image(uiImage: selectedImage)
.resizable()
.scaledToFit()
.frame(height: 250)
.cornerRadius(16)
.accessibilityLabel("Selected image")

} else {
RoundedRectangle(cornerRadius: 16)
.fill(.gray.opacity(0.2))
.frame(height: 250)
.overlay(

Text("No photo selected")
.font(.title2)

.foregroundStyle(.secondary)

)

.accessibilityLabel("No photo selected")

}
Text(resultText)
.font(.title2)
.multilineTextAlignment(.center)
.padding()
.accessibilityLabel(resultText)
PhotosPicker(selection: $selectedItem, matching: .images) {
Text("Choose Photo")
.font(.title2)
.bold()
.frame(maxWidth: .infinity)
.padding()
.background(.blue)
.foregroundStyle(.white)
.cornerRadius(12)

}
.accessibilityLabel("Choose a photo from the photo library")

Button {
if let selectedImage {
classifyImage(selectedImage)
}
} label: {
Text(isAnalyzing ? "Analyzing..." : "Identify Object")
.font(.title2)
.bold()
.frame(maxWidth: .infinity)
.padding()
.background(selectedImage == nil ? .gray : .green)
.foregroundStyle(.white)
.cornerRadius(12)

}
.disabled(selectedImage == nil || isAnalyzing)
.accessibilityLabel("Identify the object in the selected photo")
Button {
speak(resultText)
} label: {
Text("Speak Result")
.font(.title2)
.bold()
.frame(maxWidth: .infinity)
.padding()
.background(.orange)
.foregroundStyle(.white)
.cornerRadius(12)

}
.accessibilityLabel("Speak the object identification result")
Spacer()
}
.padding()
.onChange(of: selectedItem) {
loadSelectedPhoto()
}
}
func loadSelectedPhoto() {
Task {
guard let selectedItem else { return }
if let data = try? await selectedItem.loadTransferable(type: Data.self),
let image = UIImage(data: data) {
selectedImage = image
resultText = "Photo selected. Tap Identify Object."
}
}
}
func classifyImage(_ image: UIImage) {
isAnalyzing = true
resultText = "Analyzing image..."
guard let ciImage = CIImage(image: image) else {
resultText = "Sorry, I could not read this image."
isAnalyzing = false
return
}
do {

let configuration = MLModelConfiguration()
let model = try VNCoreMLModel(for: MobileNetV2(configuration: configuration).model)
let request = VNCoreMLRequest(model: model) { request, error in
DispatchQueue.main.async {
isAnalyzing = false

guard let results = request.results as? [VNClassificationObservation],

let topResult = results.first else {
resultText = "I could not identify this object."

return
}

let objectName = topResult.identifier
let confidence = Int(topResult.confidence * 100)
resultText = "This might be a \(objectName). I am \(confidence)% confident."

speak(resultText)
}
}
let handler = VNImageRequestHandler(ciImage: ciImage)
try handler.perform([request])
} catch {
resultText = "Something went wrong with the Machine Learning model."
isAnalyzing = false
}
}
func speak(_ text: String) {
let utterance = AVSpeechUtterance(string: text)
utterance.rate = 0.45
speaker.speak(utterance)
}
}
