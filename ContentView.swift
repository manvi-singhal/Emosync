import SwiftUI

struct ContentView: View {
    @StateObject var moodLogData = MoodLogData()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Emosync")
                    .font(.largeTitle)
                    .foregroundStyle(Color.accentColor)
                    .padding()
                
                Text("EmoSync is a simple tool that keeps track of emotions. It shows that even when things get tough, there's a way to feel good about yourself.")
                    .padding(.horizontal, 25)
                    .multilineTextAlignment(.center)
                    .padding()
                
                NavigationLink(destination: MoodLogListView()){
                    Text("View Mood Log")
                        .font(.title3)
                }
            }
            .navigationBarItems(trailing: NavigationLink(destination: CalendarView()) {
                Image(systemName: "plus")
                    .font(.title2)
            })
        }
        .environmentObject(moodLogData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
