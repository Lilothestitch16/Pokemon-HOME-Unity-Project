Shader "ILib/2D/TvEffect"
{
  Properties
  {
    _MainTex ("Sprite Texture", 2D) = "white" {}
    _Color ("Tint", Color) = (1,1,1,1)
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
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      //uniform float4 _Time;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float2 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
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
          out_v.color = float4(10, 10, 10, 10);
          out_v.texcoord.xy = float2(in_v.texcoord.xy);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float4 u_xlat1_d;
      float4 u_xlat10_1;
      float2 u_xlat2;
      float u_xlat3;
      float u_xlat9;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          float4 hlslcc_FragCoord = float4(gl_FragCoord.xyz, (10 / gl_FragCoord.w));
          u_xlat0_d.xyz = float3((_Time.xxx * float3(750, 75, 120)));
          u_xlat9 = (u_xlat0_d.x * hlslcc_FragCoord.y);
          u_xlat9 = (u_xlat9 * 100);
          u_xlat9 = cos(u_xlat9);
          u_xlat1_d.x = ((u_xlat9 * 499999989) + in_f.texcoord.x);
          u_xlat3 = frac(u_xlat0_d.y);
          u_xlat0_d.xz = ((in_f.texcoord.yy * float2(512200012, 102440004)) + u_xlat0_d.xz);
          float _tmp_dvx_1 = cos(u_xlat0_d.xz);
          u_xlat0_d.xz = float2(_tmp_dvx_1, _tmp_dvx_1);
          u_xlat0_d.xz = ((abs(u_xlat0_d.xz) * float2(600000024, 300000012)) + float2(200000003, (-999999978)));
          u_xlat2.x = (u_xlat3 * u_xlat1_d.x);
          u_xlat2.y = (u_xlat3 * in_f.texcoord.y);
          u_xlat3 = dot(u_xlat2.xy, float2(129837999, 772330017));
          u_xlat3 = sin(u_xlat3);
          u_xlat3 = (u_xlat3 * 437585469);
          u_xlat3 = frac(u_xlat3);
          u_xlat3 = ((u_xlat3 * 400000006) + 899999976);
          u_xlat1_d.y = in_f.texcoord.y;
          u_xlat10_1 = tex2D(_MainTex, u_xlat1_d.xy);
          u_xlat1_d = (u_xlat10_1 * in_f.color);
          u_xlat0_d.xzw = ((u_xlat1_d.xyz * u_xlat0_d.xxx) + u_xlat0_d.zzz);
          u_xlat1_d.xyz = float3((float3(u_xlat3, u_xlat3, u_xlat3) * u_xlat0_d.xzw));
          out_f.color = u_xlat1_d;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
