//
//  ExpandedBottomSheetView.swift
//  AppleMusic
//
//  Created by Lee Hojun on 2023/08/13.
//

import SwiftUI

struct ExpandedBottomSheetView: View {
  
  @Binding var expandSheet: Bool
  var animation: Namespace.ID
  
  @State private var animateContent: Bool = false
  
  var body: some View {
    GeometryReader {
      let size = $0.size
      let safeArea = $0.safeAreaInsets
      
      ZStack {
        
        Rectangle()
        .fill(.ultraThickMaterial)
        .overlay {
          Rectangle()
            .fill(Color("BG"))
            .opacity(animateContent ? 1 : 0)
        }
        .overlay(alignment: .top) {
          MusicInfoView(expandSheet: $expandSheet, animation: animation)
            .allowsHitTesting(false)
            .opacity(animateContent ? 0 : 1)
        }
        
        VStack(spacing: 15) {
          
          Capsule()
            .fill(.gray)
            .frame(width: 40, height: 5)
            .opacity(animateContent ? 1 : 0)
          
          GeometryReader {
            let size = $0.size
            
            Image("albumArtWork")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: size.width, height: size.height)
              .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
          }
          .matchedGeometryEffect(id: "ARTWORK", in: animation)
          .frame(height: size.width - 50)
          
          PlayerView(size)
            .offset(y: animateContent ? 0 : size.height)
        }
        .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
        .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
        .padding(.horizontal, 25)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onTapGesture {
          withAnimation(.easeInOut(duration: 0.3)) {
            expandSheet = false
            animateContent = false
          }
        }
      }
      .ignoresSafeArea(.container, edges: .all)
    }
    .onAppear {
      withAnimation(.easeInOut(duration: 0.35)) {
        animateContent = true
      }
    }
  }
  
  @ViewBuilder
  func PlayerView(_ mainSize: CGSize) -> some View {
    GeometryReader {
      let size = $0.size
      let spacing = size.height * 0.04
      
      VStack(spacing: spacing) {
        VStack(spacing: spacing) {
          HStack(alignment: .center, spacing: 15) {
            VStack(alignment: .leading, spacing: 4) {
              Text("All I Need To Hear")
                .font(.title3)
                .fontWeight(.semibold)
              
              Text("The 1975")
                .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
              
            } label: {
              Image(systemName: "ellipsis")
                .foregroundStyle(.white)
                .padding(12)
                .background {
                  Circle()
                    .fill(.ultraThickMaterial)
                    .environment(\.colorScheme, .dark)
                }
            }
          }
          
          Capsule()
            .fill(.ultraThickMaterial)
            .environment(\.colorScheme, .light)
            .frame(height: 5)
            .padding(.top, spacing)
          
          HStack {
            Text("0:00")
              .font(.caption)
              .foregroundStyle(.gray)
            
            Spacer()
            
            Text("0:00")
              .font(.caption)
              .foregroundStyle(.gray)
          }
        }
        
        HStack(spacing: size.width * 0.18) {
          Button {
            
          } label: {
            Image(systemName: "backward.fill")
              .font(size.height < 300 ? .title3 : .title)
          }
          
          Button {
            
          } label: {
            Image(systemName: "pause.fill")
              .font(size.height < 300 ? .largeTitle : .system(size: 50))
          }
          
          Button {
            
          } label: {
            Image(systemName: "forward.fill")
              .font(size.height < 300 ? .title3 : .title)
          }
        }
        .foregroundStyle(.white)
        
        VStack(spacing: spacing) {
          HStack(spacing: 15) {
            Image(systemName: "speaker.fill")
              .foregroundStyle(.gray)
            
            Capsule()
              .fill(.ultraThickMaterial)
              .environment(\.colorScheme, .light)
              .frame(height: 5)
            
            Image(systemName: "speaker.wave.3.fill")
              .foregroundStyle(.gray)
          }
          
          HStack(alignment: .top, spacing: size.width * 0.18) {
            Button {
              
            } label: {
              Image(systemName: "quote.bubble")
                .font(.title2)
            }
            
            VStack(spacing: 6) {
              Button {
                
              } label: {
                Image(systemName: "airpods.gen3")
                  .font(.title3)
              }
              
              Text("Seydoux's Airpods")
                .font(.caption)
            }
            
            Button {
              
            } label: {
              Image(systemName: "list.bullet")
                .font(.title2)
            }
          }
          .foregroundStyle(.white)
          .blendMode(.overlay)
          .padding(.top, spacing)
        }
      }
    }
  }
}

