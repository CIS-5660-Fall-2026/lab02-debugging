Team Members: Julie Swei, Jacob Mollot

Link to ShaderToy: https://www.shadertoy.com/view/N333zs

Description of bugs:
1. Corrected from vec to vec2 (Found because Shadertoy had a very helpful giant red highlight pointing to "vec" not being a valid type)
2. Have raycast use uv2 instead of uv (Found because uv2 is calculated but never used, so I looked more closely and it's clearly labeled as the conversion between 0-1 space to -1 to 1 space, so (0,0) represents the center of the screen, which is what this raycast calculation expects)
3. Set march limit higher so background extends longer (Found because we saw that our background was ending a lot sooner than the example, and was doing a weird "dip" where the spheres and ground overlap. We recalled from lecture that marching distance being too low can create that, so we increased it.)
4. Change H from iResolution.x / iResolution.x to iResolution.x / iResolution.y (Found because the spheres were squashed, so we figured it must have something to do with ratios. Then upon skimming the code near the H and V section, the x/x caught my eye, because it's literally just 1. So sneaky.)
5. Changed reflect() to use dir and not eye (Found because we were talking about how our spheres didn't have specularity, so we went to the specular section. We talked about the physics of light bounces, and reflect() expects an incident direction and a surface normal. Eye stores the camera's position, while dir stores the direction of the incoming camera ray. Therefore, dir is the appropriate value to reflect across nor.)


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
