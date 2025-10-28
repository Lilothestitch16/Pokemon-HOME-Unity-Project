Shader "Unlit/DepthOnly" {
	Properties {
	}
	SubShader {
		Tags { "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
		Pass {
			Tags { "QUEUE" = "Geometry-100" "RenderType" = "Opaque" }
			ColorMask 0 -1
			GpuProgramID 48729
			// No subprograms found
		}
	}
}