Shader "Custom/LightingShader1" {
	Properties {
		_MainTex("Texture", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf SimpleLambert // Forces Cg to look for a function called "LightingSimpleLambert()". 

		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}

		// Takes in 3 parameters
		/*
			The surface output
			The direction the light comes from
			Light attenuation
		*/
		half4 LightingSimpleLambert (SurfaceOutput s, half3 lightDir, half atten) {
			half NdotL = dot(s.Normal, lightDir);
			half4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten * 1);
			c.a = s.Alpha;
			return c;
		}

		/*
			In Lambertian reflectance, the amount of light a surface reflects depends on the angle between the light and the surface nromal.
			Think of pool, if you hit the ball at a 90 degree angle, the ball will come back at you. The Lambertian model made the same assumption.
			The lower the angle, the less light is reflected back at you.

			There is a mathematical formula to represent this. The angle between two unit vectors can be calculate via the dot product. When the dot product is 0,
			the vectors are orthogonal, which means they make a 90 angle. When it's equal to 1 (or -1), they are parallel to each other.

			L - light direction (called lightDir in the shader)
			N - Surface normal. 
			Lambertian reflectance - I = N (dot) L
		*/

		ENDCG
	}
	FallBack "Diffuse"
}
