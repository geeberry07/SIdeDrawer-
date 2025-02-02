/*/*
 To create a more responsive AI indicator that changes colors and icons based on the state, we can use a combination of SwiftUI animations and state management. We'll add additional states to represent different feelings and animations to transition between these states smoothly.

Here's how to implement this:

### Step 1: Define Additional States

Define additional states to represent different feelings.

```swift
 */

import SwiftUI

enum AIState {
    case idle, loading, typing, dictating, talking, happy, sad, thinking
}
/*
 ```

### Step 2: Update the Indicator View

Update the `AIIndicatorView` to handle these additional states and provide the necessary animations.

**AIIndicatorView.swift**

```swift
 */
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
                } else if aiState == .happy {
                    FeelingView(iconName: "smiley.fill", color: .yellow)
                } else if aiState == .sad {
                    FeelingView(iconName: "frown.fill", color: .blue)
                } else if aiState == .thinking {
                    FeelingView(iconName: "brain.head.profile", color: .purple)
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
                Button("Happy") { aiState = .happy }
                Button("Sad") { aiState = .sad }
                Button("Thinking") { aiState = .thinking }
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
/*
 ```

### Step 3: Create the Individual Indicator Views

Update the views for loading, typing, dictating, talking, and add new views for different feelings.

**LoadingView.swift**

```swift
 */
import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false

    var body: some View {
        Circle()
            .trim(from: 0, to: 0.6)
            .stroke(Color.blue, lineWidth: 5)
            .frame(width: 50, height: 50)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .onAppear {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                    isAnimating = true
                }
            }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
/*```

**TypingView.swift**

```swift
 */
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
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                scale = 1.0
            }
        }
    }
}

struct TypingView_Previews: PreviewProvider {
    static var previews: some View {
        TypingView()
    }
}
/*
 ```

**DictatingView.swift**

```swift
 */

import SwiftUI

struct DictatingView: View {
    @State private var opacity: Double = 0.2

    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.red)
            .frame(width: 30, height: 50)
            .opacity(opacity)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                    opacity = 1.0
                }
            }
    }
}

struct DictatingView_Previews: PreviewProvider {
    static var previews: some View {
        DictatingView()
    }
}
/*
 ```

**TalkingView.swift**

```swift
 */
import SwiftUI

struct TalkingView: View {
    @State private var offset: CGFloat = -10
    @State private var color: Color = .green

    var body: some View {
        HStack(spacing: 5) {
            Rectangle().frame(width: 5, height: 20)
            Rectangle().frame(width: 5, height: 30)
            Rectangle().frame(width: 5, height: 20)
        }
        .foregroundColor(color)
        .offset(y: offset)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                offset = 10
                color = .red
            }
        }
    }
}

struct TalkingView_Previews: PreviewProvider {
    static var previews: some View {
        TalkingView()
    }
}
/*
 ```

**FeelingView.swift**

```swift
 */

import SwiftUI

struct FeelingView: View {
    var iconName: String
    var color: Color
    @State private var isAnimating = false

    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .foregroundColor(color)
            .scaleEffect(isAnimating ? 1.2 : 1.0)
            .animation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true))
            .onAppear {
                isAnimating = true
            }
    }
}

struct FeelingView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingView(iconName: "smiley.fill", color: .yellow)
    }
}
*/
/*```
### Full Implementation
**AIIndicatorView.swift*
```swift
 */
import SwiftUI
import UIKit
import Foundation
import Combine

enum AIState {
    case idle, loading, typing, dictating, talking, happy, sad, thinking
}

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
                } else if aiState == .happy {
                    FeelingView(iconName: "smiley.fill", color: .yellow)
                } else if aiState == .sad {
                    FeelingView(iconName: "frown.fill", color: .blue)
                } else if aiState == .thinking {
                    FeelingView(iconName: "brain.head.profile", color: .purple)
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
                Button("Happy") { aiState = .happy }
                Button("Sad") { aiState = .sad }
                Button("Thinking") { aiState = .thinking }
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
/*
```
**LoadingView.swift**
```swift
 */
import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false

    var body: some View {
        Circle()
            .trim(from: 0, to: 0.6)
            .stroke(Color.blue, lineWidth: 5)
            .frame(width: 50, height: 50)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .onAppear {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                    isAnimating = true
                }
            }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
/*
 ```
**TypingView.swift**
```swift
 */
import SwiftUI

struct TypingView: View {
    @State private var scale: CGFloat = 0.5

    var body: some View {
        HStack(spacing


: 5) {
            Circle().frame(width: 10, height: 10)
            Circle().frame(width: 10, height: 10)
            Circle().frame(width: 10, height: 10)
        }
        .foregroundColor(.blue)
        .scaleEffect(scale)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                scale = 1.0
            }
        }
    }
}

struct TypingView_Previews: PreviewProvider {
    static var previews: some View {
        TypingView()
    }
}
/* ```
**DictatingView.swift**
```swift
 */
import SwiftUI

struct DictatingView: View {
    @State private var opacity: Double = 0.2

    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.red)
            .frame(width: 30, height: 50)
            .opacity(opacity)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                    opacity = 1.0
                }
            }
    }
}

struct DictatingView_Previews: PreviewProvider {
    static var previews: some View {
        DictatingView()
    }
}
/*```
**TalkingView.swift**
```swift
 */
import SwiftUI

struct TalkingView: View {
    @State private var offset: CGFloat = -10
    @State private var color: Color = .green

    var body: some View {
        HStack(spacing: 5) {
            Rectangle().frame(width: 5, height: 20)
            Rectangle().frame(width: 5, height: 30)
            Rectangle().frame(width: 5, height: 20)
        }
        .foregroundColor(color)
        .offset(y: offset)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                offset = 10
                color = .red
            }
        }
    }
}

struct TalkingView_Previews: PreviewProvider {
    static var previews: some View {
        TalkingView()
    }
}
/*
 ```
**FeelingView.swift**
```swift
 */
import SwiftUI

struct FeelingView: View {
    var iconName: String
    var color: Color
    @State private var isAnimating = false

    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .foregroundColor(color)
            .scaleEffect(isAnimating ? 1.2 : 1.0)
            .animation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true))
            .onAppear {
                isAnimating = true
            }
    }
}

struct FeelingView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingView(iconName: "smiley.fill", color: .yellow)
    }
}
/*
 ```

With these updates, your AI indicator will have more responsive animations and transitions for various states, including loading, typing, dictating, talking, and different feelings like happy, sad, and thinking.
*/
