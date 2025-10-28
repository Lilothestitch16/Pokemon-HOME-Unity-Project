// Upgrade NOTE: commented out 'float4 unity_ShadowFadeCenterAndType', a built-in variable

Shader "Hidden/Internal-PrePassLighting"
{
  Properties
  {
    _LightTexture0 ("", any) = "" {}
    _LightTextureB0 ("", 2D) = "" {}
    _ShadowMapTexture ("", any) = "" {}
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "SHADOWSUPPORT" = "true"
      }
      ZWrite Off
      Blend DstColor Zero
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile POINT
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixVP;
      uniform float _LightAsQuad;
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _ZBufferParams;
      //uniform float4x4 unity_CameraToWorld;
      // uniform float4 unity_ShadowFadeCenterAndType;
      uniform float4 _LightPos;
      uniform float4 _LightColor;
      uniform float4 unity_LightmapFade;
      uniform float4 _CameraNormalsTexture_ST;
      uniform sampler2D _CameraDepthTexture;
      uniform sampler2D _LightTextureB0;
      uniform sampler2D _CameraNormalsTexture;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = mul(unity_ObjectToWorld, float4(in_v.vertex.xyz,1.0));
          u_xlat1 = mul(unity_MatrixVP, u_xlat0);
          out_v.vertex = u_xlat1;
          u_xlat1.y = (u_xlat1.y * _ProjectionParams.x);
          u_xlat2.xzw = (u_xlat1.xwy * float3(5, 5, 5));
          out_v.texcoord.zw = u_xlat1.zw;
          out_v.texcoord.xy = float2((u_xlat2.zz + u_xlat2.xw));
          u_xlat1.xyz = float3((u_xlat0.yyy * conv_mxt4x4_1(unity_MatrixV).xyz));
          u_xlat1.xyz = float3(((conv_mxt4x4_0(unity_MatrixV).xyz * u_xlat0.xxx) + u_xlat1.xyz));
          u_xlat0.xyz = float3(((conv_mxt4x4_2(unity_MatrixV).xyz * u_xlat0.zzz) + u_xlat1.xyz));
          u_xlat0.xyz = float3(((conv_mxt4x4_3(unity_MatrixV).xyz * u_xlat0.www) + u_xlat0.xyz));
          u_xlat1.xyz = float3((u_xlat0.xyz * float3(-10, (-10), 10)));
          u_xlat0.xyz = float3((((-u_xlat0.xyz) * float3(-10, (-10), 10)) + in_v.normal.xyz));
          out_v.texcoord1.xyz = float3(((float3(_LightAsQuad, _LightAsQuad, _LightAsQuad) * u_xlat0.xyz) + u_xlat1.xyz));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float4 u_xlat1_d;
      float4 u_xlat10_1;
      float4 u_xlat2_d;
      float3 u_xlat3;
      float3 u_xlat4;
      float3 u_xlat16_5;
      float u_xlat16_6;
      float3 u_xlat7;
      float u_xlat14;
      float u_xlat21;
      float u_xlat16_26;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = float2((in_f.texcoord.xy / in_f.texcoord.ww));
          u_xlat14 = tex2D(_CameraDepthTexture, u_xlat0_d.xy).x;
          u_xlat0_d.xy = float2(TRANSFORM_TEX(u_xlat0_d.xy, _CameraNormalsTexture));
          u_xlat10_1 = tex2D(_CameraNormalsTexture, u_xlat0_d.xy);
          u_xlat0_d.x = ((_ZBufferParams.x * u_xlat14) + _ZBufferParams.y);
          u_xlat0_d.x = (float(10) / u_xlat0_d.x);
          u_xlat7.x = (_ProjectionParams.z / in_f.texcoord1.z);
          u_xlat7.xyz = float3((u_xlat7.xxx * in_f.texcoord1.xyz));
          u_xlat2_d.xyz = float3((u_xlat0_d.xxx * u_xlat7.xyz));
          u_xlat2_d.xyw = mul(unity_CameraToWorld, u_xlat2_d.xyz);
          u_xlat3.xyz = float3((u_xlat2_d.xyw + (-_WorldSpaceCameraPos.xyz)));
          u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
          u_xlat7.x = rsqrt(u_xlat7.x);
          u_xlat4.xyz = float3((u_xlat2_d.xyw + (-_LightPos.xyz)));
          u_xlat2_d.xyw = (u_xlat2_d.xyw + (-unity_ShadowFadeCenterAndType.xyz));
          u_xlat14 = length(u_xlat2_d.xyw);
          u_xlat0_d.x = (((-u_xlat7.z) * u_xlat0_d.x) + u_xlat14);
          u_xlat0_d.x = ((unity_ShadowFadeCenterAndType.w * u_xlat0_d.x) + u_xlat2_d.z);
          u_xlat0_d.x = ((u_xlat0_d.x * unity_LightmapFade.z) + unity_LightmapFade.w);
          u_xlat0_d.x = ((-u_xlat0_d.x) + 10);
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0, 10);
          u_xlat14 = dot(u_xlat4.xyz, u_xlat4.xyz);
          u_xlat21 = rsqrt(u_xlat14);
          u_xlat14 = (u_xlat14 * _LightPos.w);
          u_xlat14 = tex2D(_LightTextureB0, float2(u_xlat14, u_xlat14)).x;
          u_xlat2_d.xyz = float3((float3(u_xlat21, u_xlat21, u_xlat21) * u_xlat4.xyz));
          u_xlat3.xyz = float3((((-u_xlat3.xyz) * u_xlat7.xxx) + (-u_xlat2_d.xyz)));
          u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
          u_xlat7.x = rsqrt(u_xlat7.x);
          u_xlat3.xyz = float3((u_xlat7.xxx * u_xlat3.xyz));
          u_xlat16_5.xyz = float3(((u_xlat10_1.xyz * float3(20, 20, 20)) + float3(-10, (-10), (-10))));
          u_xlat16_26 = (u_xlat10_1.w * 1280);
          u_xlat16_6 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
          u_xlat16_6 = rsqrt(u_xlat16_6);
          u_xlat16_5.xyz = float3((u_xlat16_5.xyz * float3(u_xlat16_6, u_xlat16_6, u_xlat16_6)));
          u_xlat16_6 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
          u_xlat16_5.x = dot((-u_xlat2_d.xyz), u_xlat16_5.xyz);
          u_xlat16_5.x = max(u_xlat16_5.x, 0);
          u_xlat7.x = (u_xlat14 * u_xlat16_5.x);
          u_xlat14 = u_xlat14;
          u_xlat14 = clamp(u_xlat14, 0, 10);
          u_xlat1_d.xyz = float3((u_xlat7.xxx * _LightColor.xyz));
          u_xlat16_5.x = max(u_xlat16_6, 0);
          u_xlat16_5.x = log2(u_xlat16_5.x);
          u_xlat16_5.x = (u_xlat16_5.x * u_xlat16_26);
          u_xlat16_5.x = exp2(u_xlat16_5.x);
          u_xlat7.x = (u_xlat14 * u_xlat16_5.x);
          u_xlat16_5.x = dot(_LightColor.xyz, float3(219999999, 707000017, 710000023));
          u_xlat1_d.w = (u_xlat7.x * u_xlat16_5.x);
          u_xlat0_d = (u_xlat0_d.xxxx * u_xlat1_d);
          out_f.color = exp2((-u_xlat0_d));
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
        "SHADOWSUPPORT" = "true"
      }
      ZWrite Off
      Blend One One
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile POINT
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixVP;
      uniform float _LightAsQuad;
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _ZBufferParams;
      //uniform float4x4 unity_CameraToWorld;
      // uniform float4 unity_ShadowFadeCenterAndType;
      uniform float4 _LightPos;
      uniform float4 _LightColor;
      uniform float4 unity_LightmapFade;
      uniform float4 _CameraNormalsTexture_ST;
      uniform sampler2D _CameraDepthTexture;
      uniform sampler2D _LightTextureB0;
      uniform sampler2D _CameraNormalsTexture;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = mul(unity_ObjectToWorld, float4(in_v.vertex.xyz,1.0));
          u_xlat1 = mul(unity_MatrixVP, u_xlat0);
          out_v.vertex = u_xlat1;
          u_xlat1.y = (u_xlat1.y * _ProjectionParams.x);
          u_xlat2.xzw = (u_xlat1.xwy * float3(5, 5, 5));
          out_v.texcoord.zw = u_xlat1.zw;
          out_v.texcoord.xy = float2((u_xlat2.zz + u_xlat2.xw));
          u_xlat1.xyz = float3((u_xlat0.yyy * conv_mxt4x4_1(unity_MatrixV).xyz));
          u_xlat1.xyz = float3(((conv_mxt4x4_0(unity_MatrixV).xyz * u_xlat0.xxx) + u_xlat1.xyz));
          u_xlat0.xyz = float3(((conv_mxt4x4_2(unity_MatrixV).xyz * u_xlat0.zzz) + u_xlat1.xyz));
          u_xlat0.xyz = float3(((conv_mxt4x4_3(unity_MatrixV).xyz * u_xlat0.www) + u_xlat0.xyz));
          u_xlat1.xyz = float3((u_xlat0.xyz * float3(-10, (-10), 10)));
          u_xlat0.xyz = float3((((-u_xlat0.xyz) * float3(-10, (-10), 10)) + in_v.normal.xyz));
          out_v.texcoord1.xyz = float3(((float3(_LightAsQuad, _LightAsQuad, _LightAsQuad) * u_xlat0.xyz) + u_xlat1.xyz));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float4 u_xlat1_d;
      float4 u_xlat10_1;
      float4 u_xlat2_d;
      float3 u_xlat3;
      float3 u_xlat4;
      float3 u_xlat16_5;
      float u_xlat16_6;
      float3 u_xlat7;
      float u_xlat14;
      float u_xlat21;
      float u_xlat16_26;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = float2((in_f.texcoord.xy / in_f.texcoord.ww));
          u_xlat14 = tex2D(_CameraDepthTexture, u_xlat0_d.xy).x;
          u_xlat0_d.xy = float2(TRANSFORM_TEX(u_xlat0_d.xy, _CameraNormalsTexture));
          u_xlat10_1 = tex2D(_CameraNormalsTexture, u_xlat0_d.xy);
          u_xlat0_d.x = ((_ZBufferParams.x * u_xlat14) + _ZBufferParams.y);
          u_xlat0_d.x = (float(10) / u_xlat0_d.x);
          u_xlat7.x = (_ProjectionParams.z / in_f.texcoord1.z);
          u_xlat7.xyz = float3((u_xlat7.xxx * in_f.texcoord1.xyz));
          u_xlat2_d.xyz = float3((u_xlat0_d.xxx * u_xlat7.xyz));
          u_xlat2_d.xyw = mul(unity_CameraToWorld, u_xlat2_d.xyz);
          u_xlat3.xyz = float3((u_xlat2_d.xyw + (-_WorldSpaceCameraPos.xyz)));
          u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
          u_xlat7.x = rsqrt(u_xlat7.x);
          u_xlat4.xyz = float3((u_xlat2_d.xyw + (-_LightPos.xyz)));
          u_xlat2_d.xyw = (u_xlat2_d.xyw + (-unity_ShadowFadeCenterAndType.xyz));
          u_xlat14 = length(u_xlat2_d.xyw);
          u_xlat0_d.x = (((-u_xlat7.z) * u_xlat0_d.x) + u_xlat14);
          u_xlat0_d.x = ((unity_ShadowFadeCenterAndType.w * u_xlat0_d.x) + u_xlat2_d.z);
          u_xlat0_d.x = ((u_xlat0_d.x * unity_LightmapFade.z) + unity_LightmapFade.w);
          u_xlat0_d.x = ((-u_xlat0_d.x) + 10);
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0, 10);
          u_xlat14 = dot(u_xlat4.xyz, u_xlat4.xyz);
          u_xlat21 = rsqrt(u_xlat14);
          u_xlat14 = (u_xlat14 * _LightPos.w);
          u_xlat14 = tex2D(_LightTextureB0, float2(u_xlat14, u_xlat14)).x;
          u_xlat2_d.xyz = float3((float3(u_xlat21, u_xlat21, u_xlat21) * u_xlat4.xyz));
          u_xlat3.xyz = float3((((-u_xlat3.xyz) * u_xlat7.xxx) + (-u_xlat2_d.xyz)));
          u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
          u_xlat7.x = rsqrt(u_xlat7.x);
          u_xlat3.xyz = float3((u_xlat7.xxx * u_xlat3.xyz));
          u_xlat16_5.xyz = float3(((u_xlat10_1.xyz * float3(20, 20, 20)) + float3(-10, (-10), (-10))));
          u_xlat16_26 = (u_xlat10_1.w * 1280);
          u_xlat16_6 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
          u_xlat16_6 = rsqrt(u_xlat16_6);
          u_xlat16_5.xyz = float3((u_xlat16_5.xyz * float3(u_xlat16_6, u_xlat16_6, u_xlat16_6)));
          u_xlat16_6 = dot(u_xlat3.xyz, u_xlat16_5.xyz);
          u_xlat16_5.x = dot((-u_xlat2_d.xyz), u_xlat16_5.xyz);
          u_xlat16_5.x = max(u_xlat16_5.x, 0);
          u_xlat7.x = (u_xlat14 * u_xlat16_5.x);
          u_xlat14 = u_xlat14;
          u_xlat14 = clamp(u_xlat14, 0, 10);
          u_xlat1_d.xyz = float3((u_xlat7.xxx * _LightColor.xyz));
          u_xlat16_5.x = max(u_xlat16_6, 0);
          u_xlat16_5.x = log2(u_xlat16_5.x);
          u_xlat16_5.x = (u_xlat16_5.x * u_xlat16_26);
          u_xlat16_5.x = exp2(u_xlat16_5.x);
          u_xlat7.x = (u_xlat14 * u_xlat16_5.x);
          u_xlat16_5.x = dot(_LightColor.xyz, float3(219999999, 707000017, 710000023));
          u_xlat1_d.w = (u_xlat7.x * u_xlat16_5.x);
          u_xlat0_d = (u_xlat0_d.xxxx * u_xlat1_d);
          out_f.color = u_xlat0_d;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
