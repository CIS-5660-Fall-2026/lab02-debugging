# lab02-debugging

## Solution

**Name:** Ximing Luo

**Fixed shader:** https://www.shadertoy.com/view/7X33zl

All five bugs were in the Image tab.

### 1. `vec uv2` doesn't compile

`vec` isn't a type, so the shader wouldn't build. Changed it to `vec2`.

How I found it: the compiler error pointed right at the line. Had to fix this first before anything else could be checked.

### 2. `raycast` was given `uv` instead of `uv2`

`uv` is in [0, 1], so the whole scene was pushed into one corner of the screen. Passing `uv2` (which is in [-1, 1]) centers it.

How I found it: the scene was off-center, and `uv2` was computed but never used.

### 3. Aspect ratio was `x / x`

In `raycast`, `H` was scaled by `iResolution.x / iResolution.x`, which is always 1. The spheres came out as ellipses. Changed the denominator to `iResolution.y`.

How I found it: the spheres were squashed, and resizing the preview changed how squashed they were, so it had to be the camera setup.

### 4. `reflect(eye, nor)` should be `reflect(dir, nor)`

`reflect` wants the incoming ray direction. `eye` is a position, so the reflected ray was huge and pointed the wrong way. Reflections were just noise.

How I found it: no sky or other spheres showed up in the reflections. Reading the reflection code, `eye` clearly wasn't a direction.

### 5. Fresnel used the wrong normal

After the reflection march, `nor` was overwritten with the normal at the reflected hit point. The Fresnel line right after that still read `nor`, so the rim shading depended on whatever the reflection hit. Stored the second normal in its own variable (`nor2`) so `nor` stays the primary surface normal.

How I found it: the rim on the spheres shifted around as the camera moved. Reading `sdf3D` top to bottom showed `nor` being reassigned before the `fresnel` line.

---

# Setup 

Create a [Shadertoy account](https://www.shadertoy.com/). Either fork this shadertoy, or create a new shadertoy and copy the code from the [Debugging Puzzle](https://www.shadertoy.com/view/flGfRc).

Let's practice debugging! We have a broken shader. It should produce output that looks like this:
[Unbelievably beautiful shader](https://user-images.githubusercontent.com/1758825/200729570-8e10a37a-345d-4aff-8eff-6baf54a32a40.webm)

It don't do that. Correct THREE of the FIVE bugs that are messing up the output. You are STRONGLY ENCOURAGED to work with a partner and pair program to force you to talk about your debugging thought process out loud.

Extra credit if you can find all FIVE bugs.
