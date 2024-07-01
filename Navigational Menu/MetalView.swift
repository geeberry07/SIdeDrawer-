import UIKit
import MetalKit

class MetalView: MTKView {
    var particleSystem: ParticleSystem!

    required init(frame: CGRect) {
        super.init(frame: frame, device: MTLCreateSystemDefaultDevice())
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        device = MTLCreateSystemDefaultDevice()
        configure()
    }
    
    private func configure() {
        guard let device = device else {
            fatalError("GPU not available")
        }
        particleSystem = ParticleSystem(view: self)
        delegate = self
        enableSetNeedsDisplay = true
    }

    override func draw(_ rect: CGRect) {
        guard let drawable = currentDrawable,
              let passDescriptor = currentRenderPassDescriptor,
              let commandQueue = device?.makeCommandQueue() else { return }
        
        let commandBuffer = commandQueue.makeCommandBuffer()!
        let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: passDescriptor)!
        
        particleSystem.render(commandEncoder: commandEncoder, drawable: drawable)
        
        commandEncoder.endEncoding()
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}

extension MetalView: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // Handle view size change if needed
    }
    
    func draw(in view: MTKView) {
        self.draw(view.bounds)
    }
}
