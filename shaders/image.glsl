
void raycast(vec2 uv, out vec3 dir,
             out vec3 eye, out vec3 ref) {
    eye = rotateY(vec3(0.0, 0.0, 15.0), sin(iTime * 0.1) * 3.14159 * 0.5);
    ref = vec3(0.0, 0.0, 0.0);

    float len = tan(3.14159 * 0.125) * distance(eye, ref);
    vec3 H = normalize(cross(vec3(0.0, 1.0, 0.0), ref - eye));
    vec3 V = normalize(cross(H, eye - ref));
    V *= len;
    H *= len * iResolution.x / iResolution.y;
    vec3 p = ref + uv.x * H + uv.y * V;
    dir = normalize(p - eye);
}

void march(vec3 origin, vec3 dir, out float t, out int hitObj) {
    t = 0.001;
    for(int i = 0; i < 64; ++i) {
        vec3 pos = origin + t * dir;
        float m;
        sceneMap3D(pos, m, hitObj);
        if(m < 0.01) {
            return;
        }
        t += m;
    }
    t = -1.0;
    hitObj = -1;
}


vec3 computeMaterial(int hitObj, vec3 p, vec3 d, vec3 n) {
    switch(hitObj) {
        case 0:
        // Center sphere
        return vec3(1.0, 0.67, 0.67);
        break;
        case 1:
        // Back sphere
        return vec3(0.67, 1.0, 0.67);
        break;
        case 2:
        // Front sphere
        return vec3(0.67, 0.67, 1.0);
        break;
        case 3:
        // Floor
        float t = floor(mod((sin(p.x) + sin(p.z)) * 0.5, 2.0));
        return mix(vec3(0.7, 0.4, 0.2), vec3(1.0), t);
        break;
        case -1:
        // Background
        break;
    }
    return vec3(255.0, 229.0, 119.0) / 255.0;
}

Intersection sdf3D(vec3 dir, vec3 eye) {
    float t;
    int hitObj;
    march(eye, dir, t, hitObj);

    if(t == -1.0) {
        return Intersection(t, skyColor(dir),
                            vec3(eye + 1000.0 * dir),
                            -1);
    }

    vec3 isect = eye + t * dir;
    vec3 nor = computeNormal(isect);

    vec3 material = computeMaterial(hitObj, isect, dir, nor);

    // Specular reflection applied to all surfaces
    vec3 reflectedDir = reflect(dir, nor);
    vec3 reflectedOrigin = isect + reflectedDir * 0.01;
    float reflectedT;
    int reflectedObj;
    march(reflectedOrigin, reflectedDir, reflectedT, reflectedObj);
    vec3 specReflCol;
    if(reflectedObj == -1) {
        specReflCol = skyColor(reflectedDir);
    }
    else {
        vec3 isect2 = reflectedOrigin + reflectedT * reflectedDir;
        vec3 reflectedNormal = computeNormal(isect2);
        specReflCol = computeMaterial(reflectedObj, isect2, reflectedDir, reflectedNormal);
    }
    float fresnel = 1.0 - max(0.0, dot(normalize(eye - isect), nor));
    fresnel = 0.25 + 0.75 * fresnel;
    vec3 sdfColor = mix(material, specReflCol * material, fresnel);

    return Intersection(t, sdfColor, isect, hitObj);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    // [-1, 1]
    vec2 uv2 = 2.0 * uv - vec2(1.0);

    vec3 dir, eye, ref;
    raycast(uv2, dir, eye, ref);
    fragColor = vec4(sdf3D(dir, eye).color, 1.);

}
