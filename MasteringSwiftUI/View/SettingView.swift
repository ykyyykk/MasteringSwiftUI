import SwiftUI

struct SettingView: View {
    @EnvironmentObject var settingStore: SettingStore
    @State var showCheckInOnly = false
    @State var selectedOrder = DisplayOrderType.checkInFirst
    @State var maxPriceLevel = 20
    @State var password = "aaa"

    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            // 隱藏密碼 跟 目前儲存沒有任何聯動
            SecureField("Password", text: $password)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding(.horizontal)

            FormField(fieldName: "Password", fieldValue: $password, isSecure: false)

            Button {
                self.settingStore.showCheckInOnly = self.showCheckInOnly
                self.settingStore.displayOrder = self.selectedOrder
                self.settingStore.maxPriceLevel = self.maxPriceLevel

                print(showCheckInOnly)
                print(selectedOrder)
                print(maxPriceLevel)
                dismiss()

            } label: {
                Text("Save")
                    .foregroundStyle(.primary)
            }
        }
        .onAppear {
            print(self.showCheckInOnly)
            print(self.selectedOrder)
            print(self.maxPriceLevel)

            self.showCheckInOnly = self.settingStore.showCheckInOnly
            self.selectedOrder = self.settingStore.displayOrder
            self.maxPriceLevel = self.settingStore.maxPriceLevel

            print(self.showCheckInOnly)
            print(self.selectedOrder)
            print("maxPriceLevel: \(self.maxPriceLevel)")
        }
    }
}

#Preview {
    // 在settingStore加上EnvironmentObject後就不能使用了
    // SettingView(settingStore: SettingStore())

    SettingView().environmentObject(SettingStore())
}
