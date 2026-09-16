# lab02-debugging

## Solution

**Team member:** Yao Tang

**Shadertoy solution:** Pending publication from a Shadertoy account. The corrected source and rendered preview are included below; the submission still needs an **Unlisted** or **Public** Shadertoy URL.

- [Common tab source](shaders/common.glsl) — copied unchanged from the original shader.
- [Corrected Image tab source](shaders/image.glsl).
- [Original debugging puzzle](https://www.shadertoy.com/view/flGfRc), by amally.

![Corrected shader at iTime = 47.12 seconds](images/solution.png)

### Bugs found and how they were found

1. **Invalid GLSL type prevents compilation.** `vec uv2` uses a type that GLSL does not define. Changed it to `vec2 uv2`. **How found:** Compiling the original shader reported an undeclared `vec` identifier and a syntax error at `uv2`; checking the two-component expression identified the required type.

2. **The camera receives coordinates in the wrong range.** `mainImage` computes `uv2` in `[-1, 1]`, but passes `uv`, which is in `[0, 1]`, to `raycast`. Changed the call to `raycast(uv2, dir, eye, ref)`. **How found:** Tracing the center pixel showed that its camera coordinates were `(0.5, 0.5)` rather than `(0, 0)`, so the center ray missed the camera's reference point.

3. **The aspect-ratio correction always equals one.** `iResolution.x / iResolution.x` ignores the viewport height and stretches the scene on a nonsquare canvas. Changed the denominator to `iResolution.y`. **How found:** Inspecting the horizontal camera-vector calculation revealed the cancellation; a rendered sphere-mask check then confirmed circular bounds at landscape, square, and portrait resolutions.

4. **Reflection uses the camera position as the incident direction.** `reflect(eye, nor)` reflects a world-space position instead of the incoming ray. Changed it to `reflect(dir, nor)` and stored the result in `reflectedDir`. **How found:** Tracing the reflection inputs showed that `eye` has length 15, whereas `dir` is normalized. This both changes the reflection angle and violates the ray marcher's assumption that advancing by an SDF distance moves the ray that distance.

5. **The reflection trace overwrites the primary intersection.** Reusing `nor` for the reflected surface makes the Fresnel calculation use the wrong surface normal. Reusing `t` and `hitObj` also makes the returned `Intersection` combine a primary position with secondary-hit metadata. Added separate `reflectedNormal`, `reflectedT`, and `reflectedObj` variables. **How found:** Following the assignments between the two `march` calls and the final Fresnel/return expressions exposed the overwritten values. A per-pixel diagnostic verified that the corrected `sdf3D` preserves the primary hit distance, position, and object ID.

The secondary hit position also uses `reflectedOrigin + reflectedT * reflectedDir`, so it includes the same `0.01` origin offset used by the reflection march. The original camera orientation, animated orbit, floor pattern, materials, and Common code are preserved.

### Validation

- Reproduced the original shader's compilation error in Chrome's WebGL 2 implementation; the corrected Common + Image source compiles and links successfully.
- Pasted the corrected Image source into the original Shadertoy editor and compiled successfully there as well.
- Rendered the solution at `960 x 540` at `iTime = 0`, `6`, and `47.12`, plus `640 x 640` and `540 x 960` at `iTime = 0`.
- A diagnostic render of the center sphere produced circular bounds of `176 x 176`, `208 x 208`, and `314 x 314` pixels at those three resolutions, respectively.
- Checked primary-intersection consistency across all `480 x 270` pixels at three animation times; no mismatches were found.
- Visually compared the colored reflective spheres, diagonal floor pattern, sky, and moving camera with the supplied reference video. The screenshot above is an actual render of the included GLSL.

### Publish on Shadertoy

1. Sign in and fork the [original puzzle](https://www.shadertoy.com/view/flGfRc), or create a new shader with Common and Image tabs.
2. Put [common.glsl](shaders/common.glsl) in **Common** and [image.glsl](shaders/image.glsl) in **Image**. No input channels are needed.
3. Compile, save with visibility set to **Unlisted** or **Public**, and replace the pending solution text above with the resulting Shadertoy link.

---

# Setup 

Create a [Shadertoy account](https://www.shadertoy.com/). Either fork this shadertoy, or create a new shadertoy and copy the code from the [Debugging Puzzle](https://www.shadertoy.com/view/flGfRc).

Let's practice debugging! We have a broken shader. It should produce output that looks like this:
[Unbelievably beautiful shader](https://github.com/user-attachments/assets/281fe7ff-1145-4a94-b7c2-b05a31d943cc)

It don't do that. Correct THREE of the FIVE bugs that are messing up the output. You are STRONGLY ENCOURAGED to work with a partner and pair program to force you to talk about your debugging thought process out loud.

Extra credit if you can find all FIVE bugs.

# Submission
- Create a pull request to this repository
- In the README, include the names of both your team members
- In the README, create a link to your shader toy solution with the bugs corrected
- In the README, describe each bug you found and include a sentence about HOW you found it.
- Make sure all three of your shadertoys are set to UNLISTED or PUBLIC (so we can see them!)
