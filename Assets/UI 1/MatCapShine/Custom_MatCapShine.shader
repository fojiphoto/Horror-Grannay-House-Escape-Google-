Shader "Custom/MatCapShine" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_MatCap ("MatCap (RGB)", 2D) = "white" {}
		_MatCapStrength ("MatCapStrength", Range(0, 3)) = 1
		_ShineRamp ("ShineRamp", 2D) = "white" {}
		_ShineStrength ("Shine Strength", Range(0, 5)) = 2
		_ScrollSpeed ("Shine Scroll Speed", Float) = 10
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		sampler2D _MainTex;
		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	Fallback "VertexLit"
}