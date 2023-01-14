//
//  MyPageView.swift
//  DobbyMini Watch App
//
//  Created by yongmin lee on 12/22/22.
//

import SwiftUI

struct MyPageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: MyPageViewModel
    
    var body: some View {
        VStack {
            Text("MyPageView")
                .foregroundColor(.green)
            
            // profile Imge
            
            // name
            
            // groupCode
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("마이페이지")
        .onAppear(perform: {
            print("onAppear MyPageView ")
        })
        .onReceive(NotificationCenter.default.publisher(for: .shouldReLogin)) { _ in
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
