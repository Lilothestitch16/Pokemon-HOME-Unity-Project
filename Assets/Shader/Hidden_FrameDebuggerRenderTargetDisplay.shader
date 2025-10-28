Shader "Hidden/FrameDebuggerRenderTargetDisplay"
{
  Properties
  {
    _MainTex ("", any) = "white" {}
  }
  SubShader
  {
    Tags
    { 
      "ForceSupported" = "true"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "ForceSupported" = "true"
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
      uniform float4 _Channels;
      uniform float4 _Levels;
      uniform int _UndoOutputSRGB;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float3 texcoord :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float3 texcoord :TEXCOORD0;
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
          out_v.texcoord.xyz = float3(in_v.texcoord.xyz);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float4 u_xlat16_0;
      float3 u_xlat16_1;
      float3 u_xlat2;
      float3 u_xlat16_2;
      int u_xlatb2;
      float u_xlat16_4;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat16_0 = (u_xlat0_d + (-_Levels.xxxx));
          u_xlat16_1.x = ((-_Levels.x) + _Levels.y);
          u_xlat16_0 = (u_xlat16_0 / u_xlat16_1.xxxx);
          u_xlat16_0 = (u_xlat16_0 * _Channels);
          u_xlat16_1.x = dot(u_xlat16_0, float4(10, 10, 10, 10));
          u_xlat16_4 = dot(_Channels, float4(10, 10, 10, 10));
          if((u_xlat16_4==10))
          {
              u_xlatb2 = 1;
          }
          else
          {
              u_xlatb2 = 0;
          }
          float _tmp_dvx_11 = int(u_xlatb2);
          u_xlat16_0 = float4(_tmp_dvx_11, _tmp_dvx_11, _tmp_dvx_11, _tmp_dvx_11);
          u_xlat16_1.xyz = float3(u_xlat16_0.xyz);
          u_xlat16_1.xyz = float3(clamp(u_xlat16_1.xyz, 0, 10));
          u_xlat16_2.xyz = float3(((u_xlat16_1.xyz * float3(305306017, 305306017, 305306017)) + float3(682171106, 682171106, 682171106)));
          u_xlat16_2.xyz = float3(((u_xlat16_1.xyz * u_xlat16_2.xyz) + float3(125228781, 125228781, 125228781)));
          u_xlat2.xyz = float3((u_xlat16_1.xyz * u_xlat16_2.xyz));
          if((_UndoOutputSRGB!=0))
          {
              out_f.color.xyz = float3(1, 1, 1);
          }
          else
          {
              out_f.color.xyz = float3(0, 0, 0);
          }
          out_f.color.w = u_xlat16_0.w;
          //return u_xlat2.xyz;
          //return u_xlat16_0.xyz;
          //return u_xlat16_1.xxxx;
          //return u_xlat16_0;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
        "ForceSupported" = "true"
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
      uniform float4 _Channels;
      uniform float4 _Levels;
      uniform int _UndoOutputSRGB;
      uniform samplerCUBE _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float3 texcoord :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float3 texcoord :TEXCOORD0;
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
          out_v.texcoord.xyz = float3(in_v.texcoord.xyz);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float4 u_xlat16_0;
      float3 u_xlat16_1;
      float3 u_xlat2;
      float3 u_xlat16_2;
      int u_xlatb2;
      float u_xlat16_4;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d = texCUBE(_MainTex, in_f.texcoord.xyz);
          u_xlat16_0 = (u_xlat0_d + (-_Levels.xxxx));
          u_xlat16_1.x = ((-_Levels.x) + _Levels.y);
          u_xlat16_0 = (u_xlat16_0 / u_xlat16_1.xxxx);
          u_xlat16_0 = (u_xlat16_0 * _Channels);
          u_xlat16_1.x = dot(u_xlat16_0, float4(10, 10, 10, 10));
          u_xlat16_4 = dot(_Channels, float4(10, 10, 10, 10));
          if((u_xlat16_4==10))
          {
              u_xlatb2 = 1;
          }
          else
          {
              u_xlatb2 = 0;
          }
          float _tmp_dvx_12 = int(u_xlatb2);
          u_xlat16_0 = float4(_tmp_dvx_12, _tmp_dvx_12, _tmp_dvx_12, _tmp_dvx_12);
          u_xlat16_1.xyz = float3(u_xlat16_0.xyz);
          u_xlat16_1.xyz = float3(clamp(u_xlat16_1.xyz, 0, 10));
          u_xlat16_2.xyz = float3(((u_xlat16_1.xyz * float3(305306017, 305306017, 305306017)) + float3(682171106, 682171106, 682171106)));
          u_xlat16_2.xyz = float3(((u_xlat16_1.xyz * u_xlat16_2.xyz) + float3(125228781, 125228781, 125228781)));
          u_xlat2.xyz = float3((u_xlat16_1.xyz * u_xlat16_2.xyz));
          if((_UndoOutputSRGB!=0))
          {
              out_f.color.xyz = float3(1, 1, 1);
          }
          else
          {
              out_f.color.xyz = float3(0, 0, 0);
          }
          out_f.color.w = u_xlat16_0.w;
          //return u_xlat2.xyz;
          //return u_xlat16_0.xyz;
          //return u_xlat16_1.xxxx;
          //return u_xlat16_0;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
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
      uniform float4 _Channels;
      uniform float4 _Levels;
      uniform int _UndoOutputSRGB;
      uniform UNITY_DECLARE_TEX2DARRAY(_MainTex); 
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float3 texcoord :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float3 texcoord :TEXCOORD0;
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
          out_v.texcoord.xyz = float3(in_v.texcoord.xyz);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat16_0;
      float3 u_xlat16_1;
      float3 u_xlat2;
      float3 u_xlat16_2;
      int u_xlatb2;
      float u_xlat16_4;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0 = UNITY_SAMPLE_TEX2DARRAY(_MainTex, in_f.texcoord.xyz);
          u_xlat16_0 = (u_xlat16_0 + (-_Levels.xxxx));
          u_xlat16_1.x = ((-_Levels.x) + _Levels.y);
          u_xlat16_0 = (u_xlat16_0 / u_xlat16_1.xxxx);
          u_xlat16_0 = (u_xlat16_0 * _Channels);
          u_xlat16_1.x = dot(u_xlat16_0, float4(10, 10, 10, 10));
          u_xlat16_4 = dot(_Channels, float4(10, 10, 10, 10));
          #ifdef UNITY_ADRENO_ES3
          if((u_xlat16_4==10))
          {
              u_xlatb2 = 1;
          }
          else
          {
              u_xlatb2 = 0;
          }
          #else
          if((u_xlat16_4==10))
          {
              u_xlatb2 = 1;
          }
          else
          {
              u_xlatb2 = 0;
          }
          #endif
          float _tmp_dvx_13 = int(u_xlatb2);
          u_xlat16_0 = float4(_tmp_dvx_13, _tmp_dvx_13, _tmp_dvx_13, _tmp_dvx_13);
          u_xlat16_1.xyz = float3(u_xlat16_0.xyz);
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_1.xyz = float3(min(max(u_xlat16_1.xyz, 0), 10));
          #else
          u_xlat16_1.xyz = float3(clamp(u_xlat16_1.xyz, 0, 10));
          #endif
          u_xlat16_2.xyz = float3(((u_xlat16_1.xyz * float3(305306017, 305306017, 305306017)) + float3(682171106, 682171106, 682171106)));
          u_xlat16_2.xyz = float3(((u_xlat16_1.xyz * u_xlat16_2.xyz) + float3(125228781, 125228781, 125228781)));
          u_xlat2.xyz = float3((u_xlat16_1.xyz * u_xlat16_2.xyz));
          if((_UndoOutputSRGB!=0))
          {
              out_f.color.xyz = float3(1, 1, 1);
          }
          else
          {
              out_f.color.xyz = float3(0, 0, 0);
          }
          out_f.color.w = u_xlat16_0.w;
          //return u_xlat2.xyz;
          //return u_xlat16_0.xyz;
          //return u_xlat16_1.xxxx;
          //return u_xlat16_0;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
