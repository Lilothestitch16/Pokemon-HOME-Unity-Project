Shader "Custom/Earth Shader_02"
{
  Properties
  {
    _MainTex ("Main texture", 2D) = "white" {}
    _ColorTop ("Top", Color) = (1,1,1,1)
    _ColorBottom ("Bottom", Color) = (1,1,1,1)
    _Mitigation ("Distortion mitigation", Range(1, 30)) = 1
    _Speed ("Speed", Range(-100, 100)) = 1
    _StencilComp ("Stencil Comparison", float) = 8
    _Stencil ("Stencil ID", float) = 0
    _StencilOp ("Stencil Operation", float) = 0
    _StencilWriteMask ("Stencil Write Mask", float) = 255
    _StencilReadMask ("Stencil Read Mask", float) = 255
    _ColorMask ("Color Mask", float) = 15
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
      ColorMask 0
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
      uniform float4 _ColorTop;
      uniform float4 _ColorBottom;
      uniform float4 _TextureSampleAdd;
      uniform int _UseClipRect;
      uniform float4 _ClipRect;
      uniform int _UseAlphaClip;
      uniform float _Speed;
      uniform sampler2D _MainTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float2 texcoord :TEXCOORD0;
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
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          out_v.texcoord.xy = float2(in_v.texcoord.xy);
          out_v.texcoord1 = in_v.vertex;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float u_xlat0_d;
      float4 u_xlat16_0;
      float u_xlat10_0;
      float4 u_xlat1_d;
      float3 u_xlat16_1;
      float4 u_xlat2;
      float4 u_xlatb2;
      float u_xlat16_3;
      float u_xlat16_5;
      int u_xlatb6;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d = (_Time.x * _Speed);
          u_xlat16_1.x = floor(u_xlat0_d);
          u_xlat16_1.x = ((_Time.x * _Speed) + (-u_xlat16_1.x));
          u_xlat16_1.x = (u_xlat16_1.x + (-5));
          u_xlat16_1.x = (u_xlat16_1.x * 31400001);
          u_xlat16_1.x = sin(u_xlat16_1.x);
          u_xlat16_1.y = (u_xlat16_1.x + in_f.texcoord.y);
          u_xlat16_1.x = in_f.texcoord.x;
          u_xlat10_0 = tex2D(_MainTex, u_xlat16_1.xy).x;
          u_xlat16_1.x = ((-u_xlat10_0) + 10);
          u_xlat16_1.xyz = float3((u_xlat16_1.xxx * _ColorBottom.xyz));
          u_xlat16_1.xyz = float3(((_ColorTop.xyz * float3(u_xlat10_0, u_xlat10_0, u_xlat10_0)) + u_xlat16_1.xyz));
          u_xlat16_0.xyz = float3((u_xlat16_1.xyz + _TextureSampleAdd.xyz));
          u_xlatb2.xy = float2(bool4(in_f.texcoord1.xyxx >= _ClipRect.xyxx).xy);
          u_xlatb2.zw = bool4(_ClipRect.zzzw >= in_f.texcoord1.xxxy).zw;
          u_xlat2 = lerp(float4(0, 0, 0, 0), float4(10, 10, 10, 10), float4(u_xlatb2));
          u_xlat2.xy = float2((u_xlat2.zw * u_xlat2.xy));
          u_xlat2.x = (u_xlat2.y * u_xlat2.x);
          u_xlat16_1.xy = float2((in_f.texcoord.xy + float2(-5, (-5))));
          u_xlat16_1.x = length(u_xlat16_1.xy);
          u_xlat16_5 = (u_xlat16_1.x * 2000);
          u_xlat16_1.x = (u_xlat16_1.x + (-400000006));
          u_xlat16_1.x = (((-u_xlat16_1.x) * 80) + 5);
          u_xlat16_5 = floor(u_xlat16_5);
          if((u_xlat16_5<800))
          {
              u_xlatb6 = 1;
          }
          else
          {
              u_xlatb6 = 0;
          }
          u_xlat16_0.w = u_xlatb6;
          u_xlat1_d = (u_xlat16_0 * u_xlat2.xxxx);
          if((_UseClipRect!=0))
          {
              u_xlat16_0 = float4(1, 1, 1, 1);
          }
          else
          {
              u_xlat16_0 = float4(0, 0, 0, 0);
          }
          u_xlat16_3 = (u_xlat16_0.w + (-100000005));
          out_f.color = u_xlat16_0;
          if((u_xlat16_3<0))
          {
              u_xlatb2.x = 1;
          }
          else
          {
              u_xlatb2.x = 0;
          }
          if((_UseAlphaClip!=0))
          {
              u_xlatb6 = 1;
          }
          else
          {
              u_xlatb6 = 0;
          }
          u_xlatb2.x = (u_xlatb6 && u_xlatb2.x);
          if(((int(u_xlatb2.x) * (-1))!=0))
          {
              discard;
          }
          //return u_xlat1_d;
          //return u_xlat16_0;
          //return 5;
          //return u_xlat16_1.x;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
