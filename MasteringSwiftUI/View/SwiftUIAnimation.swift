import SwiftUI

struct SwiftUIAnimation: View {
    var body: some View {
        // 兩個動畫插在Animation放置的位置 一個放在onTapGesture外面 一個放在裡面
        隱式Animation()
        顯式Animation()
        LoadingCircleAnimation()
        LoadingLineAnimation()
        LoadingCircleProgressAnimation()
        LoadingPointAnimation()
//        RecordAnimation()
    }
}

#Preview {
    SwiftUIAnimation()
}

struct RecordAnimation: View {
    @State private var recordBegin = false
    @State private var recording = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: recordBegin ? 30 : 5)
                .frame(width: recordBegin ? 60 : 250, height: 60)
                .foregroundColor(recordBegin ? .red : .green)
                .overlay(
                    Image(systemName: "mic.fill")
                        .font(.system(.title))
                        .foregroundColor(.white)
                        .scaleEffect(recording ? 0.7 : 1)
                )

            RoundedRectangle(cornerRadius: recordBegin ? 35 : 10)
                .trim(from: 0, to: recordBegin ? 0.0001 : 1)
                .stroke(lineWidth: 5)
                .frame(width: recordBegin ? 70 : 260, height: 70)
                .foregroundColor(.green)
        }
        .onTapGesture {
            withAnimation(Animation.spring()) {
                self.recordBegin.toggle()
            }

            withAnimation(Animation.spring().repeatForever().delay(0.5)) {
                self.recording.toggle()
            }
        }
    }
}

struct LoadingPointAnimation: View {
    @State private var isLoading = false

    var body: some View {
        HStack {
            ForEach(0 ... 4, id: \.self) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.green)
                    .scaleEffect(self.isLoading ? 0 : 1)
                    // 利用.delay(0.2 * Double(index)) 來達到每個點大小都不一樣
                    .animation(.linear(duration: 0.6).repeatForever().delay(0.2 * Double(index)), value: isLoading)
            }
        }
        .onAppear {
            self.isLoading = true
        }
    }
}

struct LoadingCircleProgressAnimation: View {
    @State private var progress: CGFloat = 0.0

    var body: some View {
        ZStack {
            Text("\(Int(progress * 100))%")
                .font(.system(.title, design: .rounded))
                .bold()

            Circle()
                .stroke(Color(.systemGray5), lineWidth: 10)
                .frame(width: 150, height: 150)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.green, lineWidth: 10)
                .frame(width: 150, height: 150)
                .rotationEffect(Angle(degrees: -90))
        }
        .onAppear {
            // 每0.5秒觸發 重複
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                self.progress += 0.05
                print(self.progress)
                // 當progress大於1.0時結束
                if self.progress >= 1.0 {
                    timer.invalidate()
                }
            }
        }
    }
}

struct LoadingLineAnimation: View {
    @State private var isLoading = false

    var body: some View {
        ZStack {
            Text("Loading")
                .font(.system(.body, design: .rounded))
                .bold()
                .offset(x: 0, y: -25)

            RoundedRectangle(cornerRadius: 3)
                .stroke(Color(.systemGray5), lineWidth: 3)
                .frame(width: 250, height: 3)

            RoundedRectangle(cornerRadius: 3)
                .stroke(Color.green, lineWidth: 3)
                .frame(width: 30, height: 3)
                .offset(x: isLoading ? 110 : -110, y: 0)
                .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isLoading)
        }
        .onAppear {
            self.isLoading = true
        }
    }
}

struct LoadingCircleAnimation: View {
    @State private var isLoading = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 14)
                .frame(width: 100, height: 100)

            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(Color.green, lineWidth: 7)
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                // 線性 總時長1秒 looping 不需要到終點後反方向 當isLoading == true時開始Animation
                .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isLoading)
                .onAppear {
                    self.isLoading = true
                }
        }
    }
//    @State private var isLoading = false
//
//    var body: some View {
//        Circle()
//            .trim(from: 0, to: 0.7)
//            .stroke(Color.green, lineWidth: 5)
//            .frame(width: 100, height: 100)
//            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
//            // 線性旋轉
//            // .animation(.linear(duration: 5).repeatForever(autoreverses: false), value: isLoading)
//            .animation(.default.repeatForever(autoreverses: false), value: isLoading)
//            .onAppear {
//                isLoading = true
//            }
//    }
}

struct 隱式Animation: View {
    @State private var animationToggle = false
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(animationToggle ? Color(.systemGray5) : .red)

            Image(systemName: "heart.fill")
                .foregroundColor(animationToggle ? .red : .white)
                .font(.system(size: 100))
                .scaleEffect(animationToggle ? 1.0 : 0.5)
        }
        // value == Animation播放的條件
        .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3), value: animationToggle)
        // .animation(.default, value: animationToggle)
        .onTapGesture {
            animationToggle.toggle()
        }
    }
}

struct 顯式Animation: View {
    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false

    var body: some View {
        ZStack {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(circleColorChanged ? Color(.systemGray5) : .red)

            Image(systemName: "heart.fill")
                .foregroundColor(heartColorChanged ? .red : .white)
                .font(.system(size: 100))
                .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
        }
        .onTapGesture {
            // 因為heartSizeChanged沒有在withAnimation裡面所以heart不會有Animation
            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3)) {
                self.circleColorChanged.toggle()
                self.heartColorChanged.toggle()
            }
            self.heartSizeChanged.toggle()

            //            withAnimation(.default) {
            //                self.circleColorChanged.toggle()
            //                self.heartColorChanged.toggle()
            //                self.heartSizeChanged.toggle()
            //            }
        }
    }
}
