#define HALF_PI 1.570795
#define MAIN_LIGHT_DIR normalize(vec3(1.0, 0.2, -0.4))

// put all bugs in Image tab

// todo in broken one, hard code these in two diff scenemap3d
#define RED_SPH_POS vec3(0.)
#define GRN_SPH_POS vec3(4.0, 0.0, -4.0)
#define BLU_SPH_POS vec3(-4.0, 0.0, 4.0)

struct Intersection {
    float t;
    vec3 color;
    vec3 p;
    int object;
};



float random1(vec2 p) {
  return fract(sin(dot(p, vec2(456.789, 20487145.123))) * 842478.5453);
}

float random1( vec3 p ) {
  return fract(sin(dot(p, vec3(127.1, 311.7, 191.999))) * 43758.5453);
}

vec2 random2(vec2 p) {
  return fract(sin(vec2(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)))) * 43758.5453);
}

float mySmootherStep(float a, float b, float t) {
  t = t*t*t*(t*(t*6.0 - 15.0) + 10.0);
  return mix(a, b, t);
}


float interpNoise3D1(vec3 p) {
  vec3 pFract = fract(p);
  float llb = random1(floor(p));
  float lrb = random1(floor(p) + vec3(1.0,0.0,0.0));
  float ulb = random1(floor(p) + vec3(0.0,1.0,0.0));
  float urb = random1(floor(p) + vec3(1.0,1.0,0.0));

  float llf = random1(floor(p) + vec3(0.0,0.0,1.0));
  float lrf = random1(floor(p) + vec3(1.0,0.0,1.0));
  float ulf = random1(floor(p) + vec3(0.0,1.0,1.0));
  float urf = random1(floor(p) + vec3(1.0,1.0,1.0));

  float lerpXLB = mySmootherStep(llb, lrb, pFract.x);
  float lerpXHB = mySmootherStep(ulb, urb, pFract.x);
  float lerpXLF = mySmootherStep(llf, lrf, pFract.x);
  float lerpXHF = mySmootherStep(ulf, urf, pFract.x);

  float lerpYB = mySmootherStep(lerpXLB, lerpXHB, pFract.y);
  float lerpYF = mySmootherStep(lerpXLF, lerpXHF, pFract.y);

  return mySmootherStep(lerpYB, lerpYF, pFract.z);
}


float fbm(vec3 p, float octaves) {
  float amp = 0.5;
  float freq = 8.0;
  float sum = 0.0;
  float maxSum = 0.0;
  for(float i = 0.0; i < 10.0; ++i) {
    if(i == octaves)
    break;
    maxSum += amp;
    sum += interpNoise3D1(p * freq) * amp;
    amp *= 0.5;
    freq *= 2.0;
  }
  return sum / maxSum;
}


float sphere(vec3 p, float r, vec3 c) {
    return distance(p, c) - r;
}

float box(vec3 p, vec3 b) {
  return length(max(abs(p) - b, 0.0));
}

float torus(vec3 p, vec2 t) {
  vec2 q = vec2(length(p.xz)-t.x,p.y);
  return length(q) - t.y;
}

vec3 rotateX(vec3 p, float amt) {
    return vec3(p.x, cos(amt) * p.y - sin(amt) * p.z, sin(p.y) + cos(p.z));
}
    
vec3 rotateY(vec3 p, float a) {
    return vec3(cos(a) * p.x + sin(a) * p.z, p.y, -sin(a) * p.x + cos(a) * p.z);
}

// Map a ray direction to a color for the background
// This function is called when a ray hits nothing
vec3 skyColor(vec3 dir) {
    float t = smoothstep(0.0, 1.0, dir.y);
    t = clamp(0.0, 1.0, t + fbm(dir / 8.0, 4.0) * 0.1);
    t = fbm(dir / 8.0, 6.0);
    t = smoothstep(0.0, 1.0, t);
    vec3 dawnGradient = mix(vec3(253.0, 96.0, 81.0) / 255.0, vec3(255.0, 229.0, 119.0) / 255.0, t);
    vec3 duskGradient = mix(vec3(48.0, 24.0, 96.0) / 255.0, vec3(144.0, 96.0, 144.0) / 255.0, t);
    t = max(0.0, dot(dir, MAIN_LIGHT_DIR));
    return mix(duskGradient, dawnGradient, t);
}



// Version that just returns the t value, for surface normal computation
float sceneMap3D(vec3 pos) {
    float t = sphere(pos, 2.0, RED_SPH_POS);
    t = min(t, sphere(pos, 2.0, GRN_SPH_POS));
    t = min(t, sphere(pos, 2.0, BLU_SPH_POS));
    t = min(t, box(pos + vec3(0.0, 3.0, 0.0), vec3(50.0, 1.0, 50.0)));
    return t;
}


vec3 computeNormal(vec3 pos) {
    vec3 epsilon = vec3(0.0, 0.001, 0.0);
    return normalize( vec3( sceneMap3D(pos + epsilon.yxx) - sceneMap3D(pos - epsilon.yxx),
                            sceneMap3D(pos + epsilon.xyx) - sceneMap3D(pos - epsilon.xyx),
                            sceneMap3D(pos + epsilon.xxy) - sceneMap3D(pos - epsilon.xxy)));
}

// Version that returns t value and the ID of the object hit
void sceneMap3D(vec3 pos, out float t, out int obj) {
    t = sphere(pos, 2.0, RED_SPH_POS);
    float t2;
    obj = 0; // 0 is center sphere
    if((t2 = sphere(pos, 2.0, GRN_SPH_POS)) < t) {
        t = t2;
        obj = 1; // 1 is left sphere
    }
    if((t2 = sphere(pos, 2.0, BLU_SPH_POS)) < t) {
        t = t2;
        obj = 2; // 2 is right sphere
    }
    if((t2 = box(pos + vec3(0.0, 3.0, 0.0), vec3(50.0, 1.0, 50.0))) < t) {
        t = t2;
        obj = 3; // 3 is floor
    }
}

