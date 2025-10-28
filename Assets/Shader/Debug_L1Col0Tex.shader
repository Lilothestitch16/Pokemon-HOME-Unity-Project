Shader "Debug/L1Col0Tex" {
	Properties {
	}
	SubShader {
		LOD 100
		Tags { "RenderType" = "Opaque" "ShaderType" = "Standard" }
		Pass {
			LOD 100
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" "ShaderType" = "Standard" }
			GpuProgramID 36530
			// No subprograms found
		}
	}
	SubShader {
		LOD 100
		Tags { "RenderType" = "Opaque" "ShaderType" = "Bump" }
		Pass {
			LOD 100
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" "ShaderType" = "Bump" }
			GpuProgramID 96782
			// No subprograms found
		}
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "ShaderType" = "Grid" }
		Pass {
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "SHADOWSUPPORT" = "true" "ShaderType" = "Grid" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 131128
			// No subprograms found
		}
	}
}