//
//  SliderView.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 5/8/25.
//

import SwiftUI


struct SliderView: View {
    @State private var moodScale: Double = 1
       @State private var skinCalmness: Double = 1
       @State private var sleepScale: Double = 1
       
       let range: ClosedRange<Double> = 1...5
       
       var body: some View {
           VStack(spacing: 20) {
               labeledGradientSlider(title: "Mood", value: $moodScale)
               labeledGradientSlider(title: "Skin calmness", value: $skinCalmness)
               labeledGradientSlider(title: "Sleep", value: $sleepScale)
           }
           .font(.headline)
           .padding(.horizontal,20)
       }
       
       @ViewBuilder
       private func labeledGradientSlider(title: String, value: Binding<Double>) -> some View {
           VStack(alignment: .leading, spacing: 10) {
               Text("\(title): \(value.wrappedValue, specifier: "%.1f")")
                   .font(.headline)
                   .foregroundColor(.white)
               ZStack {
                   // Smooth red → green gradient background
                   LinearGradient(
                       colors: [.red, .orange, .yellow, .green],
                       startPoint: .leading,
                       endPoint: .trailing
                   )
                   .frame(height: 4)
                   .cornerRadius(2)
                   
                   // Clear track so gradient is visible behind it
                   Slider(value: value, in: range)
                       .accentColor(.clear)
               }
               .frame(height: 30)
           }
       }
   }





#Preview {
    SliderView()
}
