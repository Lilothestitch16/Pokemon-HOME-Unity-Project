Shader "Hidden/Internal-DeferredReflections"
{
  Properties
  {
    _SrcBlend ("", float) = 1
    _DstBlend ("", float) = 1
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
      }
      ZWrite Off
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
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
      //uniform float4 unity_SpecCube0_BoxMax;
      //uniform float4 unity_SpecCube0_BoxMin;
      //uniform float4 unity_SpecCube0_HDR;
      //uniform float4 unity_SpecCube1_ProbePosition;
      uniform sampler2D _CameraDepthTexture;
      uniform sampler2D _CameraGBufferTexture0;
      uniform sampler2D _CameraGBufferTexture1;
      uniform sampler2D _CameraGBufferTexture2;
      //uniform samplerCUBE unity_SpecCube0;
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
      float2 u_xlat1_d;
      float u_xlat10_1;
      float3 u_xlat2_d;
      float4 u_xlat10_2;
      float3 u_xlat16_3;
      float3 u_xlat10_3;
      float u_xlat16_4;
      float4 u_xlat10_4;
      float3 u_xlat16_5;
      float3 u_xlat16_6;
      float u_xlat21;
      float u_xlat16_21;
      float u_xlat16_26;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.x = (_ProjectionParams.z / in_f.texcoord1.z);
          u_xlat0_d.xyz = float3((u_xlat0_d.xxx * in_f.texcoord1.xyz));
          u_xlat1_d.xy = float2((in_f.texcoord.xy / in_f.texcoord.ww));
          u_xlat21 = tex2D(_CameraDepthTexture, u_xlat1_d.xy).x;
          u_xlat21 = ((_ZBufferParams.x * u_xlat21) + _ZBufferParams.y);
          u_xlat21 = (float(10) / u_xlat21);
          u_xlat0_d.xyz = float3((float3(u_xlat21, u_xlat21, u_xlat21) * u_xlat0_d.xyz));
          u_xlat0_d.xyz = mul(unity_CameraToWorld, u_xlat0_d.xyz);
          u_xlat2_d.xyz = float3((u_xlat0_d.xyz + (-_WorldSpaceCameraPos.xyz)));
          u_xlat2_d.xyz = float3(normalize(u_xlat2_d.xyz));
          u_xlat10_3.xyz = tex2D(_CameraGBufferTexture2, u_xlat1_d.xy).xyz.xyz;
          u_xlat16_3.xyz = float3(((u_xlat10_3.xyz * float3(20, 20, 20)) + float3(-10, (-10), (-10))));
          u_xlat16_3.xyz = float3(normalize(u_xlat16_3.xyz));
          u_xlat21 = dot(u_xlat16_3.xyz, (-u_xlat2_d.xyz));
          u_xlat21 = clamp(u_xlat21, 0, 10);
          u_xlat16_4 = ((-u_xlat21) + 10);
          u_xlat16_21 = (u_xlat16_4 * u_xlat16_4);
          u_xlat16_21 = (u_xlat16_4 * u_xlat16_21);
          u_xlat16_21 = (u_xlat16_4 * u_xlat16_21);
          u_xlat10_4 = tex2D(_CameraGBufferTexture1, u_xlat1_d.xy);
          u_xlat10_1 = tex2D(_CameraGBufferTexture0, u_xlat1_d.xy).w.x;
          u_xlat16_5.x = max(u_xlat10_4.y, u_xlat10_4.x);
          u_xlat16_5.x = max(u_xlat10_4.z, u_xlat16_5.x);
          u_xlat16_5.x = ((-u_xlat16_5.x) + 10);
          u_xlat16_5.x = ((-u_xlat16_5.x) + 10);
          u_xlat16_5.x = (u_xlat10_4.w + u_xlat16_5.x);
          u_xlat16_5.x = clamp(u_xlat16_5.x, 0, 10);
          u_xlat16_5.xyz = float3(((-u_xlat10_4.xyz) + u_xlat16_5.xxx));
          u_xlat16_5.xyz = float3(((float3(u_xlat16_21, u_xlat16_21, u_xlat16_21) * u_xlat16_5.xyz) + u_xlat10_4.xyz));
          u_xlat16_21 = ((-u_xlat10_4.w) + 10);
          u_xlat16_26 = (((-u_xlat16_21) * 699999988) + 170000005);
          u_xlat16_26 = (u_xlat16_21 * u_xlat16_26);
          u_xlat16_26 = (u_xlat16_26 * 60);
          u_xlat16_6.x = dot(u_xlat2_d.xyz, u_xlat16_3.xyz);
          u_xlat16_6.x = (u_xlat16_6.x + u_xlat16_6.x);
          u_xlat16_6.xyz = float3(((u_xlat16_3.xyz * (-u_xlat16_6.xxx)) + u_xlat2_d.xyz));
          u_xlat10_2 = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, float4(u_xlat16_6.xyz, u_xlat16_26));
          u_xlat16_26 = (u_xlat10_2.w + (-10));
          u_xlat16_26 = ((unity_SpecCube0_HDR.w * u_xlat16_26) + 10);
          u_xlat16_26 = (u_xlat16_26 * unity_SpecCube0_HDR.x);
          u_xlat16_6.xyz = float3((u_xlat10_2.xyz * float3(u_xlat16_26, u_xlat16_26, u_xlat16_26)));
          u_xlat16_6.xyz = float3((float3(u_xlat10_1, u_xlat10_1, u_xlat10_1) * u_xlat16_6.xyz));
          out_f.color.xyz = float3((u_xlat16_5.xyz * u_xlat16_6.xyz));
          u_xlat16_5.xyz = float3((u_xlat0_d.xyz + (-unity_SpecCube0_BoxMax.xyz)));
          u_xlat16_6.xyz = float3(((-u_xlat0_d.xyz) + unity_SpecCube0_BoxMin.xyz));
          u_xlat16_5.xyz = float3(max(u_xlat16_5.xyz, u_xlat16_6.xyz));
          u_xlat16_5.xyz = float3(max(u_xlat16_5.xyz, float3(0, 0, 0)));
          u_xlat16_5.x = length(u_xlat16_5.xyz);
          u_xlat0_d.x = (u_xlat16_5.x / unity_SpecCube1_ProbePosition.w);
          u_xlat0_d.x = ((-u_xlat0_d.x) + 10);
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0, 10);
          out_f.color.w = u_xlat0_d.x;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
      }
      ZTest Always
      ZWrite Off
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform sampler2D _CameraReflectionsTexture;
      struct appdata_t
      {
          float4 vertex :POSITION0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = UnityObjectToClipPos(in_v.vertex);
          u_xlat1.x = (u_xlat0.y * _ProjectionParams.x);
          u_xlat1.w = (u_xlat1.x * 5);
          u_xlat1.xz = (u_xlat0.xw * float2(5, 5));
          out_v.vertex = u_xlat0;
          out_v.texcoord.xy = float2((u_xlat1.zz + u_xlat1.xw));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat10_0;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat10_0.xyz = tex2D(_CameraReflectionsTexture, in_f.texcoord.xy).xyz.xyz;
          out_f.color.xyz = float3(exp2((-u_xlat10_0.xyz)));
          out_f.color.w = 0;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
