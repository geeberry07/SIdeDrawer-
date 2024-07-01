/*

Great start! Let's expand on your `ParticleSystem` class to fully implement it. We will include the necessary steps to load and compile shaders, create the particle array, set up the pipeline state, update particle positions, and render the particles with a glitch effect.

### Step-by-Step Expansion

1. **Load and Compile Shaders:**
   - We need vertex and fragment shaders in a `.metal` file. Let's assume you already have `particle_vertex` and `particle_fragment` functions.

2. **Create Particle Array:**
   - Define a `Particle` struct to store particle properties.

3. **Create Pipeline State:**
   - Set up the Metal pipeline state with the shaders.

4. **Render Function:**
   - Update particle positions.
   - Encode particle data to a vertex buffer.
   - Set the render pipeline state.
   - Encode draw calls for particles.

### Metal Shaders (`Shaders.metal`):

```metal
#include <metal_stdlib>
using namespace metal;
*/

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
    out.position = float4(particles[vertexID].position, 0.0, 1.0);  // Correct initialization
    out.texcoord = particles[vertexID].position * 0.5 + 0.5;  // Normalized texture coordinates
    out.color = particles[vertexID].color;
    return out;
}
//Assigning to 'float2' (vector of 2 'float' values) from incompatible type 'float4' (vector of 4 'float' values)
// No matching constructor for initialization of 'float4' (vector of 4 'float' values)
fragment float4 particle_fragment(Particle in [[stage_in]],
                                  texture2d<float> tex [[texture(0)]],
                                  sampler sam [[sampler(0)]]) {
    float4 color = tex.sample(sam, in.texcoord);
    // Apply glitch effect
    color.rgb += sin(in.position.xy * 10.0) * 0.1;
    return color;
}
// Implicit conversions between vector types ('float3' (vector of 3 'float' values) and 'metal::float2' (aka 'float2')) are not permitted
