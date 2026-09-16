# Bryan Chung - Lab 02

[Shadertoy link](https://www.shadertoy.com/view/fXc3zs)

- Line 97: fixed uv2 type (found by compile error)
- Line 100: fixed using uv instead of uv2 (found by tracing through where uv2 is used)
- Line 11: fixed aspect ratio being x / x (found by reading through raycast)
- Line 75: fixed reflect() call (found by tracing through specReflCol code)
- Line 18: increased max raymarch distance (found by trying to visually match output, ground plane extends farther)

Worked with Zachary L and Charlie W

---

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
