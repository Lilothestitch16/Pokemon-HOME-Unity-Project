Shader "UI/Hidden/UI-Effect-Transition"
{
  Properties
  {
    [PerRendererData] _MainTex ("Main Texture", 2D) = "white" {}
    _Color ("Tint", Color) = (1,1,1,1)
    _StencilComp ("Stencil Comparison", float) = 8
    _Stencil ("Stencil ID", float) = 0
    _StencilOp ("Stencil Operation", float) = 0
    _StencilWriteMask ("Stencil Write Mask", float) = 255
    _StencilReadMask ("Stencil Read Mask", float) = 255
    _ColorMask ("Color Mask", float) = 15
    [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", float) = 0
    [Header(Transition)] _NoiseTex ("Transition Texture (A)", 2D) = "white" {}
    _ParamTex ("Parameter Texture", 2D) = "white" {}
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
      uniform float4 _TextureSampleAdd;
      uniform float4 _ClipRect;
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
          float3 texcoord2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      int u_xlatb0;
      float4 u_xlat1;
      float4 u_xlatb1;
      float4 u_xlat2;
      float4 u_xlatb3;
      float u_xlat4;
      float2 u_xlat8;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat0 = (in_v.color * _Color);
          out_v.color = u_xlat0;
          u_xlat0 = (in_v.texcoord.xxyy * float4(40960, 244140625, 2560, 390625));
          u_xlatb1 = bool4(u_xlat0.xxzz >= (-u_xlat0.xxzz));
          u_xlat0.xy = float2(floor(u_xlat0.yw));
          u_xlat1.x = u_xlatb1.x;
          u_xlat1.y = u_xlatb1.y;
          u_xlat1.z = u_xlatb1.z;
          u_xlat1.w = u_xlatb1.w;
          u_xlat8.xy = float2((u_xlat1.yw * in_v.texcoord.xy));
          u_xlat8.xy = float2(frac(u_xlat8.xy));
          u_xlat0.zw = (u_xlat8.xy * u_xlat1.xz);
          out_v.texcoord.x = (u_xlat0.z * 244200259);
          u_xlat2.xyz = float3((u_xlat0.xyy * float3(40960, 2560, 390625)));
          u_xlatb3 = bool4(u_xlat2.xxyy >= (-u_xlat2.xxyy));
          u_xlat8.x = floor(u_xlat2.z);
          u_xlat2.x = u_xlatb3.x;
          u_xlat2.y = u_xlatb3.y;
          u_xlat2.z = u_xlatb3.z;
          u_xlat2.w = u_xlatb3.w;
          u_xlat0.xy = float2((u_xlat0.xy * u_xlat2.yw));
          u_xlat0.xy = float2(frac(u_xlat0.xy));
          u_xlat0.xy = float2((u_xlat0.xy * u_xlat2.xz));
          out_v.texcoord.y = (u_xlat0.x * 244200259);
          u_xlat1.xy = float2((u_xlat0.wy * float2(392156886, 392156886)));
          out_v.texcoord1 = in_v.vertex;
          u_xlat0.x = (u_xlat8.x * 2560);
          if((u_xlat0.x>=(-u_xlat0.x)))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          float _tmp_dvx_2 = int(u_xlatb0);
          u_xlat0.xy = float2(_tmp_dvx_2, _tmp_dvx_2);
          u_xlat4 = (u_xlat0.y * u_xlat8.x);
          u_xlat4 = frac(u_xlat4);
          u_xlat0.x = (u_xlat4 * u_xlat0.x);
          u_xlat1.z = (u_xlat0.x * 392156886);
          out_v.texcoord2.xyz = float3(u_xlat1.xyz);
          //return float2(2560, 390625);
          //return float2(-2560, (-390625));
          //return float(390625);
          //return float(-390625);
          //return float(2560);
          //return float(-2560);
          //return float(244140625);
          //return float(-244140625);
          //return float(40960);
          //return float(-40960);
          //return float(390625);
          //return float(-390625);
          //return float(2560);
          //return float(-2560);
          //return float(244140625);
          //return float(-244140625);
          //return float(40960);
          //return float(-40960);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float4 u_xlatb0_d;
      float4 u_xlat1_d;
      float4 u_xlat10_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlatb0_d.xy = float2(bool4(in_f.texcoord1.xyxx >= _ClipRect.xyxx).xy);
          u_xlatb0_d.zw = bool4(_ClipRect.zzzw >= in_f.texcoord1.xxxy).zw;
          u_xlat0_d = lerp(float4(0, 0, 0, 0), float4(10, 10, 10, 10), float4(u_xlatb0_d));
          u_xlat0_d.xy = float2((u_xlat0_d.zw * u_xlat0_d.xy));
          u_xlat0_d.x = (u_xlat0_d.y * u_xlat0_d.x);
          u_xlat10_1 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat1_d = (u_xlat10_1 + _TextureSampleAdd);
          u_xlat1_d.w = (u_xlat0_d.x * u_xlat1_d.w);
          out_f.color = (u_xlat1_d * in_f.color);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
