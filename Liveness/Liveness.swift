//
//  Liveness.swift
//  Liveness
//
//  Created by Lucas Bighi on 07/12/23.
//

import SwiftUI

public struct Liveness {
    
    public static func build(
        headRotationAngle: ClosedRange<Float> = -6.0...6.0,
        openEyesProbability: ClosedRange<Float> = 0.8...1.1,
        smileProbability: ClosedRange<Float> = 0.5...1.0,
        photoTaken: Binding<Image?>
    ) -> LivenessView {
        LivenessView(
            headRotationAngle: headRotationAngle,
            openEyesProbability: openEyesProbability,
            smileProbability: smileProbability,
            photoTaken: photoTaken
        )
    }
}
