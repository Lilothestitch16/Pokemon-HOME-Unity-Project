Shader "Unlit/VerticalGradient" {
	Properties {
		_Color ("_Color", Vector) = (1,1,1,0)
		_SecondaryColor ("_SecondaryColor", Vector) = (0,0,0,0)
	}
	SubShader {
		Tags { "RenderType" = "Opaque" }
		Pass {
			Tags { "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			ZWrite Off
			Cull Off
			GpuProgramID 37283
			// No subprograms found
		}
	}
}