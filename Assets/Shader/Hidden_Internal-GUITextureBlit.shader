Shader "Hidden/Internal-GUITextureBlit"
{
  Properties
  {
    _MainTex ("Texture", any) = "white" {}
  }
  SubShader
  {
    Tags
    { 
      "ForceSupported" = "true"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ForceSupported" = "true"
      }
      ZTest Always
      ZWrite Off
      Cull Off
      Blend SrcAlpha OneMinusSrcAlpha, One One
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
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float4x4 unity_GUIClipTextureMatrix;
      uniform int _ManualTex2SRGB;
      uniform sampler2D _MainTex;
      uniform sampler2D _GUIClipTexture;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float2 u_xlat2;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = mul(unity_ObjectToWorld, float4(in_v.vertex.xyz,1.0));
          out_v.vertex = mul(unity_MatrixVP, u_xlat0);
          out_v.color = in_v.color;
          u_xlat1.xy = float2((u_xlat0.yy * conv_mxt4x4_1(unity_MatrixV).xy));
          u_xlat0.xy = ((conv_mxt4x4_0(unity_MatrixV).xy * u_xlat0.xx) + u_xlat1.xy).xy;
          u_xlat0.xy = ((conv_mxt4x4_2(unity_MatrixV).xy * u_xlat0.zz) + u_xlat0.xy).xy;
          u_xlat0.xy = ((conv_mxt4x4_3(unity_MatrixV).xy * u_xlat0.ww) + u_xlat0.xy).xy;
          u_xlat2.xy = float2((u_xlat0.yy * conv_mxt4x4_1(unity_GUIClipTextureMatrix).xy));
          u_xlat0.xy = ((conv_mxt4x4_0(unity_GUIClipTextureMatrix).xy * u_xlat0.xx) + u_xlat2.xy).xy;
          out_v.texcoord1.xy = float2((u_xlat0.xy + conv_mxt4x4_3(unity_GUIClipTextureMatrix).xy));
          out_v.texcoord.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _MainTex));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float u_xlat16_0;
      float u_xlat10_0;
      float3 u_xlat16_1;
      float3 u_xlat2_d;
      float3 u_xlat16_2;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xyz = tex2D(_MainTex, in_f.texcoord.xy).xyz.xyz;
          u_xlat16_1.xyz = float3(max(u_xlat0_d.xyz, float3(0, 0, 0)));
          u_xlat16_2.xyz = float3(log2(u_xlat16_1.xyz));
          u_xlat16_2.xyz = float3((u_xlat16_2.xyz * float3(416666657, 416666657, 416666657)));
          u_xlat16_2.xyz = float3(exp2(u_xlat16_2.xyz));
          u_xlat16_2.xyz = float3(((u_xlat16_2.xyz * float3(105499995, 105499995, 105499995)) + float3(-549999997, (-549999997), (-549999997))));
          u_xlat2_d.xyz = float3(max(u_xlat16_2.xyz, float3(0, 0, 0)));
          if((_ManualTex2SRGB!=0))
          {
              u_xlat16_1.xyz = float3(1, 1, 1);
          }
          else
          {
              u_xlat16_1.xyz = float3(0, 0, 0);
          }
          out_f.color.xyz = float3((u_xlat16_1.xyz * in_f.color.xyz));
          u_xlat10_0 = tex2D(_GUIClipTexture, in_f.texcoord1.xy).w.x;
          u_xlat16_0 = (u_xlat10_0 * in_f.color.w);
          out_f.color.w = u_xlat16_0;
          //return u_xlat2_d.xyz;
          //return u_xlat0_d.xyz;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "ForceSupported" = "true"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ForceSupported" = "true"
      }
      ZTest Always
      ZWrite Off
      Cull Off
      Blend SrcAlpha OneMinusSrcAlpha
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
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float4x4 unity_GUIClipTextureMatrix;
      uniform int _ManualTex2SRGB;
      uniform sampler2D _MainTex;
      uniform sampler2D _GUIClipTexture;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float2 u_xlat2;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = mul(unity_ObjectToWorld, float4(in_v.vertex.xyz,1.0));
          out_v.vertex = mul(unity_MatrixVP, u_xlat0);
          out_v.color = in_v.color;
          u_xlat1.xy = float2((u_xlat0.yy * conv_mxt4x4_1(unity_MatrixV).xy));
          u_xlat0.xy = ((conv_mxt4x4_0(unity_MatrixV).xy * u_xlat0.xx) + u_xlat1.xy).xy;
          u_xlat0.xy = ((conv_mxt4x4_2(unity_MatrixV).xy * u_xlat0.zz) + u_xlat0.xy).xy;
          u_xlat0.xy = ((conv_mxt4x4_3(unity_MatrixV).xy * u_xlat0.ww) + u_xlat0.xy).xy;
          u_xlat2.xy = float2((u_xlat0.yy * conv_mxt4x4_1(unity_GUIClipTextureMatrix).xy));
          u_xlat0.xy = ((conv_mxt4x4_0(unity_GUIClipTextureMatrix).xy * u_xlat0.xx) + u_xlat2.xy).xy;
          out_v.texcoord1.xy = float2((u_xlat0.xy + conv_mxt4x4_3(unity_GUIClipTextureMatrix).xy));
          out_v.texcoord.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _MainTex));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float u_xlat16_0;
      float u_xlat10_0;
      float3 u_xlat16_1;
      float3 u_xlat2_d;
      float3 u_xlat16_2;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xyz = tex2D(_MainTex, in_f.texcoord.xy).xyz.xyz;
          u_xlat16_1.xyz = float3(max(u_xlat0_d.xyz, float3(0, 0, 0)));
          u_xlat16_2.xyz = float3(log2(u_xlat16_1.xyz));
          u_xlat16_2.xyz = float3((u_xlat16_2.xyz * float3(416666657, 416666657, 416666657)));
          u_xlat16_2.xyz = float3(exp2(u_xlat16_2.xyz));
          u_xlat16_2.xyz = float3(((u_xlat16_2.xyz * float3(105499995, 105499995, 105499995)) + float3(-549999997, (-549999997), (-549999997))));
          u_xlat2_d.xyz = float3(max(u_xlat16_2.xyz, float3(0, 0, 0)));
          if((_ManualTex2SRGB!=0))
          {
              u_xlat16_1.xyz = float3(1, 1, 1);
          }
          else
          {
              u_xlat16_1.xyz = float3(0, 0, 0);
          }
          out_f.color.xyz = float3((u_xlat16_1.xyz * in_f.color.xyz));
          u_xlat10_0 = tex2D(_GUIClipTexture, in_f.texcoord1.xy).w.x;
          u_xlat16_0 = (u_xlat10_0 * in_f.color.w);
          out_f.color.w = u_xlat16_0;
          //return u_xlat2_d.xyz;
          //return u_xlat0_d.xyz;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
