# lab02-debugging
### Team Member

Peizhi Zhang

### Link to Shadertoy

https://www.shadertoy.com/view/fXt3zs

### Bug fix description

**Bug 1 – Incorrect Type** 

`uv2` was incorrectly declared as `vec`. I changed it to `vec2` to fix error. I found this bug from the compiler error.

**Bug 2 – Incorrect UV Coordinates** 

`raycast()` used the original `uv` instead of the remapped `uv2`, causing the scene to appear off-center. I changed the input from `uv` to `uv2`. I found this bug by noticing that the scene was not centered and that the newly calculated `uv2` was never used.

**Bug 3 – Incorrect Aspect Ratio** 

The aspect ratio used `iResolution.x / iResolution.x`, which is a constant 1 and caused the spheres to appear horizontally stretched. I changed it to `iResolution.x / iResolution.y`. I found this bug by observing the stretched spheres compared to the video example and then checking the camera projection calculation.

**Bug 4 – Incorrect Reflection Vector** 

The reflection calculation used `eye`, which represents the camera position instead of the incoming ray direction. I changed `reflect(eye, nor)` to `reflect(dir, nor)`. I found this bug by observing that the reflections looked incorrect and checking the parameters passed to the `reflect()` function.

**Bug 5 – Ray Marching Ends Too Early** 

The ray marching loop was limited to 64 iterations, causing some rays near the spheres to terminate before reaching the floor. I increased the maximum number of iterations from 64 to 300. I found this bug by noticing missing floor regions near the spheres and checking the ray marching process. Rays passing close to the spheres take smaller steps and therefore require more iterations to reach the floor.
