//
//  ContentView.swift
//  ObjectHelperAI
//
//  Created by Ethan Wen on 6/28/26.
//

import CoreML
import PhotosUI
import SwiftUI
import Vision

struct ContentView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var predictionText = "Select an image to classify."
    var body: some View {
        VStack(spacing: 24) {
            Text("Object Helper AI")
                .font(.largeTitle)
                .bold()
            if let selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(16)
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 300)
                    .overlay(
                        Text("No Image Selected")
                            .foregroundStyle(.secondary)
                    )
            }
            Text(predictionText)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
            PhotosPicker(
                "Choose Image",
                selection: $selectedItem,
                matching: .images
            )
            .buttonStyle(.borderedProminent)
            .onChange(of: selectedItem) {
                Task {
                    await loadImage()
                }
            }
        }
        Spacer()
            .padding()
    }
    func loadImage() async {
        guard let selectedItem else { return }
        do {
            if let data = try await selectedItem.loadTransferable(
                type: Data.self
            ),
                let image = UIImage(data: data)
            {
                selectedImage = image
                classifyImage(image)
            }
        } catch {
            predictionText = "Could not load image."
        }
    }
    func classifyImage(_ image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            predictionText = "Could not prepare image."
            return
        }
        do {
            let model = try VNCoreMLModel(for: ObjectClassifier().model)
            let request = VNCoreMLRequest(model: model) { request, error in
                guard
                    let results = request.results
                        as? [VNClassificationObservation],
                    let topResult = results.first
                else {
                    predictionText = "Could not classify image."
                    return
                }
                let confidence = Int(topResult.confidence * 100)
                predictionText =
                    "I think this is: \(topResult.identifier)\nConfidence: \(confidence)%"
            }
            let handler = VNImageRequestHandler(ciImage: ciImage)
            try handler.perform([request])
        } catch {
            predictionText = "There was a problem using the model."
        }
    }
}

#Preview {
    ContentView()
}
