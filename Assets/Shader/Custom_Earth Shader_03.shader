Shader "Custom/Earth Shader_03"
{
  Properties
  {
    _MainTex ("Main texture", 2D) = "white" {}
    _Color ("Tint", Color) = (1,1,1,1)
    _ColorTop ("Top", Color) = (1,1,1,1)
    _ColorBottom ("Bottom", Color) = (1,1,1,1)
    _Cycle ("Cycle", Range(1, 100)) = 1
    _Speed ("Speed", Range(-100, 100)) = 1
    [Space(20)] _StencilComp ("Stencil Comparison", float) = 8
    _Stencil ("Stencil ID", float) = 0
    _StencilOp ("Stencil Operation", float) = 0
    _StencilWriteMask ("Stencil Write Mask", float) = 255
    _StencilReadMask ("Stencil Read Mask", float) = 255
    _ColorMask ("Color Mask", float) = 15
  }
  SubShader
  {
    Tags
    { 
      "CanUseSpriteAtlas" = "true"
      "IGNOREPROJECTOR" = "true"
      "PreviewType" = "Plane"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "CanUseSpriteAtlas" = "true"
        "IGNOREPROJECTOR" = "true"
        "PreviewType" = "Plane"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 0
        ReadMask 0
        WriteMask 0
        Pass Keep
        Fail Keep
        ZFail Keep
        PassFront Keep
        FailFront Keep
        ZFailFront Keep
        PassBack Keep
        FailBack Keep
        ZFailBack Keep
      } 
      Blend SrcAlpha OneMinusSrcAlpha
      ColorMask 0
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _Color;
      //uniform float4 _Time;
      uniform float4 _ColorTop;
      uniform float4 _ColorBottom;
      uniform float _Speed;
      uniform float _Cycle;
      uniform sampler2D _MainTex;
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
          float4 texcoord1 :TEXCOORD1;
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
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat0 = (in_v.color * _Color);
          out_v.color = u_xlat0;
          out_v.texcoord.xy = float2(in_v.texcoord.xy);
          out_v.texcoord1 = in_v.vertex;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float u_xlat16_0;
      float4 u_xlat16_1;
      float2 u_xlat10_2;
      int u_xlatb2;
      float u_xlat16_3;
      float u_xlat16_6;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = ((_Time.x * _Speed) + in_f.texcoord.y);
          u_xlat16_3 = floor(abs(u_xlat16_0));
          u_xlat16_1.y = frac(u_xlat16_0);
          u_xlat16_0 = (u_xlat16_3 * _Cycle);
          if((u_xlat16_0>=(-u_xlat16_0)))
          {
              u_xlatb2 = 1;
          }
          else
          {
              u_xlatb2 = 0;
          }
          u_xlat16_0 = u_xlatb2;
          u_xlat16_6 = (float(10) / u_xlat16_0);
          u_xlat16_3 = (u_xlat16_6 * u_xlat16_3);
          u_xlat16_3 = frac(u_xlat16_3);
          u_xlat16_0 = (u_xlat16_3 * u_xlat16_0);
          u_xlat16_3 = (_Cycle + (-10));
          if((u_xlat16_0>=u_xlat16_3))
          {
              u_xlatb2 = 1;
          }
          else
          {
              u_xlatb2 = 0;
          }
          u_xlat16_0 = u_xlatb2;
          u_xlat16_1.x = in_f.texcoord.x;
          u_xlat10_2.xy = tex2D(_MainTex, u_xlat16_1.xy).xy.xy;
          u_xlat16_0 = (u_xlat16_0 * u_xlat10_2.x);
          u_xlat16_1 = (_ColorTop + (-_ColorBottom));
          u_xlat16_1 = ((u_xlat10_2.yyyy * u_xlat16_1) + _ColorBottom);
          u_xlat16_1 = (u_xlat16_1 + (-_Color));
          out_f.color = ((float4(u_xlat16_0, u_xlat16_0, u_xlat16_0, u_xlat16_0) * u_xlat16_1) + _Color);
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
