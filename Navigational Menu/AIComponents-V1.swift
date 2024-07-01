/*
To create a component that indicates loading, typing, dictation, and an animation for when the AI is talking, we can use `Lottie`, a library for animations in SwiftUI, or SwiftUI's built-in animation capabilities for simpler effects. In this example, we'll use SwiftUI's built-in animation features to create these indicators.
*/

// ### Step 1: Define the States
// First, define the states for loading, typing, dictation, and talking.
// ```swift
import SwiftUI

enum AIState {
    case idle, loading, typing, dictating, talking
}
// ```

// ### Step 2: Create the Indicator View
// Next, create the indicator view that will change based on the AI's state.
// **AIIndicatorView.swift**
// ```swift
import SwiftUI

struct AIIndicatorView: View {
    @State var aiState: AIState = .idle

    var body: some View {
        VStack {
            Spacer()
            
            // Indicator based on AI state
            HStack {
                if aiState == .loading {
                    LoadingView()
                } else if aiState == .typing {
                    TypingView()
                } else if aiState == .dictating {
                    DictatingView()
                } else if aiState == .talking {
                    TalkingView()
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            
            Spacer()
            
            // Buttons to simulate state changes
            HStack {
                Button("Idle") { aiState = .idle }
                Button("Loading") { aiState = .loading }
                Button("Typing") { aiState = .typing }
                Button("Dictating") { aiState = .dictating }
                Button("Talking") { aiState = .talking }
            }
            .padding()
        }
        .background(Color.gray.opacity(0.2).ignoresSafeArea())
    }
}

struct AIIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        AIIndicatorView()
    }
}
// ```

// ### Step 3: Create the Individual Indicator Views
// Now, create the views for loading, typing, dictating, and talking indicators.
// **LoadingView.swift**
// ```swift
import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false

    var body: some View {
        Circle()
            .trim(from: 0, to: 0.6)
            .stroke(Color.blue, lineWidth: 5)
            .frame(width: 50, height: 50)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            .onAppear {
                isAnimating = true
            }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
// ```

// **TypingView.swift**
// ```swift
import SwiftUI

struct TypingView: View {
    @State private var scale: CGFloat = 0.5

    var body: some View {
        HStack(spacing: 5) {
            Circle().frame(width: 10, height: 10)
            Circle().frame(width: 10, height: 10)
            Circle().frame(width: 10, height: 10)
        }
        .foregroundColor(.blue)
        .scaleEffect(scale)
        .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true))
        .onAppear {
            scale = 1.0
        }
    }
}

struct TypingView_Previews: PreviewProvider {
    static var previews: some View {
        TypingView()
    }
}
// ```

// **DictatingView.swift**
// ```swift
import SwiftUI

struct DictatingView: View {
    @State private var opacity: Double = 0.2

    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.red)
            .frame(width: 30, height: 50)
            .opacity(opacity)
            .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true))
            .onAppear {
                opacity = 1.0
            }
    }
}

struct DictatingView_Previews: PreviewProvider {
    static var previews: some View {
        DictatingView()
    }
}
// ```

// **TalkingView.swift**
// ```swift
import SwiftUI

struct TalkingView: View {
    @State private var offset: CGFloat = -10

    var body: some View {
        HStack(spacing: 5) {
            Rectangle().frame(width: 5, height: 20)
            Rectangle().frame(width: 5, height: 30)
            Rectangle().frame(width: 5, height: 20)
        }
        .foregroundColor(.green)
        .offset(y: offset)
        .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true))
        .onAppear {
            offset = 10
        }
    }
}

struct TalkingView_Previews: PreviewProvider {
    static var previews: some View {
        TalkingView()
    }
}
// ```

// ### Step 4: Combine and Test
// Combine these components in `AIIndicatorView` and test the different states using the buttons.
// ### Full Implementation
// **AIIndicatorView.swift**

// ```swift
import SwiftUI

struct IndicatorView: View {
    @State var aiState: AIState = .idle

    var body: some View {
        VStack {
            Spacer()
            
            // Indicator based on AI state
            HStack {
                if aiState == .loading {
                    LoadingView()
                } else if aiState == .typing {
                    TypingView()
                } else if aiState == .dictating {
                    DictatingView()
                } else if aiState == .talking {
                    TalkingView()
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            
            Spacer()
            
            // Buttons to simulate state changes
            HStack {
                Button("Idle") { aiState = .idle }
                Button("Loading") { aiState = .loading }
                Button("Typing") { aiState = .typing }
                Button("Dictating") { aiState = .dictating }
                Button("Talking") { aiState = .talking }
            }
            .padding()
        }
        .background(Color.gray.opacity(0.2).ignoresSafeArea())
    }
}

struct IndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        AIIndicatorView()
    }
}

struct LoadView: View {
    @State private var isAnimating = false

    var body: some View {
        Circle()
            .trim(from: 0, to: 0.6)
            .stroke(Color.blue, lineWidth: 5)
            .frame(width: 50, height: 50)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            .onAppear {
                isAnimating = true
            }
    }
}

struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

struct TypeView: View {
    @State private var scale: CGFloat = 0.5

    var body: some View {
        HStack(spacing: 5) {
            Circle().frame(width: 10, height: 10)
            Circle().frame(width: 10, height: 10)
            Circle().frame(width: 10, height: 10)
        }
        .foregroundColor(.blue)
        .scaleEffect(scale)
        .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true))
        .onAppear {
            scale = 1.0
        }
    }
}

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypingView()
    }
}

struct DictateView: View {
    @State private var opacity: Double = 0.2

    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.red)
            .frame(width: 30, height: 50)
            .opacity(opacity)
            .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true))
            .onAppear {
                opacity = 1.0
            }
    }
}

struct DictateView_Previews: PreviewProvider {
    static var previews: some View {
        DictatingView()
    }
}

struct TalkView: View {
    @State private var offset: CGFloat = -10

    var body: some View {
        HStack(spacing: 5) {
            Rectangle().frame(width: 5, height: 20)
            Rectangle().frame(width: 5, height: 30)
            Rectangle().frame(width: 5, height: 20)
        }
        .foregroundColor(.green)
        .offset(y: offset)
        .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true))
        .onAppear {
            offset = 10
        }
    }
}

struct TalkView_Previews: PreviewProvider {
    static var previews: some View {
        TalkingView()
    }
}
// ```

/*
With this setup, you have a flexible and reusable `AIIndicatorView` that visually represents different states of the AI, including loading, typing, dictation, and talking, using smooth animations.
*/
