# lab02-debugging

# ShaderToy Link

https://www.shadertoy.com/view/s333Rl

# Bugs Found

1. Syntax error, found due to compilation error highlighting
2. Ray march terminating too early, found because floor cuts off due to missed rays not extending far enough
3. Aspect ratio issue, found because resolution looks too stretched and found that the raycast() function was not calculating aspect ratio correctly
4. Not using newly mapped uv value, found because camera was not focused on correct area of scene
5. Performing specular reflection based on eye not dir, found by walking through basic logic of specular reflection

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
