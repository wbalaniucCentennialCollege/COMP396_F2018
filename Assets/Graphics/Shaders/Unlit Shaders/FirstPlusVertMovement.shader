Shader "Custom/FirstPlusVertMovement" {
    Properties {
        _MainTexture("Main Color (RGB)", 2D) = "white" {}
        _Color("Colour", Color) = (1,1,1,1)

		_DissolveTexture("Cheese", 2D) = "white" {}
		_DissolveAmount("Cheese Cut Out Amount", Range(0, 1)) = 1

		// EXTRUDE VERTICIES DECLARATION
		_ExtrudeAmount("Extrude Amount", Range(-0.5, 0.5)) = 1

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
				// GRAB NORMALS TO KNOW THE VECTORS POINTING OUTWARDS OF FROM THE CAT
				float3 normal : NORMAL;
            };

            struct v2f {
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            float4 _Color;
            sampler2D _MainTexture;

			sampler2D _DissolveTexture;
			float _DissolveAmount;

			// DELCAE VARIABLE
			float _ExtrudeAmount;

            v2f vert(appdata IN) {
                v2f OUT;
                
				// Manipulate each vertex before colouring it. *****1*****
				// IN.vertex.xyz += IN.normal.xyz * _ExtrudeAmount;

				//************ 2 ****************
				// Time is a float4 (x = t/20, y = t, z = t*2, w = t*3)
				IN.vertex.xyz += IN.normal.xyz * _ExtrudeAmount * sin(_Time.y);

                OUT.position = UnityObjectToClipPos(IN.vertex);   
                OUT.uv = IN.uv; 

                return OUT;
            }

            fixed4 frag(v2f IN) : SV_Target {  
                float4 textureColour = tex2D(_MainTexture, IN.uv);
				float4 dissolveColor = tex2D(_DissolveTexture, IN.uv); 

				clip(dissolveColor.rgb - _DissolveAmount);

                return textureColour * _Color; 
            }

            ENDCG
        }
    }
}