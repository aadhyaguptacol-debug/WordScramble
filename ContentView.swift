
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
  
