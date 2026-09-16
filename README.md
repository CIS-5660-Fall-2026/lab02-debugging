# lab02-debugging

# Setup 

Create a [Shadertoy account](https://www.shadertoy.com/). Either fork this shadertoy, or create a new shadertoy and copy the code from the [Debugging Puzzle](https://www.shadertoy.com/view/flGfRc).

Let's practice debugging! We have a broken shader. It should produce output that looks like this:
[Unbelievably beautiful shader](https://user-images.githubusercontent.com/1758825/200729570-8e10a37a-345d-4aff-8eff-6baf54a32a40.webm)

It don't do that. Correct THREE of the FIVE bugs that are messing up the output. You are STRONGLY ENCOURAGED to work with a partner and pair program to force you to talk about your debugging thought process out loud.

Extra credit if you can find all FIVE bugs.

# Submission
- Create a pull request to this repository
- In the README, include the names of both your team members
- In the README, create a link to your shader toy solution with the bugs corrected
- In the README, describe each bug you found and include a sentence about HOW you found it.
- Make sure all three of your shadertoys are set to UNLISTED or PUBLIC (so we can see them!)


# My submission
- Team members: Mark Melkumyan
- [Shadertoy link](https://www.shadertoy.com/view/fX33zs)

## Bugs:

### Bug 1:
`uv2` should be a `vec2` not a `vec`.
```glsl
vec uv2 = 2.0 * uv - vec2(1.0);
```
Solution:
```glsl
vec2 uv2 = 2.0 * uv - vec2(1.0);
```
Found because of the compile error (red text).
`raycast` should also use `uv2` instead of `uv`: 
```glsl
raycast(uv2, dir, eye, ref);
```

### Bug 2:
Screenspace does not normalize aspect ratio.
Found by adding a test circle. It's renders as an oval (each edge of the "circle" touches the screen edge).
```glsl
float d = length(uv2);
float t = clamp(d, 0.0, 1.0);
fragColor = vec4(vec3(d), 1.f);
```
Solution:
```
// normalize aspect ratio
float aspect = iResolution.x / iResolution.y;
uv2.x *= aspect;
```
Fixing line 10 also works! Should be x/y, not x/x.
```glsl
H *= len * iResolution.x / iResolution.y;
```

### Bug 3:
Increase max iterations of `march` (64 is too low!). Found because I noticed the warping around the spheres, which indicates the ray stops before it can get past it.
```glsl
void march(vec3 origin, vec3 dir, out float t, out int hitObj) {
    t = 0.001;
    // increase max iterations (64 is too low!)
    for(int i = 0; i < 256; ++i) {
```

### Bug 4:
Take the `abs` of `m` in `march`. Sometimes we step BEHIND the SDF surface, but we don't want to include ALL negative m values, just ones close to zero.
```glsl
if(abs(m) < 0.01) {
    return;
}
```

### Bug 5:
Replace `eye` with `dir` in `sdf3D`. Reflect takes vectors, not positions.
```glsl
dir = reflect(dir, nor);
```
Found by previewing the reflections in black (`specReflCol = vec3(0.f)`), which indicated something was wrong with how we calculated reflections.


