//
//  ContentView.swift
//  translationgame
//
//
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @StateObject var viewModel = QuizViewModel()
    
    var body: some View {
        VStack {
            HStack{
                Text("Qu:zer")
                    .padding()
                    .foregroundColor(.yellow)
                    .font(.system(size: 40).bold())
                    .cornerRadius(8)
                    .shadow(radius: 5)
                    .padding(.top, 20)
                Spacer()
            }
            Spacer()

            if viewModel.gameCompleted {
                VStack {
                    Text("Test bitti! Toplam puanınız: \(viewModel.score)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                    
                    Button(action: {
                        withAnimation {
                            viewModel.resetGame()
                        }
                    }) {
                        Text("Yeniden Başlat")
                            .padding()
                            .background(Color.yellow.opacity(0.9))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(radius: 5)
                    }
                    .transition(.scale)
                }
                Spacer()

            } else {
                VStack {
                    Text("\"\(viewModel.questions[viewModel.currentQuestionIndex].englishWord.uppercased())\" Kelime'nin Türkçe karşılığı nedir?")
                        .font(.title)
                        .padding(.horizontal,20)
                        .foregroundColor(.white)
                        .transition(.slide)
                    
                    Spacer().frame(height: 40)
                    HStack {
                        ForEach(viewModel.questions[viewModel.currentQuestionIndex].options, id: \.self) { option in
                            Button(action: {
                                viewModel.selectedOption = option
                            }) {
                                Text(option)
                                    .padding()
                                    .background(
                                        ZStack {
                                            if viewModel.selectedOption == option {
                                                Color.yellow.opacity(0.9)
                                            } else {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.gray, lineWidth: 3)
                                            }
                                        }
                                    )
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .font(.system(size: 18))
                                    .fontWeight(Font.Weight.medium)
                                    .shadow(radius: 5)
                                    .padding(.bottom, 5)
                            }
                        }
                    }
                    Spacer().frame(height: 40)

                    HStack{
                        Button(action: {
                            withAnimation {
                                viewModel.checkAnswer()
                            }
                        }) {
                            Text("Gönder")
                                .padding()
                                .background(Color.yellow.opacity(0.9))
                                .foregroundColor(.black)
                                .font(.system(size: 22).bold())
                                .cornerRadius(8)
                                .shadow(radius: 5)
                        }
                    }.padding(.init(top: 20, leading: 20, bottom: 200, trailing: 20))
                    }
                   
                .animation(.default, value: viewModel.currentQuestionIndex)
            }
        }
        .background(Color.black.opacity(0.8))
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Sonuç"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("Tamam"))
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}


