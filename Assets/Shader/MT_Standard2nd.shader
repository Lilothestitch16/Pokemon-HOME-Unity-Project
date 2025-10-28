Shader "MT/Standard2nd" {
	Properties {
		_Col0Tex ("Col0Tex", 2D) = "white" {}
		_L1Col0Tex ("L1Col0Tex", 2D) = "white" {}
		[NoScaleOffset] _EmissionMaskTex ("EmissionMaskTex", 2D) = "white" {}
		[NoScaleOffset] _SphereMapTex ("SphereMapTex", 2D) = "black" {}
		[Header(Settings)] _ColorMapUvIndex ("ColorMapUvIndex", Float) = 0
		_Layer1UvIndex ("Layer1UvIndex", Float) = 0
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
		[Toggle(SWITCH_EMISSION_MASK_TEX_UV)] _SwitchEmissionMaskTexUV ("SwitchEmissionMaskTexUV", Float) = 0
		[Toggle(USE_LAYER_MASK_EMISSION)] _UseLayerMaskToEmission ("Use Layer Mask", Float) = 0
		[Toggle(USE_EMISSION_COLOR_TEX)] _UseEmissionColorTex ("Use Emission ColorTex", Float) = 0
		_EmissionMaskVal ("EmissionMaskVal", Range(0, 1)) = 1
		_EmissionColorValue ("Emission Color Value", Range(0, 1)) = 1
		_EmissionColor ("Emission Color", Vector) = (1,1,1,1)
		[NoScaleOffset] _EmissionColorTex ("Emission Color Tex", 2D) = "white" {}
		[Header(FinalConstantColor)] _ConstantColor ("ConstantColor", Vector) = (1,1,1,1)
		[PowerSlider(3.0)] _ConstantColorValue ("ConstantColorValue", Range(0, 32)) = 1
		[PowerSlider(3.0)] _ConstantAlpha ("ConstantColorAlpha", Range(0, 32)) = 1
		[Header(Layer1ColorMap)] [Toggle(USE_LAYER1)] _Layer1Enable ("Layer1Enable", Float) = 0
		[PowerSlider(3.0)] _Layer1OverLerpValue ("Layer1OverLerpValue", Range(0, 32)) = 1
		[Toggle(SWITCH_PRIORITY)] _SwitchPriority ("SwitchPriority", Float) = 0
		[Toggle(SWITCH_PRIORITY)] _LayerCalcMulti ("LayerCulcMulti", Float) = 0
		[Header(Layer1ColorMapStatus)] _L1ConstantColor0 ("L1ConstantColor0", Vector) = (1,1,1,1)
		[PowerSlider(3.0)] _L1ConstantColor0Val ("L1ConstantColor0Val", Range(0, 32)) = 1
		_L1ConstantColorSd0 ("L1ConstantColorSd0", Vector) = (0,0,0,1)
		[PowerSlider(3.0)] _L1ConstantColorSd0Val ("L1ConstantColorSd0Val", Range(0, 32)) = 1
		_L1AddColor0 ("L1AddColor0", Vector) = (1,1,1,1)
		[PowerSlider(3.0)] _L1AddColor0Val ("L1AddColor0Val", Range(0, 32)) = 0
		[PowerSlider(3.0)] _Layer1BaseU ("Layer1BaseU", Range(0, 32)) = 0
		[PowerSlider(3.0)] _Layer1BaseV ("Layer1BaseV", Range(0, 32)) = 0
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
		[Space] [Header(Culling___________________________)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Culling Mode", Float) = 2
		[Header(Stencil___________________________)] [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Compare Function", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Operation", Float) = 0
		[ValueOffset(128)] _PokemonStencil ("MatLink ID", Float) = 128
	}
	SubShader {
		Tags { "ShaderType" = "Standard" }
		Pass {
			Tags { "LIGHTMODE" = "FORWARDBASE" "SHADOWSUPPORT" = "true" "ShaderType" = "Standard" }
			Blend Zero Zero, Zero Zero
			ZWrite Off
			Cull Off
			Stencil {
				Comp Disabled
				Pass Keep
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 18672
			// No subprograms found
		}
		UsePass "Legacy Shaders/VertexLit/SHADOWCASTER"
	}
}