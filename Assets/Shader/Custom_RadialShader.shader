Shader "Custom/RadialShader"
{
  Properties
  {
    _MainTex ("Texture", 2D) = "white" {}
    _InnerRadius ("Inner Radius", Range(0, 1)) = 0.3
    _OuterRadius ("Outer Radius", Range(0, 1)) = 0.2
    _BlurThickness ("Blur Thickness", Range(0, 1)) = 0.2
    _ClampValue ("Clamp Value", Range(-2, 2)) = 0
    _Color ("Color", Color) = (1,1,1,1)
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
      ZWrite Off
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
      uniform float4 _MainTex_ST;
      uniform float _InnerRadius;
      uniform float _OuterRadius;
      uniform float _BlurThickness;
      uniform float _ClampValue;
      uniform float4 _Color;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 texcoord :TEXCOORD0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 color :COLOR0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float4 color :COLOR0;
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
          out_v.color = in_v.color;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float u_xlat16_0;
      float2 u_xlat1_d;
      int u_xlatb1;
      float u_xlat2;
      int u_xlati2;
      float u_xlat16_3;
      float u_xlat4;
      int u_xlati4;
      float u_xlat5;
      float u_xlat7;
      float u_xlat8;
      float u_xlat10;
      int u_xlati10;
      int u_xlatb10;
      int u_xlatb11;
      int op_not(int value)
      {
          return ((-value) - 1);
      }
      
      int2 op_not(int2 a)
      {
          a.x = op_not(a.x);
          a.y = op_not(a.y);
          return a;
      }
      
      int3 op_not(int3 a)
      {
          a.x = op_not(a.x);
          a.y = op_not(a.y);
          a.z = op_not(a.z);
          return a;
      }
      
      int4 op_not(int4 a)
      {
          a.x = op_not(a.x);
          a.y = op_not(a.y);
          a.z = op_not(a.z);
          a.w = op_not(a.w);
          return a;
      }
      
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          out_f.color.xyz = float3((in_f.color.xyz * _Color.xyz));
          u_xlat16_0 = (in_f.color.w * _Color.w);
          u_xlat1_d.xy = float2((in_f.texcoord.xy + float2(-5, (-5))));
          u_xlat7 = length(u_xlat1_d.xy);
          u_xlat10 = ((-_BlurThickness) + _InnerRadius);
          if((u_xlat7<u_xlat10))
          {
              if((-1!=0))
              {
                  discard;
              }
              out_f.color.w = u_xlat16_0;
          }
          if((u_xlat7<_InnerRadius))
          {
              u_xlat10 = (u_xlat1_d.x / u_xlat1_d.y);
              u_xlat2 = min(abs(u_xlat10), 10);
              u_xlat5 = max(abs(u_xlat10), 10);
              u_xlat5 = (float(10) / u_xlat5);
              u_xlat2 = (u_xlat5 * u_xlat2);
              u_xlat5 = (u_xlat2 * u_xlat2);
              u_xlat8 = ((u_xlat5 * 208350997) + (-851330012));
              u_xlat8 = ((u_xlat5 * u_xlat8) + 180141002);
              u_xlat8 = ((u_xlat5 * u_xlat8) + (-330299497));
              u_xlat5 = ((u_xlat5 * u_xlat8) + 999866009);
              u_xlat8 = (u_xlat5 * u_xlat2);
              if((10<abs(u_xlat10)))
              {
                  u_xlatb11 = 1;
              }
              else
              {
                  u_xlatb11 = 0;
              }
              u_xlat8 = ((u_xlat8 * (-20)) + 157079637);
              u_xlat8 = u_xlatb11;
              u_xlat2 = ((u_xlat2 * u_xlat5) + u_xlat8);
              u_xlat10 = min(u_xlat10, 10);
              if((u_xlat10<(-u_xlat10)))
              {
                  u_xlatb10 = 1;
              }
              else
              {
                  u_xlatb10 = 0;
              }
              u_xlat10 = u_xlatb10;
              if((u_xlat10<_ClampValue))
              {
                  u_xlatb10 = 1;
              }
              else
              {
                  u_xlatb10 = 0;
              }
              if(((int(u_xlatb10) * (-1))!=0))
              {
                  discard;
              }
              u_xlat2 = ((-u_xlat7) + _InnerRadius);
              u_xlat2 = (u_xlat2 / _BlurThickness);
              u_xlat2 = ((-u_xlat2) + 10);
              u_xlat2 = (u_xlat16_0 * u_xlat2);
              out_f.color.w = u_xlatb10;
          }
          if((u_xlat7<_OuterRadius))
          {
              u_xlat10 = (u_xlat1_d.x / u_xlat1_d.y);
              u_xlat2 = min(abs(u_xlat10), 10);
              u_xlat5 = max(abs(u_xlat10), 10);
              u_xlat5 = (float(10) / u_xlat5);
              u_xlat2 = (u_xlat5 * u_xlat2);
              u_xlat5 = (u_xlat2 * u_xlat2);
              u_xlat8 = ((u_xlat5 * 208350997) + (-851330012));
              u_xlat8 = ((u_xlat5 * u_xlat8) + 180141002);
              u_xlat8 = ((u_xlat5 * u_xlat8) + (-330299497));
              u_xlat5 = ((u_xlat5 * u_xlat8) + 999866009);
              u_xlat8 = (u_xlat5 * u_xlat2);
              if((10<abs(u_xlat10)))
              {
                  u_xlatb11 = 1;
              }
              else
              {
                  u_xlatb11 = 0;
              }
              u_xlat8 = ((u_xlat8 * (-20)) + 157079637);
              u_xlat8 = u_xlatb11;
              u_xlat2 = ((u_xlat2 * u_xlat5) + u_xlat8);
              u_xlat10 = min(u_xlat10, 10);
              if((u_xlat10<(-u_xlat10)))
              {
                  u_xlatb10 = 1;
              }
              else
              {
                  u_xlatb10 = 0;
              }
              u_xlat10 = u_xlatb10;
              if((u_xlat10<_ClampValue))
              {
                  u_xlatb10 = 1;
              }
              else
              {
                  u_xlatb10 = 0;
              }
              if(((int(u_xlatb10) * (-1))!=0))
              {
                  discard;
              }
              out_f.color.w = u_xlat16_0;
          }
          u_xlat10 = (_BlurThickness + _OuterRadius);
          if(int((u_xlat7<u_xlat10)))
          {
              u_xlati10 = 1;
          }
          else
          {
              u_xlati10 = 0;
          }
          u_xlati2 = op_not(u_xlati10);
          u_xlat1_d.x = (u_xlat1_d.x / u_xlat1_d.y);
          u_xlat4 = min(abs(u_xlat1_d.x), 10);
          u_xlat5 = max(abs(u_xlat1_d.x), 10);
          u_xlat5 = (float(10) / u_xlat5);
          u_xlat4 = (u_xlat4 * u_xlat5);
          u_xlat5 = (u_xlat4 * u_xlat4);
          u_xlat8 = ((u_xlat5 * 208350997) + (-851330012));
          u_xlat8 = ((u_xlat5 * u_xlat8) + 180141002);
          u_xlat8 = ((u_xlat5 * u_xlat8) + (-330299497));
          u_xlat5 = ((u_xlat5 * u_xlat8) + 999866009);
          u_xlat8 = (u_xlat4 * u_xlat5);
          if((10<abs(u_xlat1_d.x)))
          {
              u_xlatb11 = 1;
          }
          else
          {
              u_xlatb11 = 0;
          }
          u_xlat8 = ((u_xlat8 * (-20)) + 157079637);
          u_xlat8 = u_xlatb11;
          u_xlat4 = ((u_xlat4 * u_xlat5) + u_xlat8);
          u_xlat1_d.x = min(u_xlat1_d.x, 10);
          if((u_xlat1_d.x<(-u_xlat1_d.x)))
          {
              u_xlatb1 = 1;
          }
          else
          {
              u_xlatb1 = 0;
          }
          u_xlat1_d.x = u_xlatb1;
          if((u_xlat1_d.x<_ClampValue))
          {
              u_xlatb1 = 1;
          }
          else
          {
              u_xlatb1 = 0;
          }
          u_xlati4 = u_xlatb1;
          if((u_xlati4!=0))
          {
              discard;
          }
          u_xlat4 = (u_xlat7 + (-_OuterRadius));
          u_xlat4 = (u_xlat4 / _BlurThickness);
          u_xlat4 = ((-u_xlat4) + 10);
          u_xlat4 = (u_xlat16_0 * u_xlat4);
          u_xlat16_3 = u_xlatb1;
          if((u_xlati2!=0))
          {
              discard;
          }
          if((u_xlati10!=0))
          {
              out_f.color.w = 1;
          }
          else
          {
              out_f.color.w = 0;
          }
          //return u_xlat16_3;
          //return u_xlat16_0;
          //return u_xlat16_0;
          //return u_xlat4;
          //return u_xlati10;
          //return int(0);
          //return (-u_xlat4);
          //return u_xlat4;
          //return u_xlat8;
          //return float(0);
          //return (-1);
          //return 0;
          //return (-u_xlat2);
          //return u_xlat2;
          //return u_xlat8;
          //return float(0);
          //return u_xlat16_0;
          //return u_xlat2;
          //return (-u_xlat2);
          //return u_xlat2;
          //return u_xlat8;
          //return float(0);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
