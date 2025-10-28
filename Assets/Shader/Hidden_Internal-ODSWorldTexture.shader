Shader "Hidden/Internal-ODSWorldTexture"
{
  Properties
  {
    _MainTex ("", 2D) = "white" {}
    _Cutoff ("", float) = 0.5
    _Color ("", Color) = (1,1,1,1)
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "Opaque"
      }
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
      //uniform float4x4 unity_MatrixVP;
      struct appdata_t
      {
          float4 vertex :POSITION0;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float3 u_xlat1;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = (in_v.vertex.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_0(unity_ObjectToWorld) * in_v.vertex.xxxx) + u_xlat0);
          u_xlat0 = ((conv_mxt4x4_2(unity_ObjectToWorld) * in_v.vertex.zzzz) + u_xlat0);
          u_xlat1.xyz = float3((u_xlat0.xyz + conv_mxt4x4_3(unity_ObjectToWorld).xyz));
          out_v.texcoord = ((conv_mxt4x4_3(unity_ObjectToWorld) * in_v.vertex.wwww) + u_xlat0);
          out_v.vertex = mul(unity_MatrixVP, float4(u_xlat1.xyz,1.0));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          out_f.color = in_f.texcoord;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "TransparentCutout"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "TransparentCutout"
      }
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
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _MainTex_ST;
      uniform float _Cutoff;
      uniform float4 _Color;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float3 u_xlat1;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = (in_v.vertex.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_0(unity_ObjectToWorld) * in_v.vertex.xxxx) + u_xlat0);
          u_xlat0 = ((conv_mxt4x4_2(unity_ObjectToWorld) * in_v.vertex.zzzz) + u_xlat0);
          u_xlat1.xyz = float3((u_xlat0.xyz + conv_mxt4x4_3(unity_ObjectToWorld).xyz));
          out_v.texcoord = ((conv_mxt4x4_3(unity_ObjectToWorld) * in_v.vertex.wwww) + u_xlat0);
          out_v.vertex = mul(unity_MatrixVP, float4(u_xlat1.xyz,1.0));
          out_v.texcoord1.xy = float2(TRANSFORM_TEX(in_v.texcoord.xy, _MainTex));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float u_xlat10_0;
      int u_xlatb0;
      float u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat10_0 = tex2D(_MainTex, in_f.texcoord1.xy).w.x;
          u_xlat16_1 = ((u_xlat10_0 * _Color.w) + (-_Cutoff));
          if((u_xlat16_1<0))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          if(((int(u_xlatb0) * (-1))!=0))
          {
              discard;
          }
          out_f.color = in_f.texcoord;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "TreeBark"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "TreeBark"
      }
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
      //uniform float4 _Time;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _TreeInstanceScale;
      uniform float4 _SquashPlaneNormal;
      uniform float _SquashAmount;
      uniform float4 _Wind;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float4 texcoord1 :TEXCOORD1;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      float3 u_xlat3;
      float u_xlat4;
      float u_xlat8;
      float u_xlat12;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.x = dot(conv_mxt4x4_3(unity_ObjectToWorld).xyz, float3(10, 10, 10));
          u_xlat0.y = (u_xlat0.x + in_v.color.x);
          u_xlat8 = (u_xlat0.y + in_v.color.y);
          u_xlat1.xyz = float3((in_v.vertex.xyz * _TreeInstanceScale.xyz));
          u_xlat0.x = dot(u_xlat1.xyz, float3(u_xlat8, u_xlat8, u_xlat8));
          u_xlat0 = (u_xlat0.xxyy + _Time.yyyy);
          u_xlat0 = (u_xlat0 * float4(197500002, 792999983, 375, 193000004));
          u_xlat0 = frac(u_xlat0);
          u_xlat0 = ((u_xlat0 * float4(20, 20, 20, 20)) + float4(-5, (-5), (-5), (-5)));
          u_xlat0 = frac(u_xlat0);
          u_xlat0 = ((u_xlat0 * float4(20, 20, 20, 20)) + float4(-10, (-10), (-10), (-10)));
          u_xlat2 = (abs(u_xlat0) * abs(u_xlat0));
          u_xlat0 = (((-abs(u_xlat0)) * float4(20, 20, 20, 20)) + float4(30, 30, 30, 30));
          u_xlat0 = (u_xlat0 * u_xlat2);
          u_xlat0.xy = float2((u_xlat0.yw + u_xlat0.xz));
          u_xlat2.xyz = float3((u_xlat0.yyy * _Wind.xyz));
          u_xlat2.xyz = float3((u_xlat2.xyz * in_v.texcoord1.yyy));
          u_xlat3.y = (u_xlat0.y * in_v.texcoord1.y);
          u_xlat4 = (in_v.color.y * 100000001);
          u_xlat3.xz = (float2(u_xlat4, u_xlat4) * in_v.normal.xz);
          u_xlat0.z = 300000012;
          u_xlat0.xyz = float3(((u_xlat0.xzx * u_xlat3.xyz) + u_xlat2.xyz));
          u_xlat0.xyz = float3(((u_xlat0.xyz * _Wind.www) + u_xlat1.xyz));
          u_xlat0.xyz = float3(((in_v.texcoord1.xxx * _Wind.xyz) + u_xlat0.xyz));
          u_xlat12 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
          u_xlat12 = (u_xlat12 + _SquashPlaneNormal.w);
          u_xlat1.xyz = float3((((-float3(u_xlat12, u_xlat12, u_xlat12)) * _SquashPlaneNormal.xyz) + u_xlat0.xyz));
          u_xlat0.xyz = float3((u_xlat0.xyz + (-u_xlat1.xyz)));
          u_xlat0.xyz = float3(((float3(_SquashAmount, _SquashAmount, _SquashAmount) * u_xlat0.xyz) + u_xlat1.xyz));
          u_xlat0 = mul(unity_ObjectToWorld, float4(u_xlat0.xyz,1.0));
          u_xlat1 = (u_xlat0.yyyy * conv_mxt4x4_1(unity_MatrixVP));
          u_xlat1 = ((conv_mxt4x4_0(unity_MatrixVP) * u_xlat0.xxxx) + u_xlat1);
          u_xlat1 = ((conv_mxt4x4_2(unity_MatrixVP) * u_xlat0.zzzz) + u_xlat1);
          out_v.texcoord = u_xlat0;
          out_v.vertex = (u_xlat1 + conv_mxt4x4_3(unity_MatrixVP));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          out_f.color = in_f.texcoord;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "TreeLeaf"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "TreeLeaf"
      }
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
      //uniform float4 _Time;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixInvV;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _TreeInstanceScale;
      uniform float4 _SquashPlaneNormal;
      uniform float _SquashAmount;
      uniform float4 _Wind;
      uniform float _Cutoff;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 tangent :TANGENT0;
          float3 normal :NORMAL0;
          float4 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      float4 u_xlat3;
      float u_xlat12;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = (conv_mxt4x4_1(unity_WorldToObject) * conv_mxt4x4_1(unity_MatrixInvV).yyyy);
          u_xlat0 = ((conv_mxt4x4_0(unity_WorldToObject) * conv_mxt4x4_1(unity_MatrixInvV).xxxx) + u_xlat0);
          u_xlat0 = ((conv_mxt4x4_2(unity_WorldToObject) * conv_mxt4x4_1(unity_MatrixInvV).zzzz) + u_xlat0);
          u_xlat0 = ((conv_mxt4x4_3(unity_WorldToObject) * conv_mxt4x4_1(unity_MatrixInvV).wwww) + u_xlat0);
          u_xlat0 = (u_xlat0 * in_v.normal.yyyy);
          u_xlat1 = (conv_mxt4x4_1(unity_WorldToObject) * conv_mxt4x4_0(unity_MatrixInvV).yyyy);
          u_xlat1 = ((conv_mxt4x4_0(unity_WorldToObject) * conv_mxt4x4_0(unity_MatrixInvV).xxxx) + u_xlat1);
          u_xlat1 = ((conv_mxt4x4_2(unity_WorldToObject) * conv_mxt4x4_0(unity_MatrixInvV).zzzz) + u_xlat1);
          u_xlat1 = ((conv_mxt4x4_3(unity_WorldToObject) * conv_mxt4x4_0(unity_MatrixInvV).wwww) + u_xlat1);
          u_xlat0 = ((in_v.normal.xxxx * u_xlat1) + u_xlat0);
          u_xlat1 = (conv_mxt4x4_1(unity_WorldToObject) * conv_mxt4x4_2(unity_MatrixInvV).yyyy);
          u_xlat1 = ((conv_mxt4x4_0(unity_WorldToObject) * conv_mxt4x4_2(unity_MatrixInvV).xxxx) + u_xlat1);
          u_xlat1 = ((conv_mxt4x4_2(unity_WorldToObject) * conv_mxt4x4_2(unity_MatrixInvV).zzzz) + u_xlat1);
          u_xlat1 = ((conv_mxt4x4_3(unity_WorldToObject) * conv_mxt4x4_2(unity_MatrixInvV).wwww) + u_xlat1);
          u_xlat1 = ((in_v.normal.zzzz * u_xlat1) + u_xlat0);
          u_xlat12 = dot(u_xlat1, u_xlat1);
          u_xlat12 = rsqrt(u_xlat12);
          u_xlat1.xy = float2(((u_xlat1.xz * float2(u_xlat12, u_xlat12)) + (-in_v.normal.xz)));
          u_xlat12 = ((-abs(in_v.tangent.w)) + 10);
          u_xlat1.xy = float2(((float2(u_xlat12, u_xlat12) * u_xlat1.xy) + in_v.normal.xz));
          u_xlat0.xyz = float3(((u_xlat0.xyz * float3(u_xlat12, u_xlat12, u_xlat12)) + in_v.vertex.xyz));
          u_xlat0.xyz = float3((u_xlat0.xyz * _TreeInstanceScale.xyz));
          u_xlat12 = (in_v.color.y * 100000001);
          u_xlat1.xz = (u_xlat1.xy * float2(u_xlat12, u_xlat12));
          u_xlat12 = dot(conv_mxt4x4_3(unity_ObjectToWorld).xyz, float3(10, 10, 10));
          u_xlat2.y = (u_xlat12 + in_v.color.x);
          u_xlat12 = (u_xlat2.y + in_v.color.y);
          u_xlat2.x = dot(u_xlat0.xyz, float3(u_xlat12, u_xlat12, u_xlat12));
          u_xlat2 = (u_xlat2.xxyy + _Time.yyyy);
          u_xlat2 = (u_xlat2 * float4(197500002, 792999983, 375, 193000004));
          u_xlat2 = frac(u_xlat2);
          u_xlat2 = ((u_xlat2 * float4(20, 20, 20, 20)) + float4(-5, (-5), (-5), (-5)));
          u_xlat2 = frac(u_xlat2);
          u_xlat2 = ((u_xlat2 * float4(20, 20, 20, 20)) + float4(-10, (-10), (-10), (-10)));
          u_xlat3 = (abs(u_xlat2) * abs(u_xlat2));
          u_xlat2 = (((-abs(u_xlat2)) * float4(20, 20, 20, 20)) + float4(30, 30, 30, 30));
          u_xlat2 = (u_xlat2 * u_xlat3);
          u_xlat2.xy = float2((u_xlat2.yw + u_xlat2.xz));
          u_xlat3.xyz = float3((u_xlat2.yyy * _Wind.xyz));
          u_xlat3.xyz = float3((u_xlat3.xyz * in_v.texcoord1.yyy));
          u_xlat1.y = (u_xlat2.y * in_v.texcoord1.y);
          u_xlat2.z = 300000012;
          u_xlat1.xyz = float3(((u_xlat2.xzx * u_xlat1.xyz) + u_xlat3.xyz));
          u_xlat0.xyz = float3(((u_xlat1.xyz * _Wind.www) + u_xlat0.xyz));
          u_xlat0.xyz = float3(((in_v.texcoord1.xxx * _Wind.xyz) + u_xlat0.xyz));
          u_xlat12 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
          u_xlat12 = (u_xlat12 + _SquashPlaneNormal.w);
          u_xlat1.xyz = float3((((-float3(u_xlat12, u_xlat12, u_xlat12)) * _SquashPlaneNormal.xyz) + u_xlat0.xyz));
          u_xlat0.xyz = float3((u_xlat0.xyz + (-u_xlat1.xyz)));
          u_xlat0.xyz = float3(((float3(_SquashAmount, _SquashAmount, _SquashAmount) * u_xlat0.xyz) + u_xlat1.xyz));
          u_xlat0 = mul(unity_ObjectToWorld, float4(u_xlat0.xyz,1.0));
          u_xlat1 = (u_xlat0.yyyy * conv_mxt4x4_1(unity_MatrixVP));
          u_xlat1 = ((conv_mxt4x4_0(unity_MatrixVP) * u_xlat0.xxxx) + u_xlat1);
          u_xlat1 = ((conv_mxt4x4_2(unity_MatrixVP) * u_xlat0.zzzz) + u_xlat1);
          out_v.texcoord1 = u_xlat0;
          out_v.vertex = (u_xlat1 + conv_mxt4x4_3(unity_MatrixVP));
          out_v.texcoord.xy = float2(in_v.texcoord.xy);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float u_xlat10_0;
      int u_xlatb0;
      float u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat10_0 = tex2D(_MainTex, in_f.texcoord.xy).w.x;
          u_xlat16_1 = (u_xlat10_0 + (-_Cutoff));
          if((u_xlat16_1<0))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          if(((int(u_xlatb0) * (-1))!=0))
          {
              discard;
          }
          out_f.color = in_f.texcoord1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "DisableBatching" = "true"
      "RenderType" = "TreeOpaque"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "DisableBatching" = "true"
        "RenderType" = "TreeOpaque"
      }
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
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _TreeInstanceScale;
      uniform float4x4 _TerrainEngineBendTree;
      uniform float4 _SquashPlaneNormal;
      uniform float _SquashAmount;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float4 texcoord :TEXCOORD0;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float u_xlat6;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.xyz = float3((in_v.vertex.xyz * _TreeInstanceScale.xyz));
          u_xlat1.xyz = float3((u_xlat0.yyy * conv_mxt4x4_1(_TerrainEngineBendTree).xyz));
          u_xlat1.xyz = float3(((conv_mxt4x4_0(_TerrainEngineBendTree).xyz * u_xlat0.xxx) + u_xlat1.xyz));
          u_xlat1.xyz = float3(((conv_mxt4x4_2(_TerrainEngineBendTree).xyz * u_xlat0.zzz) + u_xlat1.xyz));
          u_xlat1.xyz = float3((((-in_v.vertex.xyz) * _TreeInstanceScale.xyz) + u_xlat1.xyz));
          u_xlat0.xyz = float3(((in_v.color.www * u_xlat1.xyz) + u_xlat0.xyz));
          u_xlat6 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
          u_xlat6 = (u_xlat6 + _SquashPlaneNormal.w);
          u_xlat1.xyz = float3((((-float3(u_xlat6, u_xlat6, u_xlat6)) * _SquashPlaneNormal.xyz) + u_xlat0.xyz));
          u_xlat0.xyz = float3((u_xlat0.xyz + (-u_xlat1.xyz)));
          u_xlat0.xyz = float3(((float3(_SquashAmount, _SquashAmount, _SquashAmount) * u_xlat0.xyz) + u_xlat1.xyz));
          u_xlat0 = mul(unity_ObjectToWorld, float4(u_xlat0.xyz,1.0));
          u_xlat1 = (u_xlat0.yyyy * conv_mxt4x4_1(unity_MatrixVP));
          u_xlat1 = ((conv_mxt4x4_0(unity_MatrixVP) * u_xlat0.xxxx) + u_xlat1);
          u_xlat1 = ((conv_mxt4x4_2(unity_MatrixVP) * u_xlat0.zzzz) + u_xlat1);
          out_v.texcoord = u_xlat0;
          out_v.vertex = (u_xlat1 + conv_mxt4x4_3(unity_MatrixVP));
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          out_f.color = in_f.texcoord;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "DisableBatching" = "true"
      "RenderType" = "TreeTransparentCutout"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "DisableBatching" = "true"
        "RenderType" = "TreeTransparentCutout"
      }
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
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _TreeInstanceScale;
      uniform float4x4 _TerrainEngineBendTree;
      uniform float4 _SquashPlaneNormal;
      uniform float _SquashAmount;
      uniform float _Cutoff;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 color :COLOR0;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float u_xlat6;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.xyz = float3((in_v.vertex.xyz * _TreeInstanceScale.xyz));
          u_xlat1.xyz = float3((u_xlat0.yyy * conv_mxt4x4_1(_TerrainEngineBendTree).xyz));
          u_xlat1.xyz = float3(((conv_mxt4x4_0(_TerrainEngineBendTree).xyz * u_xlat0.xxx) + u_xlat1.xyz));
          u_xlat1.xyz = float3(((conv_mxt4x4_2(_TerrainEngineBendTree).xyz * u_xlat0.zzz) + u_xlat1.xyz));
          u_xlat1.xyz = float3((((-in_v.vertex.xyz) * _TreeInstanceScale.xyz) + u_xlat1.xyz));
          u_xlat0.xyz = float3(((in_v.color.www * u_xlat1.xyz) + u_xlat0.xyz));
          u_xlat6 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
          u_xlat6 = (u_xlat6 + _SquashPlaneNormal.w);
          u_xlat1.xyz = float3((((-float3(u_xlat6, u_xlat6, u_xlat6)) * _SquashPlaneNormal.xyz) + u_xlat0.xyz));
          u_xlat0.xyz = float3((u_xlat0.xyz + (-u_xlat1.xyz)));
          u_xlat0.xyz = float3(((float3(_SquashAmount, _SquashAmount, _SquashAmount) * u_xlat0.xyz) + u_xlat1.xyz));
          u_xlat0 = mul(unity_ObjectToWorld, float4(u_xlat0.xyz,1.0));
          u_xlat1 = (u_xlat0.yyyy * conv_mxt4x4_1(unity_MatrixVP));
          u_xlat1 = ((conv_mxt4x4_0(unity_MatrixVP) * u_xlat0.xxxx) + u_xlat1);
          u_xlat1 = ((conv_mxt4x4_2(unity_MatrixVP) * u_xlat0.zzzz) + u_xlat1);
          out_v.texcoord1 = u_xlat0;
          out_v.vertex = (u_xlat1 + conv_mxt4x4_3(unity_MatrixVP));
          out_v.texcoord.xy = float2(in_v.texcoord.xy);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float u_xlat10_0;
      int u_xlatb0;
      float u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat10_0 = tex2D(_MainTex, in_f.texcoord.xy).w.x;
          u_xlat16_1 = (u_xlat10_0 + (-_Cutoff));
          if((u_xlat16_1<0))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          if(((int(u_xlatb0) * (-1))!=0))
          {
              discard;
          }
          out_f.color = in_f.texcoord1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
        "DisableBatching" = "true"
        "RenderType" = "TreeTransparentCutout"
      }
      Cull Front
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
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _TreeInstanceScale;
      uniform float4x4 _TerrainEngineBendTree;
      uniform float4 _SquashPlaneNormal;
      uniform float _SquashAmount;
      uniform float _Cutoff;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 color :COLOR0;
          float4 texcoord :TEXCOORD0;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float u_xlat6;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.xyz = float3((in_v.vertex.xyz * _TreeInstanceScale.xyz));
          u_xlat1.xyz = float3((u_xlat0.yyy * conv_mxt4x4_1(_TerrainEngineBendTree).xyz));
          u_xlat1.xyz = float3(((conv_mxt4x4_0(_TerrainEngineBendTree).xyz * u_xlat0.xxx) + u_xlat1.xyz));
          u_xlat1.xyz = float3(((conv_mxt4x4_2(_TerrainEngineBendTree).xyz * u_xlat0.zzz) + u_xlat1.xyz));
          u_xlat1.xyz = float3((((-in_v.vertex.xyz) * _TreeInstanceScale.xyz) + u_xlat1.xyz));
          u_xlat0.xyz = float3(((in_v.color.www * u_xlat1.xyz) + u_xlat0.xyz));
          u_xlat6 = dot(_SquashPlaneNormal.xyz, u_xlat0.xyz);
          u_xlat6 = (u_xlat6 + _SquashPlaneNormal.w);
          u_xlat1.xyz = float3((((-float3(u_xlat6, u_xlat6, u_xlat6)) * _SquashPlaneNormal.xyz) + u_xlat0.xyz));
          u_xlat0.xyz = float3((u_xlat0.xyz + (-u_xlat1.xyz)));
          u_xlat0.xyz = float3(((float3(_SquashAmount, _SquashAmount, _SquashAmount) * u_xlat0.xyz) + u_xlat1.xyz));
          u_xlat0 = mul(unity_ObjectToWorld, float4(u_xlat0.xyz,1.0));
          u_xlat1 = (u_xlat0.yyyy * conv_mxt4x4_1(unity_MatrixVP));
          u_xlat1 = ((conv_mxt4x4_0(unity_MatrixVP) * u_xlat0.xxxx) + u_xlat1);
          u_xlat1 = ((conv_mxt4x4_2(unity_MatrixVP) * u_xlat0.zzzz) + u_xlat1);
          out_v.texcoord1 = u_xlat0;
          out_v.vertex = (u_xlat1 + conv_mxt4x4_3(unity_MatrixVP));
          out_v.texcoord.xy = float2(in_v.texcoord.xy);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float u_xlat10_0;
      int u_xlatb0;
      float u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat10_0 = tex2D(_MainTex, in_f.texcoord.xy).w.x;
          u_xlat16_1 = (u_xlat10_0 + (-_Cutoff));
          if((u_xlat16_1<0))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          if(((int(u_xlatb0) * (-1))!=0))
          {
              discard;
          }
          out_f.color = in_f.texcoord1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "TreeBillboard"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "TreeBillboard"
      }
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
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float3 _TreeBillboardCameraRight;
      uniform float4 _TreeBillboardCameraUp;
      uniform float4 _TreeBillboardCameraFront;
      uniform float4 _TreeBillboardCameraPos;
      uniform float4 _TreeBillboardDistances;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      int u_xlatb0;
      float4 u_xlat1;
      float u_xlat2;
      float u_xlat4;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.xyz = float3((in_v.vertex.xyz + (-_TreeBillboardCameraPos.xyz)));
          u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
          if((_TreeBillboardDistances.x<u_xlat0.x))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          u_xlat1.xy = float2(in_v.texcoord1.xy);
          u_xlat1.z = in_v.texcoord.y;
          float _tmp_dvx_27 = int(u_xlatb0);
          u_xlat0.xyz = float3(_tmp_dvx_27, _tmp_dvx_27, _tmp_dvx_27);
          u_xlat4 = ((-u_xlat0.y) + u_xlat0.z);
          u_xlat2 = ((_TreeBillboardCameraPos.w * u_xlat4) + u_xlat0.y);
          u_xlat1.xyz = float3(((float3(_TreeBillboardCameraRight.x, _TreeBillboardCameraRight.y, _TreeBillboardCameraRight.z) * u_xlat0.xxx) + in_v.vertex.xyz));
          u_xlat0.xzw = (abs(u_xlat0.xxx) * _TreeBillboardCameraFront.xyz);
          u_xlat1.xyz = float3(((_TreeBillboardCameraUp.xyz * float3(u_xlat2, u_xlat2, u_xlat2)) + u_xlat1.xyz));
          u_xlat0.xyz = float3(((u_xlat0.xzw * _TreeBillboardCameraUp.www) + u_xlat1.xyz));
          u_xlat1 = (u_xlat0.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat1 = ((conv_mxt4x4_0(unity_ObjectToWorld) * u_xlat0.xxxx) + u_xlat1);
          u_xlat0 = ((conv_mxt4x4_2(unity_ObjectToWorld) * u_xlat0.zzzz) + u_xlat1);
          u_xlat1.xyz = float3((u_xlat0.xyz + conv_mxt4x4_3(unity_ObjectToWorld).xyz));
          out_v.texcoord1 = ((conv_mxt4x4_3(unity_ObjectToWorld) * in_v.vertex.wwww) + u_xlat0);
          out_v.vertex = mul(unity_MatrixVP, float4(u_xlat1.xyz,1.0));
          if((0<in_v.texcoord.y))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          out_v.texcoord.y = u_xlatb0;
          out_v.texcoord.x = in_v.texcoord.x;
          //return 10;
          //return float(0);
          //return float3(0, 0, 0);
          //return u_xlat1.xyz;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float u_xlat10_0;
      int u_xlatb0_d;
      float u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat10_0 = tex2D(_MainTex, in_f.texcoord.xy).w.x;
          u_xlat16_1 = (u_xlat10_0 + (-100000005));
          if((u_xlat16_1<0))
          {
              u_xlatb0_d = 1;
          }
          else
          {
              u_xlatb0_d = 0;
          }
          if(((int(u_xlatb0_d) * (-1))!=0))
          {
              discard;
          }
          out_f.color = in_f.texcoord1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "GrassBillboard"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "GrassBillboard"
      }
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
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _WavingTint;
      uniform float4 _WaveAndDistance;
      uniform float4 _CameraPosition;
      uniform float3 _CameraRight;
      uniform float3 _CameraUp;
      uniform float _Cutoff;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 tangent :TANGENT0;
          float4 texcoord :TEXCOORD0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      int u_xlatb0;
      float4 u_xlat1;
      float4 u_xlat2;
      float4 u_xlat3;
      float3 u_xlat16_4;
      float u_xlat5;
      float u_xlat15;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.xyz = float3((in_v.vertex.xyz + (-_CameraPosition.xyz)));
          u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
          if((_WaveAndDistance.w<u_xlat0.x))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          float _tmp_dvx_28 = int(u_xlatb0);
          u_xlat0.xy = float2(_tmp_dvx_28, _tmp_dvx_28);
          u_xlat0.xzw = ((u_xlat0.xxx * _CameraRight.xyz) + in_v.vertex.xyz);
          u_xlat0.xyz = float3(((u_xlat0.yyy * _CameraUp.xyz) + u_xlat0.xzw));
          u_xlat1.xy = float2((u_xlat0.xz * _WaveAndDistance.yy));
          u_xlat2 = (u_xlat1.yyyy * float4(600000005, 199999996, 199999996, 500000007));
          u_xlat1 = ((u_xlat1.xxxx * float4(120000001, 199999996, 599999987, 240000002)) + u_xlat2);
          u_xlat1 = ((_WaveAndDistance.xxxx * float4(120000005, 20, 160000002, 480000019)) + u_xlat1);
          u_xlat1 = frac(u_xlat1);
          u_xlat1 = ((u_xlat1 * float4(640884876, 640884876, 640884876, 640884876)) + float4(-314159274, (-314159274), (-314159274), (-314159274)));
          u_xlat2 = (u_xlat1 * u_xlat1);
          u_xlat3 = (u_xlat1 * u_xlat2);
          u_xlat1 = ((u_xlat3 * float4(-161616161, (-161616161), (-161616161), (-161616161))) + u_xlat1);
          u_xlat3 = (u_xlat2 * u_xlat3);
          u_xlat2 = (u_xlat2 * u_xlat3);
          u_xlat1 = ((u_xlat3 * float4(833330024, 833330024, 833330024, 833330024)) + u_xlat1);
          u_xlat1 = ((u_xlat2 * float4(-198409994, (-198409994), (-198409994), (-198409994))) + u_xlat1);
          u_xlat1 = (u_xlat1 * u_xlat1);
          u_xlat1 = (u_xlat1 * u_xlat1);
          u_xlat2 = (u_xlat1 * in_v.tangent.yyyy);
          u_xlat15 = dot(u_xlat1, float4(674199879, 674199879, 269679934, 134839967));
          u_xlat15 = (u_xlat15 * 699999988);
          u_xlat1.x = dot(u_xlat2, float4(240000002, 399999991, (-119999997), 960000008));
          u_xlat1.z = dot(u_xlat2, float4(600000005, 199999996, (-199999996), 100000001));
          u_xlat0.xz = (((-u_xlat1.xz) * _WaveAndDistance.zz) + u_xlat0.xz);
          u_xlat1 = (u_xlat0.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat2.xyz = float3((u_xlat0.xyz + (-_CameraPosition.xyz)));
          u_xlat5 = dot(u_xlat2.xyz, u_xlat2.xyz);
          u_xlat5 = ((-u_xlat5) + _WaveAndDistance.w);
          u_xlat5 = dot(_CameraPosition.ww, float2(u_xlat5, u_xlat5));
          u_xlat5 = clamp(u_xlat5, 0, 10);
          out_v.color.w = u_xlat5;
          u_xlat1 = ((conv_mxt4x4_0(unity_ObjectToWorld) * u_xlat0.xxxx) + u_xlat1);
          u_xlat1 = ((conv_mxt4x4_2(unity_ObjectToWorld) * u_xlat0.zzzz) + u_xlat1);
          u_xlat0.xyz = float3((u_xlat1.xyz + conv_mxt4x4_3(unity_ObjectToWorld).xyz));
          out_v.texcoord1 = ((conv_mxt4x4_3(unity_ObjectToWorld) * in_v.vertex.wwww) + u_xlat1);
          out_v.vertex = mul(unity_MatrixVP, float4(u_xlat0.xyz,1.0));
          u_xlat16_4.xyz = float3((_WavingTint.xyz + float3(-5, (-5), (-5))));
          u_xlat16_4.xyz = float3(((float3(u_xlat15, u_xlat15, u_xlat15) * u_xlat16_4.xyz) + float3(5, 5, 5)));
          u_xlat16_4.xyz = float3((u_xlat16_4.xyz * in_v.color.xyz));
          out_v.color.xyz = float3((u_xlat16_4.xyz + u_xlat16_4.xyz));
          out_v.texcoord.xy = float2(in_v.texcoord.xy);
          //return float2(0, 0);
          //return in_v.tangent.xy;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float u_xlat10_0;
      int u_xlatb0_d;
      float u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat10_0 = tex2D(_MainTex, in_f.texcoord.xy).w.x;
          u_xlat16_1 = ((u_xlat10_0 * in_f.color.w) + (-_Cutoff));
          if((u_xlat16_1<0))
          {
              u_xlatb0_d = 1;
          }
          else
          {
              u_xlatb0_d = 0;
          }
          if(((int(u_xlatb0_d) * (-1))!=0))
          {
              discard;
          }
          out_f.color = in_f.texcoord1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Grass"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "RenderType" = "Grass"
      }
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
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float4 _WavingTint;
      uniform float4 _WaveAndDistance;
      uniform float4 _CameraPosition;
      uniform float _Cutoff;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float4 texcoord :TEXCOORD0;
          float4 color :COLOR0;
      };
      
      struct OUT_Data_Vert
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float4 color :COLOR0;
          float2 texcoord :TEXCOORD0;
          float4 texcoord1 :TEXCOORD1;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlat2;
      float3 u_xlat16_3;
      float3 u_xlat4;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0.xy = float2((in_v.vertex.xz * _WaveAndDistance.yy));
          u_xlat1 = (u_xlat0.yyyy * float4(600000005, 199999996, 199999996, 500000007));
          u_xlat0 = ((u_xlat0.xxxx * float4(120000001, 199999996, 599999987, 240000002)) + u_xlat1);
          u_xlat0 = ((_WaveAndDistance.xxxx * float4(120000005, 20, 160000002, 480000019)) + u_xlat0);
          u_xlat0 = frac(u_xlat0);
          u_xlat0 = ((u_xlat0 * float4(640884876, 640884876, 640884876, 640884876)) + float4(-314159274, (-314159274), (-314159274), (-314159274)));
          u_xlat1 = (u_xlat0 * u_xlat0);
          u_xlat2 = (u_xlat0 * u_xlat1);
          u_xlat0 = ((u_xlat2 * float4(-161616161, (-161616161), (-161616161), (-161616161))) + u_xlat0);
          u_xlat2 = (u_xlat1 * u_xlat2);
          u_xlat1 = (u_xlat1 * u_xlat2);
          u_xlat0 = ((u_xlat2 * float4(833330024, 833330024, 833330024, 833330024)) + u_xlat0);
          u_xlat0 = ((u_xlat1 * float4(-198409994, (-198409994), (-198409994), (-198409994))) + u_xlat0);
          u_xlat0 = (u_xlat0 * u_xlat0);
          u_xlat0 = (u_xlat0 * u_xlat0);
          u_xlat1.x = (in_v.color.w * _WaveAndDistance.z);
          u_xlat1 = (u_xlat0 * u_xlat1.xxxx);
          u_xlat0.x = dot(u_xlat0, float4(674199879, 674199879, 269679934, 134839967));
          u_xlat0.x = (u_xlat0.x * 699999988);
          u_xlat2.x = dot(u_xlat1, float4(240000002, 399999991, (-119999997), 960000008));
          u_xlat2.z = dot(u_xlat1, float4(600000005, 199999996, (-199999996), 100000001));
          u_xlat1.xz = (((-u_xlat2.xz) * _WaveAndDistance.zz) + in_v.vertex.xz);
          u_xlat2 = (in_v.vertex.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat2 = ((conv_mxt4x4_0(unity_ObjectToWorld) * u_xlat1.xxxx) + u_xlat2);
          u_xlat2 = ((conv_mxt4x4_2(unity_ObjectToWorld) * u_xlat1.zzzz) + u_xlat2);
          u_xlat4.xyz = float3((u_xlat2.xyz + conv_mxt4x4_3(unity_ObjectToWorld).xyz));
          out_v.texcoord1 = ((conv_mxt4x4_3(unity_ObjectToWorld) * in_v.vertex.wwww) + u_xlat2);
          out_v.vertex = mul(unity_MatrixVP, float4(u_xlat4.xyz,1.0));
          u_xlat16_3.xyz = float3((_WavingTint.xyz + float3(-5, (-5), (-5))));
          u_xlat16_3.xyz = float3(((u_xlat0.xxx * u_xlat16_3.xyz) + float3(5, 5, 5)));
          u_xlat16_3.xyz = float3((u_xlat16_3.xyz * in_v.color.xyz));
          out_v.color.xyz = float3((u_xlat16_3.xyz + u_xlat16_3.xyz));
          u_xlat1.y = in_v.vertex.y;
          u_xlat0.xyz = float3((u_xlat1.xyz + (-_CameraPosition.xyz)));
          u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
          u_xlat0.x = ((-u_xlat0.x) + _WaveAndDistance.w);
          u_xlat0.x = dot(_CameraPosition.ww, u_xlat0.xx);
          u_xlat0.x = clamp(u_xlat0.x, 0, 10);
          out_v.color.w = u_xlat0.x;
          out_v.texcoord.xy = float2(in_v.texcoord.xy);
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float u_xlat10_0;
      int u_xlatb0;
      float u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat10_0 = tex2D(_MainTex, in_f.texcoord.xy).w.x;
          u_xlat16_1 = ((u_xlat10_0 * in_f.color.w) + (-_Cutoff));
          if((u_xlat16_1<0))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          if(((int(u_xlatb0) * (-1))!=0))
          {
              discard;
          }
          out_f.color = in_f.texcoord1;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
