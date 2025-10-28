Shader "MT/GroundEffect1st" {
	Properties {
		_Col0Tex ("Col0Tex", 2D) = "white" {}
		[NoScaleOffset] _EmissionMaskTex ("EmissionMaskTex", 2D) = "white" {}
		[NoScaleOffset] _SphereMapTex ("SphereMapTex", 2D) = "black" {}
		_GourndEffectMaskTex ("GourndEffectMaskTex", 2D) = "white" {}
		[Header(Settings)] _ColorMapUvIndex ("ColorMapUvIndex", Float) = 0
		[HideInInspector] _BlendMode ("__mode", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
		[MaterialToggle] _ZWrite ("Z Write", Float) = 1
		[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("Src Factor", Float) = 1
		[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("Dst Factor", Float) = 0
		[Header(ColorMapStatus)] [PowerSlider(3.0)] _LightColorValue ("LightColorValue", Range(0, 1)) = 1
		[PowerSlider(3.0)] _DiscardValue ("DiscardValue", Range(0, 1)) = 1
		_ConstantColor0 ("ConstantColor0", Vector) = (1,1,1,1)
		[PowerSlider(3.0)] _ConstantColor0Val ("ConstantColor0Val", Range(0, 32)) = 1
		_ConstantColorSd0 ("ConstantColorSd0", Vector) = (0,0,0,1)
		[PowerSlider(3.0)] _ConstantColorSd0Val ("ConstantColorSd0Val", Range(0, 32)) = 1
		[PowerSlider(3.0)] _ColorBaseU ("ColorBaseU", Range(0, 32)) = 0
		[PowerSlider(3.0)] _ColorBaseV ("ColorBaseV", Range(0, 32)) = 0
		[Header(Emission)] [Toggle(USE_EMISSION_MASK_TEX)] _EmissionMaskUse ("EmissionMaskUse", Float) = 0
		[PowerSlider(3.0)] _EmissionMaskVal ("EmissionMaskVal", Range(0, 32)) = 1
		[Toggle(SWITCH_EMISSION_MASK_TEX_UV)] _SwitchEmissionMaskTexUV ("SwitchEmissionMaskTexUV", Float) = 0
		[Header(FinalConstantColor)] _ConstantColor ("ConstantColor", Vector) = (1,1,1,1)
		[PowerSlider(3.0)] _ConstantColorValue ("ConstantColorValue", Range(0, 32)) = 1
		[PowerSlider(3.0)] _ConstantAlpha ("ConstantColorAlpha", Range(0, 32)) = 1
		[Header(RimColor)] _RimColor ("RimColor", Vector) = (1,1,1,1)
		_RimColorShadow ("RimColorShadow", Vector) = (0,0,0,1)
		[PowerSlider(3.0)] _RimColorValue ("RimColorValue", Range(0, 32)) = 0
		[PowerSlider(3.0)] _RimPower ("RimPower", Range(0, 32)) = 8
		[PowerSlider(3.0)] _RimStrength ("RimStrength", Range(0, 32)) = 8
		[Toggle(USE_RIM_MASK_TEX)] _RimMaskEnable ("RimMaskEnable", Float) = 0
		[Header(Specular)] _SpecularColor ("SpecularColor", Vector) = (1,1,1,1)
		[Toggle(SWITCH_BASECOLOR_ADD_SPECULAR)] _BaseColorAddEnable ("BaseColorAddEnable", Float) = 1
		[PowerSlider(3.0)] _SpecularScale ("SpecularScale", Range(0, 5)) = 0.4
		[PowerSlider(3.0)] _SpecularPower ("SpecularPower", Range(0, 32)) = 10
		[Toggle(USE_SPECULAR_MASK_TEX)] _SpecularMaskEnable ("SpecularMaskEnable", Float) = 0
		[Header(SphereMap)] [Toggle(USE_SPHEREMASK_TEX)] _SphereMaskEnable ("SphereMaskEnable", Float) = 1
		_SphereMapColor ("SphereMapColor", Vector) = (1,1,1,1)
		[PowerSlider(3.0)] _SphereMapColorVal ("SphereMapColorVal", Range(0, 32)) = 1
		[Header(GourndEffect)] _GroundEffectCol ("GroundEffectColor", Vector) = (1,1,1,1)
		[PowerSlider(3.0)] _MaskUVScale ("MaskUVScale", Range(0, 8)) = 0.5
		[PowerSlider(3.0)] _BottomLine ("BottomLine", Range(0, 1024)) = 0
		[PowerSlider(3.0)] _TopLine ("TopLine", Range(0, 1024)) = 0
		[PowerSlider(3.0)] _TopLineScale ("TopLineScale", Range(0, 32)) = 1
		[PowerSlider(3.0)] _LerpPow ("LerpPow", Range(0, 32)) = 1
		[PowerSlider(3.0)] _MaskAddValue ("MaskAddValue", Range(0, 2)) = 1
		[Space] [Header(Culling___________________________)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Culling Mode", Float) = 2
	}
	SubShader {
		Tags { "ShaderType" = "Standard" }
		Pass {
			Tags { "LIGHTMODE" = "FORWARDBASE" "SHADOWSUPPORT" = "true" "ShaderType" = "Standard" }
			Blend Zero Zero, Zero Zero
			ZWrite Off
			Cull Off
			GpuProgramID 46793
			// No subprograms found
		}
		UsePass "Legacy Shaders/VertexLit/SHADOWCASTER"
	}
}