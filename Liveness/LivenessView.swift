//
//  LivenessView.swift
//  Liveness
//
//  Created by Lucas Bighi on 08/12/23.
//

import SwiftUI
import BCCFace

public struct LivenessView {
    
    public typealias UIViewControllerType = LivenessDetectionViewController
    
    @Environment(\.dismiss) private var dismiss
    
    private let headRotationAngle: ClosedRange<Float>
    private let openEyesProbability: ClosedRange<Float>
    private let smileProbability: ClosedRange<Float>
    @Binding private var photoTaken: Image?
    
    init(
        headRotationAngle: ClosedRange<Float> = -6.0...6.0,
        openEyesProbability: ClosedRange<Float> = 0.8...1.1,
        smileProbability: ClosedRange<Float> = 0.5...1.0,
        photoTaken: Binding<Image?>
    ) {
        self.headRotationAngle = headRotationAngle
        self.openEyesProbability = openEyesProbability
        self.smileProbability = smileProbability
        self._photoTaken = photoTaken
    }
}

extension LivenessView {
    public class Coordinator: BCCFace.LivenessDetectionViewControllerDelegate {
        
        @Binding var photoTaken: Image?
        
        init(photoTaken: Binding<Image?>) {
            _photoTaken = photoTaken
        }
        
        public func livenessDetectionDidFinish(viewController: BCCFace.LivenessDetectionViewController, with photoTaken: UIImage, croppedFaceImage: UIImage?, qualityScore: Float, allPhotos: [UIImage]) {
            self.photoTaken = Image(uiImage: photoTaken)
        }
        
        public func livenessDetectionDidAbort(viewController: BCCFace.LivenessDetectionViewController) { }
    }
}

extension LivenessView: UIViewControllerRepresentable {
    public func makeCoordinator() -> Coordinator {
        Coordinator(photoTaken: $photoTaken)
    }
    
    public func makeUIViewController(context: Context) -> LivenessDetectionViewController {
        
        let faceDetectionParameters = FaceDetectionParameters(
            headAngleYRange: headRotationAngle,
            headAngleZRange: headRotationAngle,
            leftEyeOpenProbabilityRange: openEyesProbability,
            rightEyeOpenProbabilityRange: openEyesProbability,
            smilingProbabilityRange: smileProbability
        )
        
        let vc = LivenessDetectionViewController(
            livenessParameters: LivenessParameters(liveness: [.headRotationRandom]),
            detectionParameters: faceDetectionParameters,
            speechSettings: .defaultSpeechSettings,
            language: .ptBR
        )
        
        vc.delegate = context.coordinator
        
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: LivenessDetectionViewController, context: Context) { }
}
