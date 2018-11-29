// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// SHADERLAB AREA STARTS HERE
Shader "Custom/My Second Shader" {
    Properties {
        _MainTexture("Main Color (RGB)", 2D) = "white" {}
        _Color("Colour", Color) = (1,1,1,1)

		// Using a Texture to cut out geometry from object
		_DissolveTexture("Cheese", 2D) = "white" {}
		_DissolveAmount("Cheese Cut Out Amount", Range(0, 1)) = 1
    }
    SubShader {
        Pass {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc" 
            struct appdata {
                float4 vertex : POSITION;   
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            float4 _Color;
            sampler2D _MainTexture;

			// DECLARE DISSOLVE VARIABLES
			sampler2D _DissolveTexture;
			float _DissolveAmount;

            v2f vert(appdata IN) {
                v2f OUT;
                
                OUT.position = UnityObjectToClipPos(IN.vertex);   
                OUT.uv = IN.uv; 

                return OUT;
            }

            fixed4 frag(v2f IN) : SV_Target {  
                float4 textureColour = tex2D(_MainTexture, IN.uv);
				float4 dissolveColor = tex2D(_DissolveTexture, IN.uv); // Import dissolve texture

				// "Clip" - Kills current pixel output  (CHECK DOCUMENTATION)
				clip(dissolveColor.rgb - _DissolveAmount);

                return textureColour * _Color; 
            }

            ENDCG
        }
    }
}