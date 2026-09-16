# Lab 02 - Debugging

## Team Member
- Xuan Zhu

## Links
- [Shadertoy Demo](https://www.shadertoy.com/view/NXt3Rs)

## Bugs Fixed

### 1. Wrong UV type
```glsl
// Before
vec uv2 = 2.0 * uv - vec2(1.0);

// After
vec2 uv2 = 2.0 * uv - vec2(1.0);
```

Found from the GLSL compiler error.

### 2. Wrong UV passed to `raycast`
```glsl
// Before
raycast(uv, dir, eye, ref);

// After
raycast(uv2, dir, eye, ref);
```

`uv2` was calculated but never used.

### 3. Wrong aspect ratio
```glsl
// Before
H *= len * iResolution.x / iResolution.x;

// After
H *= len * iResolution.x / iResolution.y;
```

The original expression always gave an aspect ratio of 1.

### 4. Wrong reflection direction
```glsl
// Before
dir = reflect(eye, nor);

// After
dir = reflect(dir, nor);
```

`reflect()` needs the incident ray direction, not the camera position.

### 5. Primary hit data was overwritten
```glsl
float primaryT = t;
int primaryObj = hitObj;
```

Saved the first intersection before tracing the reflected ray.

### 6. Primary normal was overwritten
```glsl
// Before
nor = computeNormal(isect2);

// After
vec3 nor2 = computeNormal(isect2);
```

This keeps the original normal for the Fresnel calculation.

### 7. Wrong reflected ray origin
```glsl
vec3 reflOrigin = isect + dir * 0.01;
march(reflOrigin, dir, t, hitObj);

vec3 isect2 = reflOrigin + t * dir;
```

The second intersection should be calculated from the same origin used by `march()`.

### 8. Wrong X-axis rotation
```glsl
// Before
sin(p.y) + cos(p.z)

// After
sin(amt) * p.y + cos(amt) * p.z
```

Fixed using the standard X-axis rotation formula.

### 9. Wrong `clamp()` argument order
```glsl
// Before
clamp(0.0, 1.0, value);

// After
clamp(value, 0.0, 1.0);
```

GLSL uses `clamp(x, minVal, maxVal)`.
