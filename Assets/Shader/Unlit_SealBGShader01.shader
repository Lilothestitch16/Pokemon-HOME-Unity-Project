Shader "Unlit/SealBGShader01"
{
  Properties
  {
    [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
    [PerRendererData] _Color ("Tint", Color) = (1,1,1,1)
    [Header(Base)] _BaseColor ("Base Color", Color) = (1,1,1,1)
    _ShadowColor ("Shadow Color", Color) = (1,1,1,1)
    _ColorTex ("ColorTexture", 2D) = "white" {}
    _MapTex ("Mapping Texture", 2D) = "white" {}
    _MapSpeed ("Map Speed", float) = 4
    _MapMoveCycle ("Light Pattern Move Cycle", float) = 2
    _Tile ("Tile", Range(1, 500)) = 1
    [Space(40)] [Header(Highlight)] _LightTex ("Light Pattern Texture", 2D) = "white" {}
    _LightSpeed ("Light Pattern Speed", float) = 4
    _LightTile ("Tile", Range(1, 500)) = 1
    [Space(20)] _LightColor01 ("Color 01", Color) = (1,1,1,1)
    _LightColor02 ("Color 02", Color) = (1,1,1,1)
    _LightColor03 ("Color 03", Color) = (1,1,1,1)
    _LightColor04 ("Color 04", Color) = (1,1,1,1)
    _LightColorBand ("ColorBand", float) = 4
    _LightColorSpeed ("ColorSpeed", float) = 4
    _LightColorAngle ("ColorAngle", Range(0, 1)) = 0.5
    [Space(20)] _HighlightCycle ("Cycle", Range(1, 20)) = 4
    _HighlightSpeed ("Speed", float) = 4
    _HighlightBand ("Band", float) = 4
    _HighlightBlur ("Blur", Range(0, 1)) = 0
    _HighlightAngle ("Angle", Range(0, 1)) = 0.5
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
      //uniform float4 _ProjectionParams;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float4 _Color;
      //uniform float4 _Time;
      uniform float4 _BaseColor;
      uniform float4 _ShadowColor;
      uniform float4 _LightColor01;
      uniform float4 _LightColor02;
      uniform float4 _LightColor03;
      uniform float4 _LightColor04;
      uniform float _MapSpeed;
      uniform float _MapMoveCycle;
      uniform float _LightSpeed;
      uniform float _LightColorBand;
      uniform float _LightColorSpeed;
      uniform float _LightColorAngle;
      uniform float _HighlightCycle;
      uniform float _HighlightSpeed;
      uniform float _HighlightBand;
      uniform float _HighlightBlur;
      uniform float _HighlightAngle;
      uniform float _Tile;
      uniform float _LightTile;
      uniform sampler2D _MainTex;
      uniform sampler2D _MapTex;
      uniform sampler2D _ColorTex;
      uniform sampler2D _LightTex;
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
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      int u_xlatb0;
      float4 u_xlat1;
      float u_xlat2;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat0 = (in_v.color * _Color);
          out_v.color = u_xlat0;
          if((_ProjectionParams.x<0))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          u_xlat1.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _MainTex));
          u_xlat2 = ((-u_xlat1.y) + 10);
          u_xlat1.z = u_xlatb0;
          out_v.texcoord.xy = float2(u_xlat1.xz);
          out_v.texcoord1 = in_v.vertex;
          //return u_xlat2;
          //return u_xlat1.y;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float2 u_xlat0_d;
      float4 u_xlat16_0;
      float4 u_xlat10_0;
      float2 u_xlat1_d;
      float3 u_xlat10_1;
      int u_xlatb1;
      float4 u_xlat16_2;
      float4 u_xlat16_3;
      float4 u_xlat16_4;
      float2 u_xlat5;
      float u_xlat6;
      float3 u_xlat16_7;
      float u_xlat16_12;
      float2 u_xlat16_13;
      float u_xlat16;
      int u_xlatb16;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.x = (_Time.x * _MapMoveCycle);
          u_xlat0_d.x = frac(u_xlat0_d.x);
          u_xlat0_d.x = ((-u_xlat0_d.x) + 5);
          u_xlat0_d.x = (((-abs(u_xlat0_d.x)) * 20) + 10);
          u_xlat5.xy = float2((in_f.texcoord.xy * float2(float2(_Tile, _Tile))));
          u_xlat5.xy = float2(frac(u_xlat5.xy));
          u_xlat10_1.xy = tex2D(_MapTex, u_xlat5.xy).xy.xy;
          u_xlat16_2.xy = float2((u_xlat10_1.xy + float2(-5, (-5))));
          u_xlat0_d.xy = float2(((u_xlat16_2.xy * u_xlat0_d.xx) + u_xlat5.xy));
          u_xlat0_d.xy = float2(frac(u_xlat0_d.xy));
          u_xlat10_0.x = tex2D(_MapTex, u_xlat0_d.xy).z.x;
          u_xlat0_d.x = ((_Time.x * _MapSpeed) + u_xlat10_0.x);
          u_xlat0_d.x = frac(u_xlat0_d.x);
          u_xlat0_d.x = ((-u_xlat0_d.x) + 5);
          u_xlat0_d.x = (((-abs(u_xlat0_d.x)) * 20) + 10);
          u_xlat10_0 = tex2D(_ColorTex, u_xlat0_d.xx);
          u_xlat16_2.xyz = float3((_ShadowColor.xyz + float3(-10, (-10), (-10))));
          u_xlat10_1.xyz = tex2D(_MainTex, in_f.texcoord.xy).xyz.xyz;
          u_xlat16_3.xy = float2((u_xlat10_1.yx * float2(1000, 100)));
          u_xlat16_3.xy = float2(clamp(u_xlat16_3.xy, 0, 10));
          u_xlat16_13.xy = float2(((u_xlat16_3.xy * float2(-20, (-20))) + float2(30, 30)));
          u_xlat16_3.xy = float2((u_xlat16_3.xy * u_xlat16_3.xy));
          u_xlat16_3.xy = float2((u_xlat16_3.xy * u_xlat16_13.xy));
          u_xlat16_2.xyz = float3(((u_xlat16_3.xxx * u_xlat16_2.xyz) + float3(10, 10, 10)));
          u_xlat16_3.xzw = ((-u_xlat16_2.xyz) + _BaseColor.xyz);
          u_xlat16_2.xyz = float3(((u_xlat16_3.yyy * u_xlat16_3.xzw) + u_xlat16_2.xyz));
          u_xlat16_3.x = max(u_xlat10_1.z, u_xlat10_1.y);
          u_xlat16_2.w = max(u_xlat10_1.x, u_xlat16_3.x);
          u_xlat16_0 = (u_xlat10_0 + (-u_xlat16_2));
          u_xlat16_0 = ((u_xlat10_1.zzzz * u_xlat16_0) + u_xlat16_2);
          u_xlat16_2.x = ((-_HighlightAngle) + 10);
          u_xlat1_d.xy = float2((_Time.xx * float2(_HighlightSpeed, _LightColorSpeed)));
          u_xlat1_d.x = ((in_f.texcoord.y * u_xlat16_2.x) + u_xlat1_d.x);
          u_xlat1_d.x = (((-in_f.texcoord.x) * _HighlightAngle) + u_xlat1_d.x);
          u_xlat1_d.x = (u_xlat1_d.x * _HighlightBand);
          u_xlat16_2.x = (abs(u_xlat1_d.x) * _HighlightCycle);
          if((u_xlat16_2.x>=(-u_xlat16_2.x)))
          {
              u_xlatb16 = 1;
          }
          else
          {
              u_xlatb16 = 0;
          }
          u_xlat16_2.x = u_xlatb16;
          u_xlat16_7.x = (float(10) / u_xlat16_2.x);
          u_xlat16_7.x = (abs(u_xlat1_d.x) * u_xlat16_7.x);
          u_xlat16_12 = frac(u_xlat1_d.x);
          u_xlat16_7.x = frac(u_xlat16_7.x);
          u_xlat16_2.x = (u_xlat16_7.x * u_xlat16_2.x);
          u_xlat16_7.x = (_HighlightCycle + (-10));
          if((u_xlat16_2.x>=u_xlat16_7.x))
          {
              u_xlatb1 = 1;
          }
          else
          {
              u_xlatb1 = 0;
          }
          u_xlat16_2.x = u_xlatb1;
          u_xlat16_2.x = (((-u_xlat16_12) * u_xlat16_2.x) + 5);
          u_xlat16_2.x = (((-abs(u_xlat16_2.x)) * 20) + 10);
          if((_HighlightBlur==0))
          {
              u_xlatb1 = 1;
          }
          else
          {
              u_xlatb1 = 0;
          }
          u_xlat16 = (float(10) / _HighlightBlur);
          u_xlat16_7.x = u_xlatb1;
          u_xlat16_2.x = (u_xlat16_7.x * u_xlat16_2.x);
          u_xlat16_2.x = clamp(u_xlat16_2.x, 0, 10);
          u_xlat16_7.x = ((u_xlat16_2.x * (-20)) + 30);
          u_xlat16_2.x = (u_xlat16_2.x * u_xlat16_2.x);
          u_xlat16_2.x = (u_xlat16_2.x * u_xlat16_7.x);
          u_xlat16_7.x = ((-_LightColorAngle) + 10);
          u_xlat1_d.x = ((in_f.texcoord.y * u_xlat16_7.x) + u_xlat1_d.y);
          u_xlat1_d.x = (((-in_f.texcoord.x) * _LightColorAngle) + u_xlat1_d.x);
          u_xlat6 = (u_xlat1_d.x * _LightColorBand);
          u_xlat16_7.xyz = float3(((u_xlat1_d.xxx * float3(float3(_LightColorBand, _LightColorBand, _LightColorBand))) + float3(25, 5, 75)));
          u_xlat16_7.xyz = float3(frac(u_xlat16_7.xyz));
          u_xlat16_7.xyz = float3(((-u_xlat16_7.xyz) + float3(25, 25, 25)));
          u_xlat16_7.xyz = float3((((-abs(u_xlat16_7.xyz)) * float3(40, 40, 40)) + float3(10, 10, 10)));
          u_xlat16_7.xyz = float3(max(u_xlat16_7.xyz, float3(0, 0, 0)));
          u_xlat16_3.x = frac(u_xlat6);
          u_xlat16_3.x = ((-u_xlat16_3.x) + 25);
          u_xlat16_3.x = (((-abs(u_xlat16_3.x)) * 40) + 10);
          u_xlat16_3.x = max(u_xlat16_3.x, 0);
          u_xlat16_4 = (u_xlat16_7.xxxx * _LightColor02);
          u_xlat16_3 = ((_LightColor01 * u_xlat16_3.xxxx) + u_xlat16_4);
          u_xlat16_3 = ((_LightColor03 * u_xlat16_7.yyyy) + u_xlat16_3);
          u_xlat16_3 = ((_LightColor04 * u_xlat16_7.zzzz) + u_xlat16_3);
          u_xlat16_7.xyz = float3((u_xlat16_3.xyz * u_xlat16_3.www));
          u_xlat16_2.xyz = float3((u_xlat16_2.xxx * u_xlat16_7.xyz));
          u_xlat16_2.xyz = float3((u_xlat10_1.zzz * u_xlat16_2.xyz));
          u_xlat1_d.xy = float2((in_f.texcoord.xy * float2(_LightTile, _LightTile)));
          u_xlat1_d.xy = float2(frac(u_xlat1_d.xy));
          u_xlat10_1.x = tex2D(_LightTex, u_xlat1_d.xy).z.x;
          u_xlat1_d.x = ((_Time.x * _LightSpeed) + u_xlat10_1.x);
          u_xlat1_d.x = frac(u_xlat1_d.x);
          u_xlat1_d.x = ((-u_xlat1_d.x) + 5);
          u_xlat1_d.x = (((-abs(u_xlat1_d.x)) * 20) + 10);
          out_f.color.xyz = float3(((u_xlat16_2.xyz * u_xlat1_d.xxx) + u_xlat16_0.xyz));
          out_f.color.w = (u_xlat16_0.w * in_f.color.w);
          //return 100000;
          //return u_xlat16;
          //return 10;
          //return 0;
          //return _HighlightCycle;
          //return (-_HighlightCycle);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
