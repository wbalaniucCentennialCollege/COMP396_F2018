Shader "Custom/PackedTextureShader" {
	Properties {
		_MainTint ("Diffuse Tint", Color) = (1,1,1,1)

		// Add the properties below so we can input all of our textures
		_ColorA ("Terrain Color A", Color) = (1,1,1,1)
		_ColorB ("Terrain Color B", Color) = (1,1,1,1)
		_RTexture ("Red Channel Texture", 2D) = ""{}
		_GTexture ("Green Channel Texture", 2D) = ""{}
		_BTexture ("Blue Channel Texture", 2D) = ""{}
		_ATexture ("Alpha Channel Texture", 2D) = ""{}
		_BlendTex ("Blend Texture", 2D) = "" {}

	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		float4 _MainTint;
		float4 _ColorA;
		float4 _ColorB;
		sampler2D _RTexture;
		sampler2D _GTexture;
		sampler2D _BTexture;
		sampler2D _BlendTex;
		sampler2D _ATexture;
	

		struct Input {
			float2 uv_RTexture;
			float2 uv_GTexture;
			float2 uv_BTexture;
			float2 uv_ATexture;
			float2 uv_BlendTex;
		};


		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Get pixel data from the blend texture.
		}
		ENDCG
	}
	FallBack "Diffuse"
}
