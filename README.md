# lab02-debugging

# Setup

Create a [Shadertoy account](https://www.shadertoy.com/). Either fork this shadertoy, or create a new shadertoy and copy the code from the [Debugging Puzzle](https://www.shadertoy.com/view/flGfRc).

Let's practice debugging! We have a broken shader. It should produce output that looks like this:
[Unbelievably beautiful shader](https://github.com/user-attachments/assets/281fe7ff-1145-4a94-b7c2-b05a31d943cc)

It don't do that. Correct THREE of the FIVE bugs that are messing up the output. You are STRONGLY ENCOURAGED to work with a partner and pair program to force you to talk about your debugging thought process out loud.

Extra credit if you can find all FIVE bugs.

# Submission

* Jingyu Fu
* &#x20;https://www.shadertoy.com/view/73t3Rs
* Bugs Fixed
* 1\. Invalid vector type: Changed vec uv2 to vec2 uv2. I found this by checking the variable declarations and noticing that vec is not a valid GLSL type.
* 2\. Incorrect UV coordinates: Passed uv2 instead of uv to raycast. I found this by tracing the coordinates and noticing that the centered coordinates were calculated but never used.
* 3\. Incorrect aspect ratio: Changed iResolution.x / iResolution.x to iResolution.x / iResolution.y. I found this by inspecting the camera calculation: the original ratio was always 1.
* 4\. Incorrect reflection input: Replaced reflect(eye, nor) with reflect(dir, nor). I found this by checking the arguments: reflection requires an incoming direction, but eye is the camera position.
* 5\. Overwritten surface normal: Used a separate normal for the reflected intersection. I found this by tracing nor and noticing that it was overwritten before the Fresnel calculation, which needs the original surface normal.

