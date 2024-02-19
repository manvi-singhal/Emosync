import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Emosync")
                    .font(.largeTitle)
                    .foregroundStyle(Color.accentColor)
                    .padding()
                
                Text("EmoSync is a simple tool that keeps track of emotions. \n It shows that even when things get tough, there's a way to feel good about yourself.")
                    .font(.title3)
                    .padding(.horizontal, 25)
                    .multilineTextAlignment(.center)
                    .padding()
                
                NavigationLink(destination: MoodLogListView()){
                    Text("View Mood Log")
                        .font(.title3)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationBarItems(trailing: NavigationLink(destination: CalendarView()) {
                Image(systemName: "plus")
                    .font(.title2)
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
