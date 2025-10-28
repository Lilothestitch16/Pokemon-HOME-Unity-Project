Shader "Custom/Circle Shader"
{
  Properties
  {
    _MainTex ("Main texture", 2D) = "white" {}
    _Color ("Tint", Color) = (1,1,1,1)
    _CircleR ("Circle R", Range(0, 1)) = 1
    _CircleW ("Circle W", Range(0.1, 1000)) = 1
    _Alpha ("Alpha", Range(0, 1)) = 1
    _RectSize ("Size", Range(0, 1)) = 1
    _StencilComp ("Stencil Comparison", float) = 8
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
      uniform float4 _TextureSampleAdd;
      uniform int _UseClipRect;
      uniform float4 _ClipRect;
      uniform int _UseAlphaClip;
      uniform float _CircleR;
      uniform float _CircleW;
      uniform float _RectSize;
      uniform float _Alpha;
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
      float4 u_xlat16_0;
      float4 u_xlat1_d;
      float4 u_xlat10_1;
      float4 u_xlatb1;
      float u_xlat16_2;
      float2 u_xlat16_3;
      int u_xlatb4;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0.x = (_CircleW * 400000006);
          u_xlat16_0.x = (u_xlat16_0.x / _RectSize);
          u_xlat16_3.xy = float2((in_f.texcoord.xy + float2(-5, (-5))));
          u_xlat16_3.x = length(u_xlat16_3.xy);
          u_xlat16_3.x = ((-u_xlat16_3.x) + _CircleR);
          if((u_xlat16_3.x<u_xlat16_0.x))
          {
              u_xlatb1.x = 1;
          }
          else
          {
              u_xlatb1.x = 0;
          }
          if((u_xlat16_3.x<0))
          {
              u_xlatb4 = 1;
          }
          else
          {
              u_xlatb4 = 0;
          }
          u_xlat1_d.x = u_xlatb1.x;
          u_xlat16_0.x = u_xlatb4;
          u_xlat10_1 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat1_d = (u_xlat10_1 * _Color);
          u_xlat16_0.x = (u_xlat16_0.x * u_xlat1_d.w);
          u_xlat1_d.w = (u_xlat16_0.x * _Alpha);
          u_xlat16_0 = (u_xlat1_d + _TextureSampleAdd);
          u_xlatb1.xy = float2(bool4(in_f.texcoord1.xyxx >= _ClipRect.xyxx).xy);
          u_xlatb1.zw = bool4(_ClipRect.zzzw >= in_f.texcoord1.xxxy).zw;
          u_xlat1_d = lerp(float4(0, 0, 0, 0), float4(10, 10, 10, 10), float4(u_xlatb1));
          u_xlat1_d.xy = float2((u_xlat1_d.zw * u_xlat1_d.xy));
          u_xlat1_d.x = (u_xlat1_d.y * u_xlat1_d.x);
          u_xlat1_d = (u_xlat16_0 * u_xlat1_d.xxxx);
          if((_UseClipRect!=0))
          {
              u_xlat16_0 = float4(1, 1, 1, 1);
          }
          else
          {
              u_xlat16_0 = float4(0, 0, 0, 0);
          }
          u_xlat16_2 = (u_xlat16_0.w + (-100000005));
          out_f.color = u_xlat16_0;
          if((u_xlat16_2<0))
          {
              u_xlatb1.x = 1;
          }
          else
          {
              u_xlatb1.x = 0;
          }
          if((_UseAlphaClip!=0))
          {
              u_xlatb4 = 1;
          }
          else
          {
              u_xlatb4 = 0;
          }
          u_xlatb1.x = (u_xlatb4 && u_xlatb1.x);
          if(((int(u_xlatb1.x) * (-1))!=0))
          {
              discard;
          }
          //return u_xlat1_d;
          //return u_xlat16_0;
          //return 0;
          //return u_xlat1_d.x;
          //return 10;
          //return float(0);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
