Shader "Debug/Col0Tex" {
	Properties {
	}
	SubShader {
		LOD 100
		Tags { "RenderType" = "Opaque" "ShaderType" = "Standard" }
		Pass {
			LOD 100
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" "ShaderType" = "Standard" }
			GpuProgramID 9528
			// No subprograms found
		}
	}
	SubShader {
		LOD 100
		Tags { "RenderType" = "Opaque" "ShaderType" = "Bump" }
		Pass {
			LOD 100
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" "ShaderType" = "Bump" }
			GpuProgramID 97769
			// No subprograms found
		}
	}
	SubShader {
		Tags { "QUEUE" = "Transparent" "ShaderType" = "Grid" }
		Pass {
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "SHADOWSUPPORT" = "true" "ShaderType" = "Grid" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 146991
			// No subprograms found
		}
	}
}