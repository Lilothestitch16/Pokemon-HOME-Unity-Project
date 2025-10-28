Shader "Debug/Normal" {
	Properties {
	}
	SubShader {
		LOD 100
		Tags { "RenderType" = "Opaque" "ShaderType" = "Standard" }
		Pass {
			LOD 100
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" "ShaderType" = "Standard" }
			GpuProgramID 31988
			// No subprograms found
		}
	}
	SubShader {
		LOD 100
		Tags { "RenderType" = "Opaque" "ShaderType" = "Bump" }
		Pass {
			LOD 100
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" "ShaderType" = "Bump" }
			GpuProgramID 121165
			// No subprograms found
		}
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "ShaderType" = "Grid" }
		Pass {
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "SHADOWSUPPORT" = "true" "ShaderType" = "Grid" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 135617
			// No subprograms found
		}
	}
}