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

# link
solution: https://www.shadertoy.com/view/sX3GRl

# how i found the bugs
1. shadertoy showed me a compile error with "vec" -> "vec2"
2. I substituted "uv" with "uv2" in raycast because we want to go from [-1, 1]
3. fixed the aspect ratio in raycast because the screen was squished
4. fix the reflection by changing the reflection direction, after I noticed the reflections were off
5. I increased the number of steps in the raymarch because the it seemed to cut off too early.
