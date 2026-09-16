# lab02-debugging

[Debugged Shader](https://www.shadertoy.com/view/NX3GRs)

Teammate: Luke Kwon

Bugs:

1. Use of "vec" instead of "vec2" in mainImage(). I found this during my first read of the base code, and ShaderToy's linter also flagged the line as problematic.
2. Use of "uv" instead of "uv2" when calling raycast() in mainImage(). I similarly found this after my first read of the base code. When the screen was black I focused on the highest level function first (mainImage), and I caught it while visualizing fragColor with uv and uv2.
3. Multiplying H by iResolution.x / iResolution.x instead of iResolution.x / iResolution.y in raycast(). I saw that the intent here was to multiply by resolution ratio, noticed that the spheres in my image were warped, and then noticed the bug.
4. Reflect eye about the normal instead of the normalized vector pointing from isect to eye in sdf3D(). The reflections were not present in the render, which pointed to an issue with ray reflections.
5. Step size in march() was too low, causing near-misses to terminate early. I noticed in the render that areas just outside of the sphere were rendering as no intersection, pointing to an issue with raymarch step handling. Luke pointed out that the floor in my render also did not extend as far into the distance as the the reference image, which pointed us to hitting the maximum step count prior to finding a valid intersection in near-miss areas.

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
