# lab02-debugging

# Luke Kwon
Team Member: Nathan Chortek

Link: https://www.shadertoy.com/view/fXcGzs

Bugs:
1. Line 97: vec -> vec2, Found via compile error
2. Line 100: uv -> uv2, The heavily distorted image suggested there was an issue with the ray construction, and it turned out uv2 was being computed but not used.
3. Line 11: iResolution.x/ iResolution.y, The screen was stretched in the y direction, hinting that something could be wrong with resolution. Searching for a variable named resolution helped fix the problem.
4. Line 18: i < 64 -> i < 128, There was aliasing around the spheres that usually occurs from having not enough samples, and the board was cut off too early. Therefore, locating the for loop deciding the ray step counts and increasing it by 2 fixed the problem.
5. Line 75: reflect(eye,nor) -> reflect(normalize(isect-eye), nor), Specular reflections were not visible, so I located the part of the code that dealt with specular reflections. It turns out the eye was being reflected along the normal, when the ray from the eye to the intersection point should be flipped.

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
