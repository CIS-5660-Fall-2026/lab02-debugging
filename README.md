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
    * Jacob Mollot & Julie Swei
- In the README, create a link to your shader toy solution with the bugs corrected
    * https://www.shadertoy.com/view/NXt3zs
- In the README, describe each bug you found and include a sentence about HOW you found it.
    1. use vec2 at line 97 because vec is undefined
    2. use uv2 at line 100 because uv wasn't mapped properly
    3. march i = 256 gives more rays and ability to render with more depth
    4. line 11 -> aspect ratio was iResolution.x / iResolution.x
    5. line 75 -> use dir instead eye because that takes the actual point into account
- Make sure all three of your shadertoys are set to UNLISTED or PUBLIC (so we can see them!)
