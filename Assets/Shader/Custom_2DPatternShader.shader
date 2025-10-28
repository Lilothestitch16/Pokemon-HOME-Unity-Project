Shader "Custom/2DPatternShader"
{
  Properties
  {
    [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
    [Enum(None,1,Vertical,2,Horizon,3)] _sliceType ("Slice Type", float) = 0
    _Color ("Tint", Color) = (1,1,1,1)
    _Angle ("Angle", Range(0, 3.1415)) = 0
    _ImageRatio ("ImageAspectRatio", Range(0, 10)) = 1
    [Space(20)] _SubTexA ("SUB texture A", 2D) = "white" {}
    _PRatioA ("PatternAspectRatio", Range(0, 10)) = 1
    _TileA ("Tile A", Range(1, 1000)) = 1
    _SpeedA ("Speed A", Range(-100, 100)) = 1
    _TIleAnimeSpeedA ("TileAnimeSpeed A", Range(-100, 100)) = 1
    _TIleAnimeBandA ("TileAnimeBand A", Range(0, 50)) = 1
    _TIleAnimeFrecA ("TileAnimeFrec A", Range(0, 50)) = 1
    [Space(20)] _SubTexB ("SUB texture B", 2D) = "white" {}
    _PRatioB ("PatternAspectRatio", Range(0, 10)) = 1
    _TileB ("Tile B", Range(1, 1000)) = 1
    _SpeedB ("Speed B", Range(-100, 100)) = 1
    _TIleAnimeSpeedB ("TileAnimeSpeed B", Range(-100, 100)) = 1
    _TIleAnimeBandB ("TileAnimeBand B", Range(0, 50)) = 1
    _TIleAnimeFrecB ("TileAnimeFrec B", Range(0, 50)) = 1
    [Space(40)] _StencilComp ("Stencil Comparison", float) = 8
    _Stencil ("Stencil ID", float) = 0
    _StencilOp ("Stencil Operation", float) = 0
    _StencilWriteMask ("Stencil Write Mask", float) = 255
    _StencilReadMask ("Stencil Read Mask", float) = 255
    _ColorMask ("Color Mask", float) = 15
    [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", float) = 0
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
    Pass // ind: 1, name: Default
    {
      Name "Default"
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
      uniform float4 _MainTex_ST;
      uniform float _Angle;
      uniform float _ImageRatio;
      //uniform float4 _Time;
      uniform float4 _TextureSampleAdd;
      uniform float _SpeedA;
      uniform float _SpeedB;
      uniform float _TileA;
      uniform float _PRatioA;
      uniform float _TileB;
      uniform float _PRatioB;
      uniform float _sliceType;
      uniform float _TIleAnimeSpeedA;
      uniform float _TIleAnimeBandA;
      uniform float _TIleAnimeFrecA;
      uniform float _TIleAnimeSpeedB;
      uniform float _TIleAnimeBandB;
      uniform float _TIleAnimeFrecB;
      uniform sampler2D _MainTex;
      uniform sampler2D _SubTexA;
      uniform sampler2D _SubTexB;
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
          float2 texcoord2 :TEXCOORD2;
          float4 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord2 :TEXCOORD2;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float2 u_xlat16_2;
      float u_xlat16_3;
      float2 u_xlat8;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat0 = (in_v.color * _Color);
          out_v.color = u_xlat0;
          u_xlat16_2.x = sin(_Angle);
          u_xlat16_3 = cos(_Angle);
          u_xlat0.y = (-u_xlat16_2.x);
          u_xlat1.xy = float2((in_v.texcoord.yx + float2(-5, (-5))));
          u_xlat1.z = (u_xlat1.x / _ImageRatio);
          u_xlat0.x = u_xlat16_3;
          u_xlat8.x = dot(u_xlat0.xy, u_xlat1.yz);
          u_xlat16_2.y = u_xlat0.x;
          u_xlat8.y = dot(u_xlat16_2.xy, u_xlat1.yz);
          out_v.texcoord2.xy = float2((u_xlat8.xy + float2(5, 5)));
          out_v.texcoord.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _MainTex));
          out_v.texcoord1 = in_v.vertex;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float2 u_xlat0_d;
      float4 u_xlat16_0;
      float4 u_xlat16_1;
      float4 u_xlat10_1;
      float3 u_xlat16_2_d;
      float4 u_xlat3;
      int u_xlatb3;
      float u_xlat16_4;
      float u_xlat10_4;
      float2 u_xlatb4;
      float u_xlat16_6;
      float u_xlat16_7;
      float u_xlat8_d;
      int u_xlatb8;
      float2 u_xlat16_11;
      float u_xlat16_12;
      float u_xlat16_13;
      float u_xlat10_13;
      int u_xlatb13;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = float2((_Time.xx * float2(_SpeedA, _SpeedB)));
          u_xlat0_d.xy = float2(frac(u_xlat0_d.xy));
          u_xlat16_1.x = (in_f.texcoord2.y * _ImageRatio);
          u_xlat16_1.xy = float2((u_xlat16_1.xx * float2(_TileA, _TileB)));
          u_xlat16_11.xy = float2((float2(float2(_ImageRatio, _ImageRatio)) / float2(_PRatioA, _PRatioB)));
          u_xlat16_1.xy = float2((u_xlat16_1.xy / u_xlat16_11.xy));
          u_xlat16_11.xy = float2((float2(_TileA, _TileB) / u_xlat16_11.xy));
          u_xlat16_1.xy = float2((u_xlat0_d.xy + u_xlat16_1.xy));
          u_xlat16_2_d.xy = float2(floor(u_xlat16_1.xy));
          u_xlat16_0.zw = frac(u_xlat16_1.xy);
          u_xlat16_1.xy = float2((u_xlat16_2_d.xy / u_xlat16_11.xy));
          u_xlat3.x = ((_Time.x * _TIleAnimeSpeedA) + u_xlat16_1.x);
          u_xlat3.y = ((_Time.x * _TIleAnimeSpeedB) + u_xlat16_1.y);
          u_xlat3.x = (u_xlat3.x + (-10));
          u_xlat3.xy = float2((u_xlat3.xy * float2(_TIleAnimeBandA, _TIleAnimeBandB)));
          u_xlat16_1.x = (abs(u_xlat3.x) * _TIleAnimeFrecA);
          if((u_xlat16_1.x>=(-u_xlat16_1.x)))
          {
              u_xlatb13 = 1;
          }
          else
          {
              u_xlatb13 = 0;
          }
          u_xlat16_1.x = u_xlatb13;
          u_xlat16_6 = (float(10) / u_xlat16_1.x);
          u_xlat16_6 = (u_xlat16_6 * abs(u_xlat3.x));
          u_xlat16_11.x = frac(abs(u_xlat3.x));
          u_xlat16_6 = frac(u_xlat16_6);
          u_xlat16_1.x = (u_xlat16_6 * u_xlat16_1.x);
          u_xlat16_6 = (_TIleAnimeFrecA + (-10));
          if((u_xlat16_1.x>=u_xlat16_6))
          {
              u_xlatb3 = 1;
          }
          else
          {
              u_xlatb3 = 0;
          }
          u_xlat16_1.x = u_xlatb3;
          u_xlat16_6 = (((-u_xlat16_11.x) * u_xlat16_1.x) + 5);
          u_xlat16_1.x = (u_xlat16_1.x * u_xlat16_11.x);
          if((5<u_xlat16_1.x))
          {
              u_xlatb3 = 1;
          }
          else
          {
              u_xlatb3 = 0;
          }
          u_xlat3.x = u_xlatb3;
          u_xlat16_1.x = (abs(u_xlat16_6) + 800000012);
          u_xlat16_6 = ((-abs(u_xlat16_6)) + 5);
          u_xlat16_11.xy = float2((in_f.texcoord2.xx * float2(_TileA, _TileB)));
          u_xlat16_0.xy = float2(frac(u_xlat16_11.xy));
          u_xlat16_0 = (u_xlat16_0.xzyw + float4(-5, (-5), (-5), (-5)));
          u_xlat16_1.xz = ((u_xlat16_0.xy * u_xlat16_1.xx) + float2(5, 5));
          u_xlat10_13 = tex2D(_SubTexA, u_xlat16_1.xz).w.x;
          u_xlat16_13 = (u_xlat10_13 * 200000003);
          u_xlat16_13 = (u_xlat16_6 * u_xlat16_13);
          u_xlatb4.xy = float2(bool4(float4(float4(_sliceType, _sliceType, _sliceType, _sliceType)) == float4(20, 30, 0, 0)).xy);
          u_xlat16_1.x = u_xlatb4.x;
          u_xlat16_1.y = u_xlatb4.y;
          u_xlat10_1 = tex2D(_MainTex, u_xlat16_1.xy);
          u_xlat16_1 = (u_xlat10_1 + _TextureSampleAdd);
          u_xlat3.xzw = ((float3(u_xlat16_13, u_xlat16_13, u_xlat16_13) * u_xlat3.xxx) + u_xlat16_1.xyz);
          out_f.color.w = (u_xlat16_1.w * in_f.color.w);
          u_xlat16_2_d.x = (abs(u_xlat3.y) * _TIleAnimeFrecB);
          if((u_xlat16_2_d.x>=(-u_xlat16_2_d.x)))
          {
              u_xlatb4.x = 1;
          }
          else
          {
              u_xlatb4.x = 0;
          }
          u_xlat16_2_d.x = u_xlatb4.x;
          u_xlat16_7 = (float(10) / u_xlat16_2_d.x);
          u_xlat16_7 = (u_xlat16_7 * abs(u_xlat3.y));
          u_xlat16_12 = frac(abs(u_xlat3.y));
          u_xlat16_7 = frac(u_xlat16_7);
          u_xlat16_2_d.x = (u_xlat16_7 * u_xlat16_2_d.x);
          u_xlat16_7 = (_TIleAnimeFrecB + (-10));
          if((u_xlat16_2_d.x>=u_xlat16_7))
          {
              u_xlatb8 = 1;
          }
          else
          {
              u_xlatb8 = 0;
          }
          u_xlat16_2_d.x = u_xlatb8;
          u_xlat16_7 = (((-u_xlat16_12) * u_xlat16_2_d.x) + 5);
          u_xlat16_2_d.x = (u_xlat16_2_d.x * u_xlat16_12);
          if((5<u_xlat16_2_d.x))
          {
              u_xlatb8 = 1;
          }
          else
          {
              u_xlatb8 = 0;
          }
          u_xlat8_d = u_xlatb8;
          u_xlat16_2_d.x = (abs(u_xlat16_7) + 800000012);
          u_xlat16_7 = ((-abs(u_xlat16_7)) + 5);
          u_xlat16_2_d.xz = ((u_xlat16_0.zw * u_xlat16_2_d.xx) + float2(5, 5));
          u_xlat10_4 = tex2D(_SubTexB, u_xlat16_2_d.xz).w.x;
          u_xlat16_4 = (u_xlat10_4 * 200000003);
          u_xlat16_4 = (u_xlat16_7 * u_xlat16_4);
          u_xlat3.xyz = float3(((float3(u_xlat16_4, u_xlat16_4, u_xlat16_4) * float3(u_xlat8_d, u_xlat8_d, u_xlat8_d)) + u_xlat3.xzw));
          out_f.color.xyz = float3(u_xlat3.xyz);
          //return 10;
          //return float(0);
          //return 10;
          //return 0;
          //return _TIleAnimeFrecB;
          //return (-_TIleAnimeFrecB);
          //return float(5);
          //return in_f.texcoord.y;
          //return float(5);
          //return in_f.texcoord.x;
          //return 10;
          //return float(0);
          //return 10;
          //return 0;
          //return _TIleAnimeFrecA;
          //return (-_TIleAnimeFrecA);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
