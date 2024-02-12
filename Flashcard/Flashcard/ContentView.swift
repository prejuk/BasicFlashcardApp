import SwiftUI

struct Flashcard: Identifiable {
    var id = UUID()
    var question: String
    var answer: String
    var color: Color
}



struct ContentView: View {
    
    @State private var isButtonScaled = false
    @State private var randomNumber = 0
    @State private var isFlipped = false
    @State private var isAddFlashcardSheetPresented = false
    @State private var newQuestion = ""
    @State private var newAnswer = ""
    @State private var selectedColor = Color.black
    @State private var isListSheetPresented = false
    
    var body: some View {
        
        ZStack {
            Color(.gray.opacity(0.2))
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                ZStack {
                    // Container for both rectangle and text
                    VStack {
                        ZStack {
                            Rectangle()
                                .fill(myFlashcards[randomNumber].color) // Set the color based on myFlashcards array
                                .frame(width: 300, height: 300)
                                .cornerRadius(20)
                                .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0)) // Apply rotation effect
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        self.isFlipped.toggle() // Toggle the state variable to flip
                                    }
                                }
                                .gesture(
                                    DragGesture()
                                        .onEnded { gesture in
                                            if gesture.translation.width < 0 {
                                                withAnimation(.easeInOut(duration: 0.5)) {
                                                    nextCard()
                                                }
                                            } else {
                                                withAnimation(.easeInOut(duration: 0.5)) {
                                                    previousCard()
                                                }
                                            }
                                        }
                                )
                            
                            VStack {
                                if isFlipped {
                                    Text(myFlashcards[randomNumber].answer) // Show answer when flipped
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.white)
                                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0)) // Rotate the text along with the card
                                        .scaleEffect(x: -1, y: 1) // Apply scale transformation to mirror the text
                                        .frame(width: 300, height: 300) // Match the size of the rectangle
                                } else {
                                    Text(myFlashcards[randomNumber].question) // Show question when not flipped
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.white)
                                        .rotation3DEffect(.degrees(0), axis: (x: 0, y: 1, z: 0)) // Reset rotation for the question
                                        .frame(width: 300, height: 300) // Match the size of the rectangle
                                }
                            }
                        }
                    }
                }

                
                
                
                Spacer()
                
                ZStack {
                
                Rectangle()
                        .frame(width: 200, height: 60)
                        .opacity(0.5)
                        .cornerRadius(50)
                    
                HStack {
                    //list view of flashcards
                    
                    
                    
                    
                    // Back
                    Button(action: {
                        previousCard()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    
                    
                    // Favorite
                    
                    
                    
                    // Next
                   
                    
                    // Add Flashcard Button
                    Button(action: {
                        isAddFlashcardSheetPresented.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    
                    
                    
                    Button(action: {
                        nextCard()
                    }) {
                        Image(systemName: "arrow.right")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                   
                }
                    
                
            }
                
            
        }
        .sheet(isPresented: $isAddFlashcardSheetPresented, content: {
            VStack {
                TextField("Question", text: $newQuestion)
                    .padding()
                TextField("Answer", text: $newAnswer)
                    .padding()
                ColorPicker("Color", selection: $selectedColor)
                    .padding()
                Button("Add Flashcard") {
                    // Add the new flashcard to your flashcard array
                    myFlashcards.append(Flashcard(question: newQuestion, answer: newAnswer, color: selectedColor))
                    isAddFlashcardSheetPresented.toggle()
                }
                .padding()
            }
        })
            
            
            
    }
    
}
    
    func nextCard() {
        randomNumber = Int.random(in: 0..<myFlashcards.count)
    }
    
    func previousCard() {
        if randomNumber > 0 {
            randomNumber -= 1
        } else {
            // If at the beginning, loop back to the end
            randomNumber = myFlashcards.count - 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
