# lab02-debugging
Shader link: [https://www.shadertoy.com/view/s3cGRl](https://www.shadertoy.com/view/s3cGRl)
Paulo Khayat 17691103
# Submission
- Create a pull request to this repository
- In the README, include the names of both your team members
- In the README, create a link to your shader toy solution with the bugs corrected
- In the README, describe each bug you found and include a sentence about HOW you found it.
- Make sure all three of your shadertoys are set to UNLISTED or PUBLIC (so we can see them!)

# Bugs
1) The variable vec2 was written as 'vec'  
Had to fix this in order for the code to compile
2) The uv passed to the raycast function was not the one mapped to [-1, 1]  
I initially knew there was something wrong with the camera. I spent a while trying to see if the eye position is wrong or if the math after it is.   I fixed the calculation of p (subtracted half of H and V, then multiplied  by 2), though later with help from Nico i realized the problem was later in the MainImage.
3) The scaling of the uv's by the screen resolution ratio was wrong.  
i fixed this part by mistake, i thought the problem was that it was y/x instead of x/y. after rewriting it was now fine i realized.
4) dir = reflect(dir, nor); the reflected ray was the eye.  
It was hard to find but I noticed something was off with the reflections only.  
I played around with the march and realized none of the objects are hitting the sky even though they should. I increased the bounce 
    march(isect + 0.01*dir, dir, t, hitObj); to 1.*dir, i saw the sky, so i realized there was something wrong with the raycast itself.
5) there was bending beneath the balls, so i increased the march count from 64 to 200
