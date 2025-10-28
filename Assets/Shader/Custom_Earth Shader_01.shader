Shader "Custom/Earth Shader_01"
{
  Properties
  {
    _MainTex ("Main texture", 2D) = "white" {}
    _Color ("Tint", Color) = (1,1,1,1)
    _ColorTop ("Top", Color) = (1,1,1,1)
    _ColorBottom ("Bottom", Color) = (1,1,1,1)
    _Tile ("Tile", Range(0.1, 100)) = 1
    _Cycle ("Cycle", Range(1, 100)) = 1
    _Speed ("Speed", Range(-100, 100)) = 1
    [Space(20)] _Radius ("Ring Radius", Range(0, 1)) = 1
    _Width ("Ring Width", Range(0, 1)) = 1
    _Blur ("Ring Blur", Range(0, 1)) = 1
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
      uniform int _UseClipRect;
      uniform float4 _ClipRect;
      uniform int _UseAlphaClip;
      uniform float _Speed;
      uniform float _Tile;
      uniform float _Cycle;
      uniform float _Radius;
      uniform float _Width;
      uniform float _Blur;
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
          float4 texcoord1 :TEXCOORD1;
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
      float4 u_xlat0_d;
      float4 u_xlat16_0;
      float u_xlat1_d;
      float4 u_xlat16_1;
      float2 u_xlat10_1;
      int u_xlatb1;
      float4 u_xlat16_2;
      float4 u_xlat3;
      float4 u_xlatb3;
      float u_xlat16_4;
      int u_xlatb7;
      float u_xlat16_8;
      float u_xlat16_12;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0.xy = float2((in_f.texcoord.xy + float2(-5, (-5))));
          u_xlat16_0.x = length(u_xlat16_0.xy);
          u_xlat16_0.x = ((u_xlat16_0.x * 20) + (-_Radius));
          u_xlat16_4 = (_Width + _Blur);
          u_xlat16_0.x = (u_xlat16_4 + (-abs(u_xlat16_0.x)));
          u_xlat16_4 = (float(10) / _Blur);
          u_xlat16_0.x = (u_xlat16_4 * u_xlat16_0.x);
          u_xlat16_0.x = clamp(u_xlat16_0.x, 0, 10);
          u_xlat16_4 = ((u_xlat16_0.x * (-20)) + 30);
          u_xlat16_0.x = (u_xlat16_0.x * u_xlat16_0.x);
          u_xlat16_0.x = (u_xlat16_0.x * u_xlat16_4);
          u_xlat1_d = (_Time.x * _Speed);
          u_xlat16_4 = ((in_f.texcoord.y * _Tile) + u_xlat1_d);
          u_xlat16_8 = floor(abs(u_xlat16_4));
          u_xlat16_2.y = frac(u_xlat16_4);
          u_xlat16_4 = (u_xlat16_8 * _Cycle);
          if((u_xlat16_4>=(-u_xlat16_4)))
          {
              u_xlatb1 = 1;
          }
          else
          {
              u_xlatb1 = 0;
          }
          u_xlat16_4 = u_xlatb1;
          u_xlat16_12 = (float(10) / u_xlat16_4);
          u_xlat16_8 = (u_xlat16_12 * u_xlat16_8);
          u_xlat16_8 = frac(u_xlat16_8);
          u_xlat16_4 = (u_xlat16_8 * u_xlat16_4);
          u_xlat16_8 = (_Cycle + (-10));
          if((u_xlat16_4>=u_xlat16_8))
          {
              u_xlatb1 = 1;
          }
          else
          {
              u_xlatb1 = 0;
          }
          u_xlat16_4 = u_xlatb1;
          u_xlat16_2.x = in_f.texcoord.x;
          u_xlat10_1.xy = tex2D(_MainTex, u_xlat16_2.xy).xy.xy;
          u_xlat16_4 = (u_xlat16_4 * u_xlat10_1.x);
          u_xlat16_2 = (_ColorTop + (-_ColorBottom));
          u_xlat16_1 = ((u_xlat10_1.yyyy * u_xlat16_2) + _ColorBottom);
          u_xlat16_1 = (u_xlat16_1 + (-_Color));
          u_xlat16_1 = ((float4(u_xlat16_4, u_xlat16_4, u_xlat16_4, u_xlat16_4) * u_xlat16_1) + _Color);
          u_xlat16_1.w = (u_xlat16_0.x * u_xlat16_1.w);
          u_xlatb3.xy = float2(bool4(in_f.texcoord1.xyxx >= _ClipRect.xyxx).xy);
          u_xlatb3.zw = bool4(_ClipRect.zzzw >= in_f.texcoord1.xxxy).zw;
          u_xlat3 = lerp(float4(0, 0, 0, 0), float4(10, 10, 10, 10), float4(u_xlatb3));
          u_xlat3.xy = float2((u_xlat3.zw * u_xlat3.xy));
          u_xlat3.x = (u_xlat3.y * u_xlat3.x);
          u_xlat0_d = (u_xlat16_1 * u_xlat3.xxxx);
          if((_UseClipRect!=0))
          {
              u_xlat16_0 = float4(1, 1, 1, 1);
          }
          else
          {
              u_xlat16_0 = float4(0, 0, 0, 0);
          }
          u_xlat16_2.x = (u_xlat16_0.w + (-100000005));
          out_f.color = u_xlat16_0;
          if((u_xlat16_2.x<0))
          {
              u_xlatb3.x = 1;
          }
          else
          {
              u_xlatb3.x = 0;
          }
          if((_UseAlphaClip!=0))
          {
              u_xlatb7 = 1;
          }
          else
          {
              u_xlatb7 = 0;
          }
          u_xlatb3.x = (u_xlatb7 && u_xlatb3.x);
          if(((int(u_xlatb3.x) * (-1))!=0))
          {
              discard;
          }
          //return u_xlat0_d;
          //return u_xlat16_1;
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
