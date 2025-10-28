Shader "Hidden/Internal-CubemapToEquirect"
{
  Properties
  {
    _MainTex ("Texture", Cube) = "" {}
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
      }
      ZTest Always
      ZWrite Off
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform samplerCUBE _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float2 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
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
          out_v.texcoord.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _MainTex));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float4 u_xlat10_0;
      float2 u_xlat1_d;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = float2(((in_f.texcoord.xy * float2(628318548, 314159274)) + float2(-314159274, (-157079637))));
          float _tmp_dvx_29 = cos(u_xlat0_d.xy);
          u_xlat1_d.xy = float2(_tmp_dvx_29, _tmp_dvx_29);
          float _tmp_dvx_30 = sin(u_xlat0_d.xy);
          u_xlat0_d.xy = float2(_tmp_dvx_30, _tmp_dvx_30);
          u_xlat0_d.x = (u_xlat0_d.x * u_xlat1_d.y);
          u_xlat0_d.z = (u_xlat1_d.y * u_xlat1_d.x);
          u_xlat10_0 = texCUBE(_MainTex, u_xlat0_d.xyz);
          out_f.color = u_xlat10_0;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
