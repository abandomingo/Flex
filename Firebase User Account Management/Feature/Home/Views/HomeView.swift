import SwiftUI


struct HomeView: View{

    @EnvironmentObject var service: SessionServiceImpl

    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Text("Camera")
                .tabItem {
                    Image(systemName: "camera")
                    Text("Camera")
                }
            Text("Me")
                .tabItem {
                    Image(systemName: "person")
                    Text("Me")
                }
        }
    }
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
            HomeView()
                .environmentObject(SessionServiceImpl())
    }
}
