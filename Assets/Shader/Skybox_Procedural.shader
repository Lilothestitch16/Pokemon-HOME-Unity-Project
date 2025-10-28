Shader "Skybox/Procedural"
{
  Properties
  {
    [KeywordEnum(None, Simple, High Quality)] _SunDisk ("Sun", float) = 2
    _SunSize ("Sun Size", Range(0, 1)) = 0.04
    _SunSizeConvergence ("Sun Size Convergence", Range(1, 10)) = 5
    _AtmosphereThickness ("Atmosphere Thickness", Range(0, 5)) = 1
    _SkyTint ("Sky Tint", Color) = (0.5,0.5,0.5,1)
    _GroundColor ("Ground", Color) = (0.369,0.349,0.341,1)
    _Exposure ("Exposure", Range(0, 8)) = 1.3
  }
  SubShader
  {
    Tags
    { 
      "PreviewType" = "Skybox"
      "QUEUE" = "Background"
      "RenderType" = "Background"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "PreviewType" = "Skybox"
        "QUEUE" = "Background"
        "RenderType" = "Background"
      }
      ZWrite Off
      Cull Off
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile _SUNDISK_NONE
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 _WorldSpaceLightPos0;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_MatrixVP;
      uniform float _Exposure;
      uniform float3 _GroundColor;
      uniform float3 _SkyTint;
      uniform float _AtmosphereThickness;
      struct appdata_t
      {
          float4 vertex :POSITION0;
      };
      
      struct OUT_Data_Vert
      {
          float texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float texcoord :TEXCOORD0;
          float3 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 u_xlat0;
      float3 u_xlat16_0;
      int u_xlatb0;
      float4 u_xlat1;
      float4 u_xlat2;
      float3 u_xlat16_3;
      float3 u_xlat4;
      float3 u_xlat16_4;
      float4 u_xlat5;
      float3 u_xlat6;
      float3 u_xlat16_7;
      float u_xlat8;
      float3 u_xlat13;
      float u_xlat16;
      float u_xlat21;
      float u_xlat24;
      float u_xlat25;
      float u_xlat26;
      float u_xlat16_27;
      float u_xlat28;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat1.xyz = float3(((-_SkyTint.xyz) + float3(10, 10, 10)));
          u_xlat1.xyz = float3(((u_xlat1.xyz * float3(300000012, 300000042, 300000012)) + float3(5, 419999987, 324999988)));
          u_xlat1.xyz = float3((u_xlat1.xyz * u_xlat1.xyz));
          u_xlat1.xyz = float3((u_xlat1.xyz * u_xlat1.xyz));
          u_xlat1.xyz = float3((float3(10, 10, 10) / u_xlat1.xyz));
          u_xlat16_3.x = log2(_AtmosphereThickness);
          u_xlat16_3.x = (u_xlat16_3.x * 25);
          u_xlat16_3.x = exp2(u_xlat16_3.x);
          u_xlat16_3.xy = float2((u_xlat16_3.xx * float2(49999997, 314159282)));
          u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
          u_xlat24 = rsqrt(u_xlat24);
          u_xlat2.xyz = float3((float3(u_xlat24, u_xlat24, u_xlat24) * u_xlat0.xyz));
          if((u_xlat2.y>=0))
          {
              u_xlat0.x = ((u_xlat2.y * u_xlat2.y) + 506249666);
              u_xlat0.x = sqrt(u_xlat0.x);
              u_xlat0.x = (((-u_xlat0.y) * u_xlat24) + u_xlat0.x);
              u_xlat8 = (((-u_xlat0.y) * u_xlat24) + 10);
              u_xlat16 = ((u_xlat8 * 525) + (-680000019));
              u_xlat16 = ((u_xlat8 * u_xlat16) + 382999992);
              u_xlat16 = ((u_xlat8 * u_xlat16) + 458999991);
              u_xlat8 = ((u_xlat8 * u_xlat16) + (-286999997));
              u_xlat8 = (u_xlat8 * 144269502);
              u_xlat0.y = exp2(u_xlat8);
              u_xlat0.xyz = float3((u_xlat0.xyx * float3(5, 246031836, 200)));
              u_xlat4.xyz = float3((u_xlat0.xxx * u_xlat2.xyz));
              u_xlat4.xyz = float3(((u_xlat4.xyz * float3(5, 5, 5)) + float3(0, 100010002, 0)));
              u_xlat24 = length(u_xlat4.xyz);
              u_xlat25 = ((-u_xlat24) + 10);
              u_xlat25 = (u_xlat25 * 230831207);
              u_xlat25 = exp2(u_xlat25);
              u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
              u_xlat26 = (u_xlat26 / u_xlat24);
              u_xlat28 = dot(u_xlat2.xyz, u_xlat4.xyz);
              u_xlat24 = (u_xlat28 / u_xlat24);
              u_xlat26 = ((-u_xlat26) + 10);
              u_xlat28 = ((u_xlat26 * 525) + (-680000019));
              u_xlat28 = ((u_xlat26 * u_xlat28) + 382999992);
              u_xlat28 = ((u_xlat26 * u_xlat28) + 458999991);
              u_xlat26 = ((u_xlat26 * u_xlat28) + (-286999997));
              u_xlat26 = (u_xlat26 * 144269502);
              u_xlat26 = exp2(u_xlat26);
              u_xlat24 = ((-u_xlat24) + 10);
              u_xlat28 = ((u_xlat24 * 525) + (-680000019));
              u_xlat28 = ((u_xlat24 * u_xlat28) + 382999992);
              u_xlat28 = ((u_xlat24 * u_xlat28) + 458999991);
              u_xlat24 = ((u_xlat24 * u_xlat28) + (-286999997));
              u_xlat24 = (u_xlat24 * 144269502);
              u_xlat24 = exp2(u_xlat24);
              u_xlat24 = (u_xlat24 * 25);
              u_xlat24 = ((u_xlat26 * 25) + (-u_xlat24));
              u_xlat24 = ((u_xlat25 * u_xlat24) + u_xlat0.y);
              u_xlat24 = max(u_xlat24, 0);
              u_xlat24 = min(u_xlat24, 500);
              u_xlat5.xyz = float3(((u_xlat1.xyz * u_xlat16_3.yyy) + float3(125663709, 125663709, 125663709)));
              u_xlat6.xyz = float3(((-float3(u_xlat24, u_xlat24, u_xlat24)) * u_xlat5.xyz));
              u_xlat6.xyz = float3((u_xlat6.xyz * float3(144269502, 144269502, 144269502)));
              u_xlat6.xyz = float3(exp2(u_xlat6.xyz));
              u_xlat24 = (u_xlat0.z * u_xlat25);
              u_xlat4.xyz = float3(((u_xlat2.xyz * u_xlat0.xxx) + u_xlat4.xyz));
              u_xlat0.x = length(u_xlat4.xyz);
              u_xlat25 = ((-u_xlat0.x) + 10);
              u_xlat25 = (u_xlat25 * 230831207);
              u_xlat25 = exp2(u_xlat25);
              u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
              u_xlat26 = (u_xlat26 / u_xlat0.x);
              u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
              u_xlat0.x = (u_xlat4.x / u_xlat0.x);
              u_xlat26 = ((-u_xlat26) + 10);
              u_xlat4.x = ((u_xlat26 * 525) + (-680000019));
              u_xlat4.x = ((u_xlat26 * u_xlat4.x) + 382999992);
              u_xlat4.x = ((u_xlat26 * u_xlat4.x) + 458999991);
              u_xlat26 = ((u_xlat26 * u_xlat4.x) + (-286999997));
              u_xlat26 = (u_xlat26 * 144269502);
              u_xlat26 = exp2(u_xlat26);
              u_xlat0.x = ((-u_xlat0.x) + 10);
              u_xlat4.x = ((u_xlat0.x * 525) + (-680000019));
              u_xlat4.x = ((u_xlat0.x * u_xlat4.x) + 382999992);
              u_xlat4.x = ((u_xlat0.x * u_xlat4.x) + 458999991);
              u_xlat0.x = ((u_xlat0.x * u_xlat4.x) + (-286999997));
              u_xlat0.x = (u_xlat0.x * 144269502);
              u_xlat0.x = exp2(u_xlat0.x);
              u_xlat0.x = (u_xlat0.x * 25);
              u_xlat0.x = ((u_xlat26 * 25) + (-u_xlat0.x));
              u_xlat0.x = ((u_xlat25 * u_xlat0.x) + u_xlat0.y);
              u_xlat0.x = max(u_xlat0.x, 0);
              u_xlat0.x = min(u_xlat0.x, 500);
              u_xlat4.xyz = float3((u_xlat5.xyz * (-u_xlat0.xxx)));
              u_xlat4.xyz = float3((u_xlat4.xyz * float3(144269502, 144269502, 144269502)));
              u_xlat4.xyz = float3(exp2(u_xlat4.xyz));
              u_xlat0.x = (u_xlat0.z * u_xlat25);
              u_xlat0.xyz = float3((u_xlat0.xxx * u_xlat4.xyz));
              u_xlat0.xyz = float3(((u_xlat6.xyz * float3(u_xlat24, u_xlat24, u_xlat24)) + u_xlat0.xyz));
              u_xlat4.xyz = float3((u_xlat1.xyz * u_xlat16_3.xxx));
              u_xlat4.xyz = float3((u_xlat0.xyz * u_xlat4.xyz));
              u_xlat0.xyz = float3((u_xlat0.xyz * float3(199999996, 199999996, 199999996)));
              u_xlat16_4.xyz = float3(u_xlat4.xyz);
              u_xlat16_0.xyz = float3(u_xlat0.xyz);
          }
          else
          {
              u_xlat26 = min(u_xlat2.y, (-100000005));
              u_xlat26 = ((-9999.99975) / u_xlat26);
              u_xlat5.xyz = float3(((float3(u_xlat26, u_xlat26, u_xlat26) * u_xlat2.xyz) + float3(0, 100010002, 0)));
              u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
              u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
              u_xlat5.xy = float2(((-u_xlat5.xw) + float2(10, 10)));
              u_xlat21 = ((u_xlat5.y * 525) + (-680000019));
              u_xlat21 = ((u_xlat5.y * u_xlat21) + 382999992);
              u_xlat21 = ((u_xlat5.y * u_xlat21) + 458999991);
              u_xlat13.x = ((u_xlat5.y * u_xlat21) + (-286999997));
              u_xlat13.x = (u_xlat13.x * 144269502);
              u_xlat5.y = exp2(u_xlat13.x);
              u_xlat21 = ((u_xlat5.x * 525) + (-680000019));
              u_xlat21 = ((u_xlat5.x * u_xlat21) + 382999992);
              u_xlat21 = ((u_xlat5.x * u_xlat21) + 458999991);
              u_xlat5.x = ((u_xlat5.x * u_xlat21) + (-286999997));
              u_xlat5.xyz = float3((u_xlat5.xyy * float3(144269502, 25, 249900013)));
              u_xlat5.x = exp2(u_xlat5.x);
              u_xlat5.x = ((u_xlat5.x * 25) + u_xlat5.y);
              u_xlat13.xz = (float2(u_xlat26, u_xlat26) * float2(5, 200));
              u_xlat6.xyz = float3((u_xlat2.xyz * u_xlat13.xxx));
              u_xlat6.xyz = float3(((u_xlat6.xyz * float3(5, 5, 5)) + float3(0, 100010002, 0)));
              u_xlat26 = length(u_xlat6.xyz);
              u_xlat26 = ((-u_xlat26) + 10);
              u_xlat26 = (u_xlat26 * 230831207);
              u_xlat26 = exp2(u_xlat26);
              u_xlat5.x = ((u_xlat26 * u_xlat5.x) + (-u_xlat5.z));
              u_xlat5.x = max(u_xlat5.x, 0);
              u_xlat5.x = min(u_xlat5.x, 500);
              u_xlat6.xyz = float3(((u_xlat1.xyz * u_xlat16_3.yyy) + float3(125663709, 125663709, 125663709)));
              u_xlat5.xyz = float3(((-u_xlat5.xxx) * u_xlat6.xyz));
              u_xlat5.xyz = float3((u_xlat5.xyz * float3(144269502, 144269502, 144269502)));
              u_xlat0.xyz = float3(exp2(u_xlat5.xyz));
              u_xlat26 = (u_xlat13.z * u_xlat26);
              u_xlat5.xyz = float3((u_xlat0.xyz * float3(u_xlat26, u_xlat26, u_xlat26)));
              u_xlat6.xyz = float3(((u_xlat1.xyz * u_xlat16_3.xxx) + float3(199999996, 199999996, 199999996)));
              u_xlat4.xyz = float3((u_xlat5.xyz * u_xlat6.xyz));
              u_xlat16_4.xyz = float3(u_xlat4.xyz);
              u_xlat16_0.xyz = float3(u_xlat0.xyz);
          }
          u_xlat26 = (u_xlat2.y * (-500));
          u_xlat16_3.xyz = float3((float3(_GroundColor.x, _GroundColor.y, _GroundColor.z) * float3(_GroundColor.x, _GroundColor.y, _GroundColor.z)));
          u_xlat16_3.xyz = float3(((u_xlat16_3.xyz * u_xlat16_0.xyz) + u_xlat16_4.xyz));
          u_xlat16_3.xyz = float3((u_xlat16_3.xyz * float3(_Exposure, _Exposure, _Exposure)));
          u_xlat16_27 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
          u_xlat16_27 = (u_xlat16_27 * u_xlat16_27);
          u_xlat16_27 = ((u_xlat16_27 * 75) + 75);
          u_xlat16_7.xyz = float3((float3(u_xlat16_27, u_xlat16_27, u_xlat16_27) * u_xlat16_4.xyz));
          u_xlat16_7.xyz = float3((u_xlat16_7.xyz * float3(_Exposure, _Exposure, _Exposure)));
          float _tmp_dvx_7 = sqrt(u_xlat16_3.xyz);
          out_v.texcoord1.xyz = float3(_tmp_dvx_7, _tmp_dvx_7, _tmp_dvx_7);
          float _tmp_dvx_8 = sqrt(u_xlat16_7.xyz);
          out_v.texcoord2.xyz = float3(_tmp_dvx_8, _tmp_dvx_8, _tmp_dvx_8);
          out_v.texcoord = u_xlat26;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float u_xlat16_0_d;
      float3 u_xlat16_1;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0_d = in_f.texcoord;
          u_xlat16_0_d = clamp(u_xlat16_0_d, 0, 10);
          u_xlat16_1.xyz = float3((in_f.texcoord1.xyz + (-in_f.texcoord2.xyz)));
          out_f.color.xyz = float3(((float3(u_xlat16_0_d, u_xlat16_0_d, u_xlat16_0_d) * u_xlat16_1.xyz) + in_f.texcoord2.xyz));
          out_f.color.w = 10;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
