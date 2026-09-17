**Name:** Zhiyao Luo  
**Debugging Puzzle solutions:**   
https://www.shadertoy.com/view/f3c3Rs  

## Bugs Found  

### Bug 1
While reading the camera code, I noticed `iResolution.x / iResolution.x`. Since this always equals 1, I checked the aspect ratio calculation and changed the second `x` to `y`.

### Bug 2
I noticed the visible boundary was too close. I checked the loop limit and changed it from 64 iterations to 512.

### Bug 3
The shader gave a compiler error at `vec uv2`. I changed it to `vec2 uv2`.

### Bug 4
After fixing bug3, I noticed it was calculated but never used. I found this by reading through the code and changed `raycast(uv, ...)` to `raycast(uv2, ...)`.

### Bug 5
The reflection did not look correct. I drew the eye position, ray direction, and surface normal, and realized that `reflect()` needs the ray direction, so I changed `reflect(eye, nor)` to `reflect(dir, nor)`.  

---
<br>
<br>


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
