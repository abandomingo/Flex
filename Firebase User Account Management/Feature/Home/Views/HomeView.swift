import SwiftUI


struct NavView: View{

    @EnvironmentObject var service: SessionServiceImpl

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Text("Camera")
                .tabItem {
                    Image(systemName: "Camera")
                    Text("Camera")
                }
            Text("Me")
                .tabItem {
                    Image(systemName: "house")
                    Text("Me")
                }
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
            NavView()
                .environmentObject(SessionServiceImpl())
    }
}


struct HomeView: View {
    
    @EnvironmentObject var service: SessionServiceImpl
    
    var body: some View {
            VStack() {
                
                Button("Log Out") {
                    service.logout()
                }
                

//                HStack (alignment: .center, spacing: 10){
//                    Text("First Name: \(service.userDetails?.firstName ?? "N/A")")
//
//                    Text("Last Name: \(service.userDetails?.lastName ?? "N/A")")
//                    Text("Occupation: \(service.userDetails?.occupation ?? "N/A")")
//                }
                
                FeedView()
                
            }
    }
}
