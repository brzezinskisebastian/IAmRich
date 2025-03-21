import SwiftUI

struct ContentView: View {
    
    // MARK: - States
    
    let quotes = [
        "I deserve it.",
        "I am good, healthy & successful.",
        "Wealth flows to me effortlessly.",
        "Money loves me and I love money.",
        "I am unstoppable and abundant.",
        "I deserve abundance.",
        "Money is my ally.",
        "Fortune favors me.",
        "I thrive with ease.",
        "Richness flows freely.",
        "Opportunities adore me.",
        "I sparkle with success.",
        "I radiate good fortune.",
        "Wealth is my nature.",
        "I ascend effortlessly.",
        "Success is inevitable.",
        "I flourish in all things.",
        "Prosperity loves me.",
        "I magnetize blessings.",
        "Abundance is my right.",
        "I bloom with wealth.",
        "Riches come daily.",
        "I am always rising.",
        "I shine with affluence.",
        "I embrace all opulence."
    ]
    
    @State private var currentQuoteIndex = 0
    @State private var diamondFlash = false
    @State private var showConfetti = false
    @State private var isNightMode = false
    @State private var timer: Timer? = nil
    
    var body: some View {
        ZStack {
            
            
            if isNightMode {
                LinearGradient(
                    colors: [Color.blue, Color.black],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            } else {
                
                LinearGradient(
                    colors: [
                        Color("RichTop"),
                        Color("RichMid"),
                        Color("RichBottom")
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
            }
            
            VStack(spacing: 20) {
                
                Image("Diamond")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 20)
                
                    .opacity(diamondFlash ? 1.0 : 0.7)
                    .onTapGesture {
                        nextQuote()
                        flashDiamond()
                        
                    }
                    .onLongPressGesture {
                        withAnimation {
                            isNightMode.toggle()
                        }
                    }
                
                
                Text("I am Rich")
                    .font(.custom("Chalkduster", size: 42))
                    .foregroundColor(isNightMode ? .white : Color("Font Primary"))
                    .shadow(color: .black.opacity(0.6), radius: 4, x: 2, y: 3)
                
                
                Text(quotes[currentQuoteIndex])
                    .multilineTextAlignment(.center)
                    .font(.custom("MarkerFelt-Wide", size: 22))
                    .foregroundColor(isNightMode ? .white : Color("Second Primary"))
                    .shadow(color: .black.opacity(0.4), radius: 3, x: 1, y: 2)
                    .padding()
                
                
                Button(action: {
                    withAnimation {
                        showConfetti = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        withAnimation {
                            showConfetti = false
                        }
                    }
                }) {
                    Text("Celebrate")
                        .font(.headline)
                        .padding()
                        .background(showConfetti ? Color.gray.opacity(0.2) : Color.white.opacity(0.2))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
                .disabled(showConfetti)
            }
            
            
            if showConfetti {
                ConfettiView()
                    .id(UUID())
                    .zIndex(1)
            }
        }
        .onAppear {
            startQuotesTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    // MARK: - Functions
    
    private func flashDiamond() {
        withAnimation(.easeInOut(duration: 0.4)) {
            diamondFlash = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeInOut(duration: 0.2)) {
                diamondFlash = false
            }
        }
    }
    
    private func nextQuote() {
        withAnimation {
            currentQuoteIndex = (currentQuoteIndex + 1) % quotes.count
        }
    }
    
    private func startQuotesTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            nextQuote()
        }
    }
}
