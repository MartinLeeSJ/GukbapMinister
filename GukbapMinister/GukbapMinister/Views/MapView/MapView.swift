import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI

struct MapView: View {
    @Environment(\.colorScheme) var scheme
    
    @StateObject var mapViewModel = MapViewModel()
    @StateObject var locationManager = LocationManager()
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storesViewModel: StoresViewModel
    
    // 필터 버튼을 눌렀을 때 동작
    @State var isShowingFilterModal: Bool = false
    @State private var isShowingSelectedStore: Bool = false
    
    var body: some View {
        // 지오메트리 리더가 뷰 안에 선언 되어있기 때문에 뷰 만큼의 너비와 높이를 가져옴
        GeometryReader { geo in
            let width = geo.size.width
            
            NavigationStack {
                ZStack {
                    MapUIView(
                        region: $locationManager.region,
                        storeAnnotations: $mapViewModel.storeLocationAnnotations,
                        selectedStoreAnnotation: $mapViewModel.selectedStoreAnnotation,
                        isSelected: $isShowingSelectedStore,
                        filters: $mapViewModel.filteredGukbaps
                    )
                    .ignoresSafeArea(edges: [.top, .horizontal])
                    
                    VStack {
                        SearchBarButton()
                        mapFilter
                            .offset(x: width * 0.0005)
                        Spacer()
                    }
                    
                    StoreReportButton()
                        .offset(x: width * 0.5 - 47)
                    
                    VStack {
                        Spacer()
                        
                        StoreModalView(store: mapViewModel.selectedStore)
                            .padding(25)
                            .offset(y: isShowingSelectedStore ? 0 : 400)
                            .transition(.slide)
                    }
                }
            }
        }
        .onAppear {
            Task {
                DispatchQueue.main.asyncAfter(deadline:.now() + 0.5) {
                    if mapViewModel.storeLocations.isEmpty {
                        mapViewModel.storeLocations += storesViewModel.stores
                    }
                }
            }
        }
    }
}
