import SwiftUI

struct SwiftUIText: View {
    var body: some View {
        Text("Your time is limited, so don’t waste it living someone else’s life. Don’t be trapped by dogma—which is living with the results of other people’s thinking. Don’t let the noise of others’ opinions drown out your own inner voice. And most important, have the courage to follow your heart and intuition.")
            .fontWeight(.bold)
            .font(.title)
            .foregroundStyle(.gray)
            .multilineTextAlignment(.center)
            .truncationMode(.head) // 第三行的 開頭開始截 保留完整字尾
            .rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0)) // 像星際大戰一樣橫躺
            .shadow(color: .gray, radius: 2, x: 0, y: 15) // 向下的陰影
        // .lineLimit(3) // 多餘的行數被截成...
        // .rotationEffect(.degrees(45), anchor: UnitPoint(x: 0, y: 0)) // 文字Anchor左上角 轉45度
        // .rotationEffect(.degrees(45)) // 文字anchor置中 轉45度
        
        // 可使用Markdown格式
        Text("**This is how you bold a text**. *This is how you make text italic.* You can [click this link](https://www.appcoda.com) to go to appcoda.com")
            .font(.title)
    }
}

#Preview {
    SwiftUIText()
}
