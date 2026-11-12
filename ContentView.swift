
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
 Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }

             

                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)

                            Spacer()

                            Text("+\(word.count)")
                                .foregroundStyle(.green)
                                .font(.caption.bold())
                        }
                    }
                } header: {
                    Text("Used Words")
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: startGame) {
                        Label("New Game", systemImage: "arrow.clockwise")
                    }
                }
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    func addNewWord() {
        let answer = newWord.lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard !answer.isEmpty else {
            return
        }

        guard answer.count >= 3 else {
            wordError(
                title: "Too short",
                message: "Words must be at least 3 letters long!"
            )
            return
        }

    
        guard answer != rootWord.lowercased() else {
            wordError(
                title: "Start word not allowed",
                message: "You can't use the start word itself!"
            )
            return
        }

        guard isOriginal(word: answer) else {
            wordError(
                title: "Word used already",
                message: "Be more original!"
            )
            return
        }

      
        guard isPossible(word: answer) else {
            wordError(
                title: "Word not possible",
                message: "You can't spell that word from '\(rootWord)'!"
            )
            return
        }

   
        guard isReal(word: answer) else {
            wordError(
                title: "Word not recognized",
                message: "You can't just make them up, you know!"
            )
            return
        }

    

    
