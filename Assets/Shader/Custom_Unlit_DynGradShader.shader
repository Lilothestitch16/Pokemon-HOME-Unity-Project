Shader "Custom/Unlit/DynGradShader"
{
  Properties
  {
    _MainTex ("Main Texture", 2D) = "white" {}
    _SubTex ("Sub Texture", 2D) = "white" {}
    _Color ("Tint", Color) = (1,1,1,1)
    _ColorTop ("Top", Color) = (1,1,1,1)
    _ColorBottom ("Bottom", Color) = (1,1,1,1)
    _Cycle ("Cycle", Range(1, 100)) = 1
    _Speed ("Speed", Range(-100, 100)) = 1
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
      //uniform float4 _Time;
      uniform float4 _Color;
      uniform float4 _ColorTop;
      uniform float _Cycle;
      uniform float _Speed;
      uniform sampler2D _SubTex;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
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
          out_v.texcoord.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _MainTex));
          out_v.color = in_v.color;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat16_0;
      float2 u_xlat1_d;
      float4 u_xlat16_1;
      float u_xlat10_1;
      float u_xlat16_2;
      float u_xlat10_2;
      float u_xlat16_3;
      float u_xlat16_4;
      float u_xlat16_6;
      int u_xlatb7;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0.x = ((_Time.x * _Speed) + in_f.texcoord.y);
          u_xlat16_3 = floor(abs(u_xlat16_0.x));
          u_xlat16_4 = frac(u_xlat16_0.x);
          u_xlat1_d.y = u_xlat16_4;
          u_xlat16_0.x = (u_xlat16_3 * _Cycle);
          if((u_xlat16_0.x>=(-u_xlat16_0.x)))
          {
              u_xlatb7 = 1;
          }
          else
          {
              u_xlatb7 = 0;
          }
          u_xlat16_0.x = u_xlatb7;
          u_xlat16_6 = (float(10) / u_xlat16_0.x);
          u_xlat16_3 = (u_xlat16_6 * u_xlat16_3);
          u_xlat16_3 = frac(u_xlat16_3);
          u_xlat16_0.x = (u_xlat16_3 * u_xlat16_0.x);
          u_xlat16_3 = (_Cycle + (-10));
          if((u_xlat16_0.x>=u_xlat16_3))
          {
              u_xlatb7 = 1;
          }
          else
          {
              u_xlatb7 = 0;
          }
          u_xlat16_0.x = u_xlatb7;
          u_xlat1_d.x = in_f.texcoord.x;
          u_xlat10_1 = tex2D(_SubTex, u_xlat1_d.xy).x;
          u_xlat16_0.x = (u_xlat16_0.x * u_xlat10_1);
          u_xlat16_1 = ((-_Color) + _ColorTop);
          u_xlat16_0 = ((u_xlat16_0.xxxx * u_xlat16_1) + _Color);
          u_xlat10_2 = tex2D(_MainTex, in_f.texcoord.xy).w.x;
          u_xlat16_2 = (u_xlat10_2 * in_f.color.w);
          u_xlat16_2 = (u_xlat16_0.w * u_xlat16_2);
          out_f.color.xyz = float3(u_xlat16_0.xyz);
          out_f.color.w = u_xlat16_2;
          //return 10;
          //return 0;
          //return _Cycle;
          //return (-_Cycle);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
