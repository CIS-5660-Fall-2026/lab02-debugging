# lab02-debugging

## Team Members
Ziqiu Wang (done individually)

## Link to Shader
https://www.shadertoy.com/view/f3t3zs

## Bugs Fixed
1. Changed `vec uv2 = 2.0 * uv - vec2(1.0);` to `vec2 uv2 = 2.0 * uv - vec2(1.0);`. This bug was called out by the compiler. The pixel coordinates should be a 2D vector, so the type should be `vec2` rather than `vec`.

2. Changed `H *= len * iResolution.x / iResolution.x;` to `H *= len * iResolution.x / iResolution.y;`. The original line of code has `iResolution.x / iResolution.x;`, which is a meaningless identity and causes the shapes to be distorted horizontally (since it ignores the aspect ratio when doing raycasting). I found this bug by noting the distortion in the image and then noticing this bizarre identity in the code.

3. Changed `raycast(uv, dir, eye, ref);` to `raycast(uv2, dir, eye, ref);`. I found this bug by noting that the spheres were not centered and appeared at the lower left corner of the screen. This suggested that the uv coordinates used were between 0 and 1 when we should really use coordinates between -1 and 1. I noticed that the original code defined `uv2` but did not use it in the raycast.

4. Changed `dir = reflect(eye, nor);` to `dir = reflect(dir, nor);`. I noticed that all the specular reflections were absent, so there must have been something wrong with that part. Then I looked into the code and discovered that this calculation of the reflected ray direction used the eye position as the incident viewing direction instead of `dir` itself, which is clearly wrong.

5. Changed `for(int i = 0; i < 64; ++i) {` to `for(int i = 0; i < 640; ++i) {` at line 18. I found this bug because I noticed that the floor disappeared at larger distances, which suggested that the raymarching stopped before the ray could hit the floor at these distances. Increasing the raymarching limit makes sure that such intersections with the floor can happen.

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
