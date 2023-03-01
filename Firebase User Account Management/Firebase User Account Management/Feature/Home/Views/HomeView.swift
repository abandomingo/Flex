import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var service: SessionServiceImpl
    
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
