import SwiftUI

struct HomeTabView: View {
    var body: some View {
        TabView {
            HomepageView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            WorkoutsView()
                .tabItem {
                    Label("Workouts", systemImage: "figure.run")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}



struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
#Preview {
    HomeTabView()
}
