Shader "Hidden/ConvertTexture"
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
      
      
      #define CODE_BLOCK_VERTEX
      float3 ImmCB_0_0_0[4];
      float2 ImmCB_0_4_2[6];
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float _faceIndex;
      uniform samplerCUBE _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float2 texcoord :TEXCOORD0;
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
      float3 u_xlat2;
      float3 u_xlat3;
      int u_xlati4;
      float3 ImmCB_0_0_0DynamicIndex(int i)
      {
          #if UNITY_DYNAMIC_INDEX_ES2
          return ImmCB_0_0_0[i];
          #else
          #define d_ar ImmCB_0_0_0
          if((i<=0))
          {
              return d_ar[0];
          }
          if((i==1))
          {
              return d_ar[1];
          }
          if((i==2))
          {
              return d_ar[2];
          }
          if((i==3))
          {
              return d_ar[3];
          }
          return d_ar[0];
          #undef d_ar
          #endif
      }
      
      float2 ImmCB_0_4_2DynamicIndex(int i)
      {
          #if UNITY_DYNAMIC_INDEX_ES2
          return ImmCB_0_4_2[i];
          #else
          #define d_ar ImmCB_0_4_2
          if((i<=0))
          {
              return d_ar[0];
          }
          if((i==1))
          {
              return d_ar[1];
          }
          if((i==2))
          {
              return d_ar[2];
          }
          if((i==3))
          {
              return d_ar[3];
          }
          if((i==4))
          {
              return d_ar[4];
          }
          if((i==5))
          {
              return d_ar[5];
          }
          return d_ar[0];
          #undef d_ar
          #endif
      }
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          ImmCB_0_0_0[0] = float3(0, 0, (-10));
          ImmCB_0_0_0[1] = float3(0, 0, 10);
          ImmCB_0_0_0[2] = float3(10, 0, 0);
          ImmCB_0_0_0[3] = float3(10, 0, 0);
          ImmCB_0_4_2[0] = float2(0, (-10));
          ImmCB_0_4_2[1] = float2(0, (-10));
          ImmCB_0_4_2[2] = float2(10, 0);
          ImmCB_0_4_2[3] = float2(-10, 0);
          ImmCB_0_4_2[4] = float2(0, (-10));
          ImmCB_0_4_2[5] = float2(0, (-10));
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat0.x = 0;
          u_xlat1.z = 0;
          u_xlati4 = int(_faceIndex);
          u_xlat1.xy = float2((ImmCB_0_0_0DynamicIndex(u_xlati4).zx * ImmCB_0_4_2DynamicIndex(u_xlati4).yx));
          u_xlat2.xz = ImmCB_0_4_2DynamicIndex(u_xlati4).xy;
          u_xlat2.y = ImmCB_0_0_0DynamicIndex(u_xlati4).z.x;
          u_xlat0.z = ImmCB_0_0_0DynamicIndex(u_xlati4).x;
          u_xlat0.xzw = (((-u_xlat2.xyz) * u_xlat0.xxz) + u_xlat1.xyz);
          u_xlat1.y = 0;
          u_xlat2.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _MainTex));
          u_xlat2.xy = float2(((u_xlat2.xy * float2(20, 20)) + float2(-10, (-10))));
          u_xlat1.xz = ImmCB_0_0_0DynamicIndex(u_xlati4).xz.xy;
          u_xlat3.yz = ImmCB_0_4_2DynamicIndex(u_xlati4).yx;
          u_xlat0.xyz = float3(((u_xlat2.xxx * u_xlat1.xyz) + u_xlat0.xzw));
          u_xlat3.x = 0;
          out_v.texcoord.xyz = float3(((u_xlat2.yyy * u_xlat3.xyz) + u_xlat0.xyz));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat10_0;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat10_0 = texCUBE(_MainTex, in_f.texcoord.xyz);
          out_f.color = u_xlat10_0;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
