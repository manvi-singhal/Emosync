import SwiftUI

struct ContentView: View {
    @State private var isLoggingMood = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Emosync")
                    .font(.largeTitle)
                    .padding()
                
                NavigationLink(destination: LogTodayView(), isActive: $isLoggingMood) {
                    EmptyView()
                }
                
                Button(action: {
                    isLoggingMood = true
                }) {
                    Text("Log Today")
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
