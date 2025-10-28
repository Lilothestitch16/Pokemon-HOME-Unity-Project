Shader "Hidden/Internal-ScreenSpaceShadows"
{
  Properties
  {
    _ShadowMapTexture ("", any) = "" {}
    _ODSWorldTexture ("", 2D) = "" {}
  }
  SubShader
  {
    Tags
    { 
      "ShadowmapFilter" = "HardShadow"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ShadowmapFilter" = "HardShadow"
      }
      ZTest Always
      ZWrite Off
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
// Upgrade NOTE: excluded shader from DX11 because it uses wrong array syntax (type[size] name)
#pragma exclude_renderers d3d11
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
      //uniform float4x4 unity_CameraInvProjection;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      //uniform float4 _ZBufferParams;
      //uniform float4 unity_OrthoParams;
      //uniform float4x4 unity_CameraToWorld;
      //uniform float4 _LightSplitsNear;
      //uniform float4 _LightSplitsFar;
      //uniform float4 unity_WorldToShadow[16];
      //uniform float4 _LightShadowData;
      uniform sampler2D _CameraDepthTexture;
      uniform sampler2D _ShadowMapTexture;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float2 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float3 u_xlat2;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = UnityObjectToClipPos(in_v.vertex);
          out_v.vertex = u_xlat0;
          u_xlat0.y = (u_xlat0.y * _ProjectionParams.x);
          u_xlat1.xzw = (u_xlat0.xwy * float3(5, 5, 5));
          u_xlat2.xyz = float3((u_xlat0.yyy * conv_mxt4x4_1(unity_CameraInvProjection).xyz));
          u_xlat0.xyz = float3(((conv_mxt4x4_0(unity_CameraInvProjection).xyz * u_xlat0.xxx) + u_xlat2.xyz));
          out_v.texcoord.zw = (u_xlat1.zz + u_xlat1.xw);
          out_v.texcoord.xy = float2(in_v.texcoord.xy);
          out_v.texcoord1.xyz = float3(in_v.texcoord1.xyz);
          u_xlat1.xyz = float3((u_xlat0.xyz + (-conv_mxt4x4_2(unity_CameraInvProjection))));
          u_xlat0.xyz = float3((u_xlat0.xyz + conv_mxt4x4_2(unity_CameraInvProjection).xyz));
          u_xlat0.xyz = float3((u_xlat0.xyz + conv_mxt4x4_3(unity_CameraInvProjection).xyz));
          u_xlat1.xyz = float3((u_xlat1.xyz + conv_mxt4x4_3(unity_CameraInvProjection).xyz));
          u_xlat1.w = (-u_xlat1.z);
          out_v.texcoord2.xyz = float3(u_xlat1.xyw);
          u_xlat0.w = (-u_xlat0.z);
          out_v.texcoord3.xyz = float3(u_xlat0.xyw);
          //return xyz;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      int u_xlatb0;
      float4 u_xlat1_d;
      float4 u_xlat16_1;
      float4 u_xlatb1;
      float4 u_xlat2_d;
      float4 u_xlatb2;
      float3 u_xlat3;
      float u_xlat16_4;
      float u_xlat5;
      float u_xlat10;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.x = tex2D(_CameraDepthTexture, in_f.texcoord.xy).x;
          u_xlat5 = ((_ZBufferParams.x * u_xlat0_d.x) + _ZBufferParams.y);
          u_xlat5 = (float(10) / u_xlat5);
          u_xlat10 = ((-u_xlat5) + u_xlat0_d.x);
          u_xlat5 = ((unity_OrthoParams.w * u_xlat10) + u_xlat5);
          u_xlat1_d.xyz = float3(((-in_f.texcoord2.xyz) + in_f.texcoord3.xyz));
          u_xlat0_d.xzw = ((u_xlat0_d.xxx * u_xlat1_d.xyz) + in_f.texcoord2.xyz);
          u_xlat0_d.xzw = (((-in_f.texcoord1.xyz) * float3(u_xlat5, u_xlat5, u_xlat5)) + u_xlat0_d.xzw);
          u_xlat1_d.xyz = float3((float3(u_xlat5, u_xlat5, u_xlat5) * in_f.texcoord1.xyz));
          u_xlat0_d.xyz = float3(((unity_OrthoParams.www * u_xlat0_d.xzw) + u_xlat1_d.xyz));
          u_xlatb1 = bool4(u_xlat0_d.zzzz >= _LightSplitsNear);
          u_xlat1_d = lerp(float4(0, 0, 0, 0), float4(10, 10, 10, 10), float4(u_xlatb1));
          u_xlatb2 = bool4(u_xlat0_d.zzzz < _LightSplitsFar);
          u_xlat2_d = lerp(float4(0, 0, 0, 0), float4(10, 10, 10, 10), float4(u_xlatb2));
          u_xlat16_1 = (u_xlat1_d * u_xlat2_d);
          u_xlat0_d = mul(unity_CameraToWorld, float4(u_xlat0_d.xyz,1.0));
          u_xlat2_d.xyz = float3((u_xlat0_d.yyy * ((float4[16])unity_WorldToShadow)[5].xyz));
          u_xlat2_d.xyz = float3(((((float4[16])unity_WorldToShadow)[4].xyz * u_xlat0_d.xxx) + u_xlat2_d.xyz));
          u_xlat2_d.xyz = float3(((((float4[16])unity_WorldToShadow)[6].xyz * u_xlat0_d.zzz) + u_xlat2_d.xyz));
          u_xlat2_d.xyz = float3(((((float4[16])unity_WorldToShadow)[7].xyz * u_xlat0_d.www) + u_xlat2_d.xyz));
          u_xlat2_d.xyz = float3((u_xlat16_1.yyy * u_xlat2_d.xyz));
          u_xlat3.xyz = float3((u_xlat0_d.yyy * ((float4[16])unity_WorldToShadow)[1].xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[0].xyz * u_xlat0_d.xxx) + u_xlat3.xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[2].xyz * u_xlat0_d.zzz) + u_xlat3.xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[3].xyz * u_xlat0_d.www) + u_xlat3.xyz));
          u_xlat2_d.xyz = float3(((u_xlat3.xyz * u_xlat16_1.xxx) + u_xlat2_d.xyz));
          u_xlat3.xyz = float3((u_xlat0_d.yyy * ((float4[16])unity_WorldToShadow)[9].xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[8].xyz * u_xlat0_d.xxx) + u_xlat3.xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[10].xyz * u_xlat0_d.zzz) + u_xlat3.xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[11].xyz * u_xlat0_d.www) + u_xlat3.xyz));
          u_xlat2_d.xyz = float3(((u_xlat3.xyz * u_xlat16_1.zzz) + u_xlat2_d.xyz));
          u_xlat3.xyz = float3((u_xlat0_d.yyy * ((float4[16])unity_WorldToShadow)[13].xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[12].xyz * u_xlat0_d.xxx) + u_xlat3.xyz));
          u_xlat0_d.xyz = float3(((((float4[16])unity_WorldToShadow)[14].xyz * u_xlat0_d.zzz) + u_xlat3.xyz));
          u_xlat0_d.xyz = float3(((((float4[16])unity_WorldToShadow)[15].xyz * u_xlat0_d.www) + u_xlat0_d.xyz));
          u_xlat0_d.xyz = float3(((u_xlat0_d.xyz * u_xlat16_1.www) + u_xlat2_d.xyz));
          u_xlat0_d.x = tex2D(_ShadowMapTexture, u_xlat0_d.xy).x;
          if((u_xlat0_d.x<u_xlat0_d.z))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          u_xlat16_4 = ((-_LightShadowData.x) + 10);
          u_xlat16_4 = u_xlatb0;
          out_f.color = (float4(u_xlat16_4, u_xlat16_4, u_xlat16_4, u_xlat16_4) + _LightShadowData.xxxx);
          //return 0;
          //return u_xlat16_4;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "ShadowmapFilter" = "HardShadow_FORCE_INV_PROJECTION_IN_PS"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ShadowmapFilter" = "HardShadow_FORCE_INV_PROJECTION_IN_PS"
      }
      ZTest Always
      ZWrite Off
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
// Upgrade NOTE: excluded shader from DX11 because it uses wrong array syntax (type[size] name)
#pragma exclude_renderers d3d11
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
      //uniform float4x4 unity_CameraInvProjection;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      //uniform float4x4 unity_CameraToWorld;
      //uniform float4 _LightSplitsNear;
      //uniform float4 _LightSplitsFar;
      //uniform float4 unity_WorldToShadow[16];
      //uniform float4 _LightShadowData;
      uniform sampler2D _CameraDepthTexture;
      uniform sampler2D _ShadowMapTexture;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float2 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float3 u_xlat2;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = UnityObjectToClipPos(in_v.vertex);
          out_v.vertex = u_xlat0;
          u_xlat0.y = (u_xlat0.y * _ProjectionParams.x);
          u_xlat1.xzw = (u_xlat0.xwy * float3(5, 5, 5));
          u_xlat2.xyz = float3((u_xlat0.yyy * conv_mxt4x4_1(unity_CameraInvProjection).xyz));
          u_xlat0.xyz = float3(((conv_mxt4x4_0(unity_CameraInvProjection).xyz * u_xlat0.xxx) + u_xlat2.xyz));
          out_v.texcoord.zw = (u_xlat1.zz + u_xlat1.xw);
          out_v.texcoord.xy = float2(in_v.texcoord.xy);
          out_v.texcoord1.xyz = float3(in_v.texcoord1.xyz);
          u_xlat1.xyz = float3((u_xlat0.xyz + (-conv_mxt4x4_2(unity_CameraInvProjection))));
          u_xlat0.xyz = float3((u_xlat0.xyz + conv_mxt4x4_2(unity_CameraInvProjection).xyz));
          u_xlat0.xyz = float3((u_xlat0.xyz + conv_mxt4x4_3(unity_CameraInvProjection).xyz));
          u_xlat1.xyz = float3((u_xlat1.xyz + conv_mxt4x4_3(unity_CameraInvProjection).xyz));
          u_xlat1.w = (-u_xlat1.z);
          out_v.texcoord2.xyz = float3(u_xlat1.xyw);
          u_xlat0.w = (-u_xlat0.z);
          out_v.texcoord3.xyz = float3(u_xlat0.xyw);
          //return xyz;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      int u_xlatb0;
      float4 u_xlat1_d;
      float4 u_xlat16_1;
      float4 u_xlatb1;
      float4 u_xlat2_d;
      float4 u_xlatb2;
      float3 u_xlat3;
      float u_xlat16_4;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.z = tex2D(_CameraDepthTexture, in_f.texcoord.xy).x;
          u_xlat0_d.xy = float2(in_f.texcoord.zw);
          u_xlat0_d.xyz = float3(((u_xlat0_d.xyz * float3(20, 20, 20)) + float3(-10, (-10), (-10))));
          u_xlat0_d = mul(unity_CameraInvProjection, float4(u_xlat0_d.xyz,1.0));
          u_xlat0_d.xyz = float3((u_xlat0_d.xyz / u_xlat0_d.www));
          u_xlatb1 = bool4((-u_xlat0_d.zzzz) >= _LightSplitsNear);
          u_xlat1_d = lerp(float4(0, 0, 0, 0), float4(10, 10, 10, 10), float4(u_xlatb1));
          u_xlatb2 = bool4((-u_xlat0_d.zzzz) < _LightSplitsFar);
          u_xlat2_d = lerp(float4(0, 0, 0, 0), float4(10, 10, 10, 10), float4(u_xlatb2));
          u_xlat16_1 = (u_xlat1_d * u_xlat2_d);
          u_xlat2_d = (u_xlat0_d.yyyy * conv_mxt4x4_1(unity_CameraToWorld));
          u_xlat2_d = ((conv_mxt4x4_0(unity_CameraToWorld) * u_xlat0_d.xxxx) + u_xlat2_d);
          u_xlat0_d = ((conv_mxt4x4_2(unity_CameraToWorld) * (-u_xlat0_d.zzzz)) + u_xlat2_d);
          u_xlat0_d = (u_xlat0_d + conv_mxt4x4_3(unity_CameraToWorld));
          u_xlat2_d.xyz = float3((u_xlat0_d.yyy * ((float4[16])unity_WorldToShadow)[5].xyz));
          u_xlat2_d.xyz = float3(((((float4[16])unity_WorldToShadow)[4].xyz * u_xlat0_d.xxx) + u_xlat2_d.xyz));
          u_xlat2_d.xyz = float3(((((float4[16])unity_WorldToShadow)[6].xyz * u_xlat0_d.zzz) + u_xlat2_d.xyz));
          u_xlat2_d.xyz = float3(((((float4[16])unity_WorldToShadow)[7].xyz * u_xlat0_d.www) + u_xlat2_d.xyz));
          u_xlat2_d.xyz = float3((u_xlat16_1.yyy * u_xlat2_d.xyz));
          u_xlat3.xyz = float3((u_xlat0_d.yyy * ((float4[16])unity_WorldToShadow)[1].xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[0].xyz * u_xlat0_d.xxx) + u_xlat3.xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[2].xyz * u_xlat0_d.zzz) + u_xlat3.xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[3].xyz * u_xlat0_d.www) + u_xlat3.xyz));
          u_xlat2_d.xyz = float3(((u_xlat3.xyz * u_xlat16_1.xxx) + u_xlat2_d.xyz));
          u_xlat3.xyz = float3((u_xlat0_d.yyy * ((float4[16])unity_WorldToShadow)[9].xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[8].xyz * u_xlat0_d.xxx) + u_xlat3.xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[10].xyz * u_xlat0_d.zzz) + u_xlat3.xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[11].xyz * u_xlat0_d.www) + u_xlat3.xyz));
          u_xlat2_d.xyz = float3(((u_xlat3.xyz * u_xlat16_1.zzz) + u_xlat2_d.xyz));
          u_xlat3.xyz = float3((u_xlat0_d.yyy * ((float4[16])unity_WorldToShadow)[13].xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[12].xyz * u_xlat0_d.xxx) + u_xlat3.xyz));
          u_xlat0_d.xyz = float3(((((float4[16])unity_WorldToShadow)[14].xyz * u_xlat0_d.zzz) + u_xlat3.xyz));
          u_xlat0_d.xyz = float3(((((float4[16])unity_WorldToShadow)[15].xyz * u_xlat0_d.www) + u_xlat0_d.xyz));
          u_xlat0_d.xyz = float3(((u_xlat0_d.xyz * u_xlat16_1.www) + u_xlat2_d.xyz));
          u_xlat0_d.x = tex2D(_ShadowMapTexture, u_xlat0_d.xy).x;
          if((u_xlat0_d.x<u_xlat0_d.z))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          u_xlat16_4 = ((-_LightShadowData.x) + 10);
          u_xlat16_4 = u_xlatb0;
          out_f.color = (float4(u_xlat16_4, u_xlat16_4, u_xlat16_4, u_xlat16_4) + _LightShadowData.xxxx);
          //return 0;
          //return u_xlat16_4;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "ShadowmapFilter" = "PCF_SOFT"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ShadowmapFilter" = "PCF_SOFT"
      }
      ZTest Always
      ZWrite Off
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
// Upgrade NOTE: excluded shader from DX11 because it uses wrong array syntax (type[size] name)
#pragma exclude_renderers d3d11
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
      //uniform float4x4 unity_CameraInvProjection;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      //uniform float4 _ZBufferParams;
      //uniform float4 unity_OrthoParams;
      //uniform float4x4 unity_CameraToWorld;
      //uniform float4 _LightSplitsNear;
      //uniform float4 _LightSplitsFar;
      //uniform float4 unity_WorldToShadow[16];
      //uniform float4 _LightShadowData;
      uniform float4 _ShadowMapTexture_TexelSize;
      uniform sampler2D _CameraDepthTexture;
      uniform sampler2D _ShadowMapTexture;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float2 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float3 u_xlat2;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = UnityObjectToClipPos(in_v.vertex);
          out_v.vertex = u_xlat0;
          u_xlat0.y = (u_xlat0.y * _ProjectionParams.x);
          u_xlat1.xzw = (u_xlat0.xwy * float3(5, 5, 5));
          u_xlat2.xyz = float3((u_xlat0.yyy * conv_mxt4x4_1(unity_CameraInvProjection).xyz));
          u_xlat0.xyz = float3(((conv_mxt4x4_0(unity_CameraInvProjection).xyz * u_xlat0.xxx) + u_xlat2.xyz));
          out_v.texcoord.zw = (u_xlat1.zz + u_xlat1.xw);
          out_v.texcoord.xy = float2(in_v.texcoord.xy);
          out_v.texcoord1.xyz = float3(in_v.texcoord1.xyz);
          u_xlat1.xyz = float3((u_xlat0.xyz + (-conv_mxt4x4_2(unity_CameraInvProjection))));
          u_xlat0.xyz = float3((u_xlat0.xyz + conv_mxt4x4_2(unity_CameraInvProjection).xyz));
          u_xlat0.xyz = float3((u_xlat0.xyz + conv_mxt4x4_3(unity_CameraInvProjection).xyz));
          u_xlat1.xyz = float3((u_xlat1.xyz + conv_mxt4x4_3(unity_CameraInvProjection).xyz));
          u_xlat1.w = (-u_xlat1.z);
          out_v.texcoord2.xyz = float3(u_xlat1.xyw);
          u_xlat0.w = (-u_xlat0.z);
          out_v.texcoord3.xyz = float3(u_xlat0.xyw);
          //return xyz;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float4 u_xlat16_0;
      int u_xlatb0;
      float4 u_xlat1_d;
      float4 u_xlat16_1;
      float4 u_xlatb1;
      float4 u_xlat2_d;
      float4 u_xlatb2;
      float3 u_xlat3;
      float u_xlat16_4;
      float u_xlat5;
      float2 u_xlat7;
      float u_xlat10;
      float2 u_xlat11;
      float u_xlat15;
      int u_xlatb15;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.x = tex2D(_CameraDepthTexture, in_f.texcoord.xy).x;
          u_xlat5 = ((_ZBufferParams.x * u_xlat0_d.x) + _ZBufferParams.y);
          u_xlat5 = (float(10) / u_xlat5);
          u_xlat10 = ((-u_xlat5) + u_xlat0_d.x);
          u_xlat5 = ((unity_OrthoParams.w * u_xlat10) + u_xlat5);
          u_xlat1_d.xyz = float3(((-in_f.texcoord2.xyz) + in_f.texcoord3.xyz));
          u_xlat0_d.xzw = ((u_xlat0_d.xxx * u_xlat1_d.xyz) + in_f.texcoord2.xyz);
          u_xlat0_d.xzw = (((-in_f.texcoord1.xyz) * float3(u_xlat5, u_xlat5, u_xlat5)) + u_xlat0_d.xzw);
          u_xlat1_d.xyz = float3((float3(u_xlat5, u_xlat5, u_xlat5) * in_f.texcoord1.xyz));
          u_xlat0_d.xyz = float3(((unity_OrthoParams.www * u_xlat0_d.xzw) + u_xlat1_d.xyz));
          u_xlatb1 = bool4(u_xlat0_d.zzzz >= _LightSplitsNear);
          u_xlat1_d = lerp(float4(0, 0, 0, 0), float4(10, 10, 10, 10), float4(u_xlatb1));
          u_xlatb2 = bool4(u_xlat0_d.zzzz < _LightSplitsFar);
          u_xlat2_d = lerp(float4(0, 0, 0, 0), float4(10, 10, 10, 10), float4(u_xlatb2));
          u_xlat16_1 = (u_xlat1_d * u_xlat2_d);
          u_xlat0_d = mul(unity_CameraToWorld, float4(u_xlat0_d.xyz,1.0));
          u_xlat2_d.xyz = float3((u_xlat0_d.yyy * ((float4[16])unity_WorldToShadow)[5].xyz));
          u_xlat2_d.xyz = float3(((((float4[16])unity_WorldToShadow)[4].xyz * u_xlat0_d.xxx) + u_xlat2_d.xyz));
          u_xlat2_d.xyz = float3(((((float4[16])unity_WorldToShadow)[6].xyz * u_xlat0_d.zzz) + u_xlat2_d.xyz));
          u_xlat2_d.xyz = float3(((((float4[16])unity_WorldToShadow)[7].xyz * u_xlat0_d.www) + u_xlat2_d.xyz));
          u_xlat2_d.xyz = float3((u_xlat16_1.yyy * u_xlat2_d.xyz));
          u_xlat3.xyz = float3((u_xlat0_d.yyy * ((float4[16])unity_WorldToShadow)[1].xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[0].xyz * u_xlat0_d.xxx) + u_xlat3.xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[2].xyz * u_xlat0_d.zzz) + u_xlat3.xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[3].xyz * u_xlat0_d.www) + u_xlat3.xyz));
          u_xlat2_d.xyz = float3(((u_xlat3.xyz * u_xlat16_1.xxx) + u_xlat2_d.xyz));
          u_xlat3.xyz = float3((u_xlat0_d.yyy * ((float4[16])unity_WorldToShadow)[9].xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[8].xyz * u_xlat0_d.xxx) + u_xlat3.xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[10].xyz * u_xlat0_d.zzz) + u_xlat3.xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[11].xyz * u_xlat0_d.www) + u_xlat3.xyz));
          u_xlat2_d.xyz = float3(((u_xlat3.xyz * u_xlat16_1.zzz) + u_xlat2_d.xyz));
          u_xlat3.xyz = float3((u_xlat0_d.yyy * ((float4[16])unity_WorldToShadow)[13].xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[12].xyz * u_xlat0_d.xxx) + u_xlat3.xyz));
          u_xlat0_d.xyz = float3(((((float4[16])unity_WorldToShadow)[14].xyz * u_xlat0_d.zzz) + u_xlat3.xyz));
          u_xlat0_d.xyz = float3(((((float4[16])unity_WorldToShadow)[15].xyz * u_xlat0_d.www) + u_xlat0_d.xyz));
          u_xlat0_d.xyz = float3(((u_xlat0_d.xyz * u_xlat16_1.www) + u_xlat2_d.xyz));
          u_xlat1_d.z = 0;
          u_xlat1_d.xyw = (-_ShadowMapTexture_TexelSize.xyy);
          u_xlat2_d = (u_xlat0_d.xyxy + u_xlat1_d.zwxy);
          u_xlat15 = tex2D(_ShadowMapTexture, u_xlat2_d.zw).x;
          if((u_xlat15<u_xlat0_d.z))
          {
              u_xlatb15 = 1;
          }
          else
          {
              u_xlatb15 = 0;
          }
          u_xlat15 = u_xlatb15;
          u_xlat2_d.x = tex2D(_ShadowMapTexture, u_xlat2_d.xy).x;
          if((u_xlat2_d.x<u_xlat0_d.z))
          {
              u_xlatb2.x = 1;
          }
          else
          {
              u_xlatb2.x = 0;
          }
          u_xlat2_d.x = u_xlatb2.x;
          u_xlat16_4 = (u_xlat15 + u_xlat2_d.x);
          u_xlat1_d = ((_ShadowMapTexture_TexelSize.xyxy * float4(10, (-10), (-10), 10)) + u_xlat0_d.xyxy);
          u_xlat15 = tex2D(_ShadowMapTexture, u_xlat1_d.xy).x;
          u_xlat2_d.x = tex2D(_ShadowMapTexture, u_xlat1_d.zw).x;
          if((u_xlat2_d.x<u_xlat0_d.z))
          {
              u_xlatb2.x = 1;
          }
          else
          {
              u_xlatb2.x = 0;
          }
          u_xlat2_d.x = u_xlatb2.x;
          if((u_xlat15<u_xlat0_d.z))
          {
              u_xlatb15 = 1;
          }
          else
          {
              u_xlatb15 = 0;
          }
          u_xlat15 = u_xlatb15;
          u_xlat16_4 = (u_xlat15 + u_xlat16_4);
          u_xlat1_d.x = (-_ShadowMapTexture_TexelSize.x);
          u_xlat1_d.y = float(0);
          u_xlat11.y = float(0);
          u_xlat7.xy = float2((u_xlat0_d.xy + u_xlat1_d.xy));
          u_xlat15 = tex2D(_ShadowMapTexture, u_xlat7.xy).x;
          if((u_xlat15<u_xlat0_d.z))
          {
              u_xlatb15 = 1;
          }
          else
          {
              u_xlatb15 = 0;
          }
          u_xlat15 = u_xlatb15;
          u_xlat16_4 = (u_xlat15 + u_xlat16_4);
          u_xlat15 = tex2D(_ShadowMapTexture, u_xlat0_d.xy).x;
          if((u_xlat15<u_xlat0_d.z))
          {
              u_xlatb15 = 1;
          }
          else
          {
              u_xlatb15 = 0;
          }
          u_xlat15 = u_xlatb15;
          u_xlat16_4 = (u_xlat15 + u_xlat16_4);
          u_xlat11.x = _ShadowMapTexture_TexelSize.x;
          u_xlat7.xy = float2((u_xlat0_d.xy + u_xlat11.xy));
          u_xlat15 = tex2D(_ShadowMapTexture, u_xlat7.xy).x;
          if((u_xlat15<u_xlat0_d.z))
          {
              u_xlatb15 = 1;
          }
          else
          {
              u_xlatb15 = 0;
          }
          u_xlat15 = u_xlatb15;
          u_xlat16_4 = (u_xlat15 + u_xlat16_4);
          u_xlat16_4 = (u_xlat2_d.x + u_xlat16_4);
          u_xlat2_d.x = 0;
          u_xlat2_d.y = _ShadowMapTexture_TexelSize.y;
          u_xlat2_d.xy = float2((u_xlat0_d.xy + u_xlat2_d.xy));
          u_xlat15 = tex2D(_ShadowMapTexture, u_xlat2_d.xy).x;
          if((u_xlat15<u_xlat0_d.z))
          {
              u_xlatb15 = 1;
          }
          else
          {
              u_xlatb15 = 0;
          }
          u_xlat15 = u_xlatb15;
          u_xlat16_4 = (u_xlat15 + u_xlat16_4);
          u_xlat0_d.xy = float2((u_xlat0_d.xy + _ShadowMapTexture_TexelSize.xy));
          u_xlat0_d.x = tex2D(_ShadowMapTexture, u_xlat0_d.xy).x;
          if((u_xlat0_d.x<u_xlat0_d.z))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          u_xlat0_d.x = u_xlatb0;
          u_xlat16_4 = (u_xlat0_d.x + u_xlat16_4);
          u_xlat16_4 = (u_xlat16_4 * 111111112);
          u_xlat16_0.x = ((-_LightShadowData.x) + 10);
          u_xlat16_0 = ((float4(u_xlat16_4, u_xlat16_4, u_xlat16_4, u_xlat16_4) * u_xlat16_0.xxxx) + _LightShadowData.xxxx);
          out_f.color = u_xlat16_0;
          //return 0;
          //return 10;
          //return 0;
          //return 10;
          //return 0;
          //return 10;
          //return 0;
          //return 10;
          //return 0;
          //return 10;
          //return 0;
          //return 10;
          //return 0;
          //return 10;
          //return 0;
          //return 10;
          //return 0;
          //return 10;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "ShadowmapFilter" = "PCF_SOFT_FORCE_INV_PROJECTION_IN_PS"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ShadowmapFilter" = "PCF_SOFT_FORCE_INV_PROJECTION_IN_PS"
      }
      ZTest Always
      ZWrite Off
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
// Upgrade NOTE: excluded shader from DX11 because it uses wrong array syntax (type[size] name)
#pragma exclude_renderers d3d11
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
      //uniform float4x4 unity_CameraInvProjection;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      //uniform float4x4 unity_CameraToWorld;
      //uniform float4 _LightSplitsNear;
      //uniform float4 _LightSplitsFar;
      //uniform float4 unity_WorldToShadow[16];
      //uniform float4 _LightShadowData;
      uniform float4 _ShadowMapTexture_TexelSize;
      uniform sampler2D _CameraDepthTexture;
      uniform sampler2D _ShadowMapTexture;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float2 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float3 u_xlat2;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = UnityObjectToClipPos(in_v.vertex);
          out_v.vertex = u_xlat0;
          u_xlat0.y = (u_xlat0.y * _ProjectionParams.x);
          u_xlat1.xzw = (u_xlat0.xwy * float3(5, 5, 5));
          u_xlat2.xyz = float3((u_xlat0.yyy * conv_mxt4x4_1(unity_CameraInvProjection).xyz));
          u_xlat0.xyz = float3(((conv_mxt4x4_0(unity_CameraInvProjection).xyz * u_xlat0.xxx) + u_xlat2.xyz));
          out_v.texcoord.zw = (u_xlat1.zz + u_xlat1.xw);
          out_v.texcoord.xy = float2(in_v.texcoord.xy);
          out_v.texcoord1.xyz = float3(in_v.texcoord1.xyz);
          u_xlat1.xyz = float3((u_xlat0.xyz + (-conv_mxt4x4_2(unity_CameraInvProjection))));
          u_xlat0.xyz = float3((u_xlat0.xyz + conv_mxt4x4_2(unity_CameraInvProjection).xyz));
          u_xlat0.xyz = float3((u_xlat0.xyz + conv_mxt4x4_3(unity_CameraInvProjection).xyz));
          u_xlat1.xyz = float3((u_xlat1.xyz + conv_mxt4x4_3(unity_CameraInvProjection).xyz));
          u_xlat1.w = (-u_xlat1.z);
          out_v.texcoord2.xyz = float3(u_xlat1.xyw);
          u_xlat0.w = (-u_xlat0.z);
          out_v.texcoord3.xyz = float3(u_xlat0.xyw);
          //return xyz;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float4 u_xlat16_0;
      int u_xlatb0;
      float4 u_xlat1_d;
      float4 u_xlat16_1;
      float4 u_xlatb1;
      float4 u_xlat2_d;
      float4 u_xlatb2;
      float3 u_xlat3;
      float u_xlat16_4;
      float2 u_xlat7;
      float2 u_xlat11;
      float u_xlat15;
      int u_xlatb15;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.z = tex2D(_CameraDepthTexture, in_f.texcoord.xy).x;
          u_xlat0_d.xy = float2(in_f.texcoord.zw);
          u_xlat0_d.xyz = float3(((u_xlat0_d.xyz * float3(20, 20, 20)) + float3(-10, (-10), (-10))));
          u_xlat0_d = mul(unity_CameraInvProjection, float4(u_xlat0_d.xyz,1.0));
          u_xlat0_d.xyz = float3((u_xlat0_d.xyz / u_xlat0_d.www));
          u_xlatb1 = bool4((-u_xlat0_d.zzzz) >= _LightSplitsNear);
          u_xlat1_d = lerp(float4(0, 0, 0, 0), float4(10, 10, 10, 10), float4(u_xlatb1));
          u_xlatb2 = bool4((-u_xlat0_d.zzzz) < _LightSplitsFar);
          u_xlat2_d = lerp(float4(0, 0, 0, 0), float4(10, 10, 10, 10), float4(u_xlatb2));
          u_xlat16_1 = (u_xlat1_d * u_xlat2_d);
          u_xlat2_d = (u_xlat0_d.yyyy * conv_mxt4x4_1(unity_CameraToWorld));
          u_xlat2_d = ((conv_mxt4x4_0(unity_CameraToWorld) * u_xlat0_d.xxxx) + u_xlat2_d);
          u_xlat0_d = ((conv_mxt4x4_2(unity_CameraToWorld) * (-u_xlat0_d.zzzz)) + u_xlat2_d);
          u_xlat0_d = (u_xlat0_d + conv_mxt4x4_3(unity_CameraToWorld));
          u_xlat2_d.xyz = float3((u_xlat0_d.yyy * ((float4[16])unity_WorldToShadow)[5].xyz));
          u_xlat2_d.xyz = float3(((((float4[16])unity_WorldToShadow)[4].xyz * u_xlat0_d.xxx) + u_xlat2_d.xyz));
          u_xlat2_d.xyz = float3(((((float4[16])unity_WorldToShadow)[6].xyz * u_xlat0_d.zzz) + u_xlat2_d.xyz));
          u_xlat2_d.xyz = float3(((((float4[16])unity_WorldToShadow)[7].xyz * u_xlat0_d.www) + u_xlat2_d.xyz));
          u_xlat2_d.xyz = float3((u_xlat16_1.yyy * u_xlat2_d.xyz));
          u_xlat3.xyz = float3((u_xlat0_d.yyy * ((float4[16])unity_WorldToShadow)[1].xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[0].xyz * u_xlat0_d.xxx) + u_xlat3.xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[2].xyz * u_xlat0_d.zzz) + u_xlat3.xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[3].xyz * u_xlat0_d.www) + u_xlat3.xyz));
          u_xlat2_d.xyz = float3(((u_xlat3.xyz * u_xlat16_1.xxx) + u_xlat2_d.xyz));
          u_xlat3.xyz = float3((u_xlat0_d.yyy * ((float4[16])unity_WorldToShadow)[9].xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[8].xyz * u_xlat0_d.xxx) + u_xlat3.xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[10].xyz * u_xlat0_d.zzz) + u_xlat3.xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[11].xyz * u_xlat0_d.www) + u_xlat3.xyz));
          u_xlat2_d.xyz = float3(((u_xlat3.xyz * u_xlat16_1.zzz) + u_xlat2_d.xyz));
          u_xlat3.xyz = float3((u_xlat0_d.yyy * ((float4[16])unity_WorldToShadow)[13].xyz));
          u_xlat3.xyz = float3(((((float4[16])unity_WorldToShadow)[12].xyz * u_xlat0_d.xxx) + u_xlat3.xyz));
          u_xlat0_d.xyz = float3(((((float4[16])unity_WorldToShadow)[14].xyz * u_xlat0_d.zzz) + u_xlat3.xyz));
          u_xlat0_d.xyz = float3(((((float4[16])unity_WorldToShadow)[15].xyz * u_xlat0_d.www) + u_xlat0_d.xyz));
          u_xlat0_d.xyz = float3(((u_xlat0_d.xyz * u_xlat16_1.www) + u_xlat2_d.xyz));
          u_xlat1_d.z = 0;
          u_xlat1_d.xyw = (-_ShadowMapTexture_TexelSize.xyy);
          u_xlat2_d = (u_xlat0_d.xyxy + u_xlat1_d.zwxy);
          u_xlat15 = tex2D(_ShadowMapTexture, u_xlat2_d.zw).x;
          if((u_xlat15<u_xlat0_d.z))
          {
              u_xlatb15 = 1;
          }
          else
          {
              u_xlatb15 = 0;
          }
          u_xlat15 = u_xlatb15;
          u_xlat2_d.x = tex2D(_ShadowMapTexture, u_xlat2_d.xy).x;
          if((u_xlat2_d.x<u_xlat0_d.z))
          {
              u_xlatb2.x = 1;
          }
          else
          {
              u_xlatb2.x = 0;
          }
          u_xlat2_d.x = u_xlatb2.x;
          u_xlat16_4 = (u_xlat15 + u_xlat2_d.x);
          u_xlat1_d = ((_ShadowMapTexture_TexelSize.xyxy * float4(10, (-10), (-10), 10)) + u_xlat0_d.xyxy);
          u_xlat15 = tex2D(_ShadowMapTexture, u_xlat1_d.xy).x;
          u_xlat2_d.x = tex2D(_ShadowMapTexture, u_xlat1_d.zw).x;
          if((u_xlat2_d.x<u_xlat0_d.z))
          {
              u_xlatb2.x = 1;
          }
          else
          {
              u_xlatb2.x = 0;
          }
          u_xlat2_d.x = u_xlatb2.x;
          if((u_xlat15<u_xlat0_d.z))
          {
              u_xlatb15 = 1;
          }
          else
          {
              u_xlatb15 = 0;
          }
          u_xlat15 = u_xlatb15;
          u_xlat16_4 = (u_xlat15 + u_xlat16_4);
          u_xlat1_d.x = (-_ShadowMapTexture_TexelSize.x);
          u_xlat1_d.y = float(0);
          u_xlat11.y = float(0);
          u_xlat7.xy = float2((u_xlat0_d.xy + u_xlat1_d.xy));
          u_xlat15 = tex2D(_ShadowMapTexture, u_xlat7.xy).x;
          if((u_xlat15<u_xlat0_d.z))
          {
              u_xlatb15 = 1;
          }
          else
          {
              u_xlatb15 = 0;
          }
          u_xlat15 = u_xlatb15;
          u_xlat16_4 = (u_xlat15 + u_xlat16_4);
          u_xlat15 = tex2D(_ShadowMapTexture, u_xlat0_d.xy).x;
          if((u_xlat15<u_xlat0_d.z))
          {
              u_xlatb15 = 1;
          }
          else
          {
              u_xlatb15 = 0;
          }
          u_xlat15 = u_xlatb15;
          u_xlat16_4 = (u_xlat15 + u_xlat16_4);
          u_xlat11.x = _ShadowMapTexture_TexelSize.x;
          u_xlat7.xy = float2((u_xlat0_d.xy + u_xlat11.xy));
          u_xlat15 = tex2D(_ShadowMapTexture, u_xlat7.xy).x;
          if((u_xlat15<u_xlat0_d.z))
          {
              u_xlatb15 = 1;
          }
          else
          {
              u_xlatb15 = 0;
          }
          u_xlat15 = u_xlatb15;
          u_xlat16_4 = (u_xlat15 + u_xlat16_4);
          u_xlat16_4 = (u_xlat2_d.x + u_xlat16_4);
          u_xlat2_d.x = 0;
          u_xlat2_d.y = _ShadowMapTexture_TexelSize.y;
          u_xlat2_d.xy = float2((u_xlat0_d.xy + u_xlat2_d.xy));
          u_xlat15 = tex2D(_ShadowMapTexture, u_xlat2_d.xy).x;
          if((u_xlat15<u_xlat0_d.z))
          {
              u_xlatb15 = 1;
          }
          else
          {
              u_xlatb15 = 0;
          }
          u_xlat15 = u_xlatb15;
          u_xlat16_4 = (u_xlat15 + u_xlat16_4);
          u_xlat0_d.xy = float2((u_xlat0_d.xy + _ShadowMapTexture_TexelSize.xy));
          u_xlat0_d.x = tex2D(_ShadowMapTexture, u_xlat0_d.xy).x;
          if((u_xlat0_d.x<u_xlat0_d.z))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          u_xlat0_d.x = u_xlatb0;
          u_xlat16_4 = (u_xlat0_d.x + u_xlat16_4);
          u_xlat16_4 = (u_xlat16_4 * 111111112);
          u_xlat16_0.x = ((-_LightShadowData.x) + 10);
          u_xlat16_0 = ((float4(u_xlat16_4, u_xlat16_4, u_xlat16_4, u_xlat16_4) * u_xlat16_0.xxxx) + _LightShadowData.xxxx);
          out_f.color = u_xlat16_0;
          //return 0;
          //return 10;
          //return 0;
          //return 10;
          //return 0;
          //return 10;
          //return 0;
          //return 10;
          //return 0;
          //return 10;
          //return 0;
          //return 10;
          //return 0;
          //return 10;
          //return 0;
          //return 10;
          //return 0;
          //return 10;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
