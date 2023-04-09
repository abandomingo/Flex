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
            CameraView()
                .tabItem {
                    Image(systemName: "camera")
                    Text("Camera")
                }
            BioView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Bio")
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
