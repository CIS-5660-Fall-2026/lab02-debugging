# lab02-debugging
- Name: Anna
- Fixed shader toy: https://www.shadertoy.com/view/fXtGRs

Bugs found:
1. invalid type vec (mainImage): uv2 was declared as vec, which isn't a GLSL type, so the shader wouldn't compile. Changed to vec2.
    - How it was found: reading the compiler error message.
2. unused uv2 (mainImage): uv2 was computed in the [-1, 1] range, but raycast was still given uv in [0, 1], so the screen center mapped to a corner of the view and the camera looked off-center. Now uv2 is passed.
   - How it was found: noticing that a variable was computed and then never used, then checking that `p = ref + uv.x * H + uv.y * V` needs a range centered on 0 while the screen isnt.
3. aspect ratio always 1 (raycast): `H *= len * iResolution.x / iResolution.x` always evaluated to len, so wide screens stretched the image horizontally. Changed to `iResolution.x / iResolution.y`.
   - How it was found: the spheres are stretched, so I looked up how resolution.x and resolution.y were involved. Simplified the expression and realized that y value for resolution is not involved in scaling.
4. reflecting a position instead of a direction (sdf3D): `reflect(eye, nor)` passed the camera position, but reflect expects the incoming ray direction, so reflections depended on where the world origin was. Changed to `reflect(dir, nor)`.
   - How it was found: checking the argument types against the definition of reflect(I, N) and seeing that eye is a point, not a direction.
5. normal overwritten before Fresnel (sdf3D): nor was reused for the reflected object's normal in the else branch, so when the reflected ray hit another object, the Fresnel term used the wrong surface's normal and shading was wrong only in some areas. Fixed by using separate `hitNor` and `reflNor` variables.
   - How it was found: the fresnel effect does not align with the reference videos entirely, so I went to check where that occasional discrepancy came from by checking where variables can branch in sdf3D's code.


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
