//
//  SliderView.swift
//  Skin Tracker
//
//  Created by Lidiia Diachkovskaia on 5/8/25.
//

import SwiftUI


struct SliderView: View {
    @Binding var skinDay: SkinDay  // Bind to SkinDay to access SkinScale

    let range: ClosedRange<Double> = 1...5

    var body: some View {
        VStack(spacing: 20) {
            labeledGradientSlider(title: "Mood", value: $skinDay.skinSlider.mood)
            labeledGradientSlider(title: "Skin Calmness", value: $skinDay.skinSlider.skinCalmness)
            labeledGradientSlider(title: "Sleep", value: $skinDay.skinSlider.sleep)
        }
        .font(.headline)
        .padding(.horizontal, 20)
    }

    @ViewBuilder
    private func labeledGradientSlider(title: String, value: Binding<Double>) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(title): \(value.wrappedValue, specifier: "%.1f")")
                .font(.headline)
                .foregroundColor(.white)
            ZStack {
                LinearGradient(
                    colors: [.red, .orange, .yellow, .green],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 4)
                .cornerRadius(2)

                Slider(value: value, in: range)
                    .accentColor(.clear)
            }
            .frame(height: 30)
        }
    }
}




#Preview {
   // SliderView()
}
