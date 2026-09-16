# lab02-debugging
Shadertoy viewed [here](https://www.shadertoy.com/view/f3c3zs). The bugs I found are:
1. (To correct the black screen) Shadertoy provided compiler errors indicated that there was a misspelled variable type (`'vec': undeclared identifier` & `'uv2': syntax error`)
2. (To correct the "cropping") `vec2 uv2` is never used, so just "redefined" `uv` there instead.
3. (To correct the "stretching out") The aspect ratio is incorrect: in `raycast`, changed the height (`H`) modification from `H *= len * iResolution.x / iResolution.x` to `H *= len * iResolution.x / iResolution.y`
4. (To correct no reflection) Corrected the direction of reflection (in `dir = reflect(eye, nor)` to `dir = reflect(dir, nor)`) - thank you to Bryce and Rin for the assistance
5. (To correct the floor "bending" around the spheres) Increased the step size in `march` (from `i < 64` to `i < 250`) - thank you to Nathan for the hint

## Assignment Description
Viewed [here](https://github.com/CIS-5660-Fall-2026/lab02-debugging/blob/main/README.md).
