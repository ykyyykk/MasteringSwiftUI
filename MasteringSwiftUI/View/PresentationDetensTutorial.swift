import SwiftUI

struct PresentationDetensTutorial: View {
    @State private var showSheet = false

    var body: some View {
        VStack {
            Button("Show Bottom Sheet") {
                showSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $showSheet) {
                Text("This is the expandable bottom sheet.")
                // 大約螢幕高度的10% 固定高度200 中 大
                // .presentationDetents([.fraction(0.1), .height(200), .medium, .large])
                // 是否顯示 灰色capsule
                // .presentationDragIndicator(.hidden)
                // 固定一種大小 一定要用Array包起來
                // .presentationDetents([.medium])
            }

            Spacer()
        }
    }
}

#Preview {
    PresentationDetensTutorial()
}
