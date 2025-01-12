
import SwiftUI
import PopupView

struct ReportView: View {
    @Environment(\.colorScheme) var scheme
    @Binding var isshowingReportSheet : Bool

    @Binding var selectedReportButton : String
    @Binding var reportEnter : Bool
    @StateObject var reviewReportViewModel = ReviewReportViewModel()
    @StateObject private var reviewViewModel: ReviewViewModel = ReviewViewModel()
    var review: Review

    @State private var memo: String = ""

    var trimMemo: String {
        memo.trimmingCharacters(in: .whitespaces)
    }
    
    var Content = [
        "음란성, 욕설등 부적절한 내용",
        "부적절한 홍보 또는 광고",
        "주문과 관련없는 사진 게시",
        "개인정보 유출 위험",
        "리뷰 작성 취지에 맞지 않는 애용(복사글 등)",
        "저작권 도용 의심(사진 등)",
        "기타(아래 내용 작성)",
    ]
    var body: some View {
        let customColor = scheme == .light ? Color("AccentColor") : Color.secondary
      
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading){
                    Spacer()
                    HStack{
                        Text("리뷰를 신고하는")
                        
                    }
                    .font(.system(size:18))
                    .fontWeight(.semibold)
                    HStack{
                        Text("이유를 알려주세요!")
                        
                    }
                    .font(.system(size:18))
                    .fontWeight(.semibold)
                    
                    HStack{
                        Text("타당한 근거 없이 신고된 내용은 관리자 확인후 반영되지 않을 수 있습니다.")
                        
                    }
                    .font(.system(size:11))
                    .foregroundColor(.secondary)
                    .padding(.top,5)
                    .padding(.bottom,10)
                    
                    VStack(alignment: .leading, spacing: 30){
                        ForEach(Array(Content.enumerated()), id: \.offset) { count, index in
                        
                            Button(action:{
                                self.selectedReportButton = index
                            }){
                                HStack{
                                    Text(index).font(.system(size:16))
                                        .foregroundColor(scheme == .light ? .black : .white)
                                    Spacer()
                                    ZStack{
                                        Circle()
                                            .fill(self.selectedReportButton == index ? Color("AccentColor") : Color.secondary.opacity(0.2))
                                            .frame(width: 18,height: 18)
                                            .background(scheme == .light ? .white : .black)
                                        
                                        if self.selectedReportButton == index {
                                         
                                                Image(systemName: "checkmark.circle.fill")
                                                                              .font(.system(size:18))
                                                                              .foregroundColor(Color.blue)
                                                                              .background(scheme == .light ? .white : .black)
                                            
                                        }
                                    }
                                }
                            }
//                            .background(scheme == .light ? .white : .black)
                        }
                        TextField("신고사유를 작성해주세요", text: $memo, axis: .vertical)
                  
                            .font(.system(size:15))
                            .lineLimit(4...)
                            .textFieldStyle(.roundedBorder)
                            .opacity(1)
                            .animation(.easeInOut, value: memo)
                            .padding(20)
                    }
                    
                    Spacer()
//                reviewText: "",
//                createdAt: 0.0 ,
//                nickName: "",
//                starRating: 0,
//                storeName: ""
                    Button(action:{
                        self.reportEnter.toggle()
                        self.reviewReportViewModel.reviewReport.id = review.id
                        self.reviewReportViewModel.reviewReport.reviewText = review.reviewText
                        self.reviewReportViewModel.reviewReport.createdAt = review.createdAt
                        self.reviewReportViewModel.reviewReport.nickName = review.nickName
                        self.reviewReportViewModel.reviewReport.starRating = review.starRating
                        self.reviewReportViewModel.reviewReport.storeName = review.storeName

                        reviewReportViewModel.handleDoneTapped()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isshowingReportSheet.toggle()
                        }

                        print("신고하기 버튼 눌렸음")
                    }){
                        Text("신고하기")
                            .font(.subheadline)
                            .foregroundColor(scheme == .light ? .black : .black)
                            .padding()
                            .frame(maxWidth: Screen.maxWidth)
                            .bold()
                    }
                    .background(
                        self.selectedReportButton == ""  ?
                        
                        Color("lightGray") :  Color("AccentColor") )
                    
                    .clipShape(Capsule())
                    .disabled(self.selectedReportButton == "")
                    
                }}
            .navigationTitle("리뷰 신고하기")
            .navigationBarTitleDisplayMode(.inline)
            
            .animation(.default,value:selectedReportButton)
            .padding()

            .navigationBarBackButtonHidden(true)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    isshowingReportSheet.toggle()
                                }) {
                                    Image(systemName: "xmark")
                                        .foregroundColor(scheme == .light ? .black : .white)
            
                                }
                            }
            }
                        .popup(isPresented: $reportEnter) {
                            HStack {
                                Image(systemName: "checkmark")
                                    .foregroundColor(scheme == .light ? .white : .black)
                                Text("신고가 완료되었습니다.")
                                    .foregroundColor(scheme == .light ? .white : .black)
                                    .font(.footnote)
                                    .bold()
                            }
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .background(customColor)
                            .cornerRadius(100)
                        } customize: {
                            $0
                                .autohideIn(1.3)
                                .animation(.spring())
                                .type(.floater())
                                .position(.top)
                        } // popup
                   
        }//NavigationStack
        .background(Color.white) // 화면 밖 터치할 때 백그라운드 지정을 안 해주면 View에 올라간 요소들 클릭 시에만 적용됨.
        .onTapGesture() { // 키보드 밖 화면 터치 시 키보드 사라짐
            endEditing()
        }
      
        
    }
    
    
    
}
//extension View {
//    func endEditing() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}



//struct ReportView_Previews: PreviewProvider {
//
//    @State static var selectedReportButton = ""
//    @State var reportEnter : Bool
//    @State static var reportText = ""
//
//    static var previews: some View {
//        ReportView(isshowingReportSheet: .constant(false), selectedReportButton: $selectedReportButton, reportEnter: .constant(true), reportText: "", Content: [
//            "음란성, 욕설등 부적절한 내용",
//            "부적절한 홍보 또는 광고",
//            "주문과 관련없는 사진 게시",
//            "개인정보 유출 위험",
//            "리뷰 작성 취지에 맞지 않는 애용(복사글 등)",
//            "저작권 도용 의심(사진 등)",
//            "기타(아래 내용 작성)",
//        ])
//    }
//}
