Shader "Unlit/AcieveShader01"
{
  Properties
  {
    [Enum(Bronze,1,Silver,2,Gold,3)] _Mat ("MaterialType", float) = 1
    _ColorTex ("ColorTexture", 2D) = "white" {}
    _MainTex ("Texture", 2D) = "white" {}
    _OutlineThick ("Outline Thick", float) = 1
    _OutlineThreshold ("Outline Threshold", float) = 0
    _OutlineColor ("Color", Color) = (1,1,1,1)
    _Stencil ("Stencil", float) = 32
    _StencilOp ("Stencil Operation", float) = 0
    _StencilComp ("Stencil Comparison", float) = 8
    _StencilReadMask ("Stencil Read Mask", float) = 255
    _StencilWriteMask ("Stencil Write Mask", float) = 255
    _ColorMask ("Color Mask", float) = 15
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    LOD 100
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      LOD 100
      ZWrite Off
      Cull Off
      Blend SrcAlpha OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform int _Mat;
      uniform sampler2D _MainTex;
      uniform sampler2D _ColorTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float2 texcoord :TEXCOORD0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 color :COLOR0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float4 color :COLOR0;
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
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          out_v.texcoord.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _MainTex));
          out_v.color = in_v.color;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float3 u_xlatb0;
      float4 u_xlat1_d;
      float4 u_xlat10_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlatb0.xyz = float3(bool4(int4(int4(_Mat, _Mat, _Mat, _Mat)) == int4(1, 2, 3, 0)).xyz);
          u_xlat0_d.xyz = float3(lerp(float3(0, 0, 0), float3(10, 10, 10), float3(u_xlatb0.xyz)));
          u_xlat10_1 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat0_d.xy = float2((u_xlat0_d.xy * u_xlat10_1.xy));
          u_xlat0_d.x = (u_xlat0_d.y + u_xlat0_d.x);
          u_xlat0_d.y = ((u_xlat10_1.z * u_xlat0_d.z) + u_xlat0_d.x);
          u_xlat1_d.w = (u_xlat10_1.w * in_f.color.w);
          u_xlat0_d.x = 5;
          u_xlat1_d.xyz = tex2D(_ColorTex, u_xlat0_d.xy).xyz.xyz;
          out_f.color = u_xlat1_d;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
