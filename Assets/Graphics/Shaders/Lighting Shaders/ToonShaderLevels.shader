﻿Shader "Custom/ToonShaderLevels" {
	Properties {
		_MainTex("Texture", 2D) = "white" {}
		_CelShadingLevels("Levels", Range(1, 10)) = 5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Toon

		#pragma target 3.0

		sampler2D _MainTex;
		fixed _CelShadingLevels;

		struct Input {
			float2 uv_MainTex;
		};

		UNITY_INSTANCING_BUFFER_START(Props)
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}

		/*
			Set "Wrap Mode" to Clamp. If UV coordinates are greater than 1 or less than 0, they will be clamped to the last pixel on the border
			Set "Filter Mode" to Point. Point - Pixel appear blocky, Bilinear - Pixels are averaged, Trilinear - Pixels are averaged and blended
		*/

		fixed4 LightingToon(SurfaceOutput s, fixed3 lightDir, fixed atten) {
			// First calculate the dot product of the light direction and the surface normal
			half NdotL = dot(s.Normal, lightDir);

			half cel = floor(NdotL * _CelShadingLevels) / (_CelShadingLevels - 0.5);

			// Set what colour should be returned
			half4 color;
			
			color.rgb = s.Albedo * _LightColor0.rgb * (cel * atten);
			color.a = s.Alpha;

			return color;
		}


		ENDCG
	}
	FallBack "Diffuse"
}
