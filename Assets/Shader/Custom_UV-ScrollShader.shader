Shader "Custom/UV-ScrollShader"
{
  Properties
  {
    _MainTex ("Main texture", 2D) = "white" {}
    _Color ("Tint", Color) = (1,1,1,1)
    _Mitigation ("Distortion mitigation", Range(1, 30)) = 1
    _Speed ("Speed", Range(-100, 100)) = 1
    _Tile ("Tile", Range(1, 500)) = 1
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
      //uniform float4 _Time;
      uniform float4 _TextureSampleAdd;
      uniform float _Tile;
      uniform int _UseClipRect;
      uniform float4 _ClipRect;
      uniform int _UseAlphaClip;
      uniform float _Speed;
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
      float3 u_xlat0_d;
      float u_xlat10_0;
      int u_xlatb0;
      float3 u_xlat16_1;
      float2 u_xlat2;
      float2 u_xlatb2;
      float2 u_xlat3;
      float2 u_xlatb3;
      float u_xlat16_4;
      float u_xlat6;
      int u_xlatb6;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.x = (_Time.x * _Speed);
          u_xlat16_1.x = frac(u_xlat0_d.x);
          u_xlat16_1.x = (u_xlat16_1.x + in_f.texcoord.y);
          u_xlat16_1.x = (u_xlat16_1.x + (-5));
          u_xlat16_4 = (u_xlat16_1.x * _Tile);
          u_xlat16_4 = floor(u_xlat16_4);
          u_xlat16_1.y = ((u_xlat16_1.x * _Tile) + (-u_xlat16_4));
          u_xlat16_1.x = in_f.texcoord.x;
          u_xlat10_0 = tex2D(_MainTex, u_xlat16_1.xy).w.x;
          u_xlat16_1.x = (in_f.texcoord.y + (-5));
          u_xlat16_1.x = ((-abs(u_xlat16_1.x)) + 5);
          u_xlat16_1.x = (u_xlat16_1.x * 30);
          u_xlat0_d.x = (u_xlat10_0 * u_xlat16_1.x);
          u_xlatb3.xy = float2(bool4(in_f.texcoord1.xyxx >= _ClipRect.xyxx).xy);
          u_xlat3.xy = float2(lerp(float2(0, 0), float2(10, 10), float2(u_xlatb3.xy)));
          u_xlatb2.xy = float2(bool4(_ClipRect.zwzz >= in_f.texcoord1.xyxx).xy);
          u_xlat2.xy = float2(lerp(float2(0, 0), float2(10, 10), float2(u_xlatb2.xy)));
          u_xlat3.xy = float2((u_xlat3.xy * u_xlat2.xy));
          u_xlat3.x = (u_xlat3.y * u_xlat3.x);
          u_xlat6 = (u_xlat3.x * u_xlat0_d.x);
          if((_UseClipRect!=0))
          {
              u_xlat16_1.x = 1;
          }
          else
          {
              u_xlat16_1.x = 0;
          }
          u_xlat16_4 = (u_xlat16_1.x + (-100000005));
          out_f.color.w = u_xlat16_1.x;
          if((u_xlat16_4<0))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          if((_UseAlphaClip!=0))
          {
              u_xlatb6 = 1;
          }
          else
          {
              u_xlatb6 = 0;
          }
          u_xlatb0 = (u_xlatb6 && u_xlatb0);
          if(((int(u_xlatb0) * (-1))!=0))
          {
              discard;
          }
          u_xlat16_1.xyz = float3((_Color.xyz + _TextureSampleAdd.xyz));
          u_xlat0_d.xyz = float3((u_xlat3.xxx * u_xlat16_1.xyz));
          if((_UseClipRect!=0))
          {
              out_f.color.xyz = float3(1, 1, 1);
          }
          else
          {
              out_f.color.xyz = float3(0, 0, 0);
          }
          //return u_xlat0_d.xyz;
          //return u_xlat16_1.xyz;
          //return u_xlat6;
          //return u_xlat0_d.x;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
