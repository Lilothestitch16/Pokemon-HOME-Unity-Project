Shader "Unlit/InvisiblePlane" {
	Properties {
	}
	SubShader {
		Tags { "QUEUE" = "AlphaTest+50" }
		Pass {
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest+50" "SHADOWSUPPORT" = "true" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 36692
			// No subprograms found
		}
		Pass {
			Name "ShadowCaster"
			Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "AlphaTest+50" "SHADOWSUPPORT" = "true" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZTest Less
			Cull Off
			GpuProgramID 86659
			// No subprograms found
		}
	}
}