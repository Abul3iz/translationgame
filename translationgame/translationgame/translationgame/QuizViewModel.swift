//
//  QuizViewModel.swift
//  translationgame
//
// 
//

import Foundation

import SwiftUI

class QuizViewModel: ObservableObject {
    @Published var questions: [Question] = [
        Question(englishWord: "Apple", options: ["Elma", "Armut", "Muz", "Karpuz"], correctAnswer: "Elma"),
        Question(englishWord: "Dog", options: ["Kedi", "Köpek", "Balık", "Kuş"], correctAnswer: "Köpek"),
        Question(englishWord: "Sun", options: ["Ay", "Güneş", "Yıldız", "Bulut"], correctAnswer: "Güneş"),
        Question(englishWord: "Book", options: ["Defter", "Kitap", "Kalem", "Masa"], correctAnswer: "Kitap"),
        Question(englishWord: "Water", options: ["Su", "Çay", "Kahve", "Süt"], correctAnswer: "Su"),
        Question(englishWord: "House", options: ["Araba", "Ev", "Bina", "Ofis"], correctAnswer: "Ev"),
        Question(englishWord: "Car", options: ["Bisiklet", "Tren", "Uçak", "Araba"], correctAnswer: "Araba"),
        Question(englishWord: "Tree", options: ["Çiçek", "Ağaç", "Yaprak", "Dal"], correctAnswer: "Ağaç"),
        Question(englishWord: "Chair", options: ["Sandalye", "Masa", "Dolap", "Yatak"], correctAnswer: "Sandalye"),
        Question(englishWord: "Milk", options: ["Peynir", "Yoğurt", "Süt", "Tereyağı"], correctAnswer: "Süt")
    ]
    
    @Published var currentQuestionIndex = 0
    @Published var score = 0
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var gameCompleted = false
    @Published var selectedOption: String? = nil
    
    func checkAnswer() {
        guard let selectedOption = selectedOption else {
            alertMessage = "Lütfen bir seçenek seçin."
            showAlert = true
            return
        }
        
        if selectedOption == questions[currentQuestionIndex].correctAnswer {
            score += 1
            alertMessage = "Doğru! Puanınız: \(score)"
        } else {
            alertMessage = "Yanlış! Doğru cevap: \(questions[currentQuestionIndex].correctAnswer)"
        }
        
        showAlert = true
        nextQuestion()
    }
    
    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedOption = nil
        } else {
            gameCompleted = true
            alertMessage = "Test bitti! Toplam puanınız: \(score)"
            showAlert = true
        }
    }
    
    func resetGame() {
        currentQuestionIndex = 9
        score = 0
        gameCompleted = false
        selectedOption = nil
    }
}
