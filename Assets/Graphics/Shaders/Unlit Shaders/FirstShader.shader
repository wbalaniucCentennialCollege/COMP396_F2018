// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// SHADERLAB AREA STARTS HERE
Shader "Custom/My First Shader" {
    Properties {
        _MainTexture("Main Color (RGB)", 2D) = "white" {}
        _Color("Colour", Color) = (1,1,1,1)
    }
    // Can have different subshaders that will be selected based on available devices
    SubShader {
        // Takng data and drawing it to the screen. YOU CAN HAVE MULTIPLE PASSES! Each pass is a draw call
        Pass {
// SHADERLAB AREA ENDS HERE
            CGPROGRAM
            
            // DEFINE THE NAME OF THE VERTEX AND FRAGMENT SHADER FIRST!!!
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc" // Helper function to help with some calculations
            // Verticies
            // Normal
            // Colour
            // UVs
            struct appdata {
                float4 vertex : POSITION;   // "vertex" - Variable Name. "POSITION" - Type. "float4" - Data format the data is stored in (1,1,1,1)
                float2 uv : TEXCOORD0;  // float2 (1,1). "TEXCOORD0" - 
            };

            struct v2f {
                float4 position : SV_POSITION;  // "SV" is there to satisfy a DirectX requirement
                float2 uv : TEXCOORD0;
            };

            // VARIABLE DECLARATION OF THE PROPERTIES DEFINED ABOVE IN SHADERLAB
            float4 _Color;
            sampler2D _MainTexture;

            // Vertex shader
            // Build the object

            v2f vert(appdata IN) {
                v2f OUT;
                
                OUT.position = UnityObjectToClipPos(IN.vertex);    // This is why you need to know what a matrix is!
                OUT.uv = IN.uv; 

                return OUT;
            }

            // Fragment shader
            // Colour it in
            fixed4 frag(v2f IN) : SV_Target {   // SV_Target means that the output of this function will go out to the screen to be rendered
                float4 textureColour = tex2D(_MainTexture, IN.uv);

                return textureColour * _Color;  // Must return some 4-value colour (fixed4) to be used to colour a particular pixel. 
            }

            ENDCG
        }
    }
}