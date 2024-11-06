import SwiftUI

struct PickerToggleFormStepper: View {
    @State var testBool: Bool = false
    @State var maxPriceLevel: Int = 5
    @State var selectedOrder: Int = 0
    @State var displayOrders = ["A", "B", "C"]

    var body: some View {
        Form {
            // 灰色 字體小的title
            Section(header: Text("SORT PREFERENCE")) {
                // 白底 的內容
                // 這個 下拉式選單 沒有被包在Form裡面會很醜
                Picker(selection: $selectedOrder, label: Text("Display order")) {
                    ForEach(0 ..< displayOrders.count, id: \.self) {
                        Text(self.displayOrders[$0])
                    }
                }
            }
            Section(header: Text("FILTER PREFERENCE")) {
                // 內建左右toggle
                Toggle(isOn: $testBool) {
                    Text("Show Check-in Only")
                }
            }

            // 內建的增加減少按鈕
            Stepper(onIncrement: {
                self.maxPriceLevel += 1

                if self.maxPriceLevel > 5 {
                    self.maxPriceLevel = 5
                }
            }, onDecrement: {
                self.maxPriceLevel -= 1

                if self.maxPriceLevel < 1 {
                    self.maxPriceLevel = 1
                }
            }) {
                Text("Show \(String(repeating: "$", count: maxPriceLevel)) or below")
            }
        }
    }
}

#Preview {
    PickerToggleFormStepper()
}
