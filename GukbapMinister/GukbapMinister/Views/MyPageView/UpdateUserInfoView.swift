//
//  UpdateUserInfoView.swift
//  GukbapMinister
//
//  Created by 전혜성 on 2023/02/01.
//

import SwiftUI

struct UpdateUserInfoView: View {
    @EnvironmentObject var mypageViewModel: MyPageViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    var user: User {
        mypageViewModel.user
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                        NavigationLink {
                            EditNicknameView(manager: UserInfoUpdateManager(user: user))
                        } label: {
                            HStack(alignment: .bottom) {
                                Text("닉네임 수정하기")
                                Text("현재 닉네임: \(user.userNickname)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .listRowSeparator(.hidden)

                    //TODO: - 업데이트 이후 지원
                        NavigationLink {
                            EditGukbapView()
                        } label: {
                            HStack {
                                Text("선호하는 국밥 수정하기")
                                Text("추후 업데이트 후 지원예정")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                                
                        }
                        .listRowSeparator(.hidden)
                        .disabled(true)
                    
                    //TODO: - 업데이트 이후 지원
                        NavigationLink {
                            EditPreferenceAreaView()
                        } label: {
                            HStack {
                                Text("선호하는 지역 수정하기")
                                Text("추후 업데이트 후 지원예정")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .disabled(true)

                        NavigationLink {
                            DeleteAccountView()
                        } label: {
                            Text("더보기")
                        }
                        .listRowSeparator(.hidden)

                }
                .listStyle(.plain)
                
           
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("회원정보 수정")
        }

    }
}

