import MetalKit

struct Particle {
    var position: SIMD2<Float>
    var velocity: SIMD2<Float>
    var color: SIMD4<Float>
}

class ParticleSystem {
    private let device: MTLDevice
    private let commandQueue: MTLCommandQueue
    private var pipelineState: MTLRenderPipelineState?
    private var particleArray: [Particle] = []
    private var vertexBuffer: MTLBuffer?
    private var texture: MTLTexture?

    init(view: MTKView) {
        guard let device = view.device else {
            fatalError("GPU not available")
        }

        self.device = device
        commandQueue = device.makeCommandQueue()!

        loadAvatarTexture()
        createParticles()
        setupPipelineState()
    }

    func render(commandEncoder: MTLRenderCommandEncoder, drawable: CAMetalDrawable) {
        updateParticles()

        if let vertexBuffer = vertexBuffer {
            commandEncoder.setRenderPipelineState(pipelineState!)
            commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
            commandEncoder.setFragmentTexture(texture, index: 0)
            commandEncoder.drawPrimitives(type: .point, vertexStart: 0, vertexCount: particleArray.count)
        }
    }

    private func loadAvatarTexture() {
        let textureLoader = MTKTextureLoader(device: device)
        if let image = UIImage(named: "avatar")?.cgImage {
            texture = try? textureLoader.newTexture(cgImage: image, options: nil)
        }
    }

    private func createParticles() {
        guard let texture = texture else { return }
        let width = texture.width
        let height = texture.height

        for y in 0..<height {
            for x in 0..<width {
                let u = Float(x) / Float(width) * 2.0 - 1.0
                let v = Float(y) / Float(height) * 2.0 - 1.0
                let position = SIMD2<Float>(u, v)
                let velocity = SIMD2<Float>(Float.random(in: -0.01...0.01), Float.random(in: -0.01...0.01))
                let color = SIMD4<Float>(1.0, 1.0, 1.0, 1.0)
                particleArray.append(Particle(position: position, velocity: velocity, color: color))
            }
        }
        vertexBuffer = device.makeBuffer(bytes: particleArray, length: MemoryLayout<Particle>.stride * particleArray.count, options: [])
    }

    private func setupPipelineState() {
        let library = device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "particle_vertex")
        let fragmentFunction = library?.makeFunction(name: "particle_fragment")

        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm

        pipelineState = try? device.makeRenderPipelineState(descriptor: pipelineDescriptor)
    }

    private func updateParticles() {
        for i in 0..<particleArray.count {
            particleArray[i].position += particleArray[i].velocity

            // Apply glitch effect by randomly modifying particle properties
            if Bool.random() {
                particleArray[i].color = SIMD4<Float>(Float.random(in: 0...1), Float.random(in: 0...1), Float.random(in: 0...1), 1.0)
            }
        }
        vertexBuffer = device.makeBuffer(bytes: particleArray, length: MemoryLayout<Particle>.stride * particleArray.count, options: [])
    }
}
