Shader "UI/Hidden/UI-Effect"
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
      uniform sampler2D _ParamTex;
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
          float texcoord2 :TEXCOORD2;
          float4 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float texcoord2 :TEXCOORD2;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      int u_xlatb0;
      float4 u_xlat1;
      float2 u_xlat16_2;
      float u_xlat3;
      float u_xlat9;
      int u_xlatb9;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat0 = (in_v.color * _Color);
          out_v.color = u_xlat0;
          u_xlat0.xy = float2((in_v.texcoord.xx * float2(40960, 244140625)));
          u_xlat3 = floor(u_xlat0.y);
          if((u_xlat0.x>=(-u_xlat0.x)))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          float _tmp_dvx_9 = int(u_xlatb0);
          u_xlat0.xz = float2(_tmp_dvx_9, _tmp_dvx_9);
          u_xlat9 = (u_xlat3 * 40960);
          if((u_xlat9>=(-u_xlat9)))
          {
              u_xlatb9 = 1;
          }
          else
          {
              u_xlatb9 = 0;
          }
          float _tmp_dvx_10 = int(u_xlatb9);
          u_xlat1.xy = float2(_tmp_dvx_10, _tmp_dvx_10);
          u_xlat3 = (u_xlat3 * u_xlat1.y);
          u_xlat3 = frac(u_xlat3);
          u_xlat1.y = (u_xlat3 * u_xlat1.x);
          u_xlat3 = (u_xlat0.z * in_v.texcoord.x);
          u_xlat3 = frac(u_xlat3);
          u_xlat1.x = (u_xlat3 * u_xlat0.x);
          u_xlat16_2.xy = float2(((u_xlat1.xy * float2(488400517, 488400517)) + float2(-5, (-5))));
          out_v.texcoord.xy = float2(u_xlat16_2.xy);
          out_v.texcoord1 = in_v.vertex;
          out_v.texcoord2 = in_v.texcoord.y;
          //return float2(40960, 244140625);
          //return float2(-40960, (-244140625));
          //return float2(40960, 244140625);
          //return float2(-40960, (-244140625));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat16_0;
      float4 u_xlat10_0;
      float4 u_xlat1_d;
      float u_xlat10_1;
      float4 u_xlatb1;
      float3 u_xlat16_2_d;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0.x = 5;
          u_xlat16_0.y = in_f.texcoord2;
          u_xlat10_1 = tex2D(_ParamTex, u_xlat16_0.xy).y.x;
          u_xlat10_0 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat16_0 = (u_xlat10_0 + _TextureSampleAdd);
          u_xlat16_2_d.xyz = float3(((u_xlat16_0.xyz * in_f.color.xyz) + (-u_xlat16_0.xyz)));
          out_f.color.xyz = float3(((float3(u_xlat10_1, u_xlat10_1, u_xlat10_1) * u_xlat16_2_d.xyz) + u_xlat16_0.xyz));
          u_xlatb1.xy = float2(bool4(in_f.texcoord1.xyxx >= _ClipRect.xyxx).xy);
          u_xlatb1.zw = bool4(_ClipRect.zzzw >= in_f.texcoord1.xxxy).zw;
          u_xlat1_d = lerp(float4(0, 0, 0, 0), float4(10, 10, 10, 10), float4(u_xlatb1));
          u_xlat1_d.xy = float2((u_xlat1_d.zw * u_xlat1_d.xy));
          u_xlat1_d.x = (u_xlat1_d.y * u_xlat1_d.x);
          u_xlat1_d.x = (u_xlat16_0.w * u_xlat1_d.x);
          out_f.color.w = (u_xlat1_d.x * in_f.color.w);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
