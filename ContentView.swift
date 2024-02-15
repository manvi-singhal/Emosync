import SwiftUI

struct ContentView: View {
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
            }
            .navigationBarItems(trailing: NavigationLink(destination: CalendarView()) {
                Image(systemName: "plus")
                    .font(.title2)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
