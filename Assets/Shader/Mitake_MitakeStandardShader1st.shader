Shader "Mitake/MitakeStandardShader1st"
{
  Properties
  {
    _Col0Tex ("Col0Tex", 2D) = "white" {}
    _L1Col0Tex ("L1Col0Tex", 2D) = "white" {}
    [NoScaleOffset] _EmissionMaskTex ("EmissionMaskTex", 2D) = "white" {}
    [NoScaleOffset] _SphereMapTex ("SphereMapTex", 2D) = "black" {}
    [Header(Settings)] _ColorMapUvIndex ("ColorMapUvIndex", float) = 0
    _Layer1UvIndex ("Layer1UvIndex", float) = 0
    [HideInInspector] _BlendMode ("__mode", float) = 0
    [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", float) = 4
    [MaterialToggle] _ZWrite ("Z Write", float) = 1
    [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("Src Factor", float) = 1
    [Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("Dst Factor", float) = 0
    [Header(ColorMapStatus)] [PowerSlider(3.0)] _LightColorValue ("LightColorValue", Range(0, 1)) = 1
    [PowerSlider(3.0)] _DiscardValue ("DiscardValue", Range(0, 1)) = 1
    _ConstantColor0 ("ConstantColor0", Color) = (1,1,1,1)
    [PowerSlider(3.0)] _ConstantColor0Val ("ConstantColor0Val", Range(0, 32)) = 1
    _ConstantColorSd0 ("ConstantColorSd0", Color) = (0,0,0,1)
    [PowerSlider(3.0)] _ConstantColorSd0Val ("ConstantColorSd0Val", Range(0, 32)) = 1
    [PowerSlider(3.0)] _ColorBaseU ("ColorBaseU", Range(0, 32)) = 0
    [PowerSlider(3.0)] _ColorBaseV ("ColorBaseV", Range(0, 32)) = 0
    [Header(Emission)] [Toggle(USE_EMISSION_MASK_TEX)] _EmissionMaskUse ("EmissionMaskUse", float) = 0
    [PowerSlider(3.0)] _EmissionMaskVal ("EmissionMaskVal", Range(0, 32)) = 1
    [Toggle(SWITCH_EMISSION_MASK_TEX_UV)] _SwitchEmissionMaskTexUV ("SwitchEmissionMaskTexUV", float) = 0
    [Header(FinalConstantColor)] _ConstantColor ("ConstantColor", Color) = (1,1,1,1)
    [PowerSlider(3.0)] _ConstantColorValue ("ConstantColorValue", Range(0, 32)) = 1
    [PowerSlider(3.0)] _ConstantAlpha ("ConstantColorAlpha", Range(0, 32)) = 1
    [Header(Layer1ColorMap)] [Toggle(USE_LAYER1)] _Layer1Enable ("Layer1Enable", float) = 0
    [PowerSlider(3.0)] _Layer1OverLerpValue ("Layer1OverLerpValue", Range(0, 32)) = 1
    [Toggle(SWITCH_PRIORITY)] _SwitchPriority ("SwitchPriority", float) = 0
    [Toggle(SWITCH_PRIORITY)] _LayerCalcMulti ("LayerCulcMulti", float) = 0
    [Header(Layer1ColorMapStatus)] _L1ConstantColor0 ("L1ConstantColor0", Color) = (1,1,1,1)
    [PowerSlider(3.0)] _L1ConstantColor0Val ("L1ConstantColor0Val", Range(0, 32)) = 1
    _L1ConstantColorSd0 ("L1ConstantColorSd0", Color) = (1,1,1,1)
    [PowerSlider(3.0)] _L1ConstantColorSd0Val ("L1ConstantColorSd0Val", Range(0, 32)) = 1
    _L1AddColor0 ("L1AddColor0", Color) = (1,1,1,1)
    [PowerSlider(3.0)] _L1AddColor0Val ("L1AddColor0Val", Range(0, 32)) = 0
    [PowerSlider(3.0)] _Layer1BaseU ("Layer1BaseU", Range(0, 32)) = 0
    [PowerSlider(3.0)] _Layer1BaseV ("Layer1BaseV", Range(0, 32)) = 0
    [Header(RimColor)] _RimColor ("RimColor", Color) = (1,1,1,1)
    _RimColorShadow ("RimColorShadow", Color) = (0,0,0,1)
    [PowerSlider(3.0)] _RimColorValue ("RimColorValue", Range(0, 32)) = 0
    [PowerSlider(3.0)] _RimPower ("RimPower", Range(0, 32)) = 8
    [PowerSlider(3.0)] _RimStrength ("RimStrength", Range(0, 32)) = 8
    [Toggle(USE_RIM_MASK_TEX)] _RimMaskEnable ("RimMaskEnable", float) = 0
    [Header(Specular)] _SpecularColor ("SpecularColor", Color) = (1,1,1,1)
    [Toggle(SWITCH_BASECOLOR_ADD_SPECULAR)] _BaseColorAddEnable ("BaseColorAddEnable", float) = 1
    [PowerSlider(3.0)] _SpecularScale ("SpecularScale", Range(0, 5)) = 0.4
    [PowerSlider(3.0)] _SpecularPower ("SpecularPower", Range(0, 32)) = 10
    [Toggle(USE_SPECULAR_MASK_TEX)] _SpecularMaskEnable ("SpecularMaskEnable", float) = 0
    [Header(SphereMap)] [Toggle(USE_SPHEREMASK_TEX)] _SphereMaskEnable ("SphereMaskEnable", float) = 1
    _SphereMapColor ("SphereMapColor", Color) = (1,1,1,1)
    [PowerSlider(3.0)] _SphereMapColorVal ("SphereMapColorVal", Range(0, 32)) = 1
    [Space] [Header(Culling___________________________)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Culling Mode", float) = 2
    [Header(Stencil___________________________)] [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Compare Function", float) = 0
    [Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Operation", float) = 0
    [ValueOffset(128)] _PokemonStencil ("MatLink ID", float) = 128
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
        "LIGHTMODE" = "FORWARDBASE"
        "SHADOWSUPPORT" = "true"
      }
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 0
        ReadMask 255
        WriteMask 255
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
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile DIRECTIONAL
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      #define conv_mxt4x4_0(mat4x4) float4(mat4x4[0].x,mat4x4[1].x,mat4x4[2].x,mat4x4[3].x)
      #define conv_mxt4x4_1(mat4x4) float4(mat4x4[0].y,mat4x4[1].y,mat4x4[2].y,mat4x4[3].y)
      #define conv_mxt4x4_2(mat4x4) float4(mat4x4[0].z,mat4x4[1].z,mat4x4[2].z,mat4x4[3].z)
      #define conv_mxt4x4_3(mat4x4) float4(mat4x4[0].w,mat4x4[1].w,mat4x4[2].w,mat4x4[3].w)
      
      
      #define CODE_BLOCK_VERTEX
      //uniform float4 unity_SHAr;
      //uniform float4 unity_SHAg;
      //uniform float4 unity_SHAb;
      //uniform float4 unity_SHBr;
      //uniform float4 unity_SHBg;
      //uniform float4 unity_SHBb;
      //uniform float4 unity_SHC;
      //uniform float4x4 unity_ObjectToWorld;
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      uniform int _ColorMapUvIndex;
      uniform int _Layer1UvIndex;
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _WorldSpaceLightPos0;
      //uniform float4x4 unity_MatrixV;
      uniform float4 _LightColor0;
      uniform float _BlendMode;
      uniform int _SpecularMaskEnable;
      uniform int _BaseColorAddEnable;
      uniform int _EmissionMaskUse;
      uniform int _SphereMaskEnable;
      uniform int _RimMaskEnable;
      uniform float4 _Col0Tex_ST;
      uniform float _ColorBaseU;
      uniform float _ColorBaseV;
      uniform float _ConstantColor0Val;
      uniform float _ConstantColorSd0Val;
      uniform float _ConstantColorValue;
      uniform float _ConstantAlpha;
      uniform float _EmissionMaskVal;
      uniform float _LightColorValue;
      uniform float _RimColorValue;
      uniform float _RimPower;
      uniform float _RimStrength;
      uniform float _SpecularPower;
      uniform float _SpecularScale;
      uniform float _SphereMapColorVal;
      uniform float _DiscardValue;
      uniform float3 _ConstantColor;
      uniform float3 _ConstantColor0;
      uniform float3 _ConstantColorSd0;
      uniform float3 _SpecularColor;
      uniform float3 _SphereMapColor;
      uniform float3 _RimColor;
      uniform float3 _RimColorShadow;
      uniform sampler2D _Col0Tex;
      uniform sampler2D _EmissionMaskTex;
      uniform sampler2D _SphereMapTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float2 texcoord2 :TEXCOORD2;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float3 texcoord4 :TEXCOORD4;
          float3 texcoord5 :TEXCOORD5;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float3 texcoord4 :TEXCOORD4;
          float3 texcoord5 :TEXCOORD5;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 phase0_Output0_1;
      float4 u_xlat0;
      float4 u_xlatb0;
      float4 u_xlat1;
      float4 u_xlat16_1;
      float4 u_xlatb1;
      float4 u_xlat2;
      float4 u_xlat16_2;
      float3 u_xlat16_3;
      float3 u_xlat16_4;
      float u_xlat15;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          u_xlat0 = (in_v.vertex.yyyy * conv_mxt4x4_1(unity_ObjectToWorld));
          u_xlat0 = ((conv_mxt4x4_0(unity_ObjectToWorld) * in_v.vertex.xxxx) + u_xlat0);
          u_xlat0 = ((conv_mxt4x4_2(unity_ObjectToWorld) * in_v.vertex.zzzz) + u_xlat0);
          u_xlat1 = (u_xlat0 + conv_mxt4x4_3(unity_ObjectToWorld));
          out_v.texcoord3.xyz = float3(((conv_mxt4x4_3(unity_ObjectToWorld).xyz * in_v.vertex.www) + u_xlat0.xyz));
          out_v.vertex = mul(unity_MatrixVP, u_xlat1);
          u_xlat0 = float4(int4(_ColorMapUvIndex, _ColorMapUvIndex, _Layer1UvIndex, _Layer1UvIndex));
          u_xlatb1 = bool4(float4(0, 1, 0, 1) >= u_xlat0.yyww);
          u_xlatb0 = bool4(u_xlat0 >= float4(2, 2, 2, 2));
          u_xlat0 = lerp(float4(0, 0, 0, 0), float4(1, 1, 1, 1), float4(u_xlatb0));
          u_xlat16_2.x = (u_xlatb1.x)?(float(-1)):(float(0));
          u_xlat16_2.y = (u_xlatb1.x)?(float(-1)):(float(0));
          u_xlat16_2.z = (u_xlatb1.z)?(float(-1)):(float(0));
          u_xlat16_2.w = (u_xlatb1.z)?(float(-1)):(float(0));
          u_xlat1 = lerp(float4(0, 0, 0, 0), float4(1, 1, 1, 1), float4(u_xlatb1));
          u_xlat16_2 = (u_xlat16_2 + u_xlat1.yyww);
          u_xlat16_2 = max(u_xlat16_2, float4(0, 0, 0, 0));
          u_xlat2 = (u_xlat16_2 * in_v.texcoord1.xyxy);
          u_xlat1 = ((in_v.texcoord.xyxy * u_xlat1.xxzz) + u_xlat2);
          phase0_Output0_1 = ((in_v.texcoord2.xyxy * u_xlat0) + u_xlat1);
          u_xlat0.x = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat0.y = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat0.z = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          u_xlat0.xyz = float3(normalize(u_xlat0.xyz));
          out_v.texcoord2.xyz = float3(u_xlat0.xyz);
          u_xlat0.xyz = float3((in_v.normal.yyy * conv_mxt4x4_1(unity_ObjectToWorld).xyz));
          u_xlat0.xyz = float3(((conv_mxt4x4_0(unity_ObjectToWorld).xyz * in_v.normal.xxx) + u_xlat0.xyz));
          u_xlat0.xyz = float3(((conv_mxt4x4_2(unity_ObjectToWorld).xyz * in_v.normal.zzz) + u_xlat0.xyz));
          out_v.texcoord4.xyz = float3(u_xlat0.xyz);
          u_xlat16_3.x = (u_xlat0.y * u_xlat0.y);
          u_xlat16_3.x = ((u_xlat0.x * u_xlat0.x) + (-u_xlat16_3.x));
          u_xlat16_1 = (u_xlat0.yzzx * u_xlat0.xyzz);
          u_xlat16_4.x = dot(unity_SHBr, u_xlat16_1);
          u_xlat16_4.y = dot(unity_SHBg, u_xlat16_1);
          u_xlat16_4.z = dot(unity_SHBb, u_xlat16_1);
          u_xlat16_3.xyz = float3(((unity_SHC.xyz * u_xlat16_3.xxx) + u_xlat16_4.xyz));
          u_xlat0.w = 1;
          u_xlat16_4.x = dot(unity_SHAr, u_xlat0);
          u_xlat16_4.y = dot(unity_SHAg, u_xlat0);
          u_xlat16_4.z = dot(unity_SHAb, u_xlat0);
          u_xlat16_3.xyz = float3((u_xlat16_3.xyz + u_xlat16_4.xyz));
          u_xlat16_3.xyz = float3(max(u_xlat16_3.xyz, float3(0, 0, 0)));
          u_xlat0.xyz = float3(log2(u_xlat16_3.xyz));
          u_xlat0.xyz = float3((u_xlat0.xyz * float3(0.416666657, 0.416666657, 0.416666657)));
          u_xlat0.xyz = float3(exp2(u_xlat0.xyz));
          u_xlat0.xyz = float3(((u_xlat0.xyz * float3(1.05499995, 1.05499995, 1.05499995)) + float3(-0.0549999997, (-0.0549999997), (-0.0549999997))));
          u_xlat0.xyz = float3(max(u_xlat0.xyz, float3(0, 0, 0)));
          out_v.texcoord5.xyz = float3(u_xlat0.xyz);
          out_v.texcoord = phase0_Output0_1.xy;
          out_v.texcoord1 = phase0_Output0_1.zw;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat16_0;
      float3 u_xlat1_d;
      float3 u_xlat10_1;
      int2 u_xlati1;
      float4 u_xlatb1_d;
      float3 u_xlat16_2_d;
      float3 u_xlat16_3_d;
      float4 u_xlat10_3;
      float3 u_xlat16_4_d;
      float3 u_xlat16_5;
      float3 u_xlat16_6;
      float3 u_xlat16_8;
      float2 u_xlat10_13;
      float u_xlat16_18;
      float u_xlat19;
      float u_xlat16_20;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat16_0.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
          u_xlat16_0.x = rsqrt(u_xlat16_0.x);
          u_xlat16_0.xyz = float3((u_xlat16_0.xxx * _WorldSpaceLightPos0.xyz));
          u_xlat1_d.xyz = float3(((-in_f.texcoord3.xyz) + _WorldSpaceCameraPos.xyz));
          u_xlat19 = dot(u_xlat1_d.xyz, u_xlat1_d.xyz);
          u_xlat19 = rsqrt(u_xlat19);
          u_xlat16_0.xyz = float3(((u_xlat1_d.xyz * float3(u_xlat19, u_xlat19, u_xlat19)) + u_xlat16_0.xyz));
          u_xlat16_0.xyz = float3(normalize(u_xlat16_0.xyz));
          u_xlat16_2_d.xyz = float3(normalize(in_f.texcoord2.xyz));
          u_xlat16_0.x = dot(u_xlat16_2_d.xyz, u_xlat16_0.xyz);
          u_xlat16_6.x = dot(u_xlat16_2_d.xyz, _WorldSpaceLightPos0.xyz);
          u_xlat16_6.x = clamp(u_xlat16_6.x, 0, 1);
          u_xlat16_6.xyz = float3((u_xlat16_6.xxx + in_f.texcoord5.xyz));
          u_xlat16_0.x = (u_xlat16_0.x * _LightColor0.x);
          u_xlat16_0.x = clamp(u_xlat16_0.x, 0, 1);
          u_xlat16_0.x = log2(u_xlat16_0.x);
          u_xlat16_2_d.x = max(_SpecularPower, 9.99999975E-05);
          u_xlat16_0.x = (u_xlat16_0.x * u_xlat16_2_d.x);
          u_xlat16_0.x = exp2(u_xlat16_0.x);
          u_xlat16_0.x = (u_xlat16_0.x * _SpecularScale);
          u_xlat16_2_d.xyz = float3((u_xlat16_0.xxx * _LightColor0.xyz));
          u_xlat16_0.x = dot(u_xlat16_2_d.xyz, float3(0.300000012, 0.589999974, 0.109999999));
          u_xlat16_3_d.xyz = float3((u_xlat16_0.xxx * _SpecularColor.xyz));
          u_xlat16_2_d.xyz = float3(((_SpecularColor.xyz * u_xlat16_2_d.xyz) + (-u_xlat16_3_d.xyz)));
          u_xlat16_2_d.xyz = float3(((float3(float3(_LightColorValue, _LightColorValue, _LightColorValue)) * u_xlat16_2_d.xyz) + u_xlat16_3_d.xyz));
          u_xlati1.x = ((-_SpecularMaskEnable) + 1);
          u_xlat16_0.x = float(u_xlati1.x);
          u_xlat1_d.xy = float2(TRANSFORM_TEX(in_f.texcoord.xy, _Col0Tex));
          u_xlat1_d.xy = float2((u_xlat1_d.xy + float2(_ColorBaseU, _ColorBaseV)));
          u_xlat10_13.xy = tex2D(_EmissionMaskTex, u_xlat1_d.xy).xy.xy;
          u_xlat10_3 = tex2D(_Col0Tex, u_xlat1_d.xy);
          u_xlat16_0.x = (u_xlat16_0.x + u_xlat10_13.y);
          u_xlat16_0.x = clamp(u_xlat16_0.x, 0, 1);
          u_xlat16_2_d.xyz = float3((u_xlat16_0.xxx * u_xlat16_2_d.xyz));
          u_xlat16_4_d.xyz = float3(((u_xlat16_6.xyz * _LightColor0.xyz) + (-u_xlat16_6.xyz)));
          u_xlat16_0.xyz = float3(((float3(float3(_LightColorValue, _LightColorValue, _LightColorValue)) * u_xlat16_4_d.xyz) + u_xlat16_6.xyz));
          u_xlat16_18 = dot(u_xlat16_0.xyz, float3(0.300000012, 0.589999974, 0.109999999));
          u_xlat16_18 = clamp(u_xlat16_18, 0, 1);
          u_xlat16_20 = ((-u_xlat16_18) + 1);
          u_xlat16_4_d.xyz = float3(((u_xlat10_3.xyz * _ConstantColorSd0.xyz) + (-u_xlat10_3.xyz)));
          u_xlat16_4_d.xyz = float3(((float3(float3(_ConstantColorSd0Val, _ConstantColorSd0Val, _ConstantColorSd0Val)) * u_xlat16_4_d.xyz) + u_xlat10_3.xyz));
          u_xlat16_4_d.xyz = float3((float3(u_xlat16_20, u_xlat16_20, u_xlat16_20) * u_xlat16_4_d.xyz));
          u_xlat16_5.xyz = float3(((u_xlat10_3.xyz * _ConstantColor0.xyz) + (-u_xlat10_3.xyz)));
          u_xlat16_5.xyz = float3(((float3(_ConstantColor0Val, _ConstantColor0Val, _ConstantColor0Val) * u_xlat16_5.xyz) + u_xlat10_3.xyz));
          u_xlat16_0.xyz = float3(((u_xlat16_5.xyz * u_xlat16_0.xyz) + u_xlat16_4_d.xyz));
          u_xlat16_4_d.xyz = float3(((-u_xlat16_0.xyz) + u_xlat10_3.xyz));
          u_xlat16_20 = float(_EmissionMaskUse);
          u_xlat16_20 = (u_xlat10_13.x * u_xlat16_20);
          u_xlat16_20 = (u_xlat16_20 * _EmissionMaskVal);
          u_xlat16_0.xyz = float3(((float3(u_xlat16_20, u_xlat16_20, u_xlat16_20) * u_xlat16_4_d.xyz) + u_xlat16_0.xyz));
          u_xlat16_4_d.xyz = float3((u_xlat16_0.xyz * u_xlat16_2_d.xyz));
          u_xlat1_d.x = float(_BaseColorAddEnable);
          if((u_xlat1_d.x<0.5))
          {
              u_xlatb1_d.x = 1;
          }
          else
          {
              u_xlatb1_d.x = 0;
          }
          u_xlat16_2_d.xyz = float3((u_xlatb1_d.x)?(u_xlat16_2_d.xyz):(u_xlat16_4_d.xyz));
          u_xlat16_0.xyz = float3((u_xlat16_0.xyz + u_xlat16_2_d.xyz));
          u_xlat16_2_d.x = dot(in_f.texcoord4.xyz, in_f.texcoord4.xyz);
          u_xlat16_2_d.x = rsqrt(u_xlat16_2_d.x);
          u_xlat16_2_d.xyz = float3((u_xlat16_2_d.xxx * in_f.texcoord4.xyz));
          u_xlat1_d.xy = float2((u_xlat16_2_d.yy * conv_mxt4x4_1(unity_MatrixV).xy));
          u_xlat1_d.xy = ((conv_mxt4x4_0(unity_MatrixV).xy * u_xlat16_2_d.xx) + u_xlat1_d.xy).xy;
          u_xlat1_d.xy = ((conv_mxt4x4_2(unity_MatrixV).xy * u_xlat16_2_d.zz) + u_xlat1_d.xy).xy;
          u_xlat1_d.xy = float2((u_xlat1_d.xy + float2(1, 1)));
          u_xlat1_d.xy = float2((u_xlat1_d.xy * float2(0.5, 0.5)));
          u_xlat10_1.xyz = tex2D(_SphereMapTex, u_xlat1_d.xy).xyz.xyz;
          u_xlat16_4_d.xyz = float3((u_xlat10_1.xyz * _SphereMapColor.xyz));
          u_xlat16_4_d.xyz = float3((u_xlat16_4_d.xyz * float3(float3(_SphereMapColorVal, _SphereMapColorVal, _SphereMapColorVal))));
          u_xlati1.xy = float2(((-int2(_SphereMaskEnable, _RimMaskEnable)) + int2(1, 1)));
          u_xlat16_5.xy = float2(u_xlati1.xy);
          u_xlat16_5.xy = float2((u_xlat10_13.yy + u_xlat16_5.xy));
          u_xlat16_5.xy = float2(clamp(u_xlat16_5.xy, 0, 1));
          u_xlat16_0.xyz = float3(((u_xlat16_4_d.xyz * u_xlat16_5.xxx) + u_xlat16_0.xyz));
          u_xlat1_d.x = conv_mxt4x4_0(unity_MatrixV).z.x;
          u_xlat1_d.y = conv_mxt4x4_1(unity_MatrixV).z.x;
          u_xlat1_d.z = conv_mxt4x4_2(unity_MatrixV).z.x;
          u_xlat1_d.x = dot(u_xlat16_2_d.xyz, u_xlat1_d.xyz);
          u_xlat1_d.x = clamp(u_xlat1_d.x, 0, 1);
          u_xlat16_2_d.x = ((-u_xlat1_d.x) + 1);
          u_xlat16_2_d.x = log2(u_xlat16_2_d.x);
          u_xlat16_2_d.x = (u_xlat16_2_d.x * _RimPower);
          u_xlat16_2_d.x = exp2(u_xlat16_2_d.x);
          u_xlat16_2_d.x = (u_xlat16_2_d.x * _RimStrength);
          u_xlat16_2_d.x = clamp(u_xlat16_2_d.x, 0, 1);
          u_xlat16_2_d.x = (u_xlat16_5.y * u_xlat16_2_d.x);
          u_xlat16_8.xyz = float3((_RimColor.xyz + (-_RimColorShadow.xyz)));
          u_xlat16_8.xyz = float3(((float3(u_xlat16_18, u_xlat16_18, u_xlat16_18) * u_xlat16_8.xyz) + _RimColorShadow.xyz));
          u_xlat16_8.xyz = float3((u_xlat16_8.xyz * u_xlat16_8.xyz));
          u_xlat16_2_d.xyz = float3((u_xlat16_2_d.xxx * u_xlat16_8.xyz));
          u_xlat16_0.xyz = float3(((u_xlat16_2_d.xyz * float3(float3(_RimColorValue, _RimColorValue, _RimColorValue))) + u_xlat16_0.xyz));
          u_xlat16_2_d.xyz = float3(((u_xlat16_0.xyz * float3(_ConstantColor.x, _ConstantColor.y, _ConstantColor.z)) + (-u_xlat16_0.xyz)));
          out_f.color.xyz = float3(((float3(float3(_ConstantColorValue, _ConstantColorValue, _ConstantColorValue)) * u_xlat16_2_d.xyz) + u_xlat16_0.xyz));
          u_xlat16_0.x = (u_xlat10_3.w * _ConstantAlpha);
          if((u_xlat16_0.x>=_DiscardValue))
          {
              u_xlatb1_d.x = 1;
          }
          else
          {
              u_xlatb1_d.x = 0;
          }
          u_xlat16_0.x = (u_xlatb1_d.x)?(1):(0);
          u_xlatb1_d = bool4(float4(_BlendMode, _BlendMode, _BlendMode, _BlendMode) == float4(4, 1, 2, 3));
          u_xlat16_0.x = (u_xlatb1_d.x)?(u_xlat16_0.x):(u_xlat10_3.w);
          u_xlat16_6.x = (u_xlat16_0.x * _ConstantAlpha);
          u_xlatb1_d.x = (u_xlatb1_d.z || u_xlatb1_d.y);
          u_xlatb1_d.x = (u_xlatb1_d.w || u_xlatb1_d.x);
          out_f.color.w = (u_xlatb1_d.x)?(u_xlat16_6.x):(u_xlat16_0.x);
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
        "LIGHTMODE" = "FORWARDADD"
      }
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 0
        ReadMask 255
        WriteMask 255
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
      Blend One One
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile POINT
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
      //uniform float4x4 unity_WorldToObject;
      //uniform float4x4 unity_MatrixVP;
      uniform float4x4 unity_WorldToLight;
      uniform int _ColorMapUvIndex;
      uniform int _Layer1UvIndex;
      //uniform float3 _WorldSpaceCameraPos;
      //uniform float4 _WorldSpaceLightPos0;
      uniform float4 _LightColor0;
      uniform int _SpecularMaskEnable;
      uniform int _BaseColorAddEnable;
      uniform float4 _Col0Tex_ST;
      uniform float _ColorBaseU;
      uniform float _ColorBaseV;
      uniform float _ConstantColor0Val;
      uniform float _ConstantColorSd0Val;
      uniform float _LightColorValue;
      uniform float _SpecularPower;
      uniform float _SpecularScale;
      uniform float3 _ConstantColor0;
      uniform float3 _ConstantColorSd0;
      uniform float3 _SpecularColor;
      uniform sampler2D _LightTexture0;
      uniform sampler2D _Col0Tex;
      uniform sampler2D _EmissionMaskTex;
      struct appdata_t
      {
          float4 vertex :POSITION0;
          float3 normal :NORMAL0;
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float2 texcoord2 :TEXCOORD2;
      };
      
      struct OUT_Data_Vert
      {
          float2 texcoord :TEXCOORD0;
          float2 texcoord1 :TEXCOORD1;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float3 texcoord4 :TEXCOORD4;
          float3 texcoord5 :TEXCOORD5;
          float3 texcoord6 :TEXCOORD6;
          float4 vertex :SV_POSITION;
      };
      
      struct v2f
      {
          float2 texcoord :TEXCOORD0;
          float3 texcoord2 :TEXCOORD2;
          float3 texcoord3 :TEXCOORD3;
          float3 texcoord6 :TEXCOORD6;
      };
      
      struct OUT_Data_Frag
      {
          float4 color :SV_Target0;
      };
      
      float4 phase0_Output0_1;
      float4 u_xlat0;
      float4 u_xlat1;
      float4 u_xlatb1;
      float4 u_xlat2;
      float4 u_xlatb2;
      float4 u_xlat3;
      float4 u_xlat16_3;
      float u_xlat13;
      OUT_Data_Vert vert(appdata_t in_v)
      {
          OUT_Data_Vert out_v;
          out_v.vertex = UnityObjectToClipPos(in_v.vertex);
          u_xlat1 = float4(int4(_ColorMapUvIndex, _ColorMapUvIndex, _Layer1UvIndex, _Layer1UvIndex));
          u_xlatb2 = bool4(float4(0, 1, 0, 1) >= u_xlat1.yyww);
          u_xlatb1 = bool4(u_xlat1 >= float4(2, 2, 2, 2));
          u_xlat1 = lerp(float4(0, 0, 0, 0), float4(1, 1, 1, 1), float4(u_xlatb1));
          u_xlat16_3.x = (u_xlatb2.x)?(float(-1)):(float(0));
          u_xlat16_3.y = (u_xlatb2.x)?(float(-1)):(float(0));
          u_xlat16_3.z = (u_xlatb2.z)?(float(-1)):(float(0));
          u_xlat16_3.w = (u_xlatb2.z)?(float(-1)):(float(0));
          u_xlat2 = lerp(float4(0, 0, 0, 0), float4(1, 1, 1, 1), float4(u_xlatb2));
          u_xlat16_3 = (u_xlat16_3 + u_xlat2.yyww);
          u_xlat16_3 = max(u_xlat16_3, float4(0, 0, 0, 0));
          u_xlat3 = (u_xlat16_3 * in_v.texcoord1.xyxy);
          u_xlat2 = ((in_v.texcoord.xyxy * u_xlat2.xxzz) + u_xlat3);
          phase0_Output0_1 = ((in_v.texcoord2.xyxy * u_xlat1) + u_xlat2);
          u_xlat1.x = dot(in_v.normal.xyz, conv_mxt4x4_0(unity_WorldToObject).xyz);
          u_xlat1.y = dot(in_v.normal.xyz, conv_mxt4x4_1(unity_WorldToObject).xyz);
          u_xlat1.z = dot(in_v.normal.xyz, conv_mxt4x4_2(unity_WorldToObject).xyz);
          u_xlat1.xyz = float3(normalize(u_xlat1.xyz));
          out_v.texcoord2.xyz = float3(u_xlat1.xyz);
          out_v.texcoord3.xyz = float3(((conv_mxt4x4_3(unity_ObjectToWorld).xyz * in_v.vertex.www) + u_xlat0.xyz));
          u_xlat0 = ((conv_mxt4x4_3(unity_ObjectToWorld) * in_v.vertex.wwww) + u_xlat0);
          u_xlat1.xyz = float3((in_v.normal.yyy * conv_mxt4x4_1(unity_ObjectToWorld).xyz));
          u_xlat1.xyz = float3(((conv_mxt4x4_0(unity_ObjectToWorld).xyz * in_v.normal.xxx) + u_xlat1.xyz));
          u_xlat1.xyz = float3(((conv_mxt4x4_2(unity_ObjectToWorld).xyz * in_v.normal.zzz) + u_xlat1.xyz));
          out_v.texcoord4.xyz = float3(u_xlat1.xyz);
          out_v.texcoord5.xyz = float3(0, 0, 0);
          u_xlat1.xyz = float3((u_xlat0.yyy * conv_mxt4x4_1(unity_WorldToLight).xyz));
          u_xlat1.xyz = float3(((conv_mxt4x4_0(unity_WorldToLight).xyz * u_xlat0.xxx) + u_xlat1.xyz));
          u_xlat0.xyz = float3(((conv_mxt4x4_2(unity_WorldToLight).xyz * u_xlat0.zzz) + u_xlat1.xyz));
          out_v.texcoord6.xyz = float3(((conv_mxt4x4_3(unity_WorldToLight).xyz * u_xlat0.www) + u_xlat0.xyz));
          out_v.texcoord = phase0_Output0_1.xy;
          out_v.texcoord1 = phase0_Output0_1.zw;
          return out_v;
      }
      
      #define CODE_BLOCK_FRAGMENT
      float3 u_xlat0_d;
      int u_xlatb0;
      float3 u_xlat1_d;
      float3 u_xlat10_1;
      float3 u_xlat16_2;
      float3 u_xlat16_3_d;
      float3 u_xlat16_4;
      float3 u_xlat16_5;
      float2 u_xlat6;
      int u_xlati6;
      float u_xlat16_8;
      float u_xlat18;
      float u_xlat10_18;
      float u_xlat16_20;
      OUT_Data_Frag frag(v2f in_f)
      {
          OUT_Data_Frag out_f;
          u_xlat0_d.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
          u_xlat0_d.x = rsqrt(u_xlat0_d.x);
          u_xlat0_d.xyz = float3((u_xlat0_d.xxx * _WorldSpaceLightPos0.xyz));
          u_xlat1_d.xyz = float3(((-in_f.texcoord3.xyz) + _WorldSpaceCameraPos.xyz));
          u_xlat18 = dot(u_xlat1_d.xyz, u_xlat1_d.xyz);
          u_xlat18 = rsqrt(u_xlat18);
          u_xlat16_2.xyz = float3(((u_xlat1_d.xyz * float3(u_xlat18, u_xlat18, u_xlat18)) + u_xlat0_d.xyz));
          u_xlat16_2.xyz = float3(normalize(u_xlat16_2.xyz));
          u_xlat16_3_d.xyz = float3(normalize(in_f.texcoord2.xyz));
          u_xlat16_2.x = dot(u_xlat16_3_d.xyz, u_xlat16_2.xyz);
          u_xlat0_d.x = dot(u_xlat16_3_d.xyz, _WorldSpaceLightPos0.xyz);
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0, 1);
          u_xlat16_2.x = (u_xlat16_2.x * _LightColor0.x);
          u_xlat16_2.x = clamp(u_xlat16_2.x, 0, 1);
          u_xlat16_2.x = log2(u_xlat16_2.x);
          u_xlat16_8 = max(_SpecularPower, 9.99999975E-05);
          u_xlat16_2.x = (u_xlat16_2.x * u_xlat16_8);
          u_xlat16_2.x = exp2(u_xlat16_2.x);
          u_xlat16_2.x = (u_xlat16_2.x * _SpecularScale);
          u_xlat16_2.xyz = float3((u_xlat16_2.xxx * _LightColor0.xyz));
          u_xlat16_20 = dot(u_xlat16_2.xyz, float3(0.300000012, 0.589999974, 0.109999999));
          u_xlat16_3_d.xyz = float3((float3(u_xlat16_20, u_xlat16_20, u_xlat16_20) * _SpecularColor.xyz));
          u_xlat16_2.xyz = float3(((_SpecularColor.xyz * u_xlat16_2.xyz) + (-u_xlat16_3_d.xyz)));
          u_xlat16_2.xyz = float3(((float3(float3(_LightColorValue, _LightColorValue, _LightColorValue)) * u_xlat16_2.xyz) + u_xlat16_3_d.xyz));
          u_xlati6 = ((-_SpecularMaskEnable) + 1);
          u_xlat16_20 = float(u_xlati6);
          u_xlat6.xy = float2(TRANSFORM_TEX(in_f.texcoord.xy, _Col0Tex));
          u_xlat6.xy = float2((u_xlat6.xy + float2(_ColorBaseU, _ColorBaseV)));
          u_xlat10_18 = tex2D(_EmissionMaskTex, u_xlat6.xy).y.x;
          u_xlat10_1.xyz = tex2D(_Col0Tex, u_xlat6.xy).xyz.xyz;
          u_xlat16_20 = (u_xlat16_20 + u_xlat10_18);
          u_xlat16_20 = clamp(u_xlat16_20, 0, 1);
          u_xlat16_2.xyz = float3((float3(u_xlat16_20, u_xlat16_20, u_xlat16_20) * u_xlat16_2.xyz));
          u_xlat6.x = dot(in_f.texcoord6.xyz, in_f.texcoord6.xyz);
          u_xlat6.x = tex2D(_LightTexture0, u_xlat6.xx).x;
          u_xlat16_20 = (u_xlat6.x * u_xlat0_d.x);
          u_xlat16_20 = max(u_xlat16_20, 0);
          u_xlat16_3_d.xyz = float3(((float3(u_xlat16_20, u_xlat16_20, u_xlat16_20) * _LightColor0.xyz) + (-float3(u_xlat16_20, u_xlat16_20, u_xlat16_20))));
          u_xlat16_3_d.xyz = float3(((float3(float3(_LightColorValue, _LightColorValue, _LightColorValue)) * u_xlat16_3_d.xyz) + float3(u_xlat16_20, u_xlat16_20, u_xlat16_20)));
          u_xlat16_20 = dot(u_xlat16_3_d.xyz, float3(0.300000012, 0.589999974, 0.109999999));
          u_xlat16_20 = clamp(u_xlat16_20, 0, 1);
          u_xlat16_20 = ((-u_xlat16_20) + 1);
          u_xlat16_4.xyz = float3(((u_xlat10_1.xyz * _ConstantColorSd0.xyz) + (-u_xlat10_1.xyz)));
          u_xlat16_4.xyz = float3(((float3(float3(_ConstantColorSd0Val, _ConstantColorSd0Val, _ConstantColorSd0Val)) * u_xlat16_4.xyz) + u_xlat10_1.xyz));
          u_xlat16_4.xyz = float3((float3(u_xlat16_20, u_xlat16_20, u_xlat16_20) * u_xlat16_4.xyz));
          u_xlat16_5.xyz = float3(((u_xlat10_1.xyz * _ConstantColor0.xyz) + (-u_xlat10_1.xyz)));
          u_xlat16_5.xyz = float3(((float3(_ConstantColor0Val, _ConstantColor0Val, _ConstantColor0Val) * u_xlat16_5.xyz) + u_xlat10_1.xyz));
          u_xlat16_3_d.xyz = float3(((u_xlat16_5.xyz * u_xlat16_3_d.xyz) + u_xlat16_4.xyz));
          u_xlat16_3_d.xyz = float3((u_xlat16_2.xyz * u_xlat16_3_d.xyz));
          u_xlat0_d.x = float(_BaseColorAddEnable);
          if((u_xlat0_d.x<0.5))
          {
              u_xlatb0 = 1;
          }
          else
          {
              u_xlatb0 = 0;
          }
          u_xlat16_2.xyz = float3((int(u_xlatb0))?(u_xlat16_2.xyz):(u_xlat16_3_d.xyz));
          out_f.color.xyz = float3((u_xlat6.xxx * u_xlat16_2.xyz));
          out_f.color.w = 0;
          return out_f;
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: 
    {
      Tags
      { 
      }
      ZClip Off
      ZWrite Off
      Cull Off
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
      // m_ProgramMask = 0
      
    } // end phase
  }
  FallBack Off
}
