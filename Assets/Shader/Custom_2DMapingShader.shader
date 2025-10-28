Shader "Custom/2DMapingShader"
{
  Properties
  {
    [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
    [Enum(None,1,Vertical,2,Horizon,3)] _sliceType ("Slice Type", float) = 0
    _Color ("Tint", Color) = (1,1,1,1)
    _Angle ("Angle", Range(0, 3.1415)) = 0
    [Space] _MapTex ("MappingTexture", 2D) = "white" {}
    _ImageRatio ("ImageAspectRatio", Range(0, 10)) = 1
    _MapRatio ("MappingTextureAspectRatio", Range(0, 10)) = 1
    _SubTexA ("SUB texture A", 2D) = "white" {}
    [Space] _Tile ("Tile", Range(0.1, 10)) = 1
    _Speed ("Speed", Range(-100, 100)) = 1
    [Space] [Toggle] _Bswitch ("2nd Scroll", float) = 0
    _TileB ("TileB", Range(0.1, 10)) = 1
    _SpeedB ("SpeedB", Range(-100, 100)) = 1
    _StencilComp ("Stencil Comparison", float) = 8
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
      uniform float _Speed;
      uniform float _SpeedB;
      uniform float _Tile;
      uniform float _TileB;
      uniform float _MapRatio;
      uniform float _Bswitch;
      uniform float _sliceType;
      uniform sampler2D _MainTex;
      uniform sampler2D _MapTex;
      uniform sampler2D _SubTexA;
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
      float4 u_xlat0_d;
      float3 u_xlatb0;
      float4 u_xlat1_d;
      float4 u_xlat16_1;
      float4 u_xlat10_1;
      float4 u_xlat2;
      float4 u_xlat16_2_d;
      float4 u_xlat10_2;
      float4 u_xlat3;
      float4 u_xlat16_3_d;
      float4 u_xlat10_3;
      float2 u_xlat16_4;
      float2 u_xlat16_7;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlatb0.xyz = float3(bool4(float4(_sliceType, _sliceType, _Bswitch, _sliceType) == float4(20, 30, 10, 0)).xyz);
          u_xlat16_1.x = u_xlatb0.x;
          u_xlat16_1.y = u_xlatb0.y;
          u_xlat10_1 = tex2D(_MainTex, u_xlat16_1.xy);
          u_xlat16_1 = (u_xlat10_1 + _TextureSampleAdd);
          u_xlat0_d.x = (_Time.x * _Speed);
          u_xlat0_d.x = frac(u_xlat0_d.x);
          u_xlat16_2_d.x = (_ImageRatio / _MapRatio);
          u_xlat16_7.xy = float2((in_f.texcoord2.xy * float2(float2(_Tile, _Tile))));
          u_xlat16_3_d.x = frac(u_xlat16_7.x);
          u_xlat16_7.x = (u_xlat16_7.y / u_xlat16_2_d.x);
          u_xlat16_7.x = ((u_xlat16_7.x * _ImageRatio) + u_xlat0_d.x);
          u_xlat16_3_d.y = frac(u_xlat16_7.x);
          u_xlat0_d.xy = tex2D(_MapTex, u_xlat16_3_d.xy).xz.xy;
          u_xlat10_3 = tex2D(_SubTexA, u_xlat0_d.yx);
          u_xlat16_3_d = (u_xlat10_3 * float4(299999993, 299999993, 299999993, 299999993));
          u_xlatb0.xy = float2(bool4(u_xlat0_d.yxyy < float4(999999978, 999999978, 0, 0)).xy);
          u_xlat0_d.x = u_xlatb0.x;
          u_xlat0_d.y = u_xlatb0.y;
          u_xlat3 = (u_xlat0_d.xxxx * u_xlat16_3_d);
          u_xlat1_d = ((u_xlat3 * u_xlat0_d.yyyy) + u_xlat16_1);
          if(u_xlatb0.z)
          {
              u_xlat0_d.x = (_Time.x * _SpeedB);
              u_xlat0_d.x = frac(u_xlat0_d.x);
              u_xlat16_2_d.yz = (in_f.texcoord2.xy * float2(float2(_TileB, _TileB)));
              u_xlat16_2_d.x = (u_xlat16_2_d.z / u_xlat16_2_d.x);
              u_xlat16_2_d.x = ((u_xlat16_2_d.x * _ImageRatio) + u_xlat0_d.x);
              u_xlat16_4.xy = float2(frac(u_xlat16_2_d.yx));
              u_xlat0_d.xy = tex2D(_MapTex, u_xlat16_4.xy).xz.xy;
              u_xlat10_2 = tex2D(_SubTexA, u_xlat0_d.yx);
              u_xlat16_2_d = (u_xlat10_2 * float4(199999996, 199999996, 199999996, 199999996));
              u_xlatb0.xy = float2(bool4(u_xlat0_d.yxyy < float4(999999978, 999999978, 0, 0)).xy);
              u_xlat0_d.x = u_xlatb0.x;
              u_xlat0_d.y = u_xlatb0.y;
              u_xlat2 = (u_xlat0_d.xxxx * u_xlat16_2_d);
              u_xlat0_d = (((-u_xlat2) * u_xlat0_d.yyyy) + u_xlat1_d);
              out_f.color = u_xlat0_d;
          }
          else
          {
              out_f.color = u_xlat1_d;
          }
          //return float(0);
          //return float(10);
          //return float(0);
          //return float(10);
          //return float(0);
          //return float(10);
          //return float(0);
          //return float(10);
          //return float(5);
          //return in_f.texcoord.y;
          //return float(5);
          //return in_f.texcoord.x;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
