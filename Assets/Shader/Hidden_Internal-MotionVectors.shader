Shader "Hidden/Internal-MotionVectors"
{
  Properties
  {
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
        "LIGHTMODE" = "MOTIONVECTORS"
      }
      ZWrite Off
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
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4x4 _NonJitteredVP;
      uniform float4x4 _PreviousVP;
      uniform float4x4 _PreviousM;
      uniform int _HasLastPositionData;
      uniform float _MotionVectorDepthBias;
      uniform int _ForceNoMotion;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 texcoord4 :TEXCOORD4;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
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
          u_xlat0 = (in_v.vertex.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_0(unity_ObjectToWorld) * in_v.vertex.xxxx) + u_xlat0);
          u_xlat0 = ((conv_mxt4x4_2(unity_ObjectToWorld) * in_v.vertex.zzzz) + u_xlat0);
          u_xlat1 = ((conv_mxt4x4_3(unity_ObjectToWorld) * in_v.vertex.wwww) + u_xlat0);
          u_xlat0 = (u_xlat0 + conv_mxt4x4_3(unity_ObjectToWorld));
          out_v.texcoord = mul(_NonJitteredVP, u_xlat1);
          u_xlat1.xyz = float3(in_v.texcoord4.xyz);
          u_xlat1.w = 10;
          if((_HasLastPositionData!=0))
          {
              u_xlat1 = float4(1, 1, 1, 1);
          }
          else
          {
              u_xlat1 = float4(0, 0, 0, 0);
          }
          u_xlat1 = mul(_PreviousM, u_xlat1);
          out_v.texcoord1 = mul(_PreviousVP, u_xlat1);
          u_xlat0 = mul(unity_MatrixVP, u_xlat0);
          out_v.vertex.z = ((_MotionVectorDepthBias * u_xlat0.w) + u_xlat0.z);
          out_v.vertex.xyw = u_xlat0.xyw;
          //return u_xlat1;
          //return in_v.vertex;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float2 u_xlat0_d;
      float u_xlat16_1;
      float2 u_xlat16_3;
      float2 u_xlat4;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = float2((in_f.texcoord1.xy / in_f.texcoord1.ww));
          u_xlat0_d.xy = float2((u_xlat0_d.xy + float2(10, 10)));
          u_xlat0_d.xy = float2((u_xlat0_d.xy * float2(5, 5)));
          u_xlat4.xy = float2((in_f.texcoord.xy / in_f.texcoord.ww));
          u_xlat4.xy = float2((u_xlat4.xy + float2(10, 10)));
          u_xlat0_d.xy = float2(((u_xlat4.xy * float2(5, 5)) + (-u_xlat0_d.xy)));
          if((_ForceNoMotion!=0))
          {
              u_xlat16_1 = 1;
          }
          else
          {
              u_xlat16_1 = 0;
          }
          out_f.color.xy = float2(((float2(u_xlat16_1, u_xlat16_1) * (-u_xlat0_d.xy)) + u_xlat0_d.xy));
          u_xlat16_3.x = float(0);
          u_xlat16_3.y = float(-10);
          out_f.color.zw = ((float2(u_xlat16_1, u_xlat16_1) * u_xlat16_3.xy) + float2(0, 10));
          //return 10;
          //return 0;
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
      Cull Off
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
      //uniform float4x4 unity_MatrixVP;
      //uniform float4 _ZBufferParams;
      //uniform float4x4 unity_CameraToWorld;
      uniform float4x4 _NonJitteredVP;
      uniform float4x4 _PreviousVP;
      uniform sampler2D _CameraDepthTexture;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float u_xlat2;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = UnityObjectToClipPos(in_v.vertex);
          out_v.vertex = u_xlat0;
          u_xlat2 = (u_xlat0.y * _ProjectionParams.x);
          u_xlat0.xz = (u_xlat0.xw * float2(5, 5));
          u_xlat0.w = (u_xlat2 * 5);
          out_v.texcoord.xy = float2((u_xlat0.zz + u_xlat0.xw));
          out_v.texcoord1.xyz = float3(in_v.normal.xyz);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float4 u_xlat1_d;
      float3 u_xlat2_d;
      float3 u_xlat3;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.x = tex2D(_CameraDepthTexture, in_f.texcoord.xy).x;
          u_xlat0_d.x = ((_ZBufferParams.x * u_xlat0_d.x) + _ZBufferParams.y);
          u_xlat0_d.x = (float(10) / u_xlat0_d.x);
          u_xlat3.x = (_ProjectionParams.z / in_f.texcoord1.z);
          u_xlat3.xyz = float3((u_xlat3.xxx * in_f.texcoord1.xyz));
          u_xlat0_d.xyz = float3((u_xlat0_d.xxx * u_xlat3.xyz));
          u_xlat0_d = mul(unity_CameraToWorld, float4(u_xlat0_d.xyz,1.0));
          u_xlat1_d.xyz = float3((u_xlat0_d.yyy * conv_mxt4x4_1(_PreviousVP).xyw));
          u_xlat1_d.xyz = float3(((conv_mxt4x4_0(_PreviousVP).xyw * u_xlat0_d.xxx) + u_xlat1_d.xyz));
          u_xlat1_d.xyz = float3(((conv_mxt4x4_2(_PreviousVP).xyw * u_xlat0_d.zzz) + u_xlat1_d.xyz));
          u_xlat1_d.xyz = float3(((conv_mxt4x4_3(_PreviousVP).xyw * u_xlat0_d.www) + u_xlat1_d.xyz));
          u_xlat1_d.xy = float2((u_xlat1_d.xy / u_xlat1_d.zz));
          u_xlat1_d.xy = float2((u_xlat1_d.xy + float2(10, 10)));
          u_xlat1_d.xy = float2((u_xlat1_d.xy * float2(5, 5)));
          u_xlat2_d.xyz = float3((u_xlat0_d.yyy * conv_mxt4x4_1(_NonJitteredVP).xyw));
          u_xlat2_d.xyz = float3(((conv_mxt4x4_0(_NonJitteredVP).xyw * u_xlat0_d.xxx) + u_xlat2_d.xyz));
          u_xlat0_d.xyz = float3(((conv_mxt4x4_2(_NonJitteredVP).xyw * u_xlat0_d.zzz) + u_xlat2_d.xyz));
          u_xlat0_d.xyz = float3(((conv_mxt4x4_3(_NonJitteredVP).xyw * u_xlat0_d.www) + u_xlat0_d.xyz));
          u_xlat0_d.xy = float2((u_xlat0_d.xy / u_xlat0_d.zz));
          u_xlat0_d.xy = float2((u_xlat0_d.xy + float2(10, 10)));
          u_xlat0_d.xy = float2(((u_xlat0_d.xy * float2(5, 5)) + (-u_xlat1_d.xy)));
          out_f.color.xy = float2(u_xlat0_d.xy);
          out_f.color.zw = float2(0, 10);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: 
    {
      Tags
      { 
      }
      ZTest Always
      Cull Off
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
      //uniform float4x4 unity_MatrixVP;
      //uniform float4 _ZBufferParams;
      //uniform float4x4 unity_CameraToWorld;
      uniform float4x4 _NonJitteredVP;
      uniform float4x4 _PreviousVP;
      uniform sampler2D _CameraDepthTexture;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
          float SV_Depth :SV_Depth;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float u_xlat2;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = UnityObjectToClipPos(in_v.vertex);
          out_v.vertex = u_xlat0;
          u_xlat2 = (u_xlat0.y * _ProjectionParams.x);
          u_xlat0.xz = (u_xlat0.xw * float2(5, 5));
          u_xlat0.w = (u_xlat2 * 5);
          out_v.texcoord.xy = float2((u_xlat0.zz + u_xlat0.xw));
          out_v.texcoord1.xyz = float3(in_v.normal.xyz);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float4 u_xlat1_d;
      float3 u_xlat2_d;
      float u_xlat9;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.x = (_ProjectionParams.z / in_f.texcoord1.z);
          u_xlat0_d.xyz = float3((u_xlat0_d.xxx * in_f.texcoord1.xyz));
          u_xlat9 = tex2D(_CameraDepthTexture, in_f.texcoord.xy).x;
          u_xlat1_d.x = ((_ZBufferParams.x * u_xlat9) + _ZBufferParams.y);
          out_f.SV_Depth = u_xlat9;
          u_xlat9 = (float(10) / u_xlat1_d.x);
          u_xlat0_d.xyz = float3((float3(u_xlat9, u_xlat9, u_xlat9) * u_xlat0_d.xyz));
          u_xlat0_d = mul(unity_CameraToWorld, float4(u_xlat0_d.xyz,1.0));
          u_xlat1_d.xyz = float3((u_xlat0_d.yyy * conv_mxt4x4_1(_PreviousVP).xyw));
          u_xlat1_d.xyz = float3(((conv_mxt4x4_0(_PreviousVP).xyw * u_xlat0_d.xxx) + u_xlat1_d.xyz));
          u_xlat1_d.xyz = float3(((conv_mxt4x4_2(_PreviousVP).xyw * u_xlat0_d.zzz) + u_xlat1_d.xyz));
          u_xlat1_d.xyz = float3(((conv_mxt4x4_3(_PreviousVP).xyw * u_xlat0_d.www) + u_xlat1_d.xyz));
          u_xlat1_d.xy = float2((u_xlat1_d.xy / u_xlat1_d.zz));
          u_xlat1_d.xy = float2((u_xlat1_d.xy + float2(10, 10)));
          u_xlat1_d.xy = float2((u_xlat1_d.xy * float2(5, 5)));
          u_xlat2_d.xyz = float3((u_xlat0_d.yyy * conv_mxt4x4_1(_NonJitteredVP).xyw));
          u_xlat2_d.xyz = float3(((conv_mxt4x4_0(_NonJitteredVP).xyw * u_xlat0_d.xxx) + u_xlat2_d.xyz));
          u_xlat0_d.xyz = float3(((conv_mxt4x4_2(_NonJitteredVP).xyw * u_xlat0_d.zzz) + u_xlat2_d.xyz));
          u_xlat0_d.xyz = float3(((conv_mxt4x4_3(_NonJitteredVP).xyw * u_xlat0_d.www) + u_xlat0_d.xyz));
          u_xlat0_d.xy = float2((u_xlat0_d.xy / u_xlat0_d.zz));
          u_xlat0_d.xy = float2((u_xlat0_d.xy + float2(10, 10)));
          u_xlat0_d.xy = float2(((u_xlat0_d.xy * float2(5, 5)) + (-u_xlat1_d.xy)));
          out_f.color.xy = float2(u_xlat0_d.xy);
          out_f.color.zw = float2(0, 10);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
