

import Foundation
import SwiftUI

struct MusclegroupView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.regular)
            .foregroundColor(.black)
            .padding(.vertical, 2)
            .padding(.horizontal, 8)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.red, lineWidth: 1)
            )
    }
}
