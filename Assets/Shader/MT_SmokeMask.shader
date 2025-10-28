Shader "MT/SmokeMask" {
	Properties {
		_Mask0Tex ("Mask Texture1", 2D) = "black" {}
		_FireTex ("Multiply Texture", 2D) = "white" {}
		[Header(Material Value_______________________)] _DiscardValue ("Cut off threshould", Range(0, 1)) = 0.5
		[Space] [Header(UV Control_______________________)] [KeywordEnum(ZERO, ONE, TWO)] MASK_FIRST_UV ("Mask0 UV Index", Float) = 0
		_Mask0UVTranslateU ("BlendTex1 UV Translate(U)", Float) = 0
		_Mask0UVTranslateV ("BlendTex1 UV Translate(V)", Float) = 0
		[Space] [Header(Model Scaling__________________)] _BillboardScale ("Scale Input", Float) = 1
		[Space] [Header(Stencil___________________________)] _Stencil ("MatLink ID", Float) = 0
		[Space] [Header(Z Test____________________________)] [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
		[MaterialToggle] _ZWrite ("Z Write", Float) = 0
	}
	SubShader {
		Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
		Pass {
			Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
			ColorMask 0 -1
			ZWrite Off
			Cull Off
			Stencil {
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 13683
			// No subprograms found
		}
	}
	CustomEditor "SmokeMaskShaderGUI"
}