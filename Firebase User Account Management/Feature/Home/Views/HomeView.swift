import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var service: SessionServiceImpl
<<<<<<< Updated upstream
    
    var body: some View {
            VStack(alignment: .leading,
                   spacing: 10) {
                
                Image("muscle")
                    .resizable()
                
                Text("First Name: \(service.userDetails?.firstName ?? "N/A")")
                Text("Last Name: \(service.userDetails?.lastName ?? "N/A")")
                Text("Occupation: \(service.userDetails?.occupation ?? "N/A")")
                    
                    ButtonView(title: "Logout") {
                        service.logout()
                    }
                
            }
            .padding(.horizontal, 16)
            .navigationTitle("Your Flex Page")
=======
    @State private var selectedIndex = 0

    var body: some View {
        TabView(selection: $selectedIndex){
            
            FeedView()
                .onTapGesture{
                    self.selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "house")
                }.tag(0)
            
            ContentView()
                .onTapGesture{
                    self.selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "camera")
                }.tag(1)
            
            BioView()
                .onTapGesture{
                    self.selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "person")
                }.tag(2)
        }
>>>>>>> Stashed changes
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(SessionServiceImpl())
        }
    }
}
