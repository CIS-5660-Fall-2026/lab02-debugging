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


https://www.shadertoy.com/view/73cGRl

In mainImage, I found the initial bug where we had vec uv2 = 2.0 * uv - vec2(1.0); When I tried to run it, the error pointed me to that spot. 

Also in mainImage, I saw that raycast was using uv instead of uv2. I found this when just looking around the initial bug. 

In raycast, I found the bug where H *= len * iResolution.x / iResolution.x; I found this because the scene looked a little bit chonky.

I found the issue in sdf3D where we were using the eye position instead of dir for our reflect function. I found this because I noticed that we didn't have any reflections, so I guessed that there was something wrong with how we were getting our reflected rays. 

We would see like the blackhole effect near objects, and I remembered this issue from our last lecture. I went to the march function and just increased our max number of steps. 
