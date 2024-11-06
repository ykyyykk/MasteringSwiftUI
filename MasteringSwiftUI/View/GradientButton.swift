import SwiftUI

struct GradientButton: View {
    var body: some View {
        VStack {
            Button {
                print("normal")
            } label: {
                Label(
                    title: {
                        Text("Delete")
                    },
                    icon: {
                        Image(systemName: "trash")
                            .font(.title)
                    }
                )
            }
            .buttonStyle(GradientBackgroundStyle())

            Button(action: {}) {
                Text("Buy Me A Coffe")
            }
            .tint(.purple)
            .buttonStyle(.borderedProminent) // 加了這一行就會有圓角
//            .buttonBorderShape(.roundedRectangle(radius: 5)) // 圓角radius設定
            .buttonBorderShape(.capsule) // 設定成橢圓

            Button("Delete", role: .destructive) {}
                .buttonStyle(.borderedProminent)
            Button("Delete", role: .destructive) {}
                .buttonStyle(.bordered)
        }
    }
}

// 縮減button樣式 可以重複使用
struct GradientBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0) // 按鈕壓下的動畫
    }
}

#Preview {
    GradientButton()
}
