
import SwiftUI
import UIKit

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

  
    var score: Int {
        usedWords.reduce(0) { $0 + $1.count }
    }
    var body: some View {
        NavigationStack {
            List {
            

                Section {
                    HStack {
                        Label("Your Score", systemImage: "star.fill")
                            .font(.headline)

                        Spacer()

                        Text("\(score)")
                            .font(.title.bold())
                            .foregroundStyle(.blue)
                    }
                }

