Shader "Custom/StandardDiffuseAmbient" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0


		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _Color;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		// The "SurfaceOutput" (Unity 4) struct has the following properties
		/*
			fixed3 Albedo - Diffuse colour of the material
			fixed3 Normal - Tangent-space normal, if written
			fixed3 Emission - The colour of the light emitted by this material
			fixed Alpha - Transparency
			half Specular - Specular power (reflectiveness) from 0 to 1
			fixed Gloss - Specular intensity
		*/
		// The "SurfaceOutputStandard" (Unity 5+) struct has the following properties
		/*
			fixed3 Albedo - Base color of the material
			fixed3 Normal
			half3 Emission
			fixed Alpha
			half Occlusion - Default to 1
			half Smoothness - 0 = rought, 1 = smooth
			half Metallic - 0 = non-metal, 1 = metal
		*/
		// The "SurfaceOutputStandardSpecular" struct has the following properties
		/*
			fixed3 Albedo
			fixed3 Normal
			half3 Emission
			fixed Alpha
			half Occlusion
			half Smoothness
			fixed3 Specular; - Specular colour. Different than other specular properties as you can specify an actual colour rather than a single value
		*/
		// "SWIZZLING" _Color.rgb
		// "SMEARING" is...o.Albedo = 0; // Black = (0,0,0) OR o.Albedgo = 1; White = (1,1,1)
		// "MASKING" o.Albedo.rg = _Color.rg; Left size swizzle of certain components in packed array
		void surf (Input IN, inout SurfaceOutputStandard o) {
			o.Albedo = _Color.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
