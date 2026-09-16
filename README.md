# lab02-debugging

# Submission
- Yiding Tian (worked alone)
- [Shader Link All 5 solved] (https://www.shadertoy.com/view/f333zs)
- Bug 1 `vec2 uv2 = 2.0 * uv - vec2(1.0);` Type error suggested by compiler
- Bug 2 `raycast(uv2, dir, eye, ref);` Declared `uv2` but never used and used `uv` instead
- Bug 3 `H *= len * iResolution.x / iResolution.y;` The scene looked squashed in y direction so must be a perspective error
- Bug 4 `dir = reflect(dir, nor);` Specular reflection was not working so the reflection must be wrong
- Bug 5 `for(int i = 0; i < 256; ++i) {` The chessboard looked cut off so ray marching distance was not enough

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
