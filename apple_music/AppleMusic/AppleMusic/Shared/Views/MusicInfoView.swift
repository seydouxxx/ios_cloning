//
//  MusicInfoView.swift
//  AppleMusic
//
//  Created by Lee Hojun on 2023/08/13.
//

import SwiftUI

struct MusicInfoView: View {
  
  @Binding var expandSheet: Bool
  var animation: Namespace.ID
  
  var body: some View {
    HStack(spacing: 0) {
      
      ZStack {
        if !expandSheet {
          GeometryReader {
            let size = $0.size
            
            Image("albumArtWork")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: size.width, height: size.height)
              .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
          }
          .matchedGeometryEffect(id: "ARTWORK", in: animation)
        }
      }
      .frame(width: 45, height: 45)
      
      Text("All I Need To Hear")
        .fontWeight(.semibold)
        .lineLimit(1)
        .padding(.horizontal, 15)
      
      Spacer(minLength: 0)
      
      Button {
        
      } label: {
        Image(systemName: "pause.fill")
          .font(.title2)
      }
      
      Button {
        
      } label: {
        Image(systemName: "forward.fill")
          .font(.title2)
      }
      .padding(.leading, 25)
    }
    .foregroundStyle(.primary)
    .padding(.horizontal)
    .padding(.bottom, 5)
    .frame(height: 70)
    .contentShape(Rectangle())
    .onTapGesture {
      withAnimation(.easeInOut(duration: 0.3)) {
        expandSheet = true
      }
    }
  }
}
