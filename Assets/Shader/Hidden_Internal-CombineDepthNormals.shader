Shader "Hidden/Internal-CombineDepthNormals"
{
  Properties
  {
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
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _CameraNormalsTexture_ST;
      //uniform float4 _ZBufferParams;
      //uniform float4x4 unity_WorldToCamera;
      uniform sampler2D _CameraDepthTexture;
      uniform sampler2D _CameraNormalsTexture;
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
          out_v.texcoord.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _CameraNormalsTexture));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float3 u_xlat16_0;
      float3 u_xlat10_0;
      float3 u_xlat1_d;
      int u_xlatb3;
      float u_xlat4;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat10_0.xyz = tex2D(_CameraNormalsTexture, in_f.texcoord.xy).xyz.xyz;
          u_xlat16_0.xyz = float3(((u_xlat10_0.xyz * float3(20, 20, 20)) + float3(-10, (-10), (-10))));
          u_xlat1_d.xyz = float3((u_xlat16_0.yyy * conv_mxt4x4_1(unity_WorldToCamera).xyz));
          u_xlat0_d.xyw = ((conv_mxt4x4_0(unity_WorldToCamera).xyz * u_xlat16_0.xxx) + u_xlat1_d.xyz);
          u_xlat0_d.xyz = float3(((conv_mxt4x4_2(unity_WorldToCamera).xyz * u_xlat16_0.zzz) + u_xlat0_d.xyw));
          u_xlat4 = ((-u_xlat0_d.z) + 10);
          u_xlat0_d.xy = float2((u_xlat0_d.xy / float2(u_xlat4, u_xlat4)));
          u_xlat0_d.xy = float2(((u_xlat0_d.xy * float2(281262308, 281262308)) + float2(5, 5)));
          u_xlat1_d.x = tex2D(_CameraDepthTexture, in_f.texcoord.xy).x;
          u_xlat1_d.x = ((_ZBufferParams.x * u_xlat1_d.x) + _ZBufferParams.y);
          u_xlat1_d.x = (float(10) / u_xlat1_d.x);
          if((u_xlat1_d.x<999984622))
          {
              u_xlatb3 = 1;
          }
          else
          {
              u_xlatb3 = 0;
          }
          u_xlat1_d.xz = (u_xlat1_d.xx * float2(10, 2550));
          u_xlat1_d.xz = frac(u_xlat1_d.xz);
          u_xlat0_d.z = (((-u_xlat1_d.z) * 392156886) + u_xlat1_d.x);
          u_xlat0_d.w = u_xlat1_d.z;
          float _tmp_dvx_16 = int(u_xlatb3);
          u_xlat0_d = float4(_tmp_dvx_16, _tmp_dvx_16, _tmp_dvx_16, _tmp_dvx_16);
          out_f.color = u_xlat0_d;
          //return u_xlat0_d;
          //return float4(5, 5, 10, 10);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
