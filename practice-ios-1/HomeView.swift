//
//  HomeView.swift
//  practice-ios-1
//
//  Created by Eizaburo Tamaki on 2025/08/17.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            
            //hero
            VStack{
                Text("ヒーローエリア")
                    .font(.title3)
                    .foregroundColor(.white)
                Text("ヒーローエリアのキャッチコピー。")
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: 180)
            .background(.gray)
            
            //services
            VStack{
                
                //service
                VStack{
                    Text("サービスA")
                        .foregroundColor(.white)
                    Text("サービスAの説明")
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 300, maxHeight: 100)
                .background(.gray)
                .padding(.top, 30)
                
                //service
                VStack{
                    Text("サービスB")
                        .foregroundColor(.white)
                    Text("サービスBの説明")
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 300, maxHeight: 100)
                .background(.gray)
                .padding(.top, 30)
                
                //service
                VStack{
                    Text("サービスC")
                        .foregroundColor(.white)
                    Text("サービスCの説明")
                        .foregroundColor(.white)
                }
                .frame(maxWidth: 300, maxHeight: 100)
                .background(.gray)
                .padding(.top, 30)
                
            }
            
            //Spacer
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
