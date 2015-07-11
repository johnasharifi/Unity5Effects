// G-Buffers (Unity internals)
sampler2D _CameraGBufferTexture0;   // diffuse color (rgb), occlusion (a)
sampler2D _CameraGBufferTexture1;   // spec color (rgb), smoothness (a)
sampler2D _CameraGBufferTexture2;   // normal (rgb), --unused, very low precision-- (a) 
sampler2D _CameraGBufferTexture3;   // emission (rgb), --unused-- (a)
sampler2D_float _CameraDepthTexture;

// not Unity internals
sampler2D _PrevCameraGBufferTexture0;   // diffuse color (rgb), occlusion (a)
sampler2D _PrevCameraGBufferTexture1;   // spec color (rgb), smoothness (a)
sampler2D _PrevCameraGBufferTexture2;   // normal (rgb), --unused, very low precision-- (a) 
sampler2D _PrevCameraGBufferTexture3;   // emission (rgb), --unused-- (a)
sampler2D_float _PrevCameraDepthTexture;

sampler2D _FrameBuffer;
sampler2D _PrevFrameBuffer;

float4x4 _InvViewProj;
float4x4 _PrevInvViewProj;


half4 GetAlbedo(float2 uv)      { return tex2D(_CameraGBufferTexture0, uv); }
half4 GetSpecular(float2 uv)    { return tex2D(_CameraGBufferTexture1, uv); }
half4 GetNormal(float2 uv)      { return tex2D(_CameraGBufferTexture2, uv); }
half4 GetEmission(float2 uv)    { return tex2D(_CameraGBufferTexture3, uv); }
float GetDepth(float2 uv)       { return tex2D(_CameraDepthTexture, uv).x; }
half4 GetFrameBuffer(float2 uv) { return tex2D(_FrameBuffer, uv); }
float4 GetPosition(float2 uv)
{
    float2 screen_position = uv * 2.0 - 1.0;
    float depth = tex2D(_CameraDepthTexture, uv).x;
    return mul(_InvViewProj, float4(screen_position, depth, 1.0));
}

half4 GetPrevAlbedo(float2 uv)      { return tex2D(_PrevCameraGBufferTexture0, uv); }
half4 GetPrevSpecular(float2 uv)    { return tex2D(_PrevCameraGBufferTexture1, uv); }
half4 GetPrevNormal(float2 uv)      { return tex2D(_PrevCameraGBufferTexture2, uv); }
half4 GetPrevEmission(float2 uv)    { return tex2D(_PrevCameraGBufferTexture3, uv); }
float GetPrevDepth(float2 uv)       { return tex2D(_PrevCameraDepthTexture, uv).x; }
half4 GetPrevFrameBuffer(float2 uv) { return tex2D(_PrevFrameBuffer, uv); }
float4 GetPrevPosition(float2 uv)
{
    float2 screen_position = uv * 2.0 - 1.0;
    float depth = tex2D(_PrevCameraDepthTexture, uv).x;
    return mul(_PrevInvViewProj, float4(screen_position, depth, 1.0));
}
