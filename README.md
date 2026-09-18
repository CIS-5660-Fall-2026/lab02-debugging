# lab02-debugging

# Result
Team Members: Anya Agarwal

Link to fixed shader toy: https://www.shadertoy.com/view/f3cGRs

Bug 1: On line 97, `vec` was used instead of `vec2`, which resulted in an error. I found this error by reading the red error message, since this was a syntax error instead of a logic error.

Bug 2: On line 100, `uv` was used instead of `uv2`. I found this by first analyzing the ray cast in the `mainImage()` function, since that is the origin of the whole program, and found that there was a mismatch in the variable used.

Bug 3: On line 11, the denominator should be `iResolution.y` instead of `iResolution.x`. I found this because the spheres were quite warped, so I guessed that the issue is either coming from ray distorting or a bug in the aspect ratio. It turned out to be the aspect ratio.

Bug 4: On line 18, I increased the step size to be 200. The boundaries of the scene were being cut off, and I guessed that was happening because the ray in the ray cast was being terminated too soon, which caused it to not catch geometry in the distance.

Bug 5: On line 75, `eye` was used as the incoming ray instead of `dir`. I narrowed down the bug to be somewhere in the `sdf3D()` function since that is what handles the reflected ray cast. After reasoning out how a reflected ray is calculated, I realized that we need the actual ray, which is `dir`, instead of the `eye`, which is simply the camera location.

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
