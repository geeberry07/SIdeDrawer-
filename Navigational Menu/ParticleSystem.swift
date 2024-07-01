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
    private var sampler: MTLSamplerState?

    init(view: MTKView) {
        guard let device = view.device else {
            fatalError("GPU not available")
        }

        self.device = device
        commandQueue = device.makeCommandQueue()!

        loadAvatarTexture()
        createParticles()
        setupPipelineState()
        setupSamplerState()
    }

    func render(commandEncoder: MTLRenderCommandEncoder, drawable: CAMetalDrawable) {
        updateParticles()

        let vertexBuffer = device.makeBuffer(bytes: particleArray, length: MemoryLayout<Particle>.stride * particleArray.count, options: [])

        commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        commandEncoder.setRenderPipelineState(pipelineState!)
        commandEncoder.setFragmentTexture(texture, index: 0)
        commandEncoder.setFragmentSamplerState(sampler, index: 0)
        commandEncoder.drawPrimitives(type: .point, vertexStart: 0, vertexCount: particleArray.count)
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
    }

    private func setupPipelineState() {
        do {
            let library = try device.makeLibrary(source: shaderSource, options: nil)
            let vertexFunction = library.makeFunction(name: "particle_vertex")
            let fragmentFunction = library.makeFunction(name: "particle_fragment")

            let pipelineDescriptor = MTLRenderPipelineDescriptor()
            pipelineDescriptor.vertexFunction = vertexFunction
            pipelineDescriptor.fragmentFunction = fragmentFunction
            pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm

            pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            print("Failed to create pipeline state: \(error)")
        }
    }

    private func setupSamplerState() {
        let samplerDescriptor = MTLSamplerDescriptor()
        samplerDescriptor.minFilter = .linear
        samplerDescriptor.magFilter = .linear
        samplerDescriptor.mipFilter = .linear
        samplerDescriptor.maxAnisotropy = 1
        samplerDescriptor.sAddressMode = .clampToEdge
        samplerDescriptor.tAddressMode = .clampToEdge
        samplerDescriptor.rAddressMode = .clampToEdge
        samplerDescriptor.normalizedCoordinates = true
        samplerDescriptor.lodMinClamp = 0
        samplerDescriptor.lodMaxClamp = Float.greatestFiniteMagnitude
        sampler = device.makeSamplerState(descriptor: samplerDescriptor)
    }

    private func updateParticles() {
        for i in 0..<particleArray.count {
            particleArray[i].position += particleArray[i].velocity

            // Apply glitch effect by randomly modifying particle properties
            if Bool.random() {
                particleArray[i].color = SIMD4<Float>(Float.random(in: 0...1), Float.random(in: 0...1), Float.random(in: 0...1), 1.0)
            }
        }
    }
}
