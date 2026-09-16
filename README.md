Name: Yikai Li

solution: https://www.shadertoy.com/view/NX33zl

bug 1: vec uv2 = 2.0 * uv - vec2(1.0); compile error

bug 2: raycast(uv, dir, eye, ref); uv2 was a value never used 

bug 3: H *= len * iResolution.x / iResolution.x; value isn't changed, height/width ratio not applied

bug 4: dir = reflect(eye, nor); eye is a position not a direction

bug 5(guess): for(int i = 0; i < 64; ++i) {
        vec3 pos = origin + t * dir;
there is some white points on edge and floor not extended enough, 64 steps is not enough to make the image converge, so expand it to 256




# lab02-debugging

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
