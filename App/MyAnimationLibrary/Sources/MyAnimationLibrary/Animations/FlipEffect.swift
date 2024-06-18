//
//  FlipEffect.swift
//  CourseApp
//
//  Created by Marcel Mravec on 21.05.2024.
//

import SwiftUI

public struct FlipEffect: GeometryEffect {
    public var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    
    @Binding public var flipped: Bool
    public var angle: Double
    let half = 0.5
    let axis: (x: CGFloat, y: CGFloat)
    let beginingOfEffect = 90.0
    let endOfEffect = 270.0
    
    public init(flipped: Binding<Bool>, angle: Double, axis: (x: CGFloat, y: CGFloat)) {
        self._flipped = flipped
        self.angle = angle
        self.axis = axis
    }
    
    public func effectValue(size: CGSize) -> ProjectionTransform {
        // We schedule the change to be done after the view has finished drawing,
        // otherwise, we would receive a runtime error, indicating we are changing
        // the state while the view is being drawn.
        DispatchQueue.main.async {
            self.flipped = self.angle >= beginingOfEffect && self.angle < endOfEffect
        }
        
        let animatableAngle = CGFloat(Angle(degrees: angle).radians)
        
        var transform3d = CATransform3DIdentity
        transform3d.m34 = -1 / max(size.width, size.height)
        
        transform3d = CATransform3DRotate(transform3d, animatableAngle, axis.x, axis.y, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width * half, -size.height * half, 0)
        
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width * half, y: size.height * half))
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}
