import SwiftUI

struct PathAndShape: View {
    var body: some View {
        ScrollView {
            VStack {
//                基礎Path介紹()
//                有黑色border的隆起矩形()
//                圓餅圖()
//                上方隆起的矩形()
//                Loading()

                CirclePieChart()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    PathAndShape()
}

struct CirclePieChart: View {
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.4)
                // 因為是 stroke所以是一個環 不是圓
                .stroke(Color(.systemBlue), lineWidth: 80)

            Circle()
                .trim(from: 0.4, to: 0.6)
                .stroke(Color(.systemTeal), lineWidth: 80)

            Circle()
                .trim(from: 0.6, to: 0.75)
                .stroke(Color(.systemPurple), lineWidth: 80)

            Circle()
                .trim(from: 0.75, to: 1)
                .stroke(Color(.systemYellow), lineWidth: 90)
                .overlay(
                    Text("25%")
                        .font(.system(.title, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                        .offset(x: 80, y: -100)
                )
        }
        .frame(width: 250, height: 250)
    }
}

struct Loading: View {
    private var purpleGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 207/255, green: 150/255, blue: 207/255), Color(red: 107/255, green: 116/255, blue: 179/255)]), startPoint: .trailing, endPoint: .leading)

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray6), lineWidth: 20)
                .frame(width: 300, height: 300)

            Circle()
                // 從0 3點方向 一直到 0.85 1點方向
                .trim(from: 0, to: 0.85)
                // 紫色漸層
                .stroke(purpleGradient, lineWidth: 20)
                .frame(width: 300, height: 300)
                .overlay {
                    VStack {
                        Text("85%")
                            .font(.system(size: 80, weight: .bold, design: .rounded))
                            .foregroundColor(.gray)
                        Text("Complete")
                            .font(.system(.body, design: .rounded))
                            .bold()
                            .foregroundColor(.gray)
                    }
                }
        }
    }
}

// RoundedRectangle Circle Capsule同樣繼承Shape
struct Dome: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addQuadCurve(to: CGPoint(x: rect.size.width, y: 0), control: CGPoint(x: rect.size.width/2, y: -(rect.size.width * 0.1)))
        path.addRect(CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))

        return path
    }
}

struct 上方隆起的矩形: View {
    var body: some View {
//        Path { path in
//            path.move(to: CGPoint(x: 0, y: 0))
//            path.addQuadCurve(to: CGPoint(x: 200, y: 0), control: CGPoint(x: 100, y: -20))
//            path.addLine(to: CGPoint(x: 200, y: 40))
//            path.addLine(to: CGPoint(x: 200, y: 40))
//            path.addLine(to: CGPoint(x: 0, y: 40))
//        }
//        .fill(Color.green)

        // 另一種path的方式 直接新增一個矩行 就不用那麼多行 addLine
//        Path { path in
//            path.move(to: CGPoint(x: 0, y: 0))
//            path.addQuadCurve(to: CGPoint(x: 200, y: 0), control: CGPoint(x: 100, y: -20))
//            path.addRect(CGRect(x: 0, y: 0, width: 200, height: 40))
//        }
//        .fill(Color.green)

        // 直接使用Dome會只有隆起的部分沒有矩形
        // Dome()

        // 這樣才會有矩形 但是不知道為什麼按不下去
        Button(action: {}) {
            Text("Test")
                .font(.system(.title, design: .rounded))
                .bold()
                .foregroundColor(.white)
                .frame(width: 250, height: 50)
                .background(Dome().fill(Color.red))
        }
    }
}

struct 圓餅圖: View {
    var body: some View {
        ZStack {
            Path { path in
                // 設定起始點
                path.move(to: CGPoint(x: 187, y: 187))
                // 設定中心點 跟起始點不一樣會變pacman radius 半徑 起始角度 3點 終點角度 6點 是否為順時針 false 會變成白色區域是綠色的
                path.addArc(center: .init(x: 187, y: 187), radius: 150, startAngle: .degrees(0), endAngle: .degrees(190), clockwise: true)
            }
            .fill(.yellow)

            Path { path in
                path.move(to: CGPoint(x: 187, y: 187))
                path.addArc(center: .init(x: 187, y: 187), radius: 150, startAngle: .degrees(190), endAngle: .degrees(110), clockwise: true)
            }
            .fill(.teal)

            Path { path in
                path.move(to: CGPoint(x: 187, y: 187))
                path.addArc(center: .init(x: 187, y: 187), radius: 150, startAngle: .degrees(110), endAngle: .degrees(90), clockwise: true)
            }
            .fill(.blue)

            Path { path in
                path.move(to: CGPoint(x: 187, y: 187))
                path.addArc(center: .init(x: 187, y: 187), radius: 150, startAngle: .degrees(90), endAngle: .degrees(360), clockwise: true)
            }
            .fill(.purple)
            // 從 起始點位移20 20
            .offset(x: 20, y: 20)
            .overlay(
                Text("25%")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                    .foregroundColor(.black)
                    //
                    .offset(x: 80, y: 290)
            )
        }
    }
}

struct 有黑色border的隆起矩形: View {
    var body: some View {
        ZStack {
            Path { path in
                // 設定初始點
                path.move(to: CGPoint(x: 20, y: 60))
                // 向右 橢圓的起點
                path.addLine(to: CGPoint(x: 40, y: 60))
                // 向右 橢圓的終點 設定橢圓中心及高度 高度方向跟Unity相反
                path.addQuadCurve(to: CGPoint(x: 210, y: 60), control: CGPoint(x: 125, y: 0))
                // 向右
                path.addLine(to: CGPoint(x: 230, y: 60))
                // 向下
                path.addLine(to: CGPoint(x: 230, y: 100))
                // 向左 因為是fill 所以自動增加一條線到起始點
                path.addLine(to: CGPoint(x: 20, y: 100))
            }
            .fill(Color.purple)

            // 橢圓的黑色外框
            Path { path in
                // 設定初始點
                path.move(to: CGPoint(x: 20, y: 60))
                // 向右 橢圓的起點
                path.addLine(to: CGPoint(x: 40, y: 60))
                // 向右 橢圓的終點 設定橢圓中心及高度 高度方向跟Unity相反
                path.addQuadCurve(to: CGPoint(x: 210, y: 60), control: CGPoint(x: 125, y: 0))
                // 向右
                path.addLine(to: CGPoint(x: 230, y: 60))
                // 向下
                path.addLine(to: CGPoint(x: 230, y: 100))
                // 向左 因為是fill 所以自動增加一條線到起始點
                path.addLine(to: CGPoint(x: 20, y: 100))
                path.closeSubpath()
            }
            .stroke(.black, lineWidth: 5)
        }
    }
}

struct 基礎Path介紹: View {
    var body: some View {
        Path { path in
            // 設定初始點
            path.move(to: CGPoint(x: 20, y: 20))
            // 向右移動到300
            path.addLine(to: CGPoint(x: 300, y: 20))
            // 向下移動到200
            path.addLine(to: CGPoint(x: 300, y: 200))
            // 向左移動到 20
            path.addLine(to: CGPoint(x: 20, y: 200))
            // 將目前的點 與 起始點連接
            path.closeSubpath()
        }
        // 顯示線條 因為沒有將線 回到初始點 所以會有開口
        .stroke(.green, lineWidth: 10)
        // 如果需要填滿使用fill 預設也是fill
        // .fill(.green)
    }
}
