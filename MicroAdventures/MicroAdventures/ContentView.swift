//
//  ContentView.swift
//  MicroAdventures
//
//  Created by Ethan Wen on 6/26/26.
//

import SwiftUI
import MapKit

enum AdventureCategory: String, CaseIterable, Identifiable {
    case outdoor = "Outdoor"
    case food = "Food"
    case culture = "Culture"
    case active = "Active"
    case relax = "Relax"

    var id: String { rawValue }
}

enum EffortLevel: String, CaseIterable, Identifiable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"

    var id: String { rawValue }
}

struct ContentView: View {
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    @State private var selectedCategories: Set<AdventureCategory> = Set(AdventureCategory.allCases)
    @State private var selectedEffortLevels: Set<EffortLevel> = Set(EffortLevel.allCases)
    @State private var isAdventureComplete: Bool = false

    private let adventureCoordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    private let adventureTitle = "Golden Gate Sunrise Walk"
    private let adventureDescription = "Catch the first light over the bay with a brisk 30-minute walk along the bridge's pedestrian path."
    private let adventureCategory: AdventureCategory = .outdoor
    private let adventureEffort: EffortLevel = .low

    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition) {
                Marker(adventureTitle, coordinate: adventureCoordinate)
            }
            .ignoresSafeArea(edges: .bottom)
            .overlay(alignment: .top) {
                adventureCard
                    .padding(.horizontal)
                    .padding(.top, 8)
            }
            .overlay(alignment: .bottom) {
                nextAdventureButton
                    .padding(.horizontal)
                    .padding(.bottom, 32)
            }
            .navigationTitle("Micro Adventures")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    filterMenu
                }
            }
        }
    }

    private var adventureCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                pill(text: adventureCategory.rawValue, tint: .blue)
                pill(text: adventureEffort.rawValue, tint: .green)
                Spacer()
            }

            Text(adventureTitle)
                .font(.title2)
                .fontWeight(.bold)

            Text(adventureDescription)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack {
                Spacer()
                Button {
                    isAdventureComplete.toggle()
                } label: {
                    Label(
                        isAdventureComplete ? "Completed" : "Mark Complete",
                        systemImage: isAdventureComplete ? "checkmark.circle.fill" : "circle"
                    )
                    .font(.subheadline.weight(.semibold))
                }
                .buttonStyle(.borderedProminent)
                .tint(isAdventureComplete ? .green : .accentColor)
            }
        }
        .padding(16)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
    }

    private var nextAdventureButton: some View {
        Button {
            // TODO: load the next adventure
        } label: {
            Label("Next Adventure", systemImage: "arrow.right.circle.fill")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
    }

    private func pill(text: String, tint: Color) -> some View {
        Text(text)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .foregroundStyle(tint)
            .background(Capsule().fill(tint.opacity(0.18)))
    }

    private var filterMenu: some View {
        Menu {
            Section("Categories") {
                Button(allCategoriesSelected ? "Deselect All" : "Select All") {
                    selectedCategories = allCategoriesSelected ? [] : Set(AdventureCategory.allCases)
                }
                ForEach(AdventureCategory.allCases) { category in
                    Button {
                        toggle(category)
                    } label: {
                        Label(category.rawValue, systemImage: selectedCategories.contains(category) ? "checkmark" : "")
                    }
                }
            }

            Section("Effort Levels") {
                Button(allEffortLevelsSelected ? "Deselect All" : "Select All") {
                    selectedEffortLevels = allEffortLevelsSelected ? [] : Set(EffortLevel.allCases)
                }
                ForEach(EffortLevel.allCases) { level in
                    Button {
                        toggle(level)
                    } label: {
                        Label(level.rawValue, systemImage: selectedEffortLevels.contains(level) ? "checkmark" : "")
                    }
                }
            }
        } label: {
            Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
        }
    }

    private var allCategoriesSelected: Bool {
        selectedCategories.count == AdventureCategory.allCases.count
    }

    private var allEffortLevelsSelected: Bool {
        selectedEffortLevels.count == EffortLevel.allCases.count
    }

    private func toggle(_ category: AdventureCategory) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }

    private func toggle(_ level: EffortLevel) {
        if selectedEffortLevels.contains(level) {
            selectedEffortLevels.remove(level)
        } else {
            selectedEffortLevels.insert(level)
        }
    }
}

#Preview {
    ContentView()
}
