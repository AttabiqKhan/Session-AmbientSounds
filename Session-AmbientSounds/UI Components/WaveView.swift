//
//  WaveView.swift
//  Session-AmbientSounds
//
//  Created by Attabiq Khan on 10/01/2025.
//

import UIKit

class WaveView: UIView {
    
    enum Direction {
        case right
        case left
    }
    
    private var displayLink: CADisplayLink?
    private var waveLayers: [CAShapeLayer] = []
    
    var speed: Double = 0.03 // Controls the animation speed
    var baseFrequency = 6.0 // Base frequency for the first wave
    var parameterA = 0.5 // How Shrink a Wave should
    var parameterB = 5.0
    var phase = 0.0
    var baseWaveHeightCoef = 65.0 // Base height for the first wave
    var direction: Direction = .left
    var waveCount = 1 // Number of waves
    var baseColor: UIColor = UIColor.waveBlue
    var waveFrequencies: [Double] = [] // Unique frequency for each wave

    // MARK: - Initialization
    
     init() {
        super.init(frame: .zero)
        setupWaves(count: waveCount)
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupWaves(count: waveCount)
    }
    
    // MARK: - Setup Multiple Waves
    private func setFrequency(forWaveAt index: Int, frequency: Double) {
        guard index >= 0 && index < waveFrequencies.count else { return }
        waveFrequencies[index] = frequency
    }
    func setupWaves(count: Int) {
        stopAnimation()
        waveLayers.forEach { $0.removeFromSuperlayer() }
        waveLayers.removeAll()
        waveFrequencies = Array(repeating: 0, count: count) // Same Frequency for every Wave , initial 0
        
        for i in 0..<count {
            let waveLayer = CAShapeLayer()
            let alpha = (i == 0) ? (0.2) : (0.1 + CGFloat(i) * 0.1) // Start from 0.1 and increment by 0.1
            waveLayer.fillColor = baseColor.withAlphaComponent(alpha).cgColor
            waveLayers.append(waveLayer)
            self.layer.addSublayer(waveLayer)
        }
            
            switch count {
            case 1 :
               setFrequency(forWaveAt: 0, frequency: 2) // First wave frequency
            case 2 :
                setFrequency(forWaveAt: 0, frequency: 2) // First wave frequency
                setFrequency(forWaveAt: 1, frequency: 4.0) // Second wave frequency
            case 3 :
                setFrequency(forWaveAt: 0, frequency: 2) // First wave frequency
                setFrequency(forWaveAt: 1, frequency: 4.0) // Second wave frequency
                setFrequency(forWaveAt: 2, frequency: 6.0) // third wave frequency
            case 4 :
                setFrequency(forWaveAt: 0, frequency: 2) // First wave frequency
                setFrequency(forWaveAt: 1, frequency: 4.0) // Second wave frequency
                setFrequency(forWaveAt: 2, frequency: 6.0) // third wave frequency
                setFrequency(forWaveAt: 3, frequency: 7.0) // fourth wave frequency
            case 5 :
                setFrequency(forWaveAt: 0, frequency: 2) // First wave frequency
                setFrequency(forWaveAt: 1, frequency: 4.0) // Second wave frequency
                setFrequency(forWaveAt: 2, frequency: 6.0) // third wave frequency
                setFrequency(forWaveAt: 3, frequency: 7.0) // fourth wave frequency
                setFrequency(forWaveAt: 4, frequency: 8.0) // fifth wave frequency
                
            default:
                print("No wave")
                
            }
        
    }
    // MARK: - Animation Control
    
    func startAnimation() {
        stopAnimation()
        displayLink = CADisplayLink(target: self, selector: #selector(updateWaves)) // 60 HZ /sec
        displayLink?.add(to: .main, forMode: .common)
    }
    
    func stopAnimation() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func updateWaves() {
        phase += (direction == .right ? speed : -speed)
        setNeedsDisplay()
    }

    // MARK: - Drawing Multiple Waves
    override func draw(_ rect: CGRect) {
        let yPosition = [150.0, 350.0, 370.0, 390.0, 420.0] // Base Y positions for each wave from top
        for (index, waveLayer) in waveLayers.enumerated() {
            let path = UIBezierPath()
            let width = Double(rect.width)
            let waveFrequency = waveFrequencies[index]
            let waveHeight = baseWaveHeightCoef * (1.1 - Double(index) * 0.2) // Different wave Different Height
            let waveLength = width / waveFrequency
            let baseYPosition = yPosition[index]

            // Move to the starting point of the wave
            path.move(to: CGPoint(x: 0, y: rect.maxY))
            path.addLine(to: CGPoint(x: 0, y: baseYPosition))
            
            for x in stride(from: 0, through: width, by: 1) {
                let actualX = x / waveLength
                // Alternate direction for odd and even indexes
                let sine = ((index % 2 == 0) ? 1 : -1) * cos(parameterA * (actualX + phase)) * sin((actualX + phase) / parameterB)
                let y = waveHeight * sine + baseYPosition
                path.addLine(to: CGPoint(x: x, y: y))
            }

            // Close the path
            path.addLine(to: CGPoint(x: CGFloat(width), y: rect.maxY))
            path.close()
            
            // Assign the path to the wave layer
            waveLayer.path = path.cgPath
        }
    }
    deinit {
        stopAnimation()
    }
}

