Shader "Unlit/Grid" {
	Properties {
		_Color ("Color", Vector) = (1,1,1,1)
		_SubLineColor ("SubLineColor", Vector) = (1,1,1,0.5)
		_RowLength ("Row", Float) = 10
		_ColumnsLength ("Columns", Float) = 10
		_Thickness ("Thickness", Float) = 0.01
		_SubLineThickness ("SubLineThickness", Float) = 0.01
		_Division ("Division", Float) = 10
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "ShaderType" = "Grid" }
		Pass {
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "SHADOWSUPPORT" = "true" "ShaderType" = "Grid" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 56527
			// No subprograms found
		}
		Pass {
			Name "ShadowCaster"
			Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Transparent" "SHADOWSUPPORT" = "true" "ShaderType" = "Grid" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZTest Less
			Cull Off
			GpuProgramID 74753
			// No subprograms found
		}
	}
}