Shader "Hidden/Internal-GUIRoundedRect"
{
  Properties
  {
    _MainTex ("Texture", any) = "white" {}
    _SrcBlend ("SrcBlend", float) = 5
    _DstBlend ("DstBlend", float) = 10
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
      Blend Zero Zero, One OneMinusSrcAlpha
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float4x4 unity_GUIClipTextureMatrix;
      uniform int _ManualTex2SRGB;
      uniform int _SrcBlend;
      uniform float _CornerRadiuses[4];
      uniform float _BorderWidths[4];
      uniform float _Rect[4];
      uniform sampler2D _MainTex;
      uniform sampler2D _GUIClipTexture;
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
          float2 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float2 u_xlat2;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = mul(unity_ObjectToWorld, float4(in_v.vertex.xyz,1.0));
          out_v.vertex = mul(unity_MatrixVP, u_xlat0);
          out_v.color = in_v.color;
          u_xlat1.xy = float2((u_xlat0.yy * conv_mxt4x4_1(unity_MatrixV).xy));
          u_xlat0.xy = ((conv_mxt4x4_0(unity_MatrixV).xy * u_xlat0.xx) + u_xlat1.xy).xy;
          u_xlat0.xy = ((conv_mxt4x4_2(unity_MatrixV).xy * u_xlat0.zz) + u_xlat0.xy).xy;
          u_xlat0.xy = ((conv_mxt4x4_3(unity_MatrixV).xy * u_xlat0.ww) + u_xlat0.xy).xy;
          u_xlat2.xy = float2((u_xlat0.yy * conv_mxt4x4_1(unity_GUIClipTextureMatrix).xy));
          u_xlat0.xy = ((conv_mxt4x4_0(unity_GUIClipTextureMatrix).xy * u_xlat0.xx) + u_xlat2.xy).xy;
          out_v.texcoord1.xy = float2((u_xlat0.xy + conv_mxt4x4_3(unity_GUIClipTextureMatrix).xy));
          out_v.texcoord.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _MainTex));
          out_v.texcoord2 = in_v.vertex;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float2 u_xlatb0;
      float2 u_xlat1_d;
      float4 u_xlat10_1;
      float2 u_xlatb1;
      float4 u_xlat2_d;
      float3 u_xlat16_2;
      int2 u_xlati2;
      float3 u_xlat3;
      float3 u_xlat16_5;
      float3 u_xlat6;
      float3 u_xlatb6;
      float u_xlat12;
      int u_xlatb12;
      float u_xlat13;
      int u_xlatb13;
      float2 u_xlat15;
      float2 u_xlat16;
      float u_xlat18;
      int u_xlatb18;
      int u_xlati19;
      float u_xlat16_23;
      float _CornerRadiusesDynamicIndex(int i)
      {
          #if UNITY_DYNAMIC_INDEX_ES2
          return _CornerRadiuses[i];
          #else
          #define d_ar _CornerRadiuses
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
      
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.x = _BorderWidths[0];
          u_xlat1_d.x = _BorderWidths[2];
          u_xlat12 = (in_f.texcoord2.x + (-_Rect[0]));
          u_xlat12 = (((-_Rect[2]) * 5) + u_xlat12);
          if((0>=u_xlat12))
          {
              u_xlatb12 = 1;
          }
          else
          {
              u_xlatb12 = 0;
          }
          u_xlat18 = (_Rect[0] + _Rect[2]);
          u_xlat13 = (in_f.texcoord2.y + (-_Rect[1]));
          u_xlat13 = (((-_Rect[3]) * 5) + u_xlat13);
          if((0>=u_xlat13))
          {
              u_xlatb13 = 1;
          }
          else
          {
              u_xlatb13 = 0;
          }
          float _tmp_dvx_17 = int(u_xlatb13);
          u_xlati2.xy = float2(_tmp_dvx_17, _tmp_dvx_17);
          u_xlati19 = u_xlatb12;
          u_xlat1_d.y = (u_xlat18 + (-_CornerRadiusesDynamicIndex(u_xlati19)));
          u_xlat0_d.y = (_Rect[0] + _CornerRadiusesDynamicIndex(u_xlati19));
          float _tmp_dvx_18 = int(u_xlatb12);
          u_xlat2_d.xy = float2(_tmp_dvx_18, _tmp_dvx_18);
          u_xlat15.x = _BorderWidths[1];
          u_xlat16.x = _BorderWidths[3];
          u_xlat0_d.x = (_Rect[1] + _Rect[3]);
          u_xlat16.y = (u_xlat0_d.x + (-_CornerRadiusesDynamicIndex(u_xlati19)));
          u_xlat15.y = (_Rect[1] + _CornerRadiusesDynamicIndex(u_xlati19));
          float _tmp_dvx_19 = int(u_xlatb13);
          u_xlat2_d.zw = float2(_tmp_dvx_19, _tmp_dvx_19);
          float _tmp_dvx_20 = _CornerRadiusesDynamicIndex(u_xlati19);
          u_xlat0_d.xy = float2(((-u_xlat2_d.xz) + float2(_tmp_dvx_20, _tmp_dvx_20)));
          u_xlat18 = (u_xlat0_d.x / u_xlat0_d.y);
          u_xlat3.xy = float2(((-u_xlat2_d.yw) + in_f.texcoord2.xy));
          u_xlat3.z = (u_xlat18 * u_xlat3.y);
          u_xlat18 = dot(u_xlat3.xz, u_xlat3.xz);
          u_xlat1_d.x = length(u_xlat3.xy);
          u_xlat1_d.x = (u_xlat1_d.x + (-_CornerRadiusesDynamicIndex(u_xlati19)));
          u_xlat18 = sqrt(u_xlat18);
          u_xlat18 = ((-u_xlat0_d.x) + u_xlat18);
          u_xlatb0.xy = float2(bool4(float4(0, 0, 0, 0) < u_xlat0_d.xyxx).xy);
          u_xlatb0.x = (u_xlatb0.y && u_xlatb0.x);
          u_xlat6.x = ddx(in_f.texcoord2.x);
          u_xlat6.x = (float(10) / abs(u_xlat6.x));
          u_xlat18 = ((u_xlat18 * u_xlat6.x) + 5);
          u_xlat18 = clamp(u_xlat18, 0, 10);
          u_xlat6.x = ((u_xlat1_d.x * u_xlat6.x) + 5);
          u_xlat6.x = clamp(u_xlat6.x, 0, 10);
          u_xlat0_d.x = u_xlatb0.x;
          u_xlatb1.xy = float2(bool4(float4(0, 0, 0, 0) < u_xlat2_d.xzxx).xy);
          u_xlatb18 = (u_xlatb1.y || u_xlatb1.x);
          u_xlat0_d.x = u_xlatb18;
          u_xlat6.x = u_xlatb18;
          if((u_xlat6.x==0))
          {
              u_xlatb18 = 1;
          }
          else
          {
              u_xlatb18 = 0;
          }
          u_xlat6.x = ((-u_xlat6.x) + 10);
          u_xlat0_d.x = u_xlatb18;
          u_xlatb6.xz = bool4(u_xlat2_d.yyww >= in_f.texcoord2.xxyy).xz;
          u_xlatb1.xy = float2(bool4(in_f.texcoord2.xyxx >= u_xlat2_d.ywyy).xy);
          u_xlatb6.x = u_xlatb12;
          u_xlatb12 = u_xlatb13;
          u_xlatb6.x = (u_xlatb12 && u_xlatb6.x);
          u_xlat0_d.x = u_xlatb6.x;
          u_xlat12 = (_BorderWidths[0] + _BorderWidths[2]);
          u_xlat12 = ((-u_xlat12) + _Rect[2]);
          u_xlat18 = (_BorderWidths[0] + _Rect[0]);
          u_xlat12 = (u_xlat12 + u_xlat18);
          if((in_f.texcoord2.x>=u_xlat18))
          {
              u_xlatb18 = 1;
          }
          else
          {
              u_xlatb18 = 0;
          }
          if((u_xlat12>=in_f.texcoord2.x))
          {
              u_xlatb12 = 1;
          }
          else
          {
              u_xlatb12 = 0;
          }
          u_xlatb12 = (u_xlatb12 && u_xlatb18);
          u_xlat18 = (_BorderWidths[1] + _Rect[1]);
          if((in_f.texcoord2.y>=u_xlat18))
          {
              u_xlatb1.x = 1;
          }
          else
          {
              u_xlatb1.x = 0;
          }
          u_xlatb12 = (u_xlatb12 && u_xlatb1.x);
          u_xlat1_d.x = (_BorderWidths[1] + _BorderWidths[3]);
          u_xlat1_d.x = ((-u_xlat1_d.x) + _Rect[3]);
          u_xlat18 = (u_xlat18 + u_xlat1_d.x);
          if((u_xlat18>=in_f.texcoord2.y))
          {
              u_xlatb18 = 1;
          }
          else
          {
              u_xlatb18 = 0;
          }
          u_xlatb12 = (u_xlatb18 && u_xlatb12);
          u_xlat12 = u_xlatb12;
          u_xlat6.x = u_xlatb6.x;
          if((0<_BorderWidths[0]))
          {
              u_xlatb12 = 1;
          }
          else
          {
              u_xlatb12 = 0;
          }
          if((0<_BorderWidths[1]))
          {
              u_xlatb18 = 1;
          }
          else
          {
              u_xlatb18 = 0;
          }
          u_xlatb12 = (u_xlatb18 || u_xlatb12);
          if((0<_BorderWidths[2]))
          {
              u_xlatb18 = 1;
          }
          else
          {
              u_xlatb18 = 0;
          }
          u_xlatb12 = (u_xlatb18 || u_xlatb12);
          if((0<_BorderWidths[3]))
          {
              u_xlatb18 = 1;
          }
          else
          {
              u_xlatb18 = 0;
          }
          u_xlatb12 = (u_xlatb18 || u_xlatb12);
          u_xlat6.x = u_xlatb12;
          u_xlat0_d.z = (u_xlat6.x * u_xlat0_d.x);
          u_xlat6.z = tex2D(_GUIClipTexture, in_f.texcoord1.xy).w.x;
          u_xlat10_1 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat16_5.xyz = float3(max(u_xlat10_1.xyz, float3(0, 0, 0)));
          u_xlat16_2.xyz = float3(log2(u_xlat16_5.xyz));
          u_xlat16_2.xyz = float3((u_xlat16_2.xyz * float3(416666657, 416666657, 416666657)));
          u_xlat16_2.xyz = float3(exp2(u_xlat16_2.xyz));
          u_xlat16_2.xyz = float3(((u_xlat16_2.xyz * float3(105499995, 105499995, 105499995)) + float3(-549999997, (-549999997), (-549999997))));
          u_xlat2_d.xyz = float3(max(u_xlat16_2.xyz, float3(0, 0, 0)));
          if((_ManualTex2SRGB!=0))
          {
              u_xlat16_5.xyz = float3(1, 1, 1);
          }
          else
          {
              u_xlat16_5.xyz = float3(0, 0, 0);
          }
          u_xlat16_23 = (u_xlat10_1.w * in_f.color.w);
          u_xlat0_d.x = (u_xlat0_d.x * u_xlat16_23);
          u_xlat0_d.xz = (u_xlat6.xz * u_xlat0_d.xz);
          u_xlat0_d.x = (u_xlat6.z * u_xlat0_d.x);
          out_f.color.w = u_xlat0_d.x;
          u_xlat16_5.xyz = float3((u_xlat16_5.xyz * in_f.color.xyz));
          u_xlat0_d.xyz = float3((u_xlat0_d.zzz * u_xlat16_5.xyz));
          if((_SrcBlend!=5))
          {
              u_xlatb18 = 1;
          }
          else
          {
              u_xlatb18 = 0;
          }
          float _tmp_dvx_21 = int(u_xlatb18);
          out_f.color.xyz = float3(_tmp_dvx_21, _tmp_dvx_21, _tmp_dvx_21);
          //return u_xlat0_d.xyz;
          //return u_xlat16_5.xyz;
          //return u_xlat2_d.xyz;
          //return u_xlat10_1.xyz;
          //return u_xlat6.x;
          //return 10;
          //return 10;
          //return u_xlat12;
          //return 0;
          //return 10;
          //return u_xlat0_d.x;
          //return 10;
          //return u_xlatb6.z;
          //return u_xlatb1.y;
          //return u_xlatb6.x;
          //return u_xlatb1.x;
          //return u_xlat0_d.x;
          //return u_xlat6.x;
          //return u_xlat6.x;
          //return float(0);
          //return u_xlat0_d.x;
          //return float(0);
          //return u_xlat18;
          //return 10;
          //return u_xlat15.xy;
          //return u_xlat16.xy;
          //return u_xlat0_d.xy;
          //return u_xlat1_d.xy;
          //return u_xlati2.x;
          //return u_xlati2.y;
          //return int2(0, 1);
          //return int2(3, 2);
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
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixV;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float4x4 unity_GUIClipTextureMatrix;
      uniform int _ManualTex2SRGB;
      uniform int _SrcBlend;
      uniform float _CornerRadiuses[4];
      uniform float _BorderWidths[4];
      uniform float _Rect[4];
      uniform sampler2D _MainTex;
      uniform sampler2D _GUIClipTexture;
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
          float2 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float4 texcoord2 :TEXCOORD2;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float2 u_xlat2;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = mul(unity_ObjectToWorld, float4(in_v.vertex.xyz,1.0));
          out_v.vertex = mul(unity_MatrixVP, u_xlat0);
          out_v.color = in_v.color;
          u_xlat1.xy = float2((u_xlat0.yy * conv_mxt4x4_1(unity_MatrixV).xy));
          u_xlat0.xy = ((conv_mxt4x4_0(unity_MatrixV).xy * u_xlat0.xx) + u_xlat1.xy).xy;
          u_xlat0.xy = ((conv_mxt4x4_2(unity_MatrixV).xy * u_xlat0.zz) + u_xlat0.xy).xy;
          u_xlat0.xy = ((conv_mxt4x4_3(unity_MatrixV).xy * u_xlat0.ww) + u_xlat0.xy).xy;
          u_xlat2.xy = float2((u_xlat0.yy * conv_mxt4x4_1(unity_GUIClipTextureMatrix).xy));
          u_xlat0.xy = ((conv_mxt4x4_0(unity_GUIClipTextureMatrix).xy * u_xlat0.xx) + u_xlat2.xy).xy;
          out_v.texcoord1.xy = float2((u_xlat0.xy + conv_mxt4x4_3(unity_GUIClipTextureMatrix).xy));
          out_v.texcoord.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _MainTex));
          out_v.texcoord2 = in_v.vertex;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      float2 u_xlatb0;
      float2 u_xlat1_d;
      float4 u_xlat10_1;
      float2 u_xlatb1;
      float4 u_xlat2_d;
      float3 u_xlat16_2;
      int2 u_xlati2;
      float3 u_xlat3;
      float3 u_xlat16_5;
      float3 u_xlat6;
      float3 u_xlatb6;
      float u_xlat12;
      int u_xlatb12;
      float u_xlat13;
      int u_xlatb13;
      float2 u_xlat15;
      float2 u_xlat16;
      float u_xlat18;
      int u_xlatb18;
      int u_xlati19;
      float u_xlat16_23;
      float _CornerRadiusesDynamicIndex(int i)
      {
          #if UNITY_DYNAMIC_INDEX_ES2
          return _CornerRadiuses[i];
          #else
          #define d_ar _CornerRadiuses
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
      
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.x = _BorderWidths[0];
          u_xlat1_d.x = _BorderWidths[2];
          u_xlat12 = (in_f.texcoord2.x + (-_Rect[0]));
          u_xlat12 = (((-_Rect[2]) * 5) + u_xlat12);
          if((0>=u_xlat12))
          {
              u_xlatb12 = 1;
          }
          else
          {
              u_xlatb12 = 0;
          }
          u_xlat18 = (_Rect[0] + _Rect[2]);
          u_xlat13 = (in_f.texcoord2.y + (-_Rect[1]));
          u_xlat13 = (((-_Rect[3]) * 5) + u_xlat13);
          if((0>=u_xlat13))
          {
              u_xlatb13 = 1;
          }
          else
          {
              u_xlatb13 = 0;
          }
          float _tmp_dvx_22 = int(u_xlatb13);
          u_xlati2.xy = float2(_tmp_dvx_22, _tmp_dvx_22);
          u_xlati19 = u_xlatb12;
          u_xlat1_d.y = (u_xlat18 + (-_CornerRadiusesDynamicIndex(u_xlati19)));
          u_xlat0_d.y = (_Rect[0] + _CornerRadiusesDynamicIndex(u_xlati19));
          float _tmp_dvx_23 = int(u_xlatb12);
          u_xlat2_d.xy = float2(_tmp_dvx_23, _tmp_dvx_23);
          u_xlat15.x = _BorderWidths[1];
          u_xlat16.x = _BorderWidths[3];
          u_xlat0_d.x = (_Rect[1] + _Rect[3]);
          u_xlat16.y = (u_xlat0_d.x + (-_CornerRadiusesDynamicIndex(u_xlati19)));
          u_xlat15.y = (_Rect[1] + _CornerRadiusesDynamicIndex(u_xlati19));
          float _tmp_dvx_24 = int(u_xlatb13);
          u_xlat2_d.zw = float2(_tmp_dvx_24, _tmp_dvx_24);
          float _tmp_dvx_25 = _CornerRadiusesDynamicIndex(u_xlati19);
          u_xlat0_d.xy = float2(((-u_xlat2_d.xz) + float2(_tmp_dvx_25, _tmp_dvx_25)));
          u_xlat18 = (u_xlat0_d.x / u_xlat0_d.y);
          u_xlat3.xy = float2(((-u_xlat2_d.yw) + in_f.texcoord2.xy));
          u_xlat3.z = (u_xlat18 * u_xlat3.y);
          u_xlat18 = dot(u_xlat3.xz, u_xlat3.xz);
          u_xlat1_d.x = length(u_xlat3.xy);
          u_xlat1_d.x = (u_xlat1_d.x + (-_CornerRadiusesDynamicIndex(u_xlati19)));
          u_xlat18 = sqrt(u_xlat18);
          u_xlat18 = ((-u_xlat0_d.x) + u_xlat18);
          u_xlatb0.xy = float2(bool4(float4(0, 0, 0, 0) < u_xlat0_d.xyxx).xy);
          u_xlatb0.x = (u_xlatb0.y && u_xlatb0.x);
          u_xlat6.x = ddx(in_f.texcoord2.x);
          u_xlat6.x = (float(10) / abs(u_xlat6.x));
          u_xlat18 = ((u_xlat18 * u_xlat6.x) + 5);
          u_xlat18 = clamp(u_xlat18, 0, 10);
          u_xlat6.x = ((u_xlat1_d.x * u_xlat6.x) + 5);
          u_xlat6.x = clamp(u_xlat6.x, 0, 10);
          u_xlat0_d.x = u_xlatb0.x;
          u_xlatb1.xy = float2(bool4(float4(0, 0, 0, 0) < u_xlat2_d.xzxx).xy);
          u_xlatb18 = (u_xlatb1.y || u_xlatb1.x);
          u_xlat0_d.x = u_xlatb18;
          u_xlat6.x = u_xlatb18;
          if((u_xlat6.x==0))
          {
              u_xlatb18 = 1;
          }
          else
          {
              u_xlatb18 = 0;
          }
          u_xlat6.x = ((-u_xlat6.x) + 10);
          u_xlat0_d.x = u_xlatb18;
          u_xlatb6.xz = bool4(u_xlat2_d.yyww >= in_f.texcoord2.xxyy).xz;
          u_xlatb1.xy = float2(bool4(in_f.texcoord2.xyxx >= u_xlat2_d.ywyy).xy);
          u_xlatb6.x = u_xlatb12;
          u_xlatb12 = u_xlatb13;
          u_xlatb6.x = (u_xlatb12 && u_xlatb6.x);
          u_xlat0_d.x = u_xlatb6.x;
          u_xlat12 = (_BorderWidths[0] + _BorderWidths[2]);
          u_xlat12 = ((-u_xlat12) + _Rect[2]);
          u_xlat18 = (_BorderWidths[0] + _Rect[0]);
          u_xlat12 = (u_xlat12 + u_xlat18);
          if((in_f.texcoord2.x>=u_xlat18))
          {
              u_xlatb18 = 1;
          }
          else
          {
              u_xlatb18 = 0;
          }
          if((u_xlat12>=in_f.texcoord2.x))
          {
              u_xlatb12 = 1;
          }
          else
          {
              u_xlatb12 = 0;
          }
          u_xlatb12 = (u_xlatb12 && u_xlatb18);
          u_xlat18 = (_BorderWidths[1] + _Rect[1]);
          if((in_f.texcoord2.y>=u_xlat18))
          {
              u_xlatb1.x = 1;
          }
          else
          {
              u_xlatb1.x = 0;
          }
          u_xlatb12 = (u_xlatb12 && u_xlatb1.x);
          u_xlat1_d.x = (_BorderWidths[1] + _BorderWidths[3]);
          u_xlat1_d.x = ((-u_xlat1_d.x) + _Rect[3]);
          u_xlat18 = (u_xlat18 + u_xlat1_d.x);
          if((u_xlat18>=in_f.texcoord2.y))
          {
              u_xlatb18 = 1;
          }
          else
          {
              u_xlatb18 = 0;
          }
          u_xlatb12 = (u_xlatb18 && u_xlatb12);
          u_xlat12 = u_xlatb12;
          u_xlat6.x = u_xlatb6.x;
          if((0<_BorderWidths[0]))
          {
              u_xlatb12 = 1;
          }
          else
          {
              u_xlatb12 = 0;
          }
          if((0<_BorderWidths[1]))
          {
              u_xlatb18 = 1;
          }
          else
          {
              u_xlatb18 = 0;
          }
          u_xlatb12 = (u_xlatb18 || u_xlatb12);
          if((0<_BorderWidths[2]))
          {
              u_xlatb18 = 1;
          }
          else
          {
              u_xlatb18 = 0;
          }
          u_xlatb12 = (u_xlatb18 || u_xlatb12);
          if((0<_BorderWidths[3]))
          {
              u_xlatb18 = 1;
          }
          else
          {
              u_xlatb18 = 0;
          }
          u_xlatb12 = (u_xlatb18 || u_xlatb12);
          u_xlat6.x = u_xlatb12;
          u_xlat0_d.z = (u_xlat6.x * u_xlat0_d.x);
          u_xlat6.z = tex2D(_GUIClipTexture, in_f.texcoord1.xy).w.x;
          u_xlat10_1 = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat16_5.xyz = float3(max(u_xlat10_1.xyz, float3(0, 0, 0)));
          u_xlat16_2.xyz = float3(log2(u_xlat16_5.xyz));
          u_xlat16_2.xyz = float3((u_xlat16_2.xyz * float3(416666657, 416666657, 416666657)));
          u_xlat16_2.xyz = float3(exp2(u_xlat16_2.xyz));
          u_xlat16_2.xyz = float3(((u_xlat16_2.xyz * float3(105499995, 105499995, 105499995)) + float3(-549999997, (-549999997), (-549999997))));
          u_xlat2_d.xyz = float3(max(u_xlat16_2.xyz, float3(0, 0, 0)));
          if((_ManualTex2SRGB!=0))
          {
              u_xlat16_5.xyz = float3(1, 1, 1);
          }
          else
          {
              u_xlat16_5.xyz = float3(0, 0, 0);
          }
          u_xlat16_23 = (u_xlat10_1.w * in_f.color.w);
          u_xlat0_d.x = (u_xlat0_d.x * u_xlat16_23);
          u_xlat0_d.xz = (u_xlat6.xz * u_xlat0_d.xz);
          u_xlat0_d.x = (u_xlat6.z * u_xlat0_d.x);
          out_f.color.w = u_xlat0_d.x;
          u_xlat16_5.xyz = float3((u_xlat16_5.xyz * in_f.color.xyz));
          u_xlat0_d.xyz = float3((u_xlat0_d.zzz * u_xlat16_5.xyz));
          if((_SrcBlend!=5))
          {
              u_xlatb18 = 1;
          }
          else
          {
              u_xlatb18 = 0;
          }
          float _tmp_dvx_26 = int(u_xlatb18);
          out_f.color.xyz = float3(_tmp_dvx_26, _tmp_dvx_26, _tmp_dvx_26);
          //return u_xlat0_d.xyz;
          //return u_xlat16_5.xyz;
          //return u_xlat2_d.xyz;
          //return u_xlat10_1.xyz;
          //return u_xlat6.x;
          //return 10;
          //return 10;
          //return u_xlat12;
          //return 0;
          //return 10;
          //return u_xlat0_d.x;
          //return 10;
          //return u_xlatb6.z;
          //return u_xlatb1.y;
          //return u_xlatb6.x;
          //return u_xlatb1.x;
          //return u_xlat0_d.x;
          //return u_xlat6.x;
          //return u_xlat6.x;
          //return float(0);
          //return u_xlat0_d.x;
          //return float(0);
          //return u_xlat18;
          //return 10;
          //return u_xlat15.xy;
          //return u_xlat16.xy;
          //return u_xlat0_d.xy;
          //return u_xlat1_d.xy;
          //return u_xlati2.x;
          //return u_xlati2.y;
          //return int2(0, 1);
          //return int2(3, 2);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack "Hidden/Internal-GUITextureClip"
}
