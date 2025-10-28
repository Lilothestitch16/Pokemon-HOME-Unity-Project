Shader "Hidden/VideoDecode"
{
  Properties
  {
    _MainTex ("_MainTex (A)", 2D) = "black" {}
    _SecondTex ("_SecondTex (A)", 2D) = "black" {}
    _ThirdTex ("_ThirdTex (A)", 2D) = "black" {}
  }
  SubShader
  {
    Tags
    { 
    }
    Pass // ind: 1, name: YCbCr_To_RGB1
    {
      Name "YCbCr_To_RGB1"
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
      //uniform int unity_StereoEyeIndex;
      uniform float4 _RightEyeUVOffset;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform sampler2D _SecondTex;
      uniform sampler2D _ThirdTex;
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
      float u_xlat4;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat0.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _MainTex));
          u_xlat4 = float(unity_StereoEyeIndex);
          out_v.texcoord.xy = float2(((float2(u_xlat4, u_xlat4) * _RightEyeUVOffset.xy) + u_xlat0.xy));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float u_xlat10_0;
      float2 u_xlat16_1;
      float u_xlat10_2;
      float u_xlat16_3;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          out_f.color.w = 10;
          u_xlat10_0 = tex2D(_SecondTex, in_f.texcoord.xy).w.x;
          u_xlat16_1.xy = float2((float2(u_xlat10_0, u_xlat10_0) * float2(390625, 1984375)));
          u_xlat10_0 = tex2D(_MainTex, in_f.texcoord.xy).w.x;
          u_xlat16_1.x = ((u_xlat10_0 * 115625) + (-u_xlat16_1.x));
          u_xlat16_3 = ((u_xlat10_0 * 115625) + u_xlat16_1.y);
          out_f.color.z = (u_xlat16_3 + (-106861997));
          u_xlat10_2 = tex2D(_ThirdTex, in_f.texcoord.xy).w.x;
          u_xlat16_1.x = (((-u_xlat10_2) * 8125) + u_xlat16_1.x);
          u_xlat16_3 = (u_xlat10_2 * 159375);
          u_xlat16_1.y = ((u_xlat10_0 * 115625) + u_xlat16_3);
          out_f.color.xy = float2((u_xlat16_1.yx + float2(-872539997, 531369984)));
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: YCbCrA_To_RGBAFull
    {
      Name "YCbCrA_To_RGBAFull"
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
      //uniform int unity_StereoEyeIndex;
      uniform float4 _RightEyeUVOffset;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform sampler2D _SecondTex;
      uniform sampler2D _ThirdTex;
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
      float u_xlat4;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat0.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _MainTex));
          u_xlat4 = float(unity_StereoEyeIndex);
          out_v.texcoord.xy = float2(((float2(u_xlat4, u_xlat4) * _RightEyeUVOffset.xy) + u_xlat0.xy));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float2 u_xlat0_d;
      float u_xlat10_0;
      float2 u_xlat16_1;
      float u_xlat16_3;
      float u_xlat10_4;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = float2(((in_f.texcoord.xy * float2(5, 10)) + float2(5, 0)));
          u_xlat10_0 = tex2D(_MainTex, u_xlat0_d.xy).w.x;
          out_f.color.w = u_xlat10_0;
          u_xlat0_d.xy = float2((in_f.texcoord.xy * float2(5, 10)));
          u_xlat10_4 = tex2D(_SecondTex, u_xlat0_d.xy).w.x;
          u_xlat16_1.xy = float2((float2(u_xlat10_4, u_xlat10_4) * float2(390625, 1984375)));
          u_xlat10_4 = tex2D(_MainTex, u_xlat0_d.xy).w.x;
          u_xlat10_0 = tex2D(_ThirdTex, u_xlat0_d.xy).w.x;
          u_xlat16_1.x = ((u_xlat10_4 * 115625) + (-u_xlat16_1.x));
          u_xlat16_3 = ((u_xlat10_4 * 115625) + u_xlat16_1.y);
          out_f.color.z = (u_xlat16_3 + (-106861997));
          u_xlat16_1.x = (((-u_xlat10_0) * 8125) + u_xlat16_1.x);
          u_xlat16_3 = (u_xlat10_0 * 159375);
          u_xlat16_1.y = ((u_xlat10_4 * 115625) + u_xlat16_3);
          out_f.color.xy = float2((u_xlat16_1.yx + float2(-872539997, 531369984)));
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: YCbCrA_To_RGBA
    {
      Name "YCbCrA_To_RGBA"
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
      //uniform int unity_StereoEyeIndex;
      uniform float4 _RightEyeUVOffset;
      uniform float4 _MainTex_ST;
      uniform sampler2D _MainTex;
      uniform sampler2D _SecondTex;
      uniform sampler2D _ThirdTex;
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
      float u_xlat4;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat0.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _MainTex));
          u_xlat4 = float(unity_StereoEyeIndex);
          out_v.texcoord.xy = float2(((float2(u_xlat4, u_xlat4) * _RightEyeUVOffset.xy) + u_xlat0.xy));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float2 u_xlat0_d;
      float u_xlat10_0;
      float2 u_xlat16_1;
      float u_xlat16_3;
      float u_xlat10_4;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = float2(((in_f.texcoord.xy * float2(5, 10)) + float2(5, 0)));
          u_xlat10_0 = tex2D(_MainTex, u_xlat0_d.xy).w.x;
          u_xlat16_1.x = (u_xlat10_0 + (-627449974));
          out_f.color.w = (u_xlat16_1.x * 115625);
          u_xlat0_d.xy = float2((in_f.texcoord.xy * float2(5, 10)));
          u_xlat10_4 = tex2D(_SecondTex, u_xlat0_d.xy).w.x;
          u_xlat16_1.xy = float2((float2(u_xlat10_4, u_xlat10_4) * float2(390625, 1984375)));
          u_xlat10_4 = tex2D(_MainTex, u_xlat0_d.xy).w.x;
          u_xlat10_0 = tex2D(_ThirdTex, u_xlat0_d.xy).w.x;
          u_xlat16_1.x = ((u_xlat10_4 * 115625) + (-u_xlat16_1.x));
          u_xlat16_3 = ((u_xlat10_4 * 115625) + u_xlat16_1.y);
          out_f.color.z = (u_xlat16_3 + (-106861997));
          u_xlat16_1.x = (((-u_xlat10_0) * 8125) + u_xlat16_1.x);
          u_xlat16_3 = (u_xlat10_0 * 159375);
          u_xlat16_1.y = ((u_xlat10_4 * 115625) + u_xlat16_3);
          out_f.color.xy = float2((u_xlat16_1.yx + float2(-872539997, 531369984)));
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 4, name: Composite_RGBA_To_RGBA
    {
      Name "Composite_RGBA_To_RGBA"
      Tags
      { 
      }
      Cull Off
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
      //uniform int unity_StereoEyeIndex;
      uniform float4 _RightEyeUVOffset;
      uniform float4 _MainTex_ST;
      uniform float _AlphaParam;
      uniform sampler2D _MainTex;
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
      float u_xlat4;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat0.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _MainTex));
          u_xlat4 = float(unity_StereoEyeIndex);
          out_v.texcoord.xy = float2(((float2(u_xlat4, u_xlat4) * _RightEyeUVOffset.xy) + u_xlat0.xy));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat0_d.w = (u_xlat0_d.w * _AlphaParam);
          out_f.color = u_xlat0_d;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 5, name: Flip_RGBA_To_RGBA
    {
      Name "Flip_RGBA_To_RGBA"
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
      uniform float _AlphaParam;
      uniform sampler2D _MainTex;
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
          u_xlat0.xy = float2(((in_v.texcoord.xy * float2(10, (-10))) + float2(0, 10)));
          out_v.texcoord.xy = float2(TRANSFORM_TEX(u_xlat0.xy, _MainTex));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d = tex2D(_MainTex, in_f.texcoord.xy);
          u_xlat0_d.w = (u_xlat0_d.w * _AlphaParam);
          out_f.color = u_xlat0_d;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 6, name: Flip_RGBASplit_To_RGBA
    {
      Name "Flip_RGBASplit_To_RGBA"
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
      uniform sampler2D _MainTex;
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
          u_xlat0.xy = float2(((in_v.texcoord.xy * float2(10, (-10))) + float2(0, 10)));
          out_v.texcoord.xy = float2(TRANSFORM_TEX(u_xlat0.xy, _MainTex));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float4 u_xlat0_d;
      float2 u_xlat1_d;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = float2((in_f.texcoord.xy * float2(5, 10)));
          u_xlat0_d.xyz = tex2D(_MainTex, u_xlat0_d.xy).xyz.xyz;
          u_xlat1_d.xy = float2(((in_f.texcoord.xy * float2(5, 10)) + float2(5, 0)));
          u_xlat0_d.w = tex2D(_MainTex, u_xlat1_d.xy).y.x;
          out_f.color = u_xlat0_d;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 7, name: Flip_SemiPlanarYCbCr_To_RGB1
    {
      Name "Flip_SemiPlanarYCbCr_To_RGB1"
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
      uniform float4 _MainTex_TexelSize;
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
          u_xlat0.xy = float2(((in_v.texcoord.xy * float2(10, (-10))) + float2(0, 10)));
          out_v.texcoord.xy = float2(TRANSFORM_TEX(u_xlat0.xy, _MainTex));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float u_xlat0_d;
      float u_xlat10_0;
      float4 u_xlat1_d;
      float2 u_xlat16_2;
      float u_xlat3;
      float u_xlat10_3;
      int u_xlati3;
      float u_xlat16_5;
      float u_xlat6;
      int u_xlati6;
      int u_xlatb6;
      int u_xlati9;
      int u_xlatb9;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d = (_MainTex_TexelSize.z + (-5));
          u_xlat3 = ((in_f.texcoord.x * u_xlat0_d) + 5);
          u_xlat0_d = (float(10) / u_xlat0_d);
          u_xlat3 = floor(u_xlat3);
          u_xlat6 = (u_xlat3 * 5);
          u_xlati3 = int(u_xlat3);
          if((u_xlat6>=(-u_xlat6)))
          {
              u_xlatb9 = 1;
          }
          else
          {
              u_xlatb9 = 0;
          }
          u_xlat6 = frac(abs(u_xlat6));
          u_xlat6 = u_xlatb9;
          if((u_xlat6==0))
          {
              u_xlatb6 = 1;
          }
          else
          {
              u_xlatb6 = 0;
          }
          u_xlati9 = (u_xlati3 + (-1));
          u_xlati3 = u_xlatb6;
          u_xlati6 = (u_xlati3 + 1);
          u_xlat3 = float(u_xlati3);
          u_xlat1_d.x = (u_xlat0_d * u_xlat3);
          u_xlat3 = float(u_xlati6);
          u_xlat1_d.z = (u_xlat0_d * u_xlat3);
          u_xlat1_d.yw = in_f.texcoord.yy;
          u_xlat10_0 = tex2D(_SecondTex, u_xlat1_d.zw).w.x;
          u_xlat10_3 = tex2D(_SecondTex, u_xlat1_d.xy).w.x;
          u_xlat16_2.xy = float2((float2(u_xlat10_3, u_xlat10_3) * float2(390625, 1984375)));
          u_xlat10_3 = tex2D(_MainTex, in_f.texcoord.xy).w.x;
          u_xlat16_2.x = ((u_xlat10_3 * 115625) + (-u_xlat16_2.x));
          u_xlat16_5 = ((u_xlat10_3 * 115625) + u_xlat16_2.y);
          out_f.color.z = (u_xlat16_5 + (-106861997));
          u_xlat16_2.x = (((-u_xlat10_0) * 8125) + u_xlat16_2.x);
          u_xlat16_5 = (u_xlat10_0 * 159375);
          u_xlat16_2.y = ((u_xlat10_3 * 115625) + u_xlat16_5);
          out_f.color.xy = float2((u_xlat16_2.yx + float2(-872539997, 531369984)));
          out_f.color.w = 10;
          //return u_xlati3;
          //return u_xlati9;
          //return u_xlat6;
          //return (-u_xlat6);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 8, name: Flip_SemiPlanarYCbCrA_To_RGBA
    {
      Name "Flip_SemiPlanarYCbCrA_To_RGBA"
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
      uniform float4 _MainTex_TexelSize;
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
          u_xlat0.xy = float2(((in_v.texcoord.xy * float2(10, (-10))) + float2(0, 10)));
          out_v.texcoord.xy = float2(TRANSFORM_TEX(u_xlat0.xy, _MainTex));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float2 u_xlat0_d;
      float u_xlat10_0;
      float4 u_xlat1_d;
      int u_xlati1;
      int u_xlatb1;
      float2 u_xlat16_2;
      float3 u_xlat3;
      float u_xlat10_3;
      int u_xlati3;
      float u_xlat16_5;
      float u_xlat10_6;
      float u_xlat9;
      int u_xlati9;
      int u_xlatb9;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.x = (_MainTex_TexelSize.z + (-5));
          u_xlat3.xyz = float3((in_f.texcoord.xxy * float3(5, 5, 10)));
          u_xlat3.x = ((u_xlat3.x * u_xlat0_d.x) + 5);
          u_xlat0_d.x = (20 / u_xlat0_d.x);
          u_xlat10_6 = tex2D(_MainTex, u_xlat3.yz).w.x;
          u_xlat3.x = floor(u_xlat3.x);
          u_xlat9 = (u_xlat3.x * 5);
          u_xlati3 = int(u_xlat3.x);
          if((u_xlat9>=(-u_xlat9)))
          {
              u_xlatb1 = 1;
          }
          else
          {
              u_xlatb1 = 0;
          }
          u_xlat9 = frac(abs(u_xlat9));
          u_xlat9 = u_xlatb1;
          if((u_xlat9==0))
          {
              u_xlatb9 = 1;
          }
          else
          {
              u_xlatb9 = 0;
          }
          u_xlati1 = (u_xlati3 + (-1));
          u_xlati3 = u_xlatb9;
          u_xlati9 = (u_xlati3 + 1);
          u_xlat3.x = float(u_xlati3);
          u_xlat1_d.x = (u_xlat0_d.x * u_xlat3.x);
          u_xlat3.x = float(u_xlati9);
          u_xlat1_d.z = (u_xlat0_d.x * u_xlat3.x);
          u_xlat1_d.yw = in_f.texcoord.yy;
          u_xlat10_0 = tex2D(_SecondTex, u_xlat1_d.zw).w.x;
          u_xlat10_3 = tex2D(_SecondTex, u_xlat1_d.xy).w.x;
          u_xlat16_2.xy = float2((float2(u_xlat10_3, u_xlat10_3) * float2(390625, 1984375)));
          u_xlat16_2.x = ((u_xlat10_6 * 115625) + (-u_xlat16_2.x));
          u_xlat16_5 = ((u_xlat10_6 * 115625) + u_xlat16_2.y);
          out_f.color.z = (u_xlat16_5 + (-106861997));
          u_xlat16_2.x = (((-u_xlat10_0) * 8125) + u_xlat16_2.x);
          u_xlat16_5 = (u_xlat10_0 * 159375);
          u_xlat16_2.y = ((u_xlat10_6 * 115625) + u_xlat16_5);
          out_f.color.xy = float2((u_xlat16_2.yx + float2(-872539997, 531369984)));
          u_xlat0_d.xy = float2(((in_f.texcoord.xy * float2(5, 10)) + float2(5, 0)));
          u_xlat10_0 = tex2D(_MainTex, u_xlat0_d.xy).w.x;
          u_xlat16_2.x = (u_xlat10_0 + (-627449974));
          out_f.color.w = (u_xlat16_2.x * 115625);
          //return u_xlati3;
          //return u_xlati1;
          //return u_xlat9;
          //return (-u_xlat9);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 9, name: Flip_NV12_To_RGB1
    {
      Name "Flip_NV12_To_RGB1"
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
          u_xlat0.xy = float2(((in_v.texcoord.xy * float2(10, (-10))) + float2(0, 10)));
          out_v.texcoord.xy = float2(TRANSFORM_TEX(u_xlat0.xy, _MainTex));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float u_xlat10_0;
      float3 u_xlat16_1;
      float2 u_xlat10_2;
      float u_xlat16_3;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat10_0 = tex2D(_MainTex, in_f.texcoord.xy).w.x;
          u_xlat10_2.xy = tex2D(_SecondTex, in_f.texcoord.xy).xy.xy;
          u_xlat16_1.xyz = float3((u_xlat10_2.yxx * float3(159375, 390625, 1984375)));
          u_xlat16_3 = ((u_xlat10_0 * 115625) + (-u_xlat16_1.y));
          u_xlat16_1.xz = ((float2(u_xlat10_0, u_xlat10_0) * float2(115625, 115625)) + u_xlat16_1.xz);
          out_f.color.xz = (u_xlat16_1.xz + float2(-872539997, (-106861997)));
          u_xlat16_1.x = (((-u_xlat10_2.y) * 8125) + u_xlat16_3);
          out_f.color.y = (u_xlat16_1.x + 531369984);
          out_f.color.w = 10;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 10, name: Flip_NV12_To_RGBA
    {
      Name "Flip_NV12_To_RGBA"
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
          u_xlat0.xy = float2(((in_v.texcoord.xy * float2(10, (-10))) + float2(0, 10)));
          out_v.texcoord.xy = float2(TRANSFORM_TEX(u_xlat0.xy, _MainTex));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float2 u_xlat0_d;
      float2 u_xlat10_0;
      float3 u_xlat16_1;
      float u_xlat16_3;
      float u_xlat10_4;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.xy = float2(((in_f.texcoord.xy * float2(5, 10)) + float2(5, 0)));
          u_xlat10_0.x = tex2D(_MainTex, u_xlat0_d.xy).w.x;
          u_xlat16_1.x = (u_xlat10_0.x + (-627449974));
          out_f.color.w = (u_xlat16_1.x * 115625);
          u_xlat0_d.xy = float2((in_f.texcoord.xy * float2(5, 10)));
          u_xlat10_4 = tex2D(_MainTex, u_xlat0_d.xy).w.x;
          u_xlat10_0.xy = tex2D(_SecondTex, u_xlat0_d.xy).xy.xy;
          u_xlat16_1.xyz = float3((u_xlat10_0.yxx * float3(159375, 390625, 1984375)));
          u_xlat16_3 = ((u_xlat10_4 * 115625) + (-u_xlat16_1.y));
          u_xlat16_1.xz = ((float2(u_xlat10_4, u_xlat10_4) * float2(115625, 115625)) + u_xlat16_1.xz);
          out_f.color.xz = (u_xlat16_1.xz + float2(-872539997, (-106861997)));
          u_xlat16_1.x = (((-u_xlat10_0.y) * 8125) + u_xlat16_3);
          out_f.color.y = (u_xlat16_1.x + 531369984);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
