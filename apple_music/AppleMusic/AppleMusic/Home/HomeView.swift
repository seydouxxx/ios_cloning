//
//  HomeView.swift
//  AppleMusic
//
//  Created by Lee Hojun on 2023/08/13.
//

import SwiftUI
import ComposableArchitecture

struct HomeView {
  
  @State private var expandSheet: Bool = false
  @Namespace var animation
  
  init() {
  }
}

extension HomeView: View {
  var body: some View {
    TabView {
      SampleTabView("Listen Now", "play.circle.fill")
      SampleTabView("Browse", "square.grid.2x2.fill")
      SampleTabView("Radio", "dot.radiowaves.left.and.right")
      SampleTabView("Music", "play.square.stack")
      SampleTabView("Search", "magnifyingglass")
    }
    .tint(.red)
    .safeAreaInset(edge: .bottom) {
      CustomBottomSheet()
    }
    .overlay {
      if expandSheet {
        ExpandedBottomSheetView(
          expandSheet: $expandSheet,
          animation: animation
        )
        .transition(
          .asymmetric(
            insertion: .identity,
            removal: .offset(y: -5)
          )
        )
      }
    }
  }
  
  @ViewBuilder
  func CustomBottomSheet() -> some View {
    ZStack {
      if expandSheet {
        Rectangle()
          .fill(.clear)
      } else {
        Rectangle()
          .fill(.ultraThickMaterial)
          .overlay {
            MusicInfoView(
              expandSheet: $expandSheet,
              animation: animation
            )
            .matchedGeometryEffect(id: "BGVIEW", in: animation)
          }
      } 
//      Rectangle()
//        .fill(.ultraThickMaterial)
//        .overlay {
//          MusicInfoView(
//            expandSheet: $expandSheet,
//            animation: animation
//          )
//        }
    }
    .frame(height: 70)
    .overlay(alignment: .bottom, content: {
      Rectangle()
        .fill(.gray.opacity(0.3))
        .frame(height: 1)
        .offset(y: -5)
    })
    .offset(y: -49)
  }
  
  @ViewBuilder
  func SampleTabView(_ title: String, _ icon: String) -> some View {
    
    ScrollView {
      Text(title)
        .padding(.top, 25)
    }
    .tabItem {
      Image(systemName: icon)
      Text(title)
    }
    .toolbarBackground(.visible, for: .tabBar)
    .toolbarBackground(.ultraThickMaterial, for: .tabBar)
    .toolbar(expandSheet ? .hidden : .visible, for: .tabBar)
  }
}

#Preview {
  ContentView()
    .preferredColorScheme(.dark)
}
