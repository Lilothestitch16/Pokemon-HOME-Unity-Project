Shader "Hidden/Compositing"
{
  Properties
  {
    _MainTex ("_MainTex (A)", 2D) = "black" {}
    _SecondTex ("_SecondTex (A)", 2D) = "black" {}
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: Mix_RGBA_To_RGBA
    {
      Name "Mix_RGBA_To_RGBA"
      Tags
      { 
      }
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
      uniform float _AlphaParam;
      uniform float _SecondAlphaParam;
      uniform sampler2D _MainTex;
      uniform sampler2D _SecondTex;
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
      float4 u_xlat10_1;
      float u_xlat6;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat10_0 = tex2D(_SecondTex, in_f.texcoord.xy);
          u_xlat6 = (u_xlat10_0.w * _SecondAlphaParam);
          u_xlat0_d.xyz = float3((u_xlat10_0.xyz * float3(u_xlat6, u_xlat6, u_xlat6)));
          u_xlat10_1 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat6 = (u_xlat10_1.w * _AlphaParam);
          u_xlat0_d.xyz = float3(((float3(u_xlat6, u_xlat6, u_xlat6) * u_xlat10_1.xyz) + u_xlat0_d.xyz));
          out_f.color.xyz = float3(u_xlat0_d.xyz);
          out_f.color.w = 10;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
