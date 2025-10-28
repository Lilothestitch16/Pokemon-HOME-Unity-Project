Shader "MT/FireCore1st" {
	Properties {
		[Header(Mask Texture Settings_______________________)] _Blend0Tex ("Blend Texture1", 2D) = "black" {}
		_Blend1Tex ("Blend Texture2", 2D) = "black" {}
		_LerpTex ("Lerp Texture", 2D) = "black" {}
		[Header(Color Settings_______________________)] _BaseColor ("Base Color", Vector) = (1,0,0,1)
		_LayerColor ("Layer Color", Vector) = (1,1,0,1)
		_ConstantColor0 ("Multiply Color", Vector) = (0.5,0.5,0.5,1)
		_ConstantColorVal ("Multiply Factor", Range(0, 1)) = 0
		[Space] [Header(Rim______________________________)] _BaseRimValue ("Rim Value(on BaseColor)", Range(0, 5)) = 1
		_LayerRimValue ("Rim Value(on LayerColor)", Range(0, 5)) = 1
		[Space] [Header(UV Control_______________________)] _Blend0UVTranslateU ("BlendTex1 UV Translate(U)", Float) = 0
		_Blend0UVTranslateV ("BlendTex1 UV Translate(V)", Float) = 0
		_Blend0UVScaleU ("BlendTex1 UV Scale(U)", Float) = 1
		_Blend0UVScaleV ("BlendTex1 UV Scale(V)", Float) = 1
		_Blend1UVTranslateU ("BlendTex2 UV Translate(U)", Float) = 0
		_Blend1UVTranslateV ("BlendTex2 UV Translate(V)", Float) = 0
		_Blend1UVScaleU ("BlendTex2 UV Scale(U)", Float) = 1
		_Blend1UVScaleV ("BlendTex2 UV Scale(V)", Float) = 1
		[Space] [Header(Stencil___________________________)] _Stencil ("MatLink ID", Float) = 0
		[Space] [Header(Z Test____________________________)] [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
		[MaterialToggle] _ZWrite ("Z Write", Float) = 0
	}
	SubShader {
		Tags { "QUEUE" = "Geometry+2" "RenderType" = "Opaque" }
		Pass {
			Tags { "QUEUE" = "Geometry+2" "RenderType" = "Opaque" }
			ZWrite Off
			Stencil {
				Comp Equal
				Pass Keep
				Fail Keep
				ZFail Keep
			}
			GpuProgramID 35488
			// No subprograms found
		}
	}
	CustomEditor "FireCoreShaderGUI"
}