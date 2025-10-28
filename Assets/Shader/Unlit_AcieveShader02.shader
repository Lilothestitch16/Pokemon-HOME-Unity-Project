Shader "Unlit/AcieveShader02"
{
  Properties
  {
    [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
    _BaseW ("Base W", float) = 4
    _BaseH ("Base H", float) = 4
    _Color ("Tint", Color) = (1,1,1,1)
    _BaseColor ("Base Color", Color) = (1,1,1,1)
    _ShadowColor ("Shadow Color", Color) = (1,1,1,1)
    [Enum(Icon,1,BG,2)] _Mat ("MaterialType", float) = 1
    _ColorTex ("ColorTexture", 2D) = "white" {}
    _PatternTexA ("Pattern Texture A", 2D) = "white" {}
    _TileA ("Tile A", Range(1, 500)) = 1
    _PatternTexB ("Pattern Texture B", 2D) = "white" {}
    _TileB ("Tile B", Range(1, 500)) = 1
    _HighlightCycle ("Highlight Cycle", float) = 4
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
      //uniform float4 _Time;
      uniform float4 _BaseColor;
      uniform float4 _ShadowColor;
      uniform float _TileA;
      uniform float _TileB;
      uniform int _Mat;
      uniform sampler2D _MainTex;
      uniform sampler2D _ColorTex;
      uniform sampler2D _PatternTexA;
      uniform sampler2D _PatternTexB;
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
      float4 u_xlat1;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat0 = (in_v.color * _Color);
          out_v.color = u_xlat0;
          out_v.texcoord.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _MainTex));
          out_v.texcoord1 = in_v.vertex;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float4 u_xlat10_0;
      float4 u_xlat16_1;
      float4 u_xlat2;
      float3 u_xlat16_2;
      float2 u_xlat3;
      float3 u_xlat16_3;
      float3 u_xlat10_3;
      float4 u_xlat4;
      float u_xlat10_4;
      int u_xlatb4;
      float3 u_xlat5;
      float3 u_xlat6;
      float u_xlat7;
      float3 u_xlat16_8;
      float u_xlat9;
      float u_xlat10_9;
      int u_xlatb9;
      float3 u_xlat16_10;
      float3 u_xlat14;
      float u_xlat16_19;
      float u_xlat22;
      float u_xlat16_28;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat10_0 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat16_1.xyz = float3((_ShadowColor.xyz + float3(-10, (-10), (-10))));
          u_xlat16_1.xyz = float3(((u_xlat10_0.yyy * u_xlat16_1.xyz) + float3(10, 10, 10)));
          if((_Mat==1))
          {
              u_xlat16_2.xy = float2((u_xlat10_0.zz * float2(499999969, 5)));
              u_xlat9 = ((_Time.x * 40) + u_xlat16_2.y);
              u_xlat3.y = frac(u_xlat9);
              u_xlat3.x = in_f.texcoord.x;
              u_xlat10_3.xyz = tex2D(_ColorTex, u_xlat3.xy).xyz.xyz;
              u_xlat16_2.x = u_xlat16_2.x;
              u_xlat16_2.x = clamp(u_xlat16_2.x, 0, 10);
              u_xlat16_28 = ((u_xlat16_2.x * (-20)) + 30);
              u_xlat16_2.x = (u_xlat16_2.x * u_xlat16_2.x);
              u_xlat16_28 = (u_xlat16_28 * u_xlat16_2.x);
              u_xlat16_3.xyz = float3(((-u_xlat16_1.xyz) + u_xlat10_3.xyz));
              u_xlat16_3.xyz = float3(((float3(u_xlat16_28, u_xlat16_28, u_xlat16_28) * u_xlat16_3.xyz) + u_xlat16_1.xyz));
              u_xlat16_3.xyz = float3(u_xlat16_3.xyz);
          }
          else
          {
              u_xlat16_28 = (u_xlat10_0.w * 111111116);
              u_xlat16_28 = clamp(u_xlat16_28, 0, 10);
              u_xlat16_2.x = ((u_xlat16_28 * (-20)) + 30);
              u_xlat16_28 = (u_xlat16_28 * u_xlat16_28);
              u_xlat16_28 = (u_xlat16_28 * u_xlat16_2.x);
              u_xlat16_2.xyz = float3(((-u_xlat16_1.xyz) + _BaseColor.xyz));
              u_xlat16_3.xyz = float3(((float3(u_xlat16_28, u_xlat16_28, u_xlat16_28) * u_xlat16_2.xyz) + u_xlat16_1.xyz));
          }
          u_xlat9 = ((_Time.x * 90) + in_f.texcoord.y);
          u_xlat9 = (u_xlat9 + (-in_f.texcoord.x));
          u_xlat16_1.x = frac(u_xlat9);
          if((u_xlat9>=(-u_xlat9)))
          {
              u_xlatb4 = 1;
          }
          else
          {
              u_xlatb4 = 0;
          }
          float _tmp_dvx_0 = int(u_xlatb4);
          u_xlat16_10.xy = float2(_tmp_dvx_0, _tmp_dvx_0);
          u_xlat16_19 = (u_xlat9 * u_xlat16_10.y);
          u_xlat16_19 = frac(u_xlat16_19);
          u_xlat16_10.x = (u_xlat16_19 * u_xlat16_10.x);
          if((u_xlat16_10.x>=0))
          {
              u_xlatb9 = 1;
          }
          else
          {
              u_xlatb9 = 0;
          }
          u_xlat16_10.x = u_xlatb9;
          u_xlat16_1.x = (u_xlat16_10.x * u_xlat16_1.x);
          u_xlat2 = (in_f.texcoord.xyxy * float4(_TileA, _TileA, _TileB, _TileB));
          u_xlat4.xy = float2(frac(u_xlat2.xz));
          u_xlat5.xy = float2((u_xlat2.yw * float2(5, 5)));
          u_xlat4.zw = frac(u_xlat5.xy);
          u_xlat9 = ((_Time.x * 80) + 449999988);
          u_xlat5.x = (in_f.texcoord.x * 31415);
          u_xlat9 = ((in_f.texcoord.x * 31415) + u_xlat9);
          u_xlat6.x = cos(u_xlat9);
          u_xlat6.z = sin((-u_xlat9));
          u_xlat6.y = 0;
          u_xlat14.xyz = float3((u_xlat6.xyz * float3(24000001, 800000012, 24000001)));
          u_xlat16_10.xyz = float3((u_xlat16_3.xyz + u_xlat16_3.xyz));
          u_xlat10_9 = tex2D(_PatternTexA, u_xlat4.xz).x;
          u_xlat9 = ((_Time.x * 60) + u_xlat10_9);
          u_xlat9 = frac(u_xlat9);
          u_xlat9 = ((-u_xlat9) + 5);
          u_xlat9 = ((-abs(u_xlat9)) + 5);
          u_xlat6.xyz = float3((float3(u_xlat9, u_xlat9, u_xlat9) * u_xlat16_10.xyz));
          u_xlat14.xyz = float3((u_xlat14.xyz * u_xlat6.xyz));
          u_xlat16_10.xy = float2((u_xlat10_0.zx * float2(499999969, 899999976)));
          u_xlat16_10.x = u_xlat16_10.x;
          u_xlat16_10.x = clamp(u_xlat16_10.x, 0, 10);
          u_xlat16_28 = ((u_xlat16_10.x * (-20)) + 30);
          u_xlat16_10.x = (u_xlat16_10.x * u_xlat16_10.x);
          u_xlat16_10.x = (u_xlat16_10.x * u_xlat16_28);
          u_xlat0_d.xyz = float3((u_xlat16_10.xxx * u_xlat14.xyz));
          u_xlat16_1.x = (u_xlat16_1.x * 31415);
          u_xlat16_1.x = sin(u_xlat16_1.x);
          u_xlat0_d.xyz = float3((((-u_xlat0_d.xyz) * u_xlat16_1.xxx) + u_xlat16_3.xyz));
          u_xlat4.x = ((_Time.x * 70) + u_xlat5.x);
          u_xlat6.x = cos(u_xlat4.x);
          u_xlat4.x = sin(u_xlat4.x);
          u_xlat22 = ((_Time.x * 120) + u_xlat5.x);
          u_xlat22 = (u_xlat22 + 449999988);
          u_xlat5.x = sin(u_xlat22);
          u_xlat7 = cos(u_xlat22);
          u_xlat4.x = (u_xlat4.x * 300000012);
          u_xlat5.x = (u_xlat4.x * u_xlat5.x);
          u_xlat5.z = (u_xlat4.x * u_xlat7);
          u_xlat5.y = u_xlat6.x;
          u_xlat5.xyz = float3((u_xlat5.xyz * float3(5, 150000006, 5)));
          u_xlat16_8.xyz = float3((u_xlat0_d.xyz + u_xlat0_d.xyz));
          u_xlat10_4 = tex2D(_PatternTexB, u_xlat4.yw).x;
          u_xlat4.x = ((_Time.x * 70) + u_xlat10_4);
          u_xlat4.x = frac(u_xlat4.x);
          u_xlat4.x = ((-u_xlat4.x) + 5);
          u_xlat4.x = ((-abs(u_xlat4.x)) + 5);
          u_xlat4.xyz = float3((u_xlat4.xxx * u_xlat16_8.xyz));
          u_xlat4.xyz = float3((u_xlat5.xyz * u_xlat4.xyz));
          u_xlat4.xyz = float3((u_xlat16_10.xxx * u_xlat4.xyz));
          u_xlat0_d.xyz = float3((((-u_xlat4.xyz) * u_xlat16_1.xxx) + u_xlat0_d.xyz));
          u_xlat16_1.xyw = ((-u_xlat0_d.xyz) + _BaseColor.xyz);
          out_f.color.xyz = float3(((u_xlat16_10.yyy * u_xlat16_1.xyw) + u_xlat0_d.xyz));
          u_xlat16_1.x = (u_xlat10_0.w * in_f.color.w);
          out_f.color.w = (u_xlat10_0.w * u_xlat16_1.x);
          //return 10;
          //return 0;
          //return float2(10, 10);
          //return float2(-10, (-10));
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
