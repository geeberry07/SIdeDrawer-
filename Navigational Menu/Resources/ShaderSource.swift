let shaderSource = """
#include <metal_stdlib>
using namespace metal;

struct Particle {
    float4 position [[position]];
    float2 texcoord;
    float4 color;
};

vertex Particle particle_vertex(uint vertexID [[vertex_id]],
                                constant Particle* particles [[buffer(0)]]) {
    Particle out;
    out.position = float4(particles[vertexID].position.x, particles[vertexID].position.y, 0.0, 1.0);
    out.texcoord = particles[vertexID].position * 0.5 + 0.5;
    out.color = particles[vertexID].color;
    return out;
}

fragment float4 particle_fragment(Particle in [[stage_in]],
                                  texture2d<float> tex [[texture(0)]],
                                  sampler sam [[sampler(0)]]) {
    float4 color = tex.sample(sam, in.texcoord);
    // Apply glitch effect
    float2 pos = float2(in.position.x, in.position.y); // Explicit conversion to float2
    color.rgb += sin(pos * 10.0) * 0.1;
    return color;
}
"""
