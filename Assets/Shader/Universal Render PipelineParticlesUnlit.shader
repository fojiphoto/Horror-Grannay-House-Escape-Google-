Shader "Universal Render Pipeline/Particles/Unlit" {
	Properties {
		_BaseMap ("Base Map", 2D) = "white" {}
		_BaseColor ("Base Color", Vector) = (1,1,1,1)
		_Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
		_BumpMap ("Normal Map", 2D) = "bump" {}
		_EmissionColor ("Color", Vector) = (0,0,0,1)
		_EmissionMap ("Emission", 2D) = "white" {}
		_SoftParticlesNearFadeDistance ("Soft Particles Near Fade", Float) = 0
		_SoftParticlesFarFadeDistance ("Soft Particles Far Fade", Float) = 1
		_CameraNearFadeDistance ("Camera Near Fade", Float) = 1
		_CameraFarFadeDistance ("Camera Far Fade", Float) = 2
		_DistortionBlend ("Distortion Blend", Float) = 0.5
		_DistortionStrength ("Distortion Strength", Float) = 1
		[HideInInspector] _Surface ("__surface", Float) = 0
		[HideInInspector] _Blend ("__mode", Float) = 0
		[HideInInspector] _AlphaClip ("__clip", Float) = 0
		[HideInInspector] _BlendOp ("__blendop", Float) = 0
		[HideInInspector] _SrcBlend ("__src", Float) = 1
		[HideInInspector] _DstBlend ("__dst", Float) = 0
		[HideInInspector] _ZWrite ("__zw", Float) = 1
		[HideInInspector] _Cull ("__cull", Float) = 2
		[HideInInspector] _ColorMode ("_ColorMode", Float) = 0
		[HideInInspector] _BaseColorAddSubDiff ("_ColorMode", Vector) = (0,0,0,0)
		[ToggleOff] _FlipbookBlending ("__flipbookblending", Float) = 0
		[HideInInspector] _SoftParticlesEnabled ("__softparticlesenabled", Float) = 0
		[HideInInspector] _CameraFadingEnabled ("__camerafadingenabled", Float) = 0
		[HideInInspector] _SoftParticleFadeParams ("__softparticlefadeparams", Vector) = (0,0,0,0)
		[HideInInspector] _CameraFadeParams ("__camerafadeparams", Vector) = (0,0,0,0)
		[HideInInspector] _DistortionEnabled ("__distortionenabled", Float) = 0
		[HideInInspector] _DistortionStrengthScaled ("Distortion Strength Scaled", Float) = 0.1
		[HideInInspector] _QueueOffset ("Queue offset", Float) = 0
		[HideInInspector] _FlipbookMode ("flipbook", Float) = 0
		[HideInInspector] _Mode ("mode", Float) = 0
		[HideInInspector] _Color ("color", Vector) = (1,1,1,1)
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "PerformanceChecks" = "False" "PreviewType" = "Plane" "RenderPipeline" = "UniversalPipeline" "RenderType" = "Opaque" }
		Pass {
			Name "ForwardLit"
			Tags { "IGNOREPROJECTOR" = "true" "PerformanceChecks" = "False" "PreviewType" = "Plane" "RenderPipeline" = "UniversalPipeline" "RenderType" = "Opaque" }
			Blend Zero Zero, Zero Zero
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 3110
			Program "vp" {
				SubProgram "gles " {
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute mediump vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BaseColor;
					uniform lowp sampler2D _BaseMap;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					#define SV_Target0 gl_FragData[0]
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture2D(_BaseMap, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat10_0 * _BaseColor;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					UNITY_BINDING(1) uniform UnityPerDraw {
					#endif
						UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
						UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
						UNITY_UNIFORM vec4 unity_LODFade;
						UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
						UNITY_UNIFORM mediump vec4 unity_LightData;
						UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
						UNITY_UNIFORM vec4 unity_ProbesOcclusion;
						UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
						UNITY_UNIFORM vec4 unity_LightmapST;
						UNITY_UNIFORM vec4 unity_DynamicLightmapST;
						UNITY_UNIFORM mediump vec4 unity_SHAr;
						UNITY_UNIFORM mediump vec4 unity_SHAg;
						UNITY_UNIFORM mediump vec4 unity_SHAb;
						UNITY_UNIFORM mediump vec4 unity_SHBr;
						UNITY_UNIFORM mediump vec4 unity_SHBg;
						UNITY_UNIFORM mediump vec4 unity_SHBb;
						UNITY_UNIFORM mediump vec4 unity_SHC;
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					};
					#endif
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					UNITY_BINDING(0) uniform UnityPerMaterial {
					#endif
						UNITY_UNIFORM vec4 _SoftParticleFadeParams;
						UNITY_UNIFORM vec4 _CameraFadeParams;
						UNITY_UNIFORM vec4 _BaseMap_ST;
						UNITY_UNIFORM mediump vec4 _BaseColor;
						UNITY_UNIFORM mediump vec4 _EmissionColor;
						UNITY_UNIFORM mediump vec4 _BaseColorAddSubDiff;
						UNITY_UNIFORM mediump float _Cutoff;
						UNITY_UNIFORM mediump float _DistortionStrengthScaled;
						UNITY_UNIFORM mediump float _DistortionBlend;
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					};
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					void main()
					{
					    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat16_0 * _BaseColor;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    SV_Target0 = u_xlat16_0;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 198
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %9 %11 %15 %17 %19 %27 %87 %128 %160 %163 %187 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                                      OpName vs_TEXCOORD8 "vs_TEXCOORD8" 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %9 Location 9 
					                                                      OpDecorate %11 RelaxedPrecision 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %12 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 15 
					                                                      OpDecorate %17 Location 17 
					                                                      OpDecorate vs_TEXCOORD1 Location 19 
					                                                      OpDecorate %27 Location 27 
					                                                      OpDecorate %32 ArrayStride 32 
					                                                      OpDecorate %33 ArrayStride 33 
					                                                      OpDecorate %35 ArrayStride 35 
					                                                      OpMemberDecorate %36 0 Offset 36 
					                                                      OpMemberDecorate %36 1 Offset 36 
					                                                      OpMemberDecorate %36 2 Offset 36 
					                                                      OpMemberDecorate %36 3 RelaxedPrecision 
					                                                      OpMemberDecorate %36 3 Offset 36 
					                                                      OpMemberDecorate %36 4 RelaxedPrecision 
					                                                      OpMemberDecorate %36 4 Offset 36 
					                                                      OpMemberDecorate %36 5 RelaxedPrecision 
					                                                      OpMemberDecorate %36 5 Offset 36 
					                                                      OpMemberDecorate %36 6 Offset 36 
					                                                      OpMemberDecorate %36 7 RelaxedPrecision 
					                                                      OpMemberDecorate %36 7 Offset 36 
					                                                      OpMemberDecorate %36 8 Offset 36 
					                                                      OpMemberDecorate %36 9 Offset 36 
					                                                      OpMemberDecorate %36 10 RelaxedPrecision 
					                                                      OpMemberDecorate %36 10 Offset 36 
					                                                      OpMemberDecorate %36 11 RelaxedPrecision 
					                                                      OpMemberDecorate %36 11 Offset 36 
					                                                      OpMemberDecorate %36 12 RelaxedPrecision 
					                                                      OpMemberDecorate %36 12 Offset 36 
					                                                      OpMemberDecorate %36 13 RelaxedPrecision 
					                                                      OpMemberDecorate %36 13 Offset 36 
					                                                      OpMemberDecorate %36 14 RelaxedPrecision 
					                                                      OpMemberDecorate %36 14 Offset 36 
					                                                      OpMemberDecorate %36 15 RelaxedPrecision 
					                                                      OpMemberDecorate %36 15 Offset 36 
					                                                      OpMemberDecorate %36 16 RelaxedPrecision 
					                                                      OpMemberDecorate %36 16 Offset 36 
					                                                      OpDecorate %36 Block 
					                                                      OpDecorate %38 DescriptorSet 38 
					                                                      OpDecorate %38 Binding 38 
					                                                      OpDecorate %87 Location 87 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 128 
					                                                      OpDecorate %134 ArrayStride 134 
					                                                      OpMemberDecorate %135 0 Offset 135 
					                                                      OpMemberDecorate %135 1 Offset 135 
					                                                      OpDecorate %135 Block 
					                                                      OpDecorate %137 DescriptorSet 137 
					                                                      OpDecorate %137 Binding 137 
					                                                      OpDecorate vs_TEXCOORD3 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD3 Location 160 
					                                                      OpDecorate vs_TEXCOORD8 Location 163 
					                                                      OpMemberDecorate %185 0 BuiltIn 185 
					                                                      OpMemberDecorate %185 1 BuiltIn 185 
					                                                      OpMemberDecorate %185 2 BuiltIn 185 
					                                                      OpDecorate %185 Block 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Output %7 
					                                 Output f32_4* %9 = OpVariable Output 
					                                              %10 = OpTypePointer Input %7 
					                                 Input f32_4* %11 = OpVariable Input 
					                                              %13 = OpTypeVector %6 2 
					                                              %14 = OpTypePointer Output %13 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                              %16 = OpTypePointer Input %13 
					                                 Input f32_2* %17 = OpVariable Input 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                          f32 %20 = OpConstant 3.674022E-40 
					                                              %21 = OpTypeInt 32 0 
					                                          u32 %22 = OpConstant 3 
					                                              %23 = OpTypePointer Output %6 
					                                              %25 = OpTypePointer Private %7 
					                               Private f32_4* %26 = OpVariable Private 
					                                 Input f32_4* %27 = OpVariable Input 
					                                              %28 = OpTypeVector %6 3 
					                                          u32 %31 = OpConstant 4 
					                                              %32 = OpTypeArray %7 %31 
					                                              %33 = OpTypeArray %7 %31 
					                                          u32 %34 = OpConstant 2 
					                                              %35 = OpTypeArray %7 %34 
					                                              %36 = OpTypeStruct %32 %33 %7 %7 %7 %35 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
					                                              %37 = OpTypePointer Uniform %36 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %38 = OpVariable Uniform 
					                                              %39 = OpTypeInt 32 1 
					                                          i32 %40 = OpConstant 0 
					                                          i32 %41 = OpConstant 1 
					                                              %42 = OpTypePointer Uniform %7 
					                                          i32 %60 = OpConstant 2 
					                                          i32 %74 = OpConstant 3 
					                               Private f32_4* %85 = OpVariable Private 
					                                              %86 = OpTypePointer Input %28 
					                                 Input f32_3* %87 = OpVariable Input 
					                                          u32 %93 = OpConstant 0 
					                                              %94 = OpTypePointer Private %6 
					                                         u32 %101 = OpConstant 1 
					                                Private f32* %109 = OpVariable Private 
					                                         f32 %116 = OpConstant 3.674022E-40 
					                                             %127 = OpTypePointer Output %28 
					                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
					                                             %134 = OpTypeArray %7 %31 
					                                             %135 = OpTypeStruct %28 %134 
					                                             %136 = OpTypePointer Uniform %135 
					          Uniform struct {f32_3; f32_4[4];}* %137 = OpVariable Uniform 
					                                             %138 = OpTypePointer Uniform %28 
					                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
					                       Output f32_3* vs_TEXCOORD8 = OpVariable Output 
					                                       f32_3 %164 = OpConstantComposite %20 %20 %20 
					                                             %184 = OpTypeArray %6 %101 
					                                             %185 = OpTypeStruct %7 %6 %184 
					                                             %186 = OpTypePointer Output %185 
					        Output struct {f32_4; f32; f32[1];}* %187 = OpVariable Output 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %12 = OpLoad %11 
					                                                      OpStore %9 %12 
					                                        f32_2 %18 = OpLoad %17 
					                                                      OpStore vs_TEXCOORD0 %18 
					                                  Output f32* %24 = OpAccessChain vs_TEXCOORD1 %22 
					                                                      OpStore %24 %20 
					                                        f32_4 %29 = OpLoad %27 
					                                        f32_3 %30 = OpVectorShuffle %29 %29 1 1 1 
					                               Uniform f32_4* %43 = OpAccessChain %38 %40 %41 
					                                        f32_4 %44 = OpLoad %43 
					                                        f32_3 %45 = OpVectorShuffle %44 %44 0 1 2 
					                                        f32_3 %46 = OpFMul %30 %45 
					                                        f32_4 %47 = OpLoad %26 
					                                        f32_4 %48 = OpVectorShuffle %47 %46 4 5 6 3 
					                                                      OpStore %26 %48 
					                               Uniform f32_4* %49 = OpAccessChain %38 %40 %40 
					                                        f32_4 %50 = OpLoad %49 
					                                        f32_3 %51 = OpVectorShuffle %50 %50 0 1 2 
					                                        f32_4 %52 = OpLoad %27 
					                                        f32_3 %53 = OpVectorShuffle %52 %52 0 0 0 
					                                        f32_3 %54 = OpFMul %51 %53 
					                                        f32_4 %55 = OpLoad %26 
					                                        f32_3 %56 = OpVectorShuffle %55 %55 0 1 2 
					                                        f32_3 %57 = OpFAdd %54 %56 
					                                        f32_4 %58 = OpLoad %26 
					                                        f32_4 %59 = OpVectorShuffle %58 %57 4 5 6 3 
					                                                      OpStore %26 %59 
					                               Uniform f32_4* %61 = OpAccessChain %38 %40 %60 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_3 %63 = OpVectorShuffle %62 %62 0 1 2 
					                                        f32_4 %64 = OpLoad %27 
					                                        f32_3 %65 = OpVectorShuffle %64 %64 2 2 2 
					                                        f32_3 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %26 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                        f32_3 %69 = OpFAdd %66 %68 
					                                        f32_4 %70 = OpLoad %26 
					                                        f32_4 %71 = OpVectorShuffle %70 %69 4 5 6 3 
					                                                      OpStore %26 %71 
					                                        f32_4 %72 = OpLoad %26 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
					                               Uniform f32_4* %75 = OpAccessChain %38 %40 %74 
					                                        f32_4 %76 = OpLoad %75 
					                                        f32_3 %77 = OpVectorShuffle %76 %76 0 1 2 
					                                        f32_3 %78 = OpFAdd %73 %77 
					                                        f32_4 %79 = OpLoad %26 
					                                        f32_4 %80 = OpVectorShuffle %79 %78 4 5 6 3 
					                                                      OpStore %26 %80 
					                                        f32_4 %81 = OpLoad %26 
					                                        f32_3 %82 = OpVectorShuffle %81 %81 0 1 2 
					                                        f32_4 %83 = OpLoad vs_TEXCOORD1 
					                                        f32_4 %84 = OpVectorShuffle %83 %82 4 5 6 3 
					                                                      OpStore vs_TEXCOORD1 %84 
					                                        f32_3 %88 = OpLoad %87 
					                               Uniform f32_4* %89 = OpAccessChain %38 %41 %40 
					                                        f32_4 %90 = OpLoad %89 
					                                        f32_3 %91 = OpVectorShuffle %90 %90 0 1 2 
					                                          f32 %92 = OpDot %88 %91 
					                                 Private f32* %95 = OpAccessChain %85 %93 
					                                                      OpStore %95 %92 
					                                        f32_3 %96 = OpLoad %87 
					                               Uniform f32_4* %97 = OpAccessChain %38 %41 %41 
					                                        f32_4 %98 = OpLoad %97 
					                                        f32_3 %99 = OpVectorShuffle %98 %98 0 1 2 
					                                         f32 %100 = OpDot %96 %99 
					                                Private f32* %102 = OpAccessChain %85 %101 
					                                                      OpStore %102 %100 
					                                       f32_3 %103 = OpLoad %87 
					                              Uniform f32_4* %104 = OpAccessChain %38 %41 %60 
					                                       f32_4 %105 = OpLoad %104 
					                                       f32_3 %106 = OpVectorShuffle %105 %105 0 1 2 
					                                         f32 %107 = OpDot %103 %106 
					                                Private f32* %108 = OpAccessChain %85 %34 
					                                                      OpStore %108 %107 
					                                       f32_4 %110 = OpLoad %85 
					                                       f32_3 %111 = OpVectorShuffle %110 %110 0 1 2 
					                                       f32_4 %112 = OpLoad %85 
					                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
					                                         f32 %114 = OpDot %111 %113 
					                                                      OpStore %109 %114 
					                                         f32 %115 = OpLoad %109 
					                                         f32 %117 = OpExtInst %1 40 %115 %116 
					                                                      OpStore %109 %117 
					                                         f32 %118 = OpLoad %109 
					                                         f32 %119 = OpExtInst %1 32 %118 
					                                                      OpStore %109 %119 
					                                         f32 %120 = OpLoad %109 
					                                       f32_3 %121 = OpCompositeConstruct %120 %120 %120 
					                                       f32_4 %122 = OpLoad %85 
					                                       f32_3 %123 = OpVectorShuffle %122 %122 0 1 2 
					                                       f32_3 %124 = OpFMul %121 %123 
					                                       f32_4 %125 = OpLoad %85 
					                                       f32_4 %126 = OpVectorShuffle %125 %124 4 5 6 3 
					                                                      OpStore %85 %126 
					                                       f32_4 %129 = OpLoad %85 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 0 1 2 
					                                                      OpStore vs_TEXCOORD2 %130 
					                                       f32_4 %131 = OpLoad %26 
					                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
					                                       f32_3 %133 = OpFNegate %132 
					                              Uniform f32_3* %139 = OpAccessChain %137 %40 
					                                       f32_3 %140 = OpLoad %139 
					                                       f32_3 %141 = OpFAdd %133 %140 
					                                       f32_4 %142 = OpLoad %85 
					                                       f32_4 %143 = OpVectorShuffle %142 %141 4 5 6 3 
					                                                      OpStore %85 %143 
					                                       f32_4 %144 = OpLoad %85 
					                                       f32_3 %145 = OpVectorShuffle %144 %144 0 1 2 
					                                       f32_4 %146 = OpLoad %85 
					                                       f32_3 %147 = OpVectorShuffle %146 %146 0 1 2 
					                                         f32 %148 = OpDot %145 %147 
					                                                      OpStore %109 %148 
					                                         f32 %149 = OpLoad %109 
					                                         f32 %150 = OpExtInst %1 40 %149 %116 
					                                                      OpStore %109 %150 
					                                         f32 %151 = OpLoad %109 
					                                         f32 %152 = OpExtInst %1 32 %151 
					                                                      OpStore %109 %152 
					                                         f32 %153 = OpLoad %109 
					                                       f32_3 %154 = OpCompositeConstruct %153 %153 %153 
					                                       f32_4 %155 = OpLoad %85 
					                                       f32_3 %156 = OpVectorShuffle %155 %155 0 1 2 
					                                       f32_3 %157 = OpFMul %154 %156 
					                                       f32_4 %158 = OpLoad %85 
					                                       f32_4 %159 = OpVectorShuffle %158 %157 4 5 6 3 
					                                                      OpStore %85 %159 
					                                       f32_4 %161 = OpLoad %85 
					                                       f32_3 %162 = OpVectorShuffle %161 %161 0 1 2 
					                                                      OpStore vs_TEXCOORD3 %162 
					                                                      OpStore vs_TEXCOORD8 %164 
					                                       f32_4 %165 = OpLoad %26 
					                                       f32_4 %166 = OpVectorShuffle %165 %165 1 1 1 1 
					                              Uniform f32_4* %167 = OpAccessChain %137 %41 %41 
					                                       f32_4 %168 = OpLoad %167 
					                                       f32_4 %169 = OpFMul %166 %168 
					                                                      OpStore %85 %169 
					                              Uniform f32_4* %170 = OpAccessChain %137 %41 %40 
					                                       f32_4 %171 = OpLoad %170 
					                                       f32_4 %172 = OpLoad %26 
					                                       f32_4 %173 = OpVectorShuffle %172 %172 0 0 0 0 
					                                       f32_4 %174 = OpFMul %171 %173 
					                                       f32_4 %175 = OpLoad %85 
					                                       f32_4 %176 = OpFAdd %174 %175 
					                                                      OpStore %85 %176 
					                              Uniform f32_4* %177 = OpAccessChain %137 %41 %60 
					                                       f32_4 %178 = OpLoad %177 
					                                       f32_4 %179 = OpLoad %26 
					                                       f32_4 %180 = OpVectorShuffle %179 %179 2 2 2 2 
					                                       f32_4 %181 = OpFMul %178 %180 
					                                       f32_4 %182 = OpLoad %85 
					                                       f32_4 %183 = OpFAdd %181 %182 
					                                                      OpStore %26 %183 
					                                       f32_4 %188 = OpLoad %26 
					                              Uniform f32_4* %189 = OpAccessChain %137 %41 %74 
					                                       f32_4 %190 = OpLoad %189 
					                                       f32_4 %191 = OpFAdd %188 %190 
					                               Output f32_4* %192 = OpAccessChain %187 %40 
					                                                      OpStore %192 %191 
					                                 Output f32* %193 = OpAccessChain %187 %40 %101 
					                                         f32 %194 = OpLoad %193 
					                                         f32 %195 = OpFNegate %194 
					                                 Output f32* %196 = OpAccessChain %187 %40 %101 
					                                                      OpStore %196 %195 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 45
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %22 %38 %42 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %12 RelaxedPrecision 
					                                                      OpDecorate %12 DescriptorSet 12 
					                                                      OpDecorate %12 Binding 12 
					                                                      OpDecorate %13 RelaxedPrecision 
					                                                      OpDecorate %16 RelaxedPrecision 
					                                                      OpDecorate %16 DescriptorSet 16 
					                                                      OpDecorate %16 Binding 16 
					                                                      OpDecorate %17 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 22 
					                                                      OpDecorate %25 RelaxedPrecision 
					                                                      OpDecorate %26 RelaxedPrecision 
					                                                      OpMemberDecorate %27 0 Offset 27 
					                                                      OpMemberDecorate %27 1 Offset 27 
					                                                      OpMemberDecorate %27 2 Offset 27 
					                                                      OpMemberDecorate %27 3 RelaxedPrecision 
					                                                      OpMemberDecorate %27 3 Offset 27 
					                                                      OpMemberDecorate %27 4 RelaxedPrecision 
					                                                      OpMemberDecorate %27 4 Offset 27 
					                                                      OpMemberDecorate %27 5 RelaxedPrecision 
					                                                      OpMemberDecorate %27 5 Offset 27 
					                                                      OpMemberDecorate %27 6 RelaxedPrecision 
					                                                      OpMemberDecorate %27 6 Offset 27 
					                                                      OpMemberDecorate %27 7 RelaxedPrecision 
					                                                      OpMemberDecorate %27 7 Offset 27 
					                                                      OpMemberDecorate %27 8 RelaxedPrecision 
					                                                      OpMemberDecorate %27 8 Offset 27 
					                                                      OpDecorate %27 Block 
					                                                      OpDecorate %29 DescriptorSet 29 
					                                                      OpDecorate %29 Binding 29 
					                                                      OpDecorate %34 RelaxedPrecision 
					                                                      OpDecorate %35 RelaxedPrecision 
					                                                      OpDecorate %36 RelaxedPrecision 
					                                                      OpDecorate %38 RelaxedPrecision 
					                                                      OpDecorate %38 Location 38 
					                                                      OpDecorate %39 RelaxedPrecision 
					                                                      OpDecorate %40 RelaxedPrecision 
					                                                      OpDecorate %42 RelaxedPrecision 
					                                                      OpDecorate %42 Location 42 
					                                                      OpDecorate %43 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %11 = OpTypePointer UniformConstant %10 
					         UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                              %14 = OpTypeSampler 
					                                              %15 = OpTypePointer UniformConstant %14 
					                     UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                              %18 = OpTypeSampledImage %10 
					                                              %20 = OpTypeVector %6 2 
					                                              %21 = OpTypePointer Input %20 
					                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                               Private f32_4* %25 = OpVariable Private 
					                                              %27 = OpTypeStruct %7 %7 %7 %7 %7 %7 %6 %6 %6 
					                                              %28 = OpTypePointer Uniform %27 
					Uniform struct {f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32; f32; f32;}* %29 = OpVariable Uniform 
					                                              %30 = OpTypeInt 32 1 
					                                          i32 %31 = OpConstant 3 
					                                              %32 = OpTypePointer Uniform %7 
					                                              %37 = OpTypePointer Input %7 
					                                 Input f32_4* %38 = OpVariable Input 
					                                              %41 = OpTypePointer Output %7 
					                                Output f32_4* %42 = OpVariable Output 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                          read_only Texture2D %13 = OpLoad %12 
					                                      sampler %17 = OpLoad %16 
					                   read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                        f32_2 %23 = OpLoad vs_TEXCOORD0 
					                                        f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                                      OpStore %9 %24 
					                                        f32_4 %26 = OpLoad %9 
					                               Uniform f32_4* %33 = OpAccessChain %29 %31 
					                                        f32_4 %34 = OpLoad %33 
					                                        f32_4 %35 = OpFMul %26 %34 
					                                                      OpStore %25 %35 
					                                        f32_4 %36 = OpLoad %25 
					                                        f32_4 %39 = OpLoad %38 
					                                        f32_4 %40 = OpFMul %36 %39 
					                                                      OpStore %25 %40 
					                                        f32_4 %43 = OpLoad %25 
					                                                      OpStore %42 %43 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "gles " {
					Keywords { "_ALPHAPREMULTIPLY_ON" "_ALPHATEST_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute mediump vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BaseColor;
					uniform 	mediump float _Cutoff;
					uniform lowp sampler2D _BaseMap;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					#define SV_Target0 gl_FragData[0]
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump float u_xlat16_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture2D(_BaseMap, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat10_0 * _BaseColor;
					    u_xlat16_1 = u_xlat16_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlatb2 = u_xlat16_1<0.0;
					    if(u_xlatb2){discard;}
					    SV_Target0.xyz = u_xlat16_0.www * u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat16_0.w;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "_ALPHAPREMULTIPLY_ON" "_ALPHATEST_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					UNITY_BINDING(1) uniform UnityPerDraw {
					#endif
						UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
						UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
						UNITY_UNIFORM vec4 unity_LODFade;
						UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
						UNITY_UNIFORM mediump vec4 unity_LightData;
						UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
						UNITY_UNIFORM vec4 unity_ProbesOcclusion;
						UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
						UNITY_UNIFORM vec4 unity_LightmapST;
						UNITY_UNIFORM vec4 unity_DynamicLightmapST;
						UNITY_UNIFORM mediump vec4 unity_SHAr;
						UNITY_UNIFORM mediump vec4 unity_SHAg;
						UNITY_UNIFORM mediump vec4 unity_SHAb;
						UNITY_UNIFORM mediump vec4 unity_SHBr;
						UNITY_UNIFORM mediump vec4 unity_SHBg;
						UNITY_UNIFORM mediump vec4 unity_SHBb;
						UNITY_UNIFORM mediump vec4 unity_SHC;
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					};
					#endif
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					UNITY_BINDING(0) uniform UnityPerMaterial {
					#endif
						UNITY_UNIFORM vec4 _SoftParticleFadeParams;
						UNITY_UNIFORM vec4 _CameraFadeParams;
						UNITY_UNIFORM vec4 _BaseMap_ST;
						UNITY_UNIFORM mediump vec4 _BaseColor;
						UNITY_UNIFORM mediump vec4 _EmissionColor;
						UNITY_UNIFORM mediump vec4 _BaseColorAddSubDiff;
						UNITY_UNIFORM mediump float _Cutoff;
						UNITY_UNIFORM mediump float _DistortionStrengthScaled;
						UNITY_UNIFORM mediump float _DistortionBlend;
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					};
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					mediump float u_xlat16_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat16_0 * _BaseColor;
					    u_xlat16_1 = u_xlat16_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat16_1<0.0);
					#else
					    u_xlatb2 = u_xlat16_1<0.0;
					#endif
					    if(u_xlatb2){discard;}
					    SV_Target0.xyz = u_xlat16_0.www * u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat16_0.w;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					Keywords { "_ALPHAPREMULTIPLY_ON" "_ALPHATEST_ON" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 198
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %9 %11 %15 %17 %19 %27 %87 %128 %160 %163 %187 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                                      OpName vs_TEXCOORD8 "vs_TEXCOORD8" 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %9 Location 9 
					                                                      OpDecorate %11 RelaxedPrecision 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %12 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 15 
					                                                      OpDecorate %17 Location 17 
					                                                      OpDecorate vs_TEXCOORD1 Location 19 
					                                                      OpDecorate %27 Location 27 
					                                                      OpDecorate %32 ArrayStride 32 
					                                                      OpDecorate %33 ArrayStride 33 
					                                                      OpDecorate %35 ArrayStride 35 
					                                                      OpMemberDecorate %36 0 Offset 36 
					                                                      OpMemberDecorate %36 1 Offset 36 
					                                                      OpMemberDecorate %36 2 Offset 36 
					                                                      OpMemberDecorate %36 3 RelaxedPrecision 
					                                                      OpMemberDecorate %36 3 Offset 36 
					                                                      OpMemberDecorate %36 4 RelaxedPrecision 
					                                                      OpMemberDecorate %36 4 Offset 36 
					                                                      OpMemberDecorate %36 5 RelaxedPrecision 
					                                                      OpMemberDecorate %36 5 Offset 36 
					                                                      OpMemberDecorate %36 6 Offset 36 
					                                                      OpMemberDecorate %36 7 RelaxedPrecision 
					                                                      OpMemberDecorate %36 7 Offset 36 
					                                                      OpMemberDecorate %36 8 Offset 36 
					                                                      OpMemberDecorate %36 9 Offset 36 
					                                                      OpMemberDecorate %36 10 RelaxedPrecision 
					                                                      OpMemberDecorate %36 10 Offset 36 
					                                                      OpMemberDecorate %36 11 RelaxedPrecision 
					                                                      OpMemberDecorate %36 11 Offset 36 
					                                                      OpMemberDecorate %36 12 RelaxedPrecision 
					                                                      OpMemberDecorate %36 12 Offset 36 
					                                                      OpMemberDecorate %36 13 RelaxedPrecision 
					                                                      OpMemberDecorate %36 13 Offset 36 
					                                                      OpMemberDecorate %36 14 RelaxedPrecision 
					                                                      OpMemberDecorate %36 14 Offset 36 
					                                                      OpMemberDecorate %36 15 RelaxedPrecision 
					                                                      OpMemberDecorate %36 15 Offset 36 
					                                                      OpMemberDecorate %36 16 RelaxedPrecision 
					                                                      OpMemberDecorate %36 16 Offset 36 
					                                                      OpDecorate %36 Block 
					                                                      OpDecorate %38 DescriptorSet 38 
					                                                      OpDecorate %38 Binding 38 
					                                                      OpDecorate %87 Location 87 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 128 
					                                                      OpDecorate %134 ArrayStride 134 
					                                                      OpMemberDecorate %135 0 Offset 135 
					                                                      OpMemberDecorate %135 1 Offset 135 
					                                                      OpDecorate %135 Block 
					                                                      OpDecorate %137 DescriptorSet 137 
					                                                      OpDecorate %137 Binding 137 
					                                                      OpDecorate vs_TEXCOORD3 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD3 Location 160 
					                                                      OpDecorate vs_TEXCOORD8 Location 163 
					                                                      OpMemberDecorate %185 0 BuiltIn 185 
					                                                      OpMemberDecorate %185 1 BuiltIn 185 
					                                                      OpMemberDecorate %185 2 BuiltIn 185 
					                                                      OpDecorate %185 Block 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Output %7 
					                                 Output f32_4* %9 = OpVariable Output 
					                                              %10 = OpTypePointer Input %7 
					                                 Input f32_4* %11 = OpVariable Input 
					                                              %13 = OpTypeVector %6 2 
					                                              %14 = OpTypePointer Output %13 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                              %16 = OpTypePointer Input %13 
					                                 Input f32_2* %17 = OpVariable Input 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                          f32 %20 = OpConstant 3.674022E-40 
					                                              %21 = OpTypeInt 32 0 
					                                          u32 %22 = OpConstant 3 
					                                              %23 = OpTypePointer Output %6 
					                                              %25 = OpTypePointer Private %7 
					                               Private f32_4* %26 = OpVariable Private 
					                                 Input f32_4* %27 = OpVariable Input 
					                                              %28 = OpTypeVector %6 3 
					                                          u32 %31 = OpConstant 4 
					                                              %32 = OpTypeArray %7 %31 
					                                              %33 = OpTypeArray %7 %31 
					                                          u32 %34 = OpConstant 2 
					                                              %35 = OpTypeArray %7 %34 
					                                              %36 = OpTypeStruct %32 %33 %7 %7 %7 %35 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
					                                              %37 = OpTypePointer Uniform %36 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %38 = OpVariable Uniform 
					                                              %39 = OpTypeInt 32 1 
					                                          i32 %40 = OpConstant 0 
					                                          i32 %41 = OpConstant 1 
					                                              %42 = OpTypePointer Uniform %7 
					                                          i32 %60 = OpConstant 2 
					                                          i32 %74 = OpConstant 3 
					                               Private f32_4* %85 = OpVariable Private 
					                                              %86 = OpTypePointer Input %28 
					                                 Input f32_3* %87 = OpVariable Input 
					                                          u32 %93 = OpConstant 0 
					                                              %94 = OpTypePointer Private %6 
					                                         u32 %101 = OpConstant 1 
					                                Private f32* %109 = OpVariable Private 
					                                         f32 %116 = OpConstant 3.674022E-40 
					                                             %127 = OpTypePointer Output %28 
					                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
					                                             %134 = OpTypeArray %7 %31 
					                                             %135 = OpTypeStruct %28 %134 
					                                             %136 = OpTypePointer Uniform %135 
					          Uniform struct {f32_3; f32_4[4];}* %137 = OpVariable Uniform 
					                                             %138 = OpTypePointer Uniform %28 
					                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
					                       Output f32_3* vs_TEXCOORD8 = OpVariable Output 
					                                       f32_3 %164 = OpConstantComposite %20 %20 %20 
					                                             %184 = OpTypeArray %6 %101 
					                                             %185 = OpTypeStruct %7 %6 %184 
					                                             %186 = OpTypePointer Output %185 
					        Output struct {f32_4; f32; f32[1];}* %187 = OpVariable Output 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %12 = OpLoad %11 
					                                                      OpStore %9 %12 
					                                        f32_2 %18 = OpLoad %17 
					                                                      OpStore vs_TEXCOORD0 %18 
					                                  Output f32* %24 = OpAccessChain vs_TEXCOORD1 %22 
					                                                      OpStore %24 %20 
					                                        f32_4 %29 = OpLoad %27 
					                                        f32_3 %30 = OpVectorShuffle %29 %29 1 1 1 
					                               Uniform f32_4* %43 = OpAccessChain %38 %40 %41 
					                                        f32_4 %44 = OpLoad %43 
					                                        f32_3 %45 = OpVectorShuffle %44 %44 0 1 2 
					                                        f32_3 %46 = OpFMul %30 %45 
					                                        f32_4 %47 = OpLoad %26 
					                                        f32_4 %48 = OpVectorShuffle %47 %46 4 5 6 3 
					                                                      OpStore %26 %48 
					                               Uniform f32_4* %49 = OpAccessChain %38 %40 %40 
					                                        f32_4 %50 = OpLoad %49 
					                                        f32_3 %51 = OpVectorShuffle %50 %50 0 1 2 
					                                        f32_4 %52 = OpLoad %27 
					                                        f32_3 %53 = OpVectorShuffle %52 %52 0 0 0 
					                                        f32_3 %54 = OpFMul %51 %53 
					                                        f32_4 %55 = OpLoad %26 
					                                        f32_3 %56 = OpVectorShuffle %55 %55 0 1 2 
					                                        f32_3 %57 = OpFAdd %54 %56 
					                                        f32_4 %58 = OpLoad %26 
					                                        f32_4 %59 = OpVectorShuffle %58 %57 4 5 6 3 
					                                                      OpStore %26 %59 
					                               Uniform f32_4* %61 = OpAccessChain %38 %40 %60 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_3 %63 = OpVectorShuffle %62 %62 0 1 2 
					                                        f32_4 %64 = OpLoad %27 
					                                        f32_3 %65 = OpVectorShuffle %64 %64 2 2 2 
					                                        f32_3 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %26 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                        f32_3 %69 = OpFAdd %66 %68 
					                                        f32_4 %70 = OpLoad %26 
					                                        f32_4 %71 = OpVectorShuffle %70 %69 4 5 6 3 
					                                                      OpStore %26 %71 
					                                        f32_4 %72 = OpLoad %26 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
					                               Uniform f32_4* %75 = OpAccessChain %38 %40 %74 
					                                        f32_4 %76 = OpLoad %75 
					                                        f32_3 %77 = OpVectorShuffle %76 %76 0 1 2 
					                                        f32_3 %78 = OpFAdd %73 %77 
					                                        f32_4 %79 = OpLoad %26 
					                                        f32_4 %80 = OpVectorShuffle %79 %78 4 5 6 3 
					                                                      OpStore %26 %80 
					                                        f32_4 %81 = OpLoad %26 
					                                        f32_3 %82 = OpVectorShuffle %81 %81 0 1 2 
					                                        f32_4 %83 = OpLoad vs_TEXCOORD1 
					                                        f32_4 %84 = OpVectorShuffle %83 %82 4 5 6 3 
					                                                      OpStore vs_TEXCOORD1 %84 
					                                        f32_3 %88 = OpLoad %87 
					                               Uniform f32_4* %89 = OpAccessChain %38 %41 %40 
					                                        f32_4 %90 = OpLoad %89 
					                                        f32_3 %91 = OpVectorShuffle %90 %90 0 1 2 
					                                          f32 %92 = OpDot %88 %91 
					                                 Private f32* %95 = OpAccessChain %85 %93 
					                                                      OpStore %95 %92 
					                                        f32_3 %96 = OpLoad %87 
					                               Uniform f32_4* %97 = OpAccessChain %38 %41 %41 
					                                        f32_4 %98 = OpLoad %97 
					                                        f32_3 %99 = OpVectorShuffle %98 %98 0 1 2 
					                                         f32 %100 = OpDot %96 %99 
					                                Private f32* %102 = OpAccessChain %85 %101 
					                                                      OpStore %102 %100 
					                                       f32_3 %103 = OpLoad %87 
					                              Uniform f32_4* %104 = OpAccessChain %38 %41 %60 
					                                       f32_4 %105 = OpLoad %104 
					                                       f32_3 %106 = OpVectorShuffle %105 %105 0 1 2 
					                                         f32 %107 = OpDot %103 %106 
					                                Private f32* %108 = OpAccessChain %85 %34 
					                                                      OpStore %108 %107 
					                                       f32_4 %110 = OpLoad %85 
					                                       f32_3 %111 = OpVectorShuffle %110 %110 0 1 2 
					                                       f32_4 %112 = OpLoad %85 
					                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
					                                         f32 %114 = OpDot %111 %113 
					                                                      OpStore %109 %114 
					                                         f32 %115 = OpLoad %109 
					                                         f32 %117 = OpExtInst %1 40 %115 %116 
					                                                      OpStore %109 %117 
					                                         f32 %118 = OpLoad %109 
					                                         f32 %119 = OpExtInst %1 32 %118 
					                                                      OpStore %109 %119 
					                                         f32 %120 = OpLoad %109 
					                                       f32_3 %121 = OpCompositeConstruct %120 %120 %120 
					                                       f32_4 %122 = OpLoad %85 
					                                       f32_3 %123 = OpVectorShuffle %122 %122 0 1 2 
					                                       f32_3 %124 = OpFMul %121 %123 
					                                       f32_4 %125 = OpLoad %85 
					                                       f32_4 %126 = OpVectorShuffle %125 %124 4 5 6 3 
					                                                      OpStore %85 %126 
					                                       f32_4 %129 = OpLoad %85 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 0 1 2 
					                                                      OpStore vs_TEXCOORD2 %130 
					                                       f32_4 %131 = OpLoad %26 
					                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
					                                       f32_3 %133 = OpFNegate %132 
					                              Uniform f32_3* %139 = OpAccessChain %137 %40 
					                                       f32_3 %140 = OpLoad %139 
					                                       f32_3 %141 = OpFAdd %133 %140 
					                                       f32_4 %142 = OpLoad %85 
					                                       f32_4 %143 = OpVectorShuffle %142 %141 4 5 6 3 
					                                                      OpStore %85 %143 
					                                       f32_4 %144 = OpLoad %85 
					                                       f32_3 %145 = OpVectorShuffle %144 %144 0 1 2 
					                                       f32_4 %146 = OpLoad %85 
					                                       f32_3 %147 = OpVectorShuffle %146 %146 0 1 2 
					                                         f32 %148 = OpDot %145 %147 
					                                                      OpStore %109 %148 
					                                         f32 %149 = OpLoad %109 
					                                         f32 %150 = OpExtInst %1 40 %149 %116 
					                                                      OpStore %109 %150 
					                                         f32 %151 = OpLoad %109 
					                                         f32 %152 = OpExtInst %1 32 %151 
					                                                      OpStore %109 %152 
					                                         f32 %153 = OpLoad %109 
					                                       f32_3 %154 = OpCompositeConstruct %153 %153 %153 
					                                       f32_4 %155 = OpLoad %85 
					                                       f32_3 %156 = OpVectorShuffle %155 %155 0 1 2 
					                                       f32_3 %157 = OpFMul %154 %156 
					                                       f32_4 %158 = OpLoad %85 
					                                       f32_4 %159 = OpVectorShuffle %158 %157 4 5 6 3 
					                                                      OpStore %85 %159 
					                                       f32_4 %161 = OpLoad %85 
					                                       f32_3 %162 = OpVectorShuffle %161 %161 0 1 2 
					                                                      OpStore vs_TEXCOORD3 %162 
					                                                      OpStore vs_TEXCOORD8 %164 
					                                       f32_4 %165 = OpLoad %26 
					                                       f32_4 %166 = OpVectorShuffle %165 %165 1 1 1 1 
					                              Uniform f32_4* %167 = OpAccessChain %137 %41 %41 
					                                       f32_4 %168 = OpLoad %167 
					                                       f32_4 %169 = OpFMul %166 %168 
					                                                      OpStore %85 %169 
					                              Uniform f32_4* %170 = OpAccessChain %137 %41 %40 
					                                       f32_4 %171 = OpLoad %170 
					                                       f32_4 %172 = OpLoad %26 
					                                       f32_4 %173 = OpVectorShuffle %172 %172 0 0 0 0 
					                                       f32_4 %174 = OpFMul %171 %173 
					                                       f32_4 %175 = OpLoad %85 
					                                       f32_4 %176 = OpFAdd %174 %175 
					                                                      OpStore %85 %176 
					                              Uniform f32_4* %177 = OpAccessChain %137 %41 %60 
					                                       f32_4 %178 = OpLoad %177 
					                                       f32_4 %179 = OpLoad %26 
					                                       f32_4 %180 = OpVectorShuffle %179 %179 2 2 2 2 
					                                       f32_4 %181 = OpFMul %178 %180 
					                                       f32_4 %182 = OpLoad %85 
					                                       f32_4 %183 = OpFAdd %181 %182 
					                                                      OpStore %26 %183 
					                                       f32_4 %188 = OpLoad %26 
					                              Uniform f32_4* %189 = OpAccessChain %137 %41 %74 
					                                       f32_4 %190 = OpLoad %189 
					                                       f32_4 %191 = OpFAdd %188 %190 
					                               Output f32_4* %192 = OpAccessChain %187 %40 
					                                                      OpStore %192 %191 
					                                 Output f32* %193 = OpAccessChain %187 %40 %101 
					                                         f32 %194 = OpLoad %193 
					                                         f32 %195 = OpFNegate %194 
					                                 Output f32* %196 = OpAccessChain %187 %40 %101 
					                                                      OpStore %196 %195 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 88
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %22 %43 %74 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %12 RelaxedPrecision 
					                                                      OpDecorate %12 DescriptorSet 12 
					                                                      OpDecorate %12 Binding 12 
					                                                      OpDecorate %13 RelaxedPrecision 
					                                                      OpDecorate %16 RelaxedPrecision 
					                                                      OpDecorate %16 DescriptorSet 16 
					                                                      OpDecorate %16 Binding 16 
					                                                      OpDecorate %17 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 22 
					                                                      OpDecorate %25 RelaxedPrecision 
					                                                      OpDecorate %26 RelaxedPrecision 
					                                                      OpMemberDecorate %27 0 Offset 27 
					                                                      OpMemberDecorate %27 1 Offset 27 
					                                                      OpMemberDecorate %27 2 Offset 27 
					                                                      OpMemberDecorate %27 3 RelaxedPrecision 
					                                                      OpMemberDecorate %27 3 Offset 27 
					                                                      OpMemberDecorate %27 4 RelaxedPrecision 
					                                                      OpMemberDecorate %27 4 Offset 27 
					                                                      OpMemberDecorate %27 5 RelaxedPrecision 
					                                                      OpMemberDecorate %27 5 Offset 27 
					                                                      OpMemberDecorate %27 6 RelaxedPrecision 
					                                                      OpMemberDecorate %27 6 Offset 27 
					                                                      OpMemberDecorate %27 7 RelaxedPrecision 
					                                                      OpMemberDecorate %27 7 Offset 27 
					                                                      OpMemberDecorate %27 8 RelaxedPrecision 
					                                                      OpMemberDecorate %27 8 Offset 27 
					                                                      OpDecorate %27 Block 
					                                                      OpDecorate %29 DescriptorSet 29 
					                                                      OpDecorate %29 Binding 29 
					                                                      OpDecorate %34 RelaxedPrecision 
					                                                      OpDecorate %35 RelaxedPrecision 
					                                                      OpDecorate %37 RelaxedPrecision 
					                                                      OpDecorate %41 RelaxedPrecision 
					                                                      OpDecorate %43 RelaxedPrecision 
					                                                      OpDecorate %43 Location 43 
					                                                      OpDecorate %46 RelaxedPrecision 
					                                                      OpDecorate %47 RelaxedPrecision 
					                                                      OpDecorate %51 RelaxedPrecision 
					                                                      OpDecorate %52 RelaxedPrecision 
					                                                      OpDecorate %53 RelaxedPrecision 
					                                                      OpDecorate %54 RelaxedPrecision 
					                                                      OpDecorate %55 RelaxedPrecision 
					                                                      OpDecorate %56 RelaxedPrecision 
					                                                      OpDecorate %60 RelaxedPrecision 
					                                                      OpDecorate %74 RelaxedPrecision 
					                                                      OpDecorate %74 Location 74 
					                                                      OpDecorate %76 RelaxedPrecision 
					                                                      OpDecorate %77 RelaxedPrecision 
					                                                      OpDecorate %78 RelaxedPrecision 
					                                                      OpDecorate %79 RelaxedPrecision 
					                                                      OpDecorate %80 RelaxedPrecision 
					                                                      OpDecorate %84 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %11 = OpTypePointer UniformConstant %10 
					         UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                              %14 = OpTypeSampler 
					                                              %15 = OpTypePointer UniformConstant %14 
					                     UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                              %18 = OpTypeSampledImage %10 
					                                              %20 = OpTypeVector %6 2 
					                                              %21 = OpTypePointer Input %20 
					                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                               Private f32_4* %25 = OpVariable Private 
					                                              %27 = OpTypeStruct %7 %7 %7 %7 %7 %7 %6 %6 %6 
					                                              %28 = OpTypePointer Uniform %27 
					Uniform struct {f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32; f32; f32;}* %29 = OpVariable Uniform 
					                                              %30 = OpTypeInt 32 1 
					                                          i32 %31 = OpConstant 3 
					                                              %32 = OpTypePointer Uniform %7 
					                                              %36 = OpTypePointer Private %6 
					                                 Private f32* %37 = OpVariable Private 
					                                              %38 = OpTypeInt 32 0 
					                                          u32 %39 = OpConstant 3 
					                                              %42 = OpTypePointer Input %7 
					                                 Input f32_4* %43 = OpVariable Input 
					                                              %44 = OpTypePointer Input %6 
					                                          i32 %48 = OpConstant 6 
					                                              %49 = OpTypePointer Uniform %6 
					                                              %57 = OpTypeBool 
					                                              %58 = OpTypePointer Private %57 
					                                Private bool* %59 = OpVariable Private 
					                                          f32 %61 = OpConstant 3.674022E-40 
					                                          i32 %64 = OpConstant 0 
					                                          i32 %65 = OpConstant 1 
					                                          i32 %67 = OpConstant -1 
					                                              %73 = OpTypePointer Output %7 
					                                Output f32_4* %74 = OpVariable Output 
					                                              %75 = OpTypeVector %6 3 
					                                              %85 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                          read_only Texture2D %13 = OpLoad %12 
					                                      sampler %17 = OpLoad %16 
					                   read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                        f32_2 %23 = OpLoad vs_TEXCOORD0 
					                                        f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                                      OpStore %9 %24 
					                                        f32_4 %26 = OpLoad %9 
					                               Uniform f32_4* %33 = OpAccessChain %29 %31 
					                                        f32_4 %34 = OpLoad %33 
					                                        f32_4 %35 = OpFMul %26 %34 
					                                                      OpStore %25 %35 
					                                 Private f32* %40 = OpAccessChain %25 %39 
					                                          f32 %41 = OpLoad %40 
					                                   Input f32* %45 = OpAccessChain %43 %39 
					                                          f32 %46 = OpLoad %45 
					                                          f32 %47 = OpFMul %41 %46 
					                                 Uniform f32* %50 = OpAccessChain %29 %48 
					                                          f32 %51 = OpLoad %50 
					                                          f32 %52 = OpFNegate %51 
					                                          f32 %53 = OpFAdd %47 %52 
					                                                      OpStore %37 %53 
					                                        f32_4 %54 = OpLoad %25 
					                                        f32_4 %55 = OpLoad %43 
					                                        f32_4 %56 = OpFMul %54 %55 
					                                                      OpStore %25 %56 
					                                          f32 %60 = OpLoad %37 
					                                         bool %62 = OpFOrdLessThan %60 %61 
					                                                      OpStore %59 %62 
					                                         bool %63 = OpLoad %59 
					                                          i32 %66 = OpSelect %63 %65 %64 
					                                          i32 %68 = OpIMul %66 %67 
					                                         bool %69 = OpINotEqual %68 %64 
					                                                      OpSelectionMerge %71 None 
					                                                      OpBranchConditional %69 %70 %71 
					                                              %70 = OpLabel 
					                                                      OpKill
					                                              %71 = OpLabel 
					                                        f32_4 %76 = OpLoad %25 
					                                        f32_3 %77 = OpVectorShuffle %76 %76 3 3 3 
					                                        f32_4 %78 = OpLoad %25 
					                                        f32_3 %79 = OpVectorShuffle %78 %78 0 1 2 
					                                        f32_3 %80 = OpFMul %77 %79 
					                                        f32_4 %81 = OpLoad %74 
					                                        f32_4 %82 = OpVectorShuffle %81 %80 4 5 6 3 
					                                                      OpStore %74 %82 
					                                 Private f32* %83 = OpAccessChain %25 %39 
					                                          f32 %84 = OpLoad %83 
					                                  Output f32* %86 = OpAccessChain %74 %39 
					                                                      OpStore %86 %84 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "gles " {
					Keywords { "_EMISSION" "_FLIPBOOKBLENDING_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute mediump vec4 in_COLOR0;
					attribute highp vec4 in_TEXCOORD0;
					attribute highp float in_TEXCOORD1;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec3 vs_TEXCOORD5;
					varying highp vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD0.zw;
					    vs_TEXCOORD5.z = in_TEXCOORD1;
					    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BaseColor;
					uniform 	mediump vec4 _EmissionColor;
					uniform lowp sampler2D _BaseMap;
					uniform lowp sampler2D _EmissionMap;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec3 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec4 u_xlat10_2;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_EmissionMap, vs_TEXCOORD5.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_EmissionMap, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat10_0.xyz + (-u_xlat10_1.xyz);
					    u_xlat0.xyz = vs_TEXCOORD5.zzz * u_xlat16_0.xyz + u_xlat10_1.xyz;
					    u_xlat10_1 = texture2D(_BaseMap, vs_TEXCOORD5.xy);
					    u_xlat10_2 = texture2D(_BaseMap, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
					    u_xlat1 = vs_TEXCOORD5.zzzz * u_xlat16_1 + u_xlat10_2;
					    u_xlat16_1 = u_xlat1 * _BaseColor;
					    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
					    SV_Target0.xyz = u_xlat0.xyz * _EmissionColor.xyz + u_xlat16_1.xyz;
					    SV_Target0.w = u_xlat16_1.w;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "_EMISSION" "_FLIPBOOKBLENDING_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					UNITY_BINDING(1) uniform UnityPerDraw {
					#endif
						UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
						UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
						UNITY_UNIFORM vec4 unity_LODFade;
						UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
						UNITY_UNIFORM mediump vec4 unity_LightData;
						UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
						UNITY_UNIFORM vec4 unity_ProbesOcclusion;
						UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
						UNITY_UNIFORM vec4 unity_LightmapST;
						UNITY_UNIFORM vec4 unity_DynamicLightmapST;
						UNITY_UNIFORM mediump vec4 unity_SHAr;
						UNITY_UNIFORM mediump vec4 unity_SHAg;
						UNITY_UNIFORM mediump vec4 unity_SHAb;
						UNITY_UNIFORM mediump vec4 unity_SHBr;
						UNITY_UNIFORM mediump vec4 unity_SHBg;
						UNITY_UNIFORM mediump vec4 unity_SHBb;
						UNITY_UNIFORM mediump vec4 unity_SHC;
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					};
					#endif
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec4 in_TEXCOORD0;
					in highp float in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD5;
					out highp vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD0.zw;
					    vs_TEXCOORD5.z = in_TEXCOORD1;
					    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					UNITY_BINDING(0) uniform UnityPerMaterial {
					#endif
						UNITY_UNIFORM vec4 _SoftParticleFadeParams;
						UNITY_UNIFORM vec4 _CameraFadeParams;
						UNITY_UNIFORM vec4 _BaseMap_ST;
						UNITY_UNIFORM mediump vec4 _BaseColor;
						UNITY_UNIFORM mediump vec4 _EmissionColor;
						UNITY_UNIFORM mediump vec4 _BaseColorAddSubDiff;
						UNITY_UNIFORM mediump float _Cutoff;
						UNITY_UNIFORM mediump float _DistortionStrengthScaled;
						UNITY_UNIFORM mediump float _DistortionBlend;
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					};
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
					UNITY_LOCATION(1) uniform mediump sampler2D _EmissionMap;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec4 u_xlat16_2;
					void main()
					{
					    u_xlat16_0.xyz = texture(_EmissionMap, vs_TEXCOORD5.xy).xyz;
					    u_xlat16_1.xyz = texture(_EmissionMap, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
					    u_xlat0.xyz = vs_TEXCOORD5.zzz * u_xlat16_0.xyz + u_xlat16_1.xyz;
					    u_xlat16_1 = texture(_BaseMap, vs_TEXCOORD5.xy);
					    u_xlat16_2 = texture(_BaseMap, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat16_1 + (-u_xlat16_2);
					    u_xlat1 = vs_TEXCOORD5.zzzz * u_xlat16_1 + u_xlat16_2;
					    u_xlat16_1 = u_xlat1 * _BaseColor;
					    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
					    SV_Target0.xyz = u_xlat0.xyz * _EmissionColor.xyz + u_xlat16_1.xyz;
					    SV_Target0.w = u_xlat16_1.w;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					Keywords { "_EMISSION" "_FLIPBOOKBLENDING_ON" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 207
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %9 %11 %15 %16 %19 %27 %87 %128 %160 %163 %169 %172 %196 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
					                                                      OpName vs_TEXCOORD8 "vs_TEXCOORD8" 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %9 Location 9 
					                                                      OpDecorate %11 RelaxedPrecision 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %12 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 15 
					                                                      OpDecorate %16 Location 16 
					                                                      OpDecorate vs_TEXCOORD1 Location 19 
					                                                      OpDecorate %27 Location 27 
					                                                      OpDecorate %32 ArrayStride 32 
					                                                      OpDecorate %33 ArrayStride 33 
					                                                      OpDecorate %35 ArrayStride 35 
					                                                      OpMemberDecorate %36 0 Offset 36 
					                                                      OpMemberDecorate %36 1 Offset 36 
					                                                      OpMemberDecorate %36 2 Offset 36 
					                                                      OpMemberDecorate %36 3 RelaxedPrecision 
					                                                      OpMemberDecorate %36 3 Offset 36 
					                                                      OpMemberDecorate %36 4 RelaxedPrecision 
					                                                      OpMemberDecorate %36 4 Offset 36 
					                                                      OpMemberDecorate %36 5 RelaxedPrecision 
					                                                      OpMemberDecorate %36 5 Offset 36 
					                                                      OpMemberDecorate %36 6 Offset 36 
					                                                      OpMemberDecorate %36 7 RelaxedPrecision 
					                                                      OpMemberDecorate %36 7 Offset 36 
					                                                      OpMemberDecorate %36 8 Offset 36 
					                                                      OpMemberDecorate %36 9 Offset 36 
					                                                      OpMemberDecorate %36 10 RelaxedPrecision 
					                                                      OpMemberDecorate %36 10 Offset 36 
					                                                      OpMemberDecorate %36 11 RelaxedPrecision 
					                                                      OpMemberDecorate %36 11 Offset 36 
					                                                      OpMemberDecorate %36 12 RelaxedPrecision 
					                                                      OpMemberDecorate %36 12 Offset 36 
					                                                      OpMemberDecorate %36 13 RelaxedPrecision 
					                                                      OpMemberDecorate %36 13 Offset 36 
					                                                      OpMemberDecorate %36 14 RelaxedPrecision 
					                                                      OpMemberDecorate %36 14 Offset 36 
					                                                      OpMemberDecorate %36 15 RelaxedPrecision 
					                                                      OpMemberDecorate %36 15 Offset 36 
					                                                      OpMemberDecorate %36 16 RelaxedPrecision 
					                                                      OpMemberDecorate %36 16 Offset 36 
					                                                      OpDecorate %36 Block 
					                                                      OpDecorate %38 DescriptorSet 38 
					                                                      OpDecorate %38 Binding 38 
					                                                      OpDecorate %87 Location 87 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 128 
					                                                      OpDecorate %134 ArrayStride 134 
					                                                      OpMemberDecorate %135 0 Offset 135 
					                                                      OpMemberDecorate %135 1 Offset 135 
					                                                      OpDecorate %135 Block 
					                                                      OpDecorate %137 DescriptorSet 137 
					                                                      OpDecorate %137 Binding 137 
					                                                      OpDecorate vs_TEXCOORD3 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD3 Location 160 
					                                                      OpDecorate vs_TEXCOORD5 Location 163 
					                                                      OpDecorate %169 Location 169 
					                                                      OpDecorate vs_TEXCOORD8 Location 172 
					                                                      OpMemberDecorate %194 0 BuiltIn 194 
					                                                      OpMemberDecorate %194 1 BuiltIn 194 
					                                                      OpMemberDecorate %194 2 BuiltIn 194 
					                                                      OpDecorate %194 Block 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Output %7 
					                                 Output f32_4* %9 = OpVariable Output 
					                                              %10 = OpTypePointer Input %7 
					                                 Input f32_4* %11 = OpVariable Input 
					                                              %13 = OpTypeVector %6 2 
					                                              %14 = OpTypePointer Output %13 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                 Input f32_4* %16 = OpVariable Input 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                          f32 %20 = OpConstant 3.674022E-40 
					                                              %21 = OpTypeInt 32 0 
					                                          u32 %22 = OpConstant 3 
					                                              %23 = OpTypePointer Output %6 
					                                              %25 = OpTypePointer Private %7 
					                               Private f32_4* %26 = OpVariable Private 
					                                 Input f32_4* %27 = OpVariable Input 
					                                              %28 = OpTypeVector %6 3 
					                                          u32 %31 = OpConstant 4 
					                                              %32 = OpTypeArray %7 %31 
					                                              %33 = OpTypeArray %7 %31 
					                                          u32 %34 = OpConstant 2 
					                                              %35 = OpTypeArray %7 %34 
					                                              %36 = OpTypeStruct %32 %33 %7 %7 %7 %35 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
					                                              %37 = OpTypePointer Uniform %36 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %38 = OpVariable Uniform 
					                                              %39 = OpTypeInt 32 1 
					                                          i32 %40 = OpConstant 0 
					                                          i32 %41 = OpConstant 1 
					                                              %42 = OpTypePointer Uniform %7 
					                                          i32 %60 = OpConstant 2 
					                                          i32 %74 = OpConstant 3 
					                               Private f32_4* %85 = OpVariable Private 
					                                              %86 = OpTypePointer Input %28 
					                                 Input f32_3* %87 = OpVariable Input 
					                                          u32 %93 = OpConstant 0 
					                                              %94 = OpTypePointer Private %6 
					                                         u32 %101 = OpConstant 1 
					                                Private f32* %109 = OpVariable Private 
					                                         f32 %116 = OpConstant 3.674022E-40 
					                                             %127 = OpTypePointer Output %28 
					                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
					                                             %134 = OpTypeArray %7 %31 
					                                             %135 = OpTypeStruct %28 %134 
					                                             %136 = OpTypePointer Uniform %135 
					          Uniform struct {f32_3; f32_4[4];}* %137 = OpVariable Uniform 
					                                             %138 = OpTypePointer Uniform %28 
					                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
					                       Output f32_3* vs_TEXCOORD5 = OpVariable Output 
					                                             %168 = OpTypePointer Input %6 
					                                  Input f32* %169 = OpVariable Input 
					                       Output f32_3* vs_TEXCOORD8 = OpVariable Output 
					                                       f32_3 %173 = OpConstantComposite %20 %20 %20 
					                                             %193 = OpTypeArray %6 %101 
					                                             %194 = OpTypeStruct %7 %6 %193 
					                                             %195 = OpTypePointer Output %194 
					        Output struct {f32_4; f32; f32[1];}* %196 = OpVariable Output 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %12 = OpLoad %11 
					                                                      OpStore %9 %12 
					                                        f32_4 %17 = OpLoad %16 
					                                        f32_2 %18 = OpVectorShuffle %17 %17 0 1 
					                                                      OpStore vs_TEXCOORD0 %18 
					                                  Output f32* %24 = OpAccessChain vs_TEXCOORD1 %22 
					                                                      OpStore %24 %20 
					                                        f32_4 %29 = OpLoad %27 
					                                        f32_3 %30 = OpVectorShuffle %29 %29 1 1 1 
					                               Uniform f32_4* %43 = OpAccessChain %38 %40 %41 
					                                        f32_4 %44 = OpLoad %43 
					                                        f32_3 %45 = OpVectorShuffle %44 %44 0 1 2 
					                                        f32_3 %46 = OpFMul %30 %45 
					                                        f32_4 %47 = OpLoad %26 
					                                        f32_4 %48 = OpVectorShuffle %47 %46 4 5 6 3 
					                                                      OpStore %26 %48 
					                               Uniform f32_4* %49 = OpAccessChain %38 %40 %40 
					                                        f32_4 %50 = OpLoad %49 
					                                        f32_3 %51 = OpVectorShuffle %50 %50 0 1 2 
					                                        f32_4 %52 = OpLoad %27 
					                                        f32_3 %53 = OpVectorShuffle %52 %52 0 0 0 
					                                        f32_3 %54 = OpFMul %51 %53 
					                                        f32_4 %55 = OpLoad %26 
					                                        f32_3 %56 = OpVectorShuffle %55 %55 0 1 2 
					                                        f32_3 %57 = OpFAdd %54 %56 
					                                        f32_4 %58 = OpLoad %26 
					                                        f32_4 %59 = OpVectorShuffle %58 %57 4 5 6 3 
					                                                      OpStore %26 %59 
					                               Uniform f32_4* %61 = OpAccessChain %38 %40 %60 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_3 %63 = OpVectorShuffle %62 %62 0 1 2 
					                                        f32_4 %64 = OpLoad %27 
					                                        f32_3 %65 = OpVectorShuffle %64 %64 2 2 2 
					                                        f32_3 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %26 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                        f32_3 %69 = OpFAdd %66 %68 
					                                        f32_4 %70 = OpLoad %26 
					                                        f32_4 %71 = OpVectorShuffle %70 %69 4 5 6 3 
					                                                      OpStore %26 %71 
					                                        f32_4 %72 = OpLoad %26 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
					                               Uniform f32_4* %75 = OpAccessChain %38 %40 %74 
					                                        f32_4 %76 = OpLoad %75 
					                                        f32_3 %77 = OpVectorShuffle %76 %76 0 1 2 
					                                        f32_3 %78 = OpFAdd %73 %77 
					                                        f32_4 %79 = OpLoad %26 
					                                        f32_4 %80 = OpVectorShuffle %79 %78 4 5 6 3 
					                                                      OpStore %26 %80 
					                                        f32_4 %81 = OpLoad %26 
					                                        f32_3 %82 = OpVectorShuffle %81 %81 0 1 2 
					                                        f32_4 %83 = OpLoad vs_TEXCOORD1 
					                                        f32_4 %84 = OpVectorShuffle %83 %82 4 5 6 3 
					                                                      OpStore vs_TEXCOORD1 %84 
					                                        f32_3 %88 = OpLoad %87 
					                               Uniform f32_4* %89 = OpAccessChain %38 %41 %40 
					                                        f32_4 %90 = OpLoad %89 
					                                        f32_3 %91 = OpVectorShuffle %90 %90 0 1 2 
					                                          f32 %92 = OpDot %88 %91 
					                                 Private f32* %95 = OpAccessChain %85 %93 
					                                                      OpStore %95 %92 
					                                        f32_3 %96 = OpLoad %87 
					                               Uniform f32_4* %97 = OpAccessChain %38 %41 %41 
					                                        f32_4 %98 = OpLoad %97 
					                                        f32_3 %99 = OpVectorShuffle %98 %98 0 1 2 
					                                         f32 %100 = OpDot %96 %99 
					                                Private f32* %102 = OpAccessChain %85 %101 
					                                                      OpStore %102 %100 
					                                       f32_3 %103 = OpLoad %87 
					                              Uniform f32_4* %104 = OpAccessChain %38 %41 %60 
					                                       f32_4 %105 = OpLoad %104 
					                                       f32_3 %106 = OpVectorShuffle %105 %105 0 1 2 
					                                         f32 %107 = OpDot %103 %106 
					                                Private f32* %108 = OpAccessChain %85 %34 
					                                                      OpStore %108 %107 
					                                       f32_4 %110 = OpLoad %85 
					                                       f32_3 %111 = OpVectorShuffle %110 %110 0 1 2 
					                                       f32_4 %112 = OpLoad %85 
					                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
					                                         f32 %114 = OpDot %111 %113 
					                                                      OpStore %109 %114 
					                                         f32 %115 = OpLoad %109 
					                                         f32 %117 = OpExtInst %1 40 %115 %116 
					                                                      OpStore %109 %117 
					                                         f32 %118 = OpLoad %109 
					                                         f32 %119 = OpExtInst %1 32 %118 
					                                                      OpStore %109 %119 
					                                         f32 %120 = OpLoad %109 
					                                       f32_3 %121 = OpCompositeConstruct %120 %120 %120 
					                                       f32_4 %122 = OpLoad %85 
					                                       f32_3 %123 = OpVectorShuffle %122 %122 0 1 2 
					                                       f32_3 %124 = OpFMul %121 %123 
					                                       f32_4 %125 = OpLoad %85 
					                                       f32_4 %126 = OpVectorShuffle %125 %124 4 5 6 3 
					                                                      OpStore %85 %126 
					                                       f32_4 %129 = OpLoad %85 
					                                       f32_3 %130 = OpVectorShuffle %129 %129 0 1 2 
					                                                      OpStore vs_TEXCOORD2 %130 
					                                       f32_4 %131 = OpLoad %26 
					                                       f32_3 %132 = OpVectorShuffle %131 %131 0 1 2 
					                                       f32_3 %133 = OpFNegate %132 
					                              Uniform f32_3* %139 = OpAccessChain %137 %40 
					                                       f32_3 %140 = OpLoad %139 
					                                       f32_3 %141 = OpFAdd %133 %140 
					                                       f32_4 %142 = OpLoad %85 
					                                       f32_4 %143 = OpVectorShuffle %142 %141 4 5 6 3 
					                                                      OpStore %85 %143 
					                                       f32_4 %144 = OpLoad %85 
					                                       f32_3 %145 = OpVectorShuffle %144 %144 0 1 2 
					                                       f32_4 %146 = OpLoad %85 
					                                       f32_3 %147 = OpVectorShuffle %146 %146 0 1 2 
					                                         f32 %148 = OpDot %145 %147 
					                                                      OpStore %109 %148 
					                                         f32 %149 = OpLoad %109 
					                                         f32 %150 = OpExtInst %1 40 %149 %116 
					                                                      OpStore %109 %150 
					                                         f32 %151 = OpLoad %109 
					                                         f32 %152 = OpExtInst %1 32 %151 
					                                                      OpStore %109 %152 
					                                         f32 %153 = OpLoad %109 
					                                       f32_3 %154 = OpCompositeConstruct %153 %153 %153 
					                                       f32_4 %155 = OpLoad %85 
					                                       f32_3 %156 = OpVectorShuffle %155 %155 0 1 2 
					                                       f32_3 %157 = OpFMul %154 %156 
					                                       f32_4 %158 = OpLoad %85 
					                                       f32_4 %159 = OpVectorShuffle %158 %157 4 5 6 3 
					                                                      OpStore %85 %159 
					                                       f32_4 %161 = OpLoad %85 
					                                       f32_3 %162 = OpVectorShuffle %161 %161 0 1 2 
					                                                      OpStore vs_TEXCOORD3 %162 
					                                       f32_4 %164 = OpLoad %16 
					                                       f32_2 %165 = OpVectorShuffle %164 %164 2 3 
					                                       f32_3 %166 = OpLoad vs_TEXCOORD5 
					                                       f32_3 %167 = OpVectorShuffle %166 %165 3 4 2 
					                                                      OpStore vs_TEXCOORD5 %167 
					                                         f32 %170 = OpLoad %169 
					                                 Output f32* %171 = OpAccessChain vs_TEXCOORD5 %34 
					                                                      OpStore %171 %170 
					                                                      OpStore vs_TEXCOORD8 %173 
					                                       f32_4 %174 = OpLoad %26 
					                                       f32_4 %175 = OpVectorShuffle %174 %174 1 1 1 1 
					                              Uniform f32_4* %176 = OpAccessChain %137 %41 %41 
					                                       f32_4 %177 = OpLoad %176 
					                                       f32_4 %178 = OpFMul %175 %177 
					                                                      OpStore %85 %178 
					                              Uniform f32_4* %179 = OpAccessChain %137 %41 %40 
					                                       f32_4 %180 = OpLoad %179 
					                                       f32_4 %181 = OpLoad %26 
					                                       f32_4 %182 = OpVectorShuffle %181 %181 0 0 0 0 
					                                       f32_4 %183 = OpFMul %180 %182 
					                                       f32_4 %184 = OpLoad %85 
					                                       f32_4 %185 = OpFAdd %183 %184 
					                                                      OpStore %85 %185 
					                              Uniform f32_4* %186 = OpAccessChain %137 %41 %60 
					                                       f32_4 %187 = OpLoad %186 
					                                       f32_4 %188 = OpLoad %26 
					                                       f32_4 %189 = OpVectorShuffle %188 %188 2 2 2 2 
					                                       f32_4 %190 = OpFMul %187 %189 
					                                       f32_4 %191 = OpLoad %85 
					                                       f32_4 %192 = OpFAdd %190 %191 
					                                                      OpStore %26 %192 
					                                       f32_4 %197 = OpLoad %26 
					                              Uniform f32_4* %198 = OpAccessChain %137 %41 %74 
					                                       f32_4 %199 = OpLoad %198 
					                                       f32_4 %200 = OpFAdd %197 %199 
					                               Output f32_4* %201 = OpAccessChain %196 %40 
					                                                      OpStore %201 %200 
					                                 Output f32* %202 = OpAccessChain %196 %40 %101 
					                                         f32 %203 = OpLoad %202 
					                                         f32 %204 = OpFNegate %203 
					                                 Output f32* %205 = OpAccessChain %196 %40 %101 
					                                                      OpStore %205 %204 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 116
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %21 %34 %92 %96 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %12 RelaxedPrecision 
					                                                      OpDecorate %12 DescriptorSet 12 
					                                                      OpDecorate %12 Binding 12 
					                                                      OpDecorate %13 RelaxedPrecision 
					                                                      OpDecorate %16 RelaxedPrecision 
					                                                      OpDecorate %16 DescriptorSet 16 
					                                                      OpDecorate %16 Binding 16 
					                                                      OpDecorate %17 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD5 Location 21 
					                                                      OpDecorate %27 RelaxedPrecision 
					                                                      OpDecorate %29 RelaxedPrecision 
					                                                      OpDecorate %30 RelaxedPrecision 
					                                                      OpDecorate %31 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 34 
					                                                      OpDecorate %37 RelaxedPrecision 
					                                                      OpDecorate %40 RelaxedPrecision 
					                                                      OpDecorate %41 RelaxedPrecision 
					                                                      OpDecorate %42 RelaxedPrecision 
					                                                      OpDecorate %43 RelaxedPrecision 
					                                                      OpDecorate %44 RelaxedPrecision 
					                                                      OpDecorate %45 RelaxedPrecision 
					                                                      OpDecorate %49 RelaxedPrecision 
					                                                      OpDecorate %51 RelaxedPrecision 
					                                                      OpDecorate %52 RelaxedPrecision 
					                                                      OpDecorate %54 RelaxedPrecision 
					                                                      OpDecorate %54 DescriptorSet 54 
					                                                      OpDecorate %54 Binding 54 
					                                                      OpDecorate %55 RelaxedPrecision 
					                                                      OpDecorate %56 RelaxedPrecision 
					                                                      OpDecorate %56 DescriptorSet 56 
					                                                      OpDecorate %56 Binding 56 
					                                                      OpDecorate %57 RelaxedPrecision 
					                                                      OpDecorate %62 RelaxedPrecision 
					                                                      OpDecorate %63 RelaxedPrecision 
					                                                      OpDecorate %64 RelaxedPrecision 
					                                                      OpDecorate %68 RelaxedPrecision 
					                                                      OpDecorate %69 RelaxedPrecision 
					                                                      OpDecorate %70 RelaxedPrecision 
					                                                      OpDecorate %71 RelaxedPrecision 
					                                                      OpDecorate %72 RelaxedPrecision 
					                                                      OpDecorate %76 RelaxedPrecision 
					                                                      OpDecorate %78 RelaxedPrecision 
					                                                      OpMemberDecorate %81 0 Offset 81 
					                                                      OpMemberDecorate %81 1 Offset 81 
					                                                      OpMemberDecorate %81 2 Offset 81 
					                                                      OpMemberDecorate %81 3 RelaxedPrecision 
					                                                      OpMemberDecorate %81 3 Offset 81 
					                                                      OpMemberDecorate %81 4 RelaxedPrecision 
					                                                      OpMemberDecorate %81 4 Offset 81 
					                                                      OpMemberDecorate %81 5 RelaxedPrecision 
					                                                      OpMemberDecorate %81 5 Offset 81 
					                                                      OpMemberDecorate %81 6 RelaxedPrecision 
					                                                      OpMemberDecorate %81 6 Offset 81 
					                                                      OpMemberDecorate %81 7 RelaxedPrecision 
					                                                      OpMemberDecorate %81 7 Offset 81 
					                                                      OpMemberDecorate %81 8 RelaxedPrecision 
					                                                      OpMemberDecorate %81 8 Offset 81 
					                                                      OpDecorate %81 Block 
					                                                      OpDecorate %83 DescriptorSet 83 
					                                                      OpDecorate %83 Binding 83 
					                                                      OpDecorate %88 RelaxedPrecision 
					                                                      OpDecorate %90 RelaxedPrecision 
					                                                      OpDecorate %92 RelaxedPrecision 
					                                                      OpDecorate %92 Location 92 
					                                                      OpDecorate %93 RelaxedPrecision 
					                                                      OpDecorate %94 RelaxedPrecision 
					                                                      OpDecorate %96 RelaxedPrecision 
					                                                      OpDecorate %96 Location 96 
					                                                      OpDecorate %100 RelaxedPrecision 
					                                                      OpDecorate %101 RelaxedPrecision 
					                                                      OpDecorate %103 RelaxedPrecision 
					                                                      OpDecorate %104 RelaxedPrecision 
					                                                      OpDecorate %112 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 3 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_3* %9 = OpVariable Private 
					                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %11 = OpTypePointer UniformConstant %10 
					         UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                              %14 = OpTypeSampler 
					                                              %15 = OpTypePointer UniformConstant %14 
					                     UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                              %18 = OpTypeSampledImage %10 
					                                              %20 = OpTypePointer Input %7 
					                        Input f32_3* vs_TEXCOORD5 = OpVariable Input 
					                                              %22 = OpTypeVector %6 2 
					                                              %25 = OpTypeVector %6 4 
					                                              %28 = OpTypePointer Private %25 
					                               Private f32_4* %29 = OpVariable Private 
					                                              %33 = OpTypePointer Input %22 
					                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                               Private f32_3* %40 = OpVariable Private 
					                               Private f32_3* %46 = OpVariable Private 
					         UniformConstant read_only Texture2D* %54 = OpVariable UniformConstant 
					                     UniformConstant sampler* %56 = OpVariable UniformConstant 
					                               Private f32_4* %62 = OpVariable Private 
					                               Private f32_4* %68 = OpVariable Private 
					                               Private f32_4* %73 = OpVariable Private 
					                                              %81 = OpTypeStruct %25 %25 %25 %25 %25 %25 %6 %6 %6 
					                                              %82 = OpTypePointer Uniform %81 
					Uniform struct {f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32; f32; f32;}* %83 = OpVariable Uniform 
					                                              %84 = OpTypeInt 32 1 
					                                          i32 %85 = OpConstant 3 
					                                              %86 = OpTypePointer Uniform %25 
					                                              %91 = OpTypePointer Input %25 
					                                 Input f32_4* %92 = OpVariable Input 
					                                              %95 = OpTypePointer Output %25 
					                                Output f32_4* %96 = OpVariable Output 
					                                          i32 %98 = OpConstant 4 
					                                             %108 = OpTypeInt 32 0 
					                                         u32 %109 = OpConstant 3 
					                                             %110 = OpTypePointer Private %6 
					                                             %113 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                          read_only Texture2D %13 = OpLoad %12 
					                                      sampler %17 = OpLoad %16 
					                   read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                        f32_3 %23 = OpLoad vs_TEXCOORD5 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 1 
					                                        f32_4 %26 = OpImageSampleImplicitLod %19 %24 
					                                        f32_3 %27 = OpVectorShuffle %26 %26 0 1 2 
					                                                      OpStore %9 %27 
					                          read_only Texture2D %30 = OpLoad %12 
					                                      sampler %31 = OpLoad %16 
					                   read_only Texture2DSampled %32 = OpSampledImage %30 %31 
					                                        f32_2 %35 = OpLoad vs_TEXCOORD0 
					                                        f32_4 %36 = OpImageSampleImplicitLod %32 %35 
					                                        f32_3 %37 = OpVectorShuffle %36 %36 0 1 2 
					                                        f32_4 %38 = OpLoad %29 
					                                        f32_4 %39 = OpVectorShuffle %38 %37 4 5 6 3 
					                                                      OpStore %29 %39 
					                                        f32_3 %41 = OpLoad %9 
					                                        f32_4 %42 = OpLoad %29 
					                                        f32_3 %43 = OpVectorShuffle %42 %42 0 1 2 
					                                        f32_3 %44 = OpFNegate %43 
					                                        f32_3 %45 = OpFAdd %41 %44 
					                                                      OpStore %40 %45 
					                                        f32_3 %47 = OpLoad vs_TEXCOORD5 
					                                        f32_3 %48 = OpVectorShuffle %47 %47 2 2 2 
					                                        f32_3 %49 = OpLoad %40 
					                                        f32_3 %50 = OpFMul %48 %49 
					                                        f32_4 %51 = OpLoad %29 
					                                        f32_3 %52 = OpVectorShuffle %51 %51 0 1 2 
					                                        f32_3 %53 = OpFAdd %50 %52 
					                                                      OpStore %46 %53 
					                          read_only Texture2D %55 = OpLoad %54 
					                                      sampler %57 = OpLoad %56 
					                   read_only Texture2DSampled %58 = OpSampledImage %55 %57 
					                                        f32_3 %59 = OpLoad vs_TEXCOORD5 
					                                        f32_2 %60 = OpVectorShuffle %59 %59 0 1 
					                                        f32_4 %61 = OpImageSampleImplicitLod %58 %60 
					                                                      OpStore %29 %61 
					                          read_only Texture2D %63 = OpLoad %54 
					                                      sampler %64 = OpLoad %56 
					                   read_only Texture2DSampled %65 = OpSampledImage %63 %64 
					                                        f32_2 %66 = OpLoad vs_TEXCOORD0 
					                                        f32_4 %67 = OpImageSampleImplicitLod %65 %66 
					                                                      OpStore %62 %67 
					                                        f32_4 %69 = OpLoad %29 
					                                        f32_4 %70 = OpLoad %62 
					                                        f32_4 %71 = OpFNegate %70 
					                                        f32_4 %72 = OpFAdd %69 %71 
					                                                      OpStore %68 %72 
					                                        f32_3 %74 = OpLoad vs_TEXCOORD5 
					                                        f32_4 %75 = OpVectorShuffle %74 %74 2 2 2 2 
					                                        f32_4 %76 = OpLoad %68 
					                                        f32_4 %77 = OpFMul %75 %76 
					                                        f32_4 %78 = OpLoad %62 
					                                        f32_4 %79 = OpFAdd %77 %78 
					                                                      OpStore %73 %79 
					                                        f32_4 %80 = OpLoad %73 
					                               Uniform f32_4* %87 = OpAccessChain %83 %85 
					                                        f32_4 %88 = OpLoad %87 
					                                        f32_4 %89 = OpFMul %80 %88 
					                                                      OpStore %68 %89 
					                                        f32_4 %90 = OpLoad %68 
					                                        f32_4 %93 = OpLoad %92 
					                                        f32_4 %94 = OpFMul %90 %93 
					                                                      OpStore %68 %94 
					                                        f32_3 %97 = OpLoad %46 
					                               Uniform f32_4* %99 = OpAccessChain %83 %98 
					                                       f32_4 %100 = OpLoad %99 
					                                       f32_3 %101 = OpVectorShuffle %100 %100 0 1 2 
					                                       f32_3 %102 = OpFMul %97 %101 
					                                       f32_4 %103 = OpLoad %68 
					                                       f32_3 %104 = OpVectorShuffle %103 %103 0 1 2 
					                                       f32_3 %105 = OpFAdd %102 %104 
					                                       f32_4 %106 = OpLoad %96 
					                                       f32_4 %107 = OpVectorShuffle %106 %105 4 5 6 3 
					                                                      OpStore %96 %107 
					                                Private f32* %111 = OpAccessChain %68 %109 
					                                         f32 %112 = OpLoad %111 
					                                 Output f32* %114 = OpAccessChain %96 %109 
					                                                      OpStore %114 %112 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "gles " {
					Keywords { "_ALPHAMODULATE_ON" "_NORMALMAP" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	mediump vec4 unity_WorldTransformParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute mediump vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					attribute highp vec4 in_TANGENT0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec4 vs_TEXCOORD2;
					varying mediump vec4 vs_TEXCOORD3;
					varying mediump vec4 vs_TEXCOORD4;
					varying highp vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					float u_xlat18;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = max(u_xlat18, 1.17549435e-38);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = max(u_xlat18, 1.17549435e-38);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyw = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat1.w = u_xlat2.x;
					    vs_TEXCOORD2 = u_xlat1;
					    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
					    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
					    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
					    u_xlat16_4.x = dot(u_xlat3.xyz, in_TANGENT0.xyz);
					    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
					    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
					    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
					    u_xlat16_4.y = dot(u_xlat3.xyz, in_TANGENT0.xyz);
					    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
					    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
					    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
					    u_xlat16_4.z = dot(u_xlat3.xyz, in_TANGENT0.xyz);
					    u_xlat18 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
					    u_xlat18 = max(u_xlat18, 1.17549435e-38);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat16_4.xyz;
					    u_xlat3.w = u_xlat2.y;
					    vs_TEXCOORD3 = u_xlat3;
					    u_xlat5.xyz = u_xlat1.zxy * u_xlat3.yzx;
					    u_xlat1.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat5.xyz);
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD4 = u_xlat2;
					    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BaseColor;
					uniform lowp sampler2D _BaseMap;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					#define SV_Target0 gl_FragData[0]
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_2;
					void main()
					{
					    u_xlat10_0 = texture2D(_BaseMap, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat10_0 * _BaseColor;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat16_2 = u_xlat16_0.w * vs_COLOR0.w;
					    SV_Target0.xyz = vec3(u_xlat16_2) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
					    SV_Target0.w = u_xlat16_2;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "_ALPHAMODULATE_ON" "_NORMALMAP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					UNITY_BINDING(1) uniform UnityPerDraw {
					#endif
						UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
						UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
						UNITY_UNIFORM vec4 unity_LODFade;
						UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
						UNITY_UNIFORM mediump vec4 unity_LightData;
						UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
						UNITY_UNIFORM vec4 unity_ProbesOcclusion;
						UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
						UNITY_UNIFORM vec4 unity_LightmapST;
						UNITY_UNIFORM vec4 unity_DynamicLightmapST;
						UNITY_UNIFORM mediump vec4 unity_SHAr;
						UNITY_UNIFORM mediump vec4 unity_SHAg;
						UNITY_UNIFORM mediump vec4 unity_SHAb;
						UNITY_UNIFORM mediump vec4 unity_SHBr;
						UNITY_UNIFORM mediump vec4 unity_SHBg;
						UNITY_UNIFORM mediump vec4 unity_SHBb;
						UNITY_UNIFORM mediump vec4 unity_SHC;
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					};
					#endif
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_TANGENT0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out mediump vec4 vs_TEXCOORD2;
					out mediump vec4 vs_TEXCOORD3;
					out mediump vec4 vs_TEXCOORD4;
					out highp vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat5;
					float u_xlat18;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.w = 0.0;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = max(u_xlat18, 1.17549435e-38);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = max(u_xlat18, 1.17549435e-38);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyw = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat1.w = u_xlat2.x;
					    vs_TEXCOORD2 = u_xlat1;
					    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
					    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
					    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
					    u_xlat16_4.x = dot(u_xlat3.xyz, in_TANGENT0.xyz);
					    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
					    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
					    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
					    u_xlat16_4.y = dot(u_xlat3.xyz, in_TANGENT0.xyz);
					    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
					    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
					    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
					    u_xlat16_4.z = dot(u_xlat3.xyz, in_TANGENT0.xyz);
					    u_xlat18 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
					    u_xlat18 = max(u_xlat18, 1.17549435e-38);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat16_4.xyz;
					    u_xlat3.w = u_xlat2.y;
					    vs_TEXCOORD3 = u_xlat3;
					    u_xlat5.xyz = u_xlat1.zxy * u_xlat3.yzx;
					    u_xlat1.xyz = u_xlat1.yzx * u_xlat3.zxy + (-u_xlat5.xyz);
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD4 = u_xlat2;
					    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					UNITY_BINDING(0) uniform UnityPerMaterial {
					#endif
						UNITY_UNIFORM vec4 _SoftParticleFadeParams;
						UNITY_UNIFORM vec4 _CameraFadeParams;
						UNITY_UNIFORM vec4 _BaseMap_ST;
						UNITY_UNIFORM mediump vec4 _BaseColor;
						UNITY_UNIFORM mediump vec4 _EmissionColor;
						UNITY_UNIFORM mediump vec4 _BaseColorAddSubDiff;
						UNITY_UNIFORM mediump float _Cutoff;
						UNITY_UNIFORM mediump float _DistortionStrengthScaled;
						UNITY_UNIFORM mediump float _DistortionBlend;
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					};
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_2;
					void main()
					{
					    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat16_0 * _BaseColor;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat16_2 = u_xlat16_0.w * vs_COLOR0.w;
					    SV_Target0.xyz = vec3(u_xlat16_2) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
					    SV_Target0.w = u_xlat16_2;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					Keywords { "_ALPHAMODULATE_ON" "_NORMALMAP" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 297
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %9 %11 %15 %17 %19 %27 %87 %160 %177 %228 %259 %262 %286 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                                      OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
					                                                      OpName vs_TEXCOORD8 "vs_TEXCOORD8" 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %9 Location 9 
					                                                      OpDecorate %11 RelaxedPrecision 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %12 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 15 
					                                                      OpDecorate %17 Location 17 
					                                                      OpDecorate vs_TEXCOORD1 Location 19 
					                                                      OpDecorate %27 Location 27 
					                                                      OpDecorate %32 ArrayStride 32 
					                                                      OpDecorate %33 ArrayStride 33 
					                                                      OpDecorate %35 ArrayStride 35 
					                                                      OpMemberDecorate %36 0 Offset 36 
					                                                      OpMemberDecorate %36 1 Offset 36 
					                                                      OpMemberDecorate %36 2 Offset 36 
					                                                      OpMemberDecorate %36 3 RelaxedPrecision 
					                                                      OpMemberDecorate %36 3 Offset 36 
					                                                      OpMemberDecorate %36 4 RelaxedPrecision 
					                                                      OpMemberDecorate %36 4 Offset 36 
					                                                      OpMemberDecorate %36 5 RelaxedPrecision 
					                                                      OpMemberDecorate %36 5 Offset 36 
					                                                      OpMemberDecorate %36 6 Offset 36 
					                                                      OpMemberDecorate %36 7 RelaxedPrecision 
					                                                      OpMemberDecorate %36 7 Offset 36 
					                                                      OpMemberDecorate %36 8 Offset 36 
					                                                      OpMemberDecorate %36 9 Offset 36 
					                                                      OpMemberDecorate %36 10 RelaxedPrecision 
					                                                      OpMemberDecorate %36 10 Offset 36 
					                                                      OpMemberDecorate %36 11 RelaxedPrecision 
					                                                      OpMemberDecorate %36 11 Offset 36 
					                                                      OpMemberDecorate %36 12 RelaxedPrecision 
					                                                      OpMemberDecorate %36 12 Offset 36 
					                                                      OpMemberDecorate %36 13 RelaxedPrecision 
					                                                      OpMemberDecorate %36 13 Offset 36 
					                                                      OpMemberDecorate %36 14 RelaxedPrecision 
					                                                      OpMemberDecorate %36 14 Offset 36 
					                                                      OpMemberDecorate %36 15 RelaxedPrecision 
					                                                      OpMemberDecorate %36 15 Offset 36 
					                                                      OpMemberDecorate %36 16 RelaxedPrecision 
					                                                      OpMemberDecorate %36 16 Offset 36 
					                                                      OpDecorate %36 Block 
					                                                      OpDecorate %38 DescriptorSet 38 
					                                                      OpDecorate %38 Binding 38 
					                                                      OpDecorate %87 Location 87 
					                                                      OpDecorate %131 ArrayStride 131 
					                                                      OpMemberDecorate %132 0 Offset 132 
					                                                      OpMemberDecorate %132 1 Offset 132 
					                                                      OpDecorate %132 Block 
					                                                      OpDecorate %134 DescriptorSet 134 
					                                                      OpDecorate %134 Binding 134 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 160 
					                                                      OpDecorate %174 RelaxedPrecision 
					                                                      OpDecorate %177 Location 177 
					                                                      OpDecorate %212 RelaxedPrecision 
					                                                      OpDecorate %213 RelaxedPrecision 
					                                                      OpDecorate %214 RelaxedPrecision 
					                                                      OpDecorate %220 RelaxedPrecision 
					                                                      OpDecorate %221 RelaxedPrecision 
					                                                      OpDecorate %222 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD3 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD3 Location 228 
					                                                      OpDecorate %250 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD4 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD4 Location 259 
					                                                      OpDecorate vs_TEXCOORD8 Location 262 
					                                                      OpMemberDecorate %284 0 BuiltIn 284 
					                                                      OpMemberDecorate %284 1 BuiltIn 284 
					                                                      OpMemberDecorate %284 2 BuiltIn 284 
					                                                      OpDecorate %284 Block 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Output %7 
					                                 Output f32_4* %9 = OpVariable Output 
					                                              %10 = OpTypePointer Input %7 
					                                 Input f32_4* %11 = OpVariable Input 
					                                              %13 = OpTypeVector %6 2 
					                                              %14 = OpTypePointer Output %13 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                              %16 = OpTypePointer Input %13 
					                                 Input f32_2* %17 = OpVariable Input 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                          f32 %20 = OpConstant 3.674022E-40 
					                                              %21 = OpTypeInt 32 0 
					                                          u32 %22 = OpConstant 3 
					                                              %23 = OpTypePointer Output %6 
					                                              %25 = OpTypePointer Private %7 
					                               Private f32_4* %26 = OpVariable Private 
					                                 Input f32_4* %27 = OpVariable Input 
					                                              %28 = OpTypeVector %6 3 
					                                          u32 %31 = OpConstant 4 
					                                              %32 = OpTypeArray %7 %31 
					                                              %33 = OpTypeArray %7 %31 
					                                          u32 %34 = OpConstant 2 
					                                              %35 = OpTypeArray %7 %34 
					                                              %36 = OpTypeStruct %32 %33 %7 %7 %7 %35 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
					                                              %37 = OpTypePointer Uniform %36 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %38 = OpVariable Uniform 
					                                              %39 = OpTypeInt 32 1 
					                                          i32 %40 = OpConstant 0 
					                                          i32 %41 = OpConstant 1 
					                                              %42 = OpTypePointer Uniform %7 
					                                          i32 %60 = OpConstant 2 
					                                          i32 %74 = OpConstant 3 
					                               Private f32_4* %85 = OpVariable Private 
					                                              %86 = OpTypePointer Input %28 
					                                 Input f32_3* %87 = OpVariable Input 
					                                          u32 %93 = OpConstant 0 
					                                              %94 = OpTypePointer Private %6 
					                                         u32 %101 = OpConstant 1 
					                                Private f32* %109 = OpVariable Private 
					                                         f32 %116 = OpConstant 3.674022E-40 
					                              Private f32_4* %127 = OpVariable Private 
					                                             %131 = OpTypeArray %7 %31 
					                                             %132 = OpTypeStruct %28 %131 
					                                             %133 = OpTypePointer Uniform %132 
					          Uniform struct {f32_3; f32_4[4];}* %134 = OpVariable Uniform 
					                                             %135 = OpTypePointer Uniform %28 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                              Private f32_4* %162 = OpVariable Private 
					                                             %163 = OpTypePointer Uniform %6 
					                                             %173 = OpTypePointer Private %28 
					                              Private f32_3* %174 = OpVariable Private 
					                                Input f32_4* %177 = OpVariable Input 
					                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
					                              Private f32_3* %230 = OpVariable Private 
					                                             %246 = OpTypePointer Input %6 
					                       Output f32_4* vs_TEXCOORD4 = OpVariable Output 
					                                             %261 = OpTypePointer Output %28 
					                       Output f32_3* vs_TEXCOORD8 = OpVariable Output 
					                                       f32_3 %263 = OpConstantComposite %20 %20 %20 
					                                             %283 = OpTypeArray %6 %101 
					                                             %284 = OpTypeStruct %7 %6 %283 
					                                             %285 = OpTypePointer Output %284 
					        Output struct {f32_4; f32; f32[1];}* %286 = OpVariable Output 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %12 = OpLoad %11 
					                                                      OpStore %9 %12 
					                                        f32_2 %18 = OpLoad %17 
					                                                      OpStore vs_TEXCOORD0 %18 
					                                  Output f32* %24 = OpAccessChain vs_TEXCOORD1 %22 
					                                                      OpStore %24 %20 
					                                        f32_4 %29 = OpLoad %27 
					                                        f32_3 %30 = OpVectorShuffle %29 %29 1 1 1 
					                               Uniform f32_4* %43 = OpAccessChain %38 %40 %41 
					                                        f32_4 %44 = OpLoad %43 
					                                        f32_3 %45 = OpVectorShuffle %44 %44 0 1 2 
					                                        f32_3 %46 = OpFMul %30 %45 
					                                        f32_4 %47 = OpLoad %26 
					                                        f32_4 %48 = OpVectorShuffle %47 %46 4 5 6 3 
					                                                      OpStore %26 %48 
					                               Uniform f32_4* %49 = OpAccessChain %38 %40 %40 
					                                        f32_4 %50 = OpLoad %49 
					                                        f32_3 %51 = OpVectorShuffle %50 %50 0 1 2 
					                                        f32_4 %52 = OpLoad %27 
					                                        f32_3 %53 = OpVectorShuffle %52 %52 0 0 0 
					                                        f32_3 %54 = OpFMul %51 %53 
					                                        f32_4 %55 = OpLoad %26 
					                                        f32_3 %56 = OpVectorShuffle %55 %55 0 1 2 
					                                        f32_3 %57 = OpFAdd %54 %56 
					                                        f32_4 %58 = OpLoad %26 
					                                        f32_4 %59 = OpVectorShuffle %58 %57 4 5 6 3 
					                                                      OpStore %26 %59 
					                               Uniform f32_4* %61 = OpAccessChain %38 %40 %60 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_3 %63 = OpVectorShuffle %62 %62 0 1 2 
					                                        f32_4 %64 = OpLoad %27 
					                                        f32_3 %65 = OpVectorShuffle %64 %64 2 2 2 
					                                        f32_3 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %26 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                                        f32_3 %69 = OpFAdd %66 %68 
					                                        f32_4 %70 = OpLoad %26 
					                                        f32_4 %71 = OpVectorShuffle %70 %69 4 5 6 3 
					                                                      OpStore %26 %71 
					                                        f32_4 %72 = OpLoad %26 
					                                        f32_3 %73 = OpVectorShuffle %72 %72 0 1 2 
					                               Uniform f32_4* %75 = OpAccessChain %38 %40 %74 
					                                        f32_4 %76 = OpLoad %75 
					                                        f32_3 %77 = OpVectorShuffle %76 %76 0 1 2 
					                                        f32_3 %78 = OpFAdd %73 %77 
					                                        f32_4 %79 = OpLoad %26 
					                                        f32_4 %80 = OpVectorShuffle %79 %78 4 5 6 3 
					                                                      OpStore %26 %80 
					                                        f32_4 %81 = OpLoad %26 
					                                        f32_3 %82 = OpVectorShuffle %81 %81 0 1 2 
					                                        f32_4 %83 = OpLoad vs_TEXCOORD1 
					                                        f32_4 %84 = OpVectorShuffle %83 %82 4 5 6 3 
					                                                      OpStore vs_TEXCOORD1 %84 
					                                        f32_3 %88 = OpLoad %87 
					                               Uniform f32_4* %89 = OpAccessChain %38 %41 %40 
					                                        f32_4 %90 = OpLoad %89 
					                                        f32_3 %91 = OpVectorShuffle %90 %90 0 1 2 
					                                          f32 %92 = OpDot %88 %91 
					                                 Private f32* %95 = OpAccessChain %85 %93 
					                                                      OpStore %95 %92 
					                                        f32_3 %96 = OpLoad %87 
					                               Uniform f32_4* %97 = OpAccessChain %38 %41 %41 
					                                        f32_4 %98 = OpLoad %97 
					                                        f32_3 %99 = OpVectorShuffle %98 %98 0 1 2 
					                                         f32 %100 = OpDot %96 %99 
					                                Private f32* %102 = OpAccessChain %85 %101 
					                                                      OpStore %102 %100 
					                                       f32_3 %103 = OpLoad %87 
					                              Uniform f32_4* %104 = OpAccessChain %38 %41 %60 
					                                       f32_4 %105 = OpLoad %104 
					                                       f32_3 %106 = OpVectorShuffle %105 %105 0 1 2 
					                                         f32 %107 = OpDot %103 %106 
					                                Private f32* %108 = OpAccessChain %85 %34 
					                                                      OpStore %108 %107 
					                                       f32_4 %110 = OpLoad %85 
					                                       f32_3 %111 = OpVectorShuffle %110 %110 0 1 2 
					                                       f32_4 %112 = OpLoad %85 
					                                       f32_3 %113 = OpVectorShuffle %112 %112 0 1 2 
					                                         f32 %114 = OpDot %111 %113 
					                                                      OpStore %109 %114 
					                                         f32 %115 = OpLoad %109 
					                                         f32 %117 = OpExtInst %1 40 %115 %116 
					                                                      OpStore %109 %117 
					                                         f32 %118 = OpLoad %109 
					                                         f32 %119 = OpExtInst %1 32 %118 
					                                                      OpStore %109 %119 
					                                         f32 %120 = OpLoad %109 
					                                       f32_3 %121 = OpCompositeConstruct %120 %120 %120 
					                                       f32_4 %122 = OpLoad %85 
					                                       f32_3 %123 = OpVectorShuffle %122 %122 0 1 2 
					                                       f32_3 %124 = OpFMul %121 %123 
					                                       f32_4 %125 = OpLoad %85 
					                                       f32_4 %126 = OpVectorShuffle %125 %124 4 5 6 3 
					                                                      OpStore %85 %126 
					                                       f32_4 %128 = OpLoad %26 
					                                       f32_3 %129 = OpVectorShuffle %128 %128 0 1 2 
					                                       f32_3 %130 = OpFNegate %129 
					                              Uniform f32_3* %136 = OpAccessChain %134 %40 
					                                       f32_3 %137 = OpLoad %136 
					                                       f32_3 %138 = OpFAdd %130 %137 
					                                       f32_4 %139 = OpLoad %127 
					                                       f32_4 %140 = OpVectorShuffle %139 %138 4 5 6 3 
					                                                      OpStore %127 %140 
					                                       f32_4 %141 = OpLoad %127 
					                                       f32_3 %142 = OpVectorShuffle %141 %141 0 1 2 
					                                       f32_4 %143 = OpLoad %127 
					                                       f32_3 %144 = OpVectorShuffle %143 %143 0 1 2 
					                                         f32 %145 = OpDot %142 %144 
					                                                      OpStore %109 %145 
					                                         f32 %146 = OpLoad %109 
					                                         f32 %147 = OpExtInst %1 40 %146 %116 
					                                                      OpStore %109 %147 
					                                         f32 %148 = OpLoad %109 
					                                         f32 %149 = OpExtInst %1 32 %148 
					                                                      OpStore %109 %149 
					                                         f32 %150 = OpLoad %109 
					                                       f32_3 %151 = OpCompositeConstruct %150 %150 %150 
					                                       f32_4 %152 = OpLoad %127 
					                                       f32_3 %153 = OpVectorShuffle %152 %152 0 1 2 
					                                       f32_3 %154 = OpFMul %151 %153 
					                                       f32_4 %155 = OpLoad %127 
					                                       f32_4 %156 = OpVectorShuffle %155 %154 4 5 2 6 
					                                                      OpStore %127 %156 
					                                Private f32* %157 = OpAccessChain %127 %93 
					                                         f32 %158 = OpLoad %157 
					                                Private f32* %159 = OpAccessChain %85 %22 
					                                                      OpStore %159 %158 
					                                       f32_4 %161 = OpLoad %85 
					                                                      OpStore vs_TEXCOORD2 %161 
					                                Uniform f32* %164 = OpAccessChain %38 %40 %40 %93 
					                                         f32 %165 = OpLoad %164 
					                                Private f32* %166 = OpAccessChain %162 %93 
					                                                      OpStore %166 %165 
					                                Uniform f32* %167 = OpAccessChain %38 %40 %41 %93 
					                                         f32 %168 = OpLoad %167 
					                                Private f32* %169 = OpAccessChain %162 %101 
					                                                      OpStore %169 %168 
					                                Uniform f32* %170 = OpAccessChain %38 %40 %60 %93 
					                                         f32 %171 = OpLoad %170 
					                                Private f32* %172 = OpAccessChain %162 %34 
					                                                      OpStore %172 %171 
					                                       f32_4 %175 = OpLoad %162 
					                                       f32_3 %176 = OpVectorShuffle %175 %175 0 1 2 
					                                       f32_4 %178 = OpLoad %177 
					                                       f32_3 %179 = OpVectorShuffle %178 %178 0 1 2 
					                                         f32 %180 = OpDot %176 %179 
					                                Private f32* %181 = OpAccessChain %174 %93 
					                                                      OpStore %181 %180 
					                                Uniform f32* %182 = OpAccessChain %38 %40 %40 %101 
					                                         f32 %183 = OpLoad %182 
					                                Private f32* %184 = OpAccessChain %162 %93 
					                                                      OpStore %184 %183 
					                                Uniform f32* %185 = OpAccessChain %38 %40 %41 %101 
					                                         f32 %186 = OpLoad %185 
					                                Private f32* %187 = OpAccessChain %162 %101 
					                                                      OpStore %187 %186 
					                                Uniform f32* %188 = OpAccessChain %38 %40 %60 %101 
					                                         f32 %189 = OpLoad %188 
					                                Private f32* %190 = OpAccessChain %162 %34 
					                                                      OpStore %190 %189 
					                                       f32_4 %191 = OpLoad %162 
					                                       f32_3 %192 = OpVectorShuffle %191 %191 0 1 2 
					                                       f32_4 %193 = OpLoad %177 
					                                       f32_3 %194 = OpVectorShuffle %193 %193 0 1 2 
					                                         f32 %195 = OpDot %192 %194 
					                                Private f32* %196 = OpAccessChain %174 %101 
					                                                      OpStore %196 %195 
					                                Uniform f32* %197 = OpAccessChain %38 %40 %40 %34 
					                                         f32 %198 = OpLoad %197 
					                                Private f32* %199 = OpAccessChain %162 %93 
					                                                      OpStore %199 %198 
					                                Uniform f32* %200 = OpAccessChain %38 %40 %41 %34 
					                                         f32 %201 = OpLoad %200 
					                                Private f32* %202 = OpAccessChain %162 %101 
					                                                      OpStore %202 %201 
					                                Uniform f32* %203 = OpAccessChain %38 %40 %60 %34 
					                                         f32 %204 = OpLoad %203 
					                                Private f32* %205 = OpAccessChain %162 %34 
					                                                      OpStore %205 %204 
					                                       f32_4 %206 = OpLoad %162 
					                                       f32_3 %207 = OpVectorShuffle %206 %206 0 1 2 
					                                       f32_4 %208 = OpLoad %177 
					                                       f32_3 %209 = OpVectorShuffle %208 %208 0 1 2 
					                                         f32 %210 = OpDot %207 %209 
					                                Private f32* %211 = OpAccessChain %174 %34 
					                                                      OpStore %211 %210 
					                                       f32_3 %212 = OpLoad %174 
					                                       f32_3 %213 = OpLoad %174 
					                                         f32 %214 = OpDot %212 %213 
					                                                      OpStore %109 %214 
					                                         f32 %215 = OpLoad %109 
					                                         f32 %216 = OpExtInst %1 40 %215 %116 
					                                                      OpStore %109 %216 
					                                         f32 %217 = OpLoad %109 
					                                         f32 %218 = OpExtInst %1 32 %217 
					                                                      OpStore %109 %218 
					                                         f32 %219 = OpLoad %109 
					                                       f32_3 %220 = OpCompositeConstruct %219 %219 %219 
					                                       f32_3 %221 = OpLoad %174 
					                                       f32_3 %222 = OpFMul %220 %221 
					                                       f32_4 %223 = OpLoad %162 
					                                       f32_4 %224 = OpVectorShuffle %223 %222 4 5 6 3 
					                                                      OpStore %162 %224 
					                                Private f32* %225 = OpAccessChain %127 %101 
					                                         f32 %226 = OpLoad %225 
					                                Private f32* %227 = OpAccessChain %162 %22 
					                                                      OpStore %227 %226 
					                                       f32_4 %229 = OpLoad %162 
					                                                      OpStore vs_TEXCOORD3 %229 
					                                       f32_4 %231 = OpLoad %85 
					                                       f32_3 %232 = OpVectorShuffle %231 %231 2 0 1 
					                                       f32_4 %233 = OpLoad %162 
					                                       f32_3 %234 = OpVectorShuffle %233 %233 1 2 0 
					                                       f32_3 %235 = OpFMul %232 %234 
					                                                      OpStore %230 %235 
					                                       f32_4 %236 = OpLoad %85 
					                                       f32_3 %237 = OpVectorShuffle %236 %236 1 2 0 
					                                       f32_4 %238 = OpLoad %162 
					                                       f32_3 %239 = OpVectorShuffle %238 %238 2 0 1 
					                                       f32_3 %240 = OpFMul %237 %239 
					                                       f32_3 %241 = OpLoad %230 
					                                       f32_3 %242 = OpFNegate %241 
					                                       f32_3 %243 = OpFAdd %240 %242 
					                                       f32_4 %244 = OpLoad %85 
					                                       f32_4 %245 = OpVectorShuffle %244 %243 4 5 6 3 
					                                                      OpStore %85 %245 
					                                  Input f32* %247 = OpAccessChain %177 %22 
					                                         f32 %248 = OpLoad %247 
					                                Uniform f32* %249 = OpAccessChain %38 %74 %22 
					                                         f32 %250 = OpLoad %249 
					                                         f32 %251 = OpFMul %248 %250 
					                                                      OpStore %109 %251 
					                                         f32 %252 = OpLoad %109 
					                                       f32_3 %253 = OpCompositeConstruct %252 %252 %252 
					                                       f32_4 %254 = OpLoad %85 
					                                       f32_3 %255 = OpVectorShuffle %254 %254 0 1 2 
					                                       f32_3 %256 = OpFMul %253 %255 
					                                       f32_4 %257 = OpLoad %127 
					                                       f32_4 %258 = OpVectorShuffle %257 %256 4 5 6 3 
					                                                      OpStore %127 %258 
					                                       f32_4 %260 = OpLoad %127 
					                                                      OpStore vs_TEXCOORD4 %260 
					                                                      OpStore vs_TEXCOORD8 %263 
					                                       f32_4 %264 = OpLoad %26 
					                                       f32_4 %265 = OpVectorShuffle %264 %264 1 1 1 1 
					                              Uniform f32_4* %266 = OpAccessChain %134 %41 %41 
					                                       f32_4 %267 = OpLoad %266 
					                                       f32_4 %268 = OpFMul %265 %267 
					                                                      OpStore %85 %268 
					                              Uniform f32_4* %269 = OpAccessChain %134 %41 %40 
					                                       f32_4 %270 = OpLoad %269 
					                                       f32_4 %271 = OpLoad %26 
					                                       f32_4 %272 = OpVectorShuffle %271 %271 0 0 0 0 
					                                       f32_4 %273 = OpFMul %270 %272 
					                                       f32_4 %274 = OpLoad %85 
					                                       f32_4 %275 = OpFAdd %273 %274 
					                                                      OpStore %85 %275 
					                              Uniform f32_4* %276 = OpAccessChain %134 %41 %60 
					                                       f32_4 %277 = OpLoad %276 
					                                       f32_4 %278 = OpLoad %26 
					                                       f32_4 %279 = OpVectorShuffle %278 %278 2 2 2 2 
					                                       f32_4 %280 = OpFMul %277 %279 
					                                       f32_4 %281 = OpLoad %85 
					                                       f32_4 %282 = OpFAdd %280 %281 
					                                                      OpStore %26 %282 
					                                       f32_4 %287 = OpLoad %26 
					                              Uniform f32_4* %288 = OpAccessChain %134 %41 %74 
					                                       f32_4 %289 = OpLoad %288 
					                                       f32_4 %290 = OpFAdd %287 %289 
					                               Output f32_4* %291 = OpAccessChain %286 %40 
					                                                      OpStore %291 %290 
					                                 Output f32* %292 = OpAccessChain %286 %40 %101 
					                                         f32 %293 = OpLoad %292 
					                                         f32 %294 = OpFNegate %293 
					                                 Output f32* %295 = OpAccessChain %286 %40 %101 
					                                                      OpStore %295 %294 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 74
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %22 %42 %60 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %12 RelaxedPrecision 
					                                                      OpDecorate %12 DescriptorSet 12 
					                                                      OpDecorate %12 Binding 12 
					                                                      OpDecorate %13 RelaxedPrecision 
					                                                      OpDecorate %16 RelaxedPrecision 
					                                                      OpDecorate %16 DescriptorSet 16 
					                                                      OpDecorate %16 Binding 16 
					                                                      OpDecorate %17 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 22 
					                                                      OpDecorate %25 RelaxedPrecision 
					                                                      OpDecorate %26 RelaxedPrecision 
					                                                      OpMemberDecorate %27 0 Offset 27 
					                                                      OpMemberDecorate %27 1 Offset 27 
					                                                      OpMemberDecorate %27 2 Offset 27 
					                                                      OpMemberDecorate %27 3 RelaxedPrecision 
					                                                      OpMemberDecorate %27 3 Offset 27 
					                                                      OpMemberDecorate %27 4 RelaxedPrecision 
					                                                      OpMemberDecorate %27 4 Offset 27 
					                                                      OpMemberDecorate %27 5 RelaxedPrecision 
					                                                      OpMemberDecorate %27 5 Offset 27 
					                                                      OpMemberDecorate %27 6 RelaxedPrecision 
					                                                      OpMemberDecorate %27 6 Offset 27 
					                                                      OpMemberDecorate %27 7 RelaxedPrecision 
					                                                      OpMemberDecorate %27 7 Offset 27 
					                                                      OpMemberDecorate %27 8 RelaxedPrecision 
					                                                      OpMemberDecorate %27 8 Offset 27 
					                                                      OpDecorate %27 Block 
					                                                      OpDecorate %29 DescriptorSet 29 
					                                                      OpDecorate %29 Binding 29 
					                                                      OpDecorate %34 RelaxedPrecision 
					                                                      OpDecorate %35 RelaxedPrecision 
					                                                      OpDecorate %38 RelaxedPrecision 
					                                                      OpDecorate %39 RelaxedPrecision 
					                                                      OpDecorate %40 RelaxedPrecision 
					                                                      OpDecorate %42 RelaxedPrecision 
					                                                      OpDecorate %42 Location 42 
					                                                      OpDecorate %43 RelaxedPrecision 
					                                                      OpDecorate %44 RelaxedPrecision 
					                                                      OpDecorate %45 RelaxedPrecision 
					                                                      OpDecorate %48 RelaxedPrecision 
					                                                      OpDecorate %50 RelaxedPrecision 
					                                                      OpDecorate %54 RelaxedPrecision 
					                                                      OpDecorate %57 RelaxedPrecision 
					                                                      OpDecorate %58 RelaxedPrecision 
					                                                      OpDecorate %60 RelaxedPrecision 
					                                                      OpDecorate %60 Location 60 
					                                                      OpDecorate %61 RelaxedPrecision 
					                                                      OpDecorate %62 RelaxedPrecision 
					                                                      OpDecorate %63 RelaxedPrecision 
					                                                      OpDecorate %64 RelaxedPrecision 
					                                                      OpDecorate %67 RelaxedPrecision 
					                                                      OpDecorate %70 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %11 = OpTypePointer UniformConstant %10 
					         UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                              %14 = OpTypeSampler 
					                                              %15 = OpTypePointer UniformConstant %14 
					                     UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                              %18 = OpTypeSampledImage %10 
					                                              %20 = OpTypeVector %6 2 
					                                              %21 = OpTypePointer Input %20 
					                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                               Private f32_4* %25 = OpVariable Private 
					                                              %27 = OpTypeStruct %7 %7 %7 %7 %7 %7 %6 %6 %6 
					                                              %28 = OpTypePointer Uniform %27 
					Uniform struct {f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32; f32; f32;}* %29 = OpVariable Uniform 
					                                              %30 = OpTypeInt 32 1 
					                                          i32 %31 = OpConstant 3 
					                                              %32 = OpTypePointer Uniform %7 
					                                              %36 = OpTypeVector %6 3 
					                                              %37 = OpTypePointer Private %36 
					                               Private f32_3* %38 = OpVariable Private 
					                                              %41 = OpTypePointer Input %7 
					                                 Input f32_4* %42 = OpVariable Input 
					                                          f32 %46 = OpConstant 3.674022E-40 
					                                        f32_3 %47 = OpConstantComposite %46 %46 %46 
					                                              %49 = OpTypePointer Private %6 
					                                 Private f32* %50 = OpVariable Private 
					                                              %51 = OpTypeInt 32 0 
					                                          u32 %52 = OpConstant 3 
					                                              %55 = OpTypePointer Input %6 
					                                              %59 = OpTypePointer Output %7 
					                                Output f32_4* %60 = OpVariable Output 
					                                          f32 %65 = OpConstant 3.674022E-40 
					                                        f32_3 %66 = OpConstantComposite %65 %65 %65 
					                                              %71 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                          read_only Texture2D %13 = OpLoad %12 
					                                      sampler %17 = OpLoad %16 
					                   read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                        f32_2 %23 = OpLoad vs_TEXCOORD0 
					                                        f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                                      OpStore %9 %24 
					                                        f32_4 %26 = OpLoad %9 
					                               Uniform f32_4* %33 = OpAccessChain %29 %31 
					                                        f32_4 %34 = OpLoad %33 
					                                        f32_4 %35 = OpFMul %26 %34 
					                                                      OpStore %25 %35 
					                                        f32_4 %39 = OpLoad %25 
					                                        f32_3 %40 = OpVectorShuffle %39 %39 0 1 2 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_3 %44 = OpVectorShuffle %43 %43 0 1 2 
					                                        f32_3 %45 = OpFMul %40 %44 
					                                        f32_3 %48 = OpFAdd %45 %47 
					                                                      OpStore %38 %48 
					                                 Private f32* %53 = OpAccessChain %25 %52 
					                                          f32 %54 = OpLoad %53 
					                                   Input f32* %56 = OpAccessChain %42 %52 
					                                          f32 %57 = OpLoad %56 
					                                          f32 %58 = OpFMul %54 %57 
					                                                      OpStore %50 %58 
					                                          f32 %61 = OpLoad %50 
					                                        f32_3 %62 = OpCompositeConstruct %61 %61 %61 
					                                        f32_3 %63 = OpLoad %38 
					                                        f32_3 %64 = OpFMul %62 %63 
					                                        f32_3 %67 = OpFAdd %64 %66 
					                                        f32_4 %68 = OpLoad %60 
					                                        f32_4 %69 = OpVectorShuffle %68 %67 4 5 6 3 
					                                                      OpStore %60 %69 
					                                          f32 %70 = OpLoad %50 
					                                  Output f32* %72 = OpAccessChain %60 %52 
					                                                      OpStore %72 %70 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "gles " {
					Keywords { "FOG_LINEAR" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute mediump vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec3 vs_TEXCOORD8;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
					    vs_TEXCOORD1.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
					    gl_Position = u_xlat1;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BaseColor;
					uniform lowp sampler2D _BaseMap;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture2D(_BaseMap, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat10_0 * _BaseColor;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    SV_Target0.xyz = u_xlat16_0.xyz * vs_TEXCOORD1.www;
					    SV_Target0.w = u_xlat16_0.w;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					UNITY_BINDING(1) uniform UnityPerDraw {
					#endif
						UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
						UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
						UNITY_UNIFORM vec4 unity_LODFade;
						UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
						UNITY_UNIFORM mediump vec4 unity_LightData;
						UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
						UNITY_UNIFORM vec4 unity_ProbesOcclusion;
						UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
						UNITY_UNIFORM vec4 unity_LightmapST;
						UNITY_UNIFORM vec4 unity_DynamicLightmapST;
						UNITY_UNIFORM mediump vec4 unity_SHAr;
						UNITY_UNIFORM mediump vec4 unity_SHAg;
						UNITY_UNIFORM mediump vec4 unity_SHAb;
						UNITY_UNIFORM mediump vec4 unity_SHBr;
						UNITY_UNIFORM mediump vec4 unity_SHBg;
						UNITY_UNIFORM mediump vec4 unity_SHBb;
						UNITY_UNIFORM mediump vec4 unity_SHC;
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					};
					#endif
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD8;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
					    vs_TEXCOORD1.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					#ifdef UNITY_ADRENO_ES3
					    vs_TEXCOORD1.w = min(max(vs_TEXCOORD1.w, 0.0), 1.0);
					#else
					    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
					#endif
					    gl_Position = u_xlat1;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					UNITY_BINDING(0) uniform UnityPerMaterial {
					#endif
						UNITY_UNIFORM vec4 _SoftParticleFadeParams;
						UNITY_UNIFORM vec4 _CameraFadeParams;
						UNITY_UNIFORM vec4 _BaseMap_ST;
						UNITY_UNIFORM mediump vec4 _BaseColor;
						UNITY_UNIFORM mediump vec4 _EmissionColor;
						UNITY_UNIFORM mediump vec4 _BaseColorAddSubDiff;
						UNITY_UNIFORM mediump float _Cutoff;
						UNITY_UNIFORM mediump float _DistortionStrengthScaled;
						UNITY_UNIFORM mediump float _DistortionBlend;
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					};
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					void main()
					{
					    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat16_0 * _BaseColor;
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    SV_Target0.xyz = u_xlat16_0.xyz * vs_TEXCOORD1.www;
					    SV_Target0.w = u_xlat16_0.w;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					Keywords { "FOG_LINEAR" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 206
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %9 %11 %15 %17 %22 %106 %120 %145 %183 %197 %199 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                                      OpName vs_TEXCOORD8 "vs_TEXCOORD8" 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %9 Location 9 
					                                                      OpDecorate %11 RelaxedPrecision 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %12 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 15 
					                                                      OpDecorate %17 Location 17 
					                                                      OpDecorate %22 Location 22 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpDecorate %28 ArrayStride 28 
					                                                      OpDecorate %30 ArrayStride 30 
					                                                      OpMemberDecorate %31 0 Offset 31 
					                                                      OpMemberDecorate %31 1 Offset 31 
					                                                      OpMemberDecorate %31 2 Offset 31 
					                                                      OpMemberDecorate %31 3 RelaxedPrecision 
					                                                      OpMemberDecorate %31 3 Offset 31 
					                                                      OpMemberDecorate %31 4 RelaxedPrecision 
					                                                      OpMemberDecorate %31 4 Offset 31 
					                                                      OpMemberDecorate %31 5 RelaxedPrecision 
					                                                      OpMemberDecorate %31 5 Offset 31 
					                                                      OpMemberDecorate %31 6 Offset 31 
					                                                      OpMemberDecorate %31 7 RelaxedPrecision 
					                                                      OpMemberDecorate %31 7 Offset 31 
					                                                      OpMemberDecorate %31 8 Offset 31 
					                                                      OpMemberDecorate %31 9 Offset 31 
					                                                      OpMemberDecorate %31 10 RelaxedPrecision 
					                                                      OpMemberDecorate %31 10 Offset 31 
					                                                      OpMemberDecorate %31 11 RelaxedPrecision 
					                                                      OpMemberDecorate %31 11 Offset 31 
					                                                      OpMemberDecorate %31 12 RelaxedPrecision 
					                                                      OpMemberDecorate %31 12 Offset 31 
					                                                      OpMemberDecorate %31 13 RelaxedPrecision 
					                                                      OpMemberDecorate %31 13 Offset 31 
					                                                      OpMemberDecorate %31 14 RelaxedPrecision 
					                                                      OpMemberDecorate %31 14 Offset 31 
					                                                      OpMemberDecorate %31 15 RelaxedPrecision 
					                                                      OpMemberDecorate %31 15 Offset 31 
					                                                      OpMemberDecorate %31 16 RelaxedPrecision 
					                                                      OpMemberDecorate %31 16 Offset 31 
					                                                      OpDecorate %31 Block 
					                                                      OpDecorate %33 DescriptorSet 33 
					                                                      OpDecorate %33 Binding 33 
					                                                      OpDecorate %69 ArrayStride 69 
					                                                      OpMemberDecorate %70 0 Offset 70 
					                                                      OpMemberDecorate %70 1 Offset 70 
					                                                      OpMemberDecorate %70 2 Offset 70 
					                                                      OpMemberDecorate %70 3 Offset 70 
					                                                      OpDecorate %70 Block 
					                                                      OpDecorate %72 DescriptorSet 72 
					                                                      OpDecorate %72 Binding 72 
					                                                      OpMemberDecorate %104 0 BuiltIn 104 
					                                                      OpMemberDecorate %104 1 BuiltIn 104 
					                                                      OpMemberDecorate %104 2 BuiltIn 104 
					                                                      OpDecorate %104 Block 
					                                                      OpDecorate vs_TEXCOORD1 Location 120 
					                                                      OpDecorate %145 Location 145 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 183 
					                                                      OpDecorate vs_TEXCOORD3 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD3 Location 197 
					                                                      OpDecorate vs_TEXCOORD8 Location 199 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Output %7 
					                                 Output f32_4* %9 = OpVariable Output 
					                                              %10 = OpTypePointer Input %7 
					                                 Input f32_4* %11 = OpVariable Input 
					                                              %13 = OpTypeVector %6 2 
					                                              %14 = OpTypePointer Output %13 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                              %16 = OpTypePointer Input %13 
					                                 Input f32_2* %17 = OpVariable Input 
					                                              %19 = OpTypeVector %6 3 
					                                              %20 = OpTypePointer Private %19 
					                               Private f32_3* %21 = OpVariable Private 
					                                 Input f32_4* %22 = OpVariable Input 
					                                              %25 = OpTypeInt 32 0 
					                                          u32 %26 = OpConstant 4 
					                                              %27 = OpTypeArray %7 %26 
					                                              %28 = OpTypeArray %7 %26 
					                                          u32 %29 = OpConstant 2 
					                                              %30 = OpTypeArray %7 %29 
					                                              %31 = OpTypeStruct %27 %28 %7 %7 %7 %30 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
					                                              %32 = OpTypePointer Uniform %31 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %33 = OpVariable Uniform 
					                                              %34 = OpTypeInt 32 1 
					                                          i32 %35 = OpConstant 0 
					                                          i32 %36 = OpConstant 1 
					                                              %37 = OpTypePointer Uniform %7 
					                                          i32 %50 = OpConstant 2 
					                                          i32 %60 = OpConstant 3 
					                                              %65 = OpTypePointer Private %7 
					                               Private f32_4* %66 = OpVariable Private 
					                                              %69 = OpTypeArray %7 %26 
					                                              %70 = OpTypeStruct %19 %7 %7 %69 
					                                              %71 = OpTypePointer Uniform %70 
					Uniform struct {f32_3; f32_4; f32_4; f32_4[4];}* %72 = OpVariable Uniform 
					                                              %94 = OpTypePointer Private %6 
					                                 Private f32* %95 = OpVariable Private 
					                                          u32 %98 = OpConstant 1 
					                                              %99 = OpTypePointer Uniform %6 
					                                             %103 = OpTypeArray %6 %98 
					                                             %104 = OpTypeStruct %7 %6 %103 
					                                             %105 = OpTypePointer Output %104 
					        Output struct {f32_4; f32; f32[1];}* %106 = OpVariable Output 
					                                         f32 %111 = OpConstant 3.674022E-40 
					                                         f32 %118 = OpConstant 3.674022E-40 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                         u32 %125 = OpConstant 3 
					                                             %129 = OpTypePointer Output %6 
					                                             %140 = OpTypePointer Uniform %19 
					                                             %144 = OpTypePointer Input %19 
					                                Input f32_3* %145 = OpVariable Input 
					                                         u32 %151 = OpConstant 0 
					                                         f32 %171 = OpConstant 3.674022E-40 
					                                             %182 = OpTypePointer Output %19 
					                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
					                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
					                       Output f32_3* vs_TEXCOORD8 = OpVariable Output 
					                                       f32_3 %200 = OpConstantComposite %118 %118 %118 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %12 = OpLoad %11 
					                                                      OpStore %9 %12 
					                                        f32_2 %18 = OpLoad %17 
					                                                      OpStore vs_TEXCOORD0 %18 
					                                        f32_4 %23 = OpLoad %22 
					                                        f32_3 %24 = OpVectorShuffle %23 %23 1 1 1 
					                               Uniform f32_4* %38 = OpAccessChain %33 %35 %36 
					                                        f32_4 %39 = OpLoad %38 
					                                        f32_3 %40 = OpVectorShuffle %39 %39 0 1 2 
					                                        f32_3 %41 = OpFMul %24 %40 
					                                                      OpStore %21 %41 
					                               Uniform f32_4* %42 = OpAccessChain %33 %35 %35 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_3 %44 = OpVectorShuffle %43 %43 0 1 2 
					                                        f32_4 %45 = OpLoad %22 
					                                        f32_3 %46 = OpVectorShuffle %45 %45 0 0 0 
					                                        f32_3 %47 = OpFMul %44 %46 
					                                        f32_3 %48 = OpLoad %21 
					                                        f32_3 %49 = OpFAdd %47 %48 
					                                                      OpStore %21 %49 
					                               Uniform f32_4* %51 = OpAccessChain %33 %35 %50 
					                                        f32_4 %52 = OpLoad %51 
					                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
					                                        f32_4 %54 = OpLoad %22 
					                                        f32_3 %55 = OpVectorShuffle %54 %54 2 2 2 
					                                        f32_3 %56 = OpFMul %53 %55 
					                                        f32_3 %57 = OpLoad %21 
					                                        f32_3 %58 = OpFAdd %56 %57 
					                                                      OpStore %21 %58 
					                                        f32_3 %59 = OpLoad %21 
					                               Uniform f32_4* %61 = OpAccessChain %33 %35 %60 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_3 %63 = OpVectorShuffle %62 %62 0 1 2 
					                                        f32_3 %64 = OpFAdd %59 %63 
					                                                      OpStore %21 %64 
					                                        f32_3 %67 = OpLoad %21 
					                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
					                               Uniform f32_4* %73 = OpAccessChain %72 %60 %36 
					                                        f32_4 %74 = OpLoad %73 
					                                        f32_4 %75 = OpFMul %68 %74 
					                                                      OpStore %66 %75 
					                               Uniform f32_4* %76 = OpAccessChain %72 %60 %35 
					                                        f32_4 %77 = OpLoad %76 
					                                        f32_3 %78 = OpLoad %21 
					                                        f32_4 %79 = OpVectorShuffle %78 %78 0 0 0 0 
					                                        f32_4 %80 = OpFMul %77 %79 
					                                        f32_4 %81 = OpLoad %66 
					                                        f32_4 %82 = OpFAdd %80 %81 
					                                                      OpStore %66 %82 
					                               Uniform f32_4* %83 = OpAccessChain %72 %60 %50 
					                                        f32_4 %84 = OpLoad %83 
					                                        f32_3 %85 = OpLoad %21 
					                                        f32_4 %86 = OpVectorShuffle %85 %85 2 2 2 2 
					                                        f32_4 %87 = OpFMul %84 %86 
					                                        f32_4 %88 = OpLoad %66 
					                                        f32_4 %89 = OpFAdd %87 %88 
					                                                      OpStore %66 %89 
					                                        f32_4 %90 = OpLoad %66 
					                               Uniform f32_4* %91 = OpAccessChain %72 %60 %60 
					                                        f32_4 %92 = OpLoad %91 
					                                        f32_4 %93 = OpFAdd %90 %92 
					                                                      OpStore %66 %93 
					                                 Private f32* %96 = OpAccessChain %66 %29 
					                                          f32 %97 = OpLoad %96 
					                                Uniform f32* %100 = OpAccessChain %72 %36 %98 
					                                         f32 %101 = OpLoad %100 
					                                         f32 %102 = OpFDiv %97 %101 
					                                                      OpStore %95 %102 
					                                       f32_4 %107 = OpLoad %66 
					                               Output f32_4* %108 = OpAccessChain %106 %35 
					                                                      OpStore %108 %107 
					                                         f32 %109 = OpLoad %95 
					                                         f32 %110 = OpFNegate %109 
					                                         f32 %112 = OpFAdd %110 %111 
					                                                      OpStore %95 %112 
					                                         f32 %113 = OpLoad %95 
					                                Uniform f32* %114 = OpAccessChain %72 %36 %29 
					                                         f32 %115 = OpLoad %114 
					                                         f32 %116 = OpFMul %113 %115 
					                                                      OpStore %95 %116 
					                                         f32 %117 = OpLoad %95 
					                                         f32 %119 = OpExtInst %1 40 %117 %118 
					                                                      OpStore %95 %119 
					                                         f32 %121 = OpLoad %95 
					                                Uniform f32* %122 = OpAccessChain %72 %50 %29 
					                                         f32 %123 = OpLoad %122 
					                                         f32 %124 = OpFMul %121 %123 
					                                Uniform f32* %126 = OpAccessChain %72 %50 %125 
					                                         f32 %127 = OpLoad %126 
					                                         f32 %128 = OpFAdd %124 %127 
					                                 Output f32* %130 = OpAccessChain vs_TEXCOORD1 %125 
					                                                      OpStore %130 %128 
					                                 Output f32* %131 = OpAccessChain vs_TEXCOORD1 %125 
					                                         f32 %132 = OpLoad %131 
					                                         f32 %133 = OpExtInst %1 43 %132 %118 %111 
					                                 Output f32* %134 = OpAccessChain vs_TEXCOORD1 %125 
					                                                      OpStore %134 %133 
					                                       f32_3 %135 = OpLoad %21 
					                                       f32_4 %136 = OpLoad vs_TEXCOORD1 
					                                       f32_4 %137 = OpVectorShuffle %136 %135 4 5 6 3 
					                                                      OpStore vs_TEXCOORD1 %137 
					                                       f32_3 %138 = OpLoad %21 
					                                       f32_3 %139 = OpFNegate %138 
					                              Uniform f32_3* %141 = OpAccessChain %72 %35 
					                                       f32_3 %142 = OpLoad %141 
					                                       f32_3 %143 = OpFAdd %139 %142 
					                                                      OpStore %21 %143 
					                                       f32_3 %146 = OpLoad %145 
					                              Uniform f32_4* %147 = OpAccessChain %33 %36 %35 
					                                       f32_4 %148 = OpLoad %147 
					                                       f32_3 %149 = OpVectorShuffle %148 %148 0 1 2 
					                                         f32 %150 = OpDot %146 %149 
					                                Private f32* %152 = OpAccessChain %66 %151 
					                                                      OpStore %152 %150 
					                                       f32_3 %153 = OpLoad %145 
					                              Uniform f32_4* %154 = OpAccessChain %33 %36 %36 
					                                       f32_4 %155 = OpLoad %154 
					                                       f32_3 %156 = OpVectorShuffle %155 %155 0 1 2 
					                                         f32 %157 = OpDot %153 %156 
					                                Private f32* %158 = OpAccessChain %66 %98 
					                                                      OpStore %158 %157 
					                                       f32_3 %159 = OpLoad %145 
					                              Uniform f32_4* %160 = OpAccessChain %33 %36 %50 
					                                       f32_4 %161 = OpLoad %160 
					                                       f32_3 %162 = OpVectorShuffle %161 %161 0 1 2 
					                                         f32 %163 = OpDot %159 %162 
					                                Private f32* %164 = OpAccessChain %66 %29 
					                                                      OpStore %164 %163 
					                                       f32_4 %165 = OpLoad %66 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                       f32_4 %167 = OpLoad %66 
					                                       f32_3 %168 = OpVectorShuffle %167 %167 0 1 2 
					                                         f32 %169 = OpDot %166 %168 
					                                                      OpStore %95 %169 
					                                         f32 %170 = OpLoad %95 
					                                         f32 %172 = OpExtInst %1 40 %170 %171 
					                                                      OpStore %95 %172 
					                                         f32 %173 = OpLoad %95 
					                                         f32 %174 = OpExtInst %1 32 %173 
					                                                      OpStore %95 %174 
					                                         f32 %175 = OpLoad %95 
					                                       f32_3 %176 = OpCompositeConstruct %175 %175 %175 
					                                       f32_4 %177 = OpLoad %66 
					                                       f32_3 %178 = OpVectorShuffle %177 %177 0 1 2 
					                                       f32_3 %179 = OpFMul %176 %178 
					                                       f32_4 %180 = OpLoad %66 
					                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
					                                                      OpStore %66 %181 
					                                       f32_4 %184 = OpLoad %66 
					                                       f32_3 %185 = OpVectorShuffle %184 %184 0 1 2 
					                                                      OpStore vs_TEXCOORD2 %185 
					                                       f32_3 %186 = OpLoad %21 
					                                       f32_3 %187 = OpLoad %21 
					                                         f32 %188 = OpDot %186 %187 
					                                                      OpStore %95 %188 
					                                         f32 %189 = OpLoad %95 
					                                         f32 %190 = OpExtInst %1 40 %189 %171 
					                                                      OpStore %95 %190 
					                                         f32 %191 = OpLoad %95 
					                                         f32 %192 = OpExtInst %1 32 %191 
					                                                      OpStore %95 %192 
					                                         f32 %193 = OpLoad %95 
					                                       f32_3 %194 = OpCompositeConstruct %193 %193 %193 
					                                       f32_3 %195 = OpLoad %21 
					                                       f32_3 %196 = OpFMul %194 %195 
					                                                      OpStore %21 %196 
					                                       f32_3 %198 = OpLoad %21 
					                                                      OpStore vs_TEXCOORD3 %198 
					                                                      OpStore vs_TEXCOORD8 %200 
					                                 Output f32* %201 = OpAccessChain %106 %35 %98 
					                                         f32 %202 = OpLoad %201 
					                                         f32 %203 = OpFNegate %202 
					                                 Output f32* %204 = OpAccessChain %106 %35 %98 
					                                                      OpStore %204 %203 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 60
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %22 %38 %42 %46 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %12 RelaxedPrecision 
					                                                      OpDecorate %12 DescriptorSet 12 
					                                                      OpDecorate %12 Binding 12 
					                                                      OpDecorate %13 RelaxedPrecision 
					                                                      OpDecorate %16 RelaxedPrecision 
					                                                      OpDecorate %16 DescriptorSet 16 
					                                                      OpDecorate %16 Binding 16 
					                                                      OpDecorate %17 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 22 
					                                                      OpDecorate %25 RelaxedPrecision 
					                                                      OpDecorate %26 RelaxedPrecision 
					                                                      OpMemberDecorate %27 0 Offset 27 
					                                                      OpMemberDecorate %27 1 Offset 27 
					                                                      OpMemberDecorate %27 2 Offset 27 
					                                                      OpMemberDecorate %27 3 RelaxedPrecision 
					                                                      OpMemberDecorate %27 3 Offset 27 
					                                                      OpMemberDecorate %27 4 RelaxedPrecision 
					                                                      OpMemberDecorate %27 4 Offset 27 
					                                                      OpMemberDecorate %27 5 RelaxedPrecision 
					                                                      OpMemberDecorate %27 5 Offset 27 
					                                                      OpMemberDecorate %27 6 RelaxedPrecision 
					                                                      OpMemberDecorate %27 6 Offset 27 
					                                                      OpMemberDecorate %27 7 RelaxedPrecision 
					                                                      OpMemberDecorate %27 7 Offset 27 
					                                                      OpMemberDecorate %27 8 RelaxedPrecision 
					                                                      OpMemberDecorate %27 8 Offset 27 
					                                                      OpDecorate %27 Block 
					                                                      OpDecorate %29 DescriptorSet 29 
					                                                      OpDecorate %29 Binding 29 
					                                                      OpDecorate %34 RelaxedPrecision 
					                                                      OpDecorate %35 RelaxedPrecision 
					                                                      OpDecorate %36 RelaxedPrecision 
					                                                      OpDecorate %38 RelaxedPrecision 
					                                                      OpDecorate %38 Location 38 
					                                                      OpDecorate %39 RelaxedPrecision 
					                                                      OpDecorate %40 RelaxedPrecision 
					                                                      OpDecorate %42 RelaxedPrecision 
					                                                      OpDecorate %42 Location 42 
					                                                      OpDecorate %44 RelaxedPrecision 
					                                                      OpDecorate %45 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD1 Location 46 
					                                                      OpDecorate %56 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %11 = OpTypePointer UniformConstant %10 
					         UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                              %14 = OpTypeSampler 
					                                              %15 = OpTypePointer UniformConstant %14 
					                     UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                              %18 = OpTypeSampledImage %10 
					                                              %20 = OpTypeVector %6 2 
					                                              %21 = OpTypePointer Input %20 
					                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                               Private f32_4* %25 = OpVariable Private 
					                                              %27 = OpTypeStruct %7 %7 %7 %7 %7 %7 %6 %6 %6 
					                                              %28 = OpTypePointer Uniform %27 
					Uniform struct {f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32; f32; f32;}* %29 = OpVariable Uniform 
					                                              %30 = OpTypeInt 32 1 
					                                          i32 %31 = OpConstant 3 
					                                              %32 = OpTypePointer Uniform %7 
					                                              %37 = OpTypePointer Input %7 
					                                 Input f32_4* %38 = OpVariable Input 
					                                              %41 = OpTypePointer Output %7 
					                                Output f32_4* %42 = OpVariable Output 
					                                              %43 = OpTypeVector %6 3 
					                        Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                              %52 = OpTypeInt 32 0 
					                                          u32 %53 = OpConstant 3 
					                                              %54 = OpTypePointer Private %6 
					                                              %57 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                          read_only Texture2D %13 = OpLoad %12 
					                                      sampler %17 = OpLoad %16 
					                   read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                        f32_2 %23 = OpLoad vs_TEXCOORD0 
					                                        f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                                      OpStore %9 %24 
					                                        f32_4 %26 = OpLoad %9 
					                               Uniform f32_4* %33 = OpAccessChain %29 %31 
					                                        f32_4 %34 = OpLoad %33 
					                                        f32_4 %35 = OpFMul %26 %34 
					                                                      OpStore %25 %35 
					                                        f32_4 %36 = OpLoad %25 
					                                        f32_4 %39 = OpLoad %38 
					                                        f32_4 %40 = OpFMul %36 %39 
					                                                      OpStore %25 %40 
					                                        f32_4 %44 = OpLoad %25 
					                                        f32_3 %45 = OpVectorShuffle %44 %44 0 1 2 
					                                        f32_4 %47 = OpLoad vs_TEXCOORD1 
					                                        f32_3 %48 = OpVectorShuffle %47 %47 3 3 3 
					                                        f32_3 %49 = OpFMul %45 %48 
					                                        f32_4 %50 = OpLoad %42 
					                                        f32_4 %51 = OpVectorShuffle %50 %49 4 5 6 3 
					                                                      OpStore %42 %51 
					                                 Private f32* %55 = OpAccessChain %25 %53 
					                                          f32 %56 = OpLoad %55 
					                                  Output f32* %58 = OpAccessChain %42 %53 
					                                                      OpStore %58 %56 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "gles " {
					Keywords { "FOG_LINEAR" "_ALPHAPREMULTIPLY_ON" "_ALPHATEST_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute mediump vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec3 vs_TEXCOORD8;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
					    vs_TEXCOORD1.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
					    gl_Position = u_xlat1;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BaseColor;
					uniform 	mediump float _Cutoff;
					uniform lowp sampler2D _BaseMap;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture2D(_BaseMap, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat10_0 * _BaseColor;
					    u_xlat16_1.x = u_xlat16_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					    u_xlatb2 = u_xlat16_1.x<0.0;
					    if(u_xlatb2){discard;}
					    u_xlat16_1.xyz = u_xlat16_0.www * u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat16_0.w;
					    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD1.www;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "FOG_LINEAR" "_ALPHAPREMULTIPLY_ON" "_ALPHATEST_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					UNITY_BINDING(1) uniform UnityPerDraw {
					#endif
						UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
						UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
						UNITY_UNIFORM vec4 unity_LODFade;
						UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
						UNITY_UNIFORM mediump vec4 unity_LightData;
						UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
						UNITY_UNIFORM vec4 unity_ProbesOcclusion;
						UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
						UNITY_UNIFORM vec4 unity_LightmapST;
						UNITY_UNIFORM vec4 unity_DynamicLightmapST;
						UNITY_UNIFORM mediump vec4 unity_SHAr;
						UNITY_UNIFORM mediump vec4 unity_SHAg;
						UNITY_UNIFORM mediump vec4 unity_SHAb;
						UNITY_UNIFORM mediump vec4 unity_SHBr;
						UNITY_UNIFORM mediump vec4 unity_SHBg;
						UNITY_UNIFORM mediump vec4 unity_SHBb;
						UNITY_UNIFORM mediump vec4 unity_SHC;
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					};
					#endif
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD8;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
					    vs_TEXCOORD1.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					#ifdef UNITY_ADRENO_ES3
					    vs_TEXCOORD1.w = min(max(vs_TEXCOORD1.w, 0.0), 1.0);
					#else
					    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
					#endif
					    gl_Position = u_xlat1;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					UNITY_BINDING(0) uniform UnityPerMaterial {
					#endif
						UNITY_UNIFORM vec4 _SoftParticleFadeParams;
						UNITY_UNIFORM vec4 _CameraFadeParams;
						UNITY_UNIFORM vec4 _BaseMap_ST;
						UNITY_UNIFORM mediump vec4 _BaseColor;
						UNITY_UNIFORM mediump vec4 _EmissionColor;
						UNITY_UNIFORM mediump vec4 _BaseColorAddSubDiff;
						UNITY_UNIFORM mediump float _Cutoff;
						UNITY_UNIFORM mediump float _DistortionStrengthScaled;
						UNITY_UNIFORM mediump float _DistortionBlend;
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					};
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat16_0 * _BaseColor;
					    u_xlat16_1.x = u_xlat16_0.w * vs_COLOR0.w + (-_Cutoff);
					    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat16_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat16_1.x<0.0;
					#endif
					    if(u_xlatb2){discard;}
					    u_xlat16_1.xyz = u_xlat16_0.www * u_xlat16_0.xyz;
					    SV_Target0.w = u_xlat16_0.w;
					    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD1.www;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					Keywords { "FOG_LINEAR" "_ALPHAPREMULTIPLY_ON" "_ALPHATEST_ON" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 206
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %9 %11 %15 %17 %22 %106 %120 %145 %183 %197 %199 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                                      OpName vs_TEXCOORD8 "vs_TEXCOORD8" 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %9 Location 9 
					                                                      OpDecorate %11 RelaxedPrecision 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %12 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 15 
					                                                      OpDecorate %17 Location 17 
					                                                      OpDecorate %22 Location 22 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpDecorate %28 ArrayStride 28 
					                                                      OpDecorate %30 ArrayStride 30 
					                                                      OpMemberDecorate %31 0 Offset 31 
					                                                      OpMemberDecorate %31 1 Offset 31 
					                                                      OpMemberDecorate %31 2 Offset 31 
					                                                      OpMemberDecorate %31 3 RelaxedPrecision 
					                                                      OpMemberDecorate %31 3 Offset 31 
					                                                      OpMemberDecorate %31 4 RelaxedPrecision 
					                                                      OpMemberDecorate %31 4 Offset 31 
					                                                      OpMemberDecorate %31 5 RelaxedPrecision 
					                                                      OpMemberDecorate %31 5 Offset 31 
					                                                      OpMemberDecorate %31 6 Offset 31 
					                                                      OpMemberDecorate %31 7 RelaxedPrecision 
					                                                      OpMemberDecorate %31 7 Offset 31 
					                                                      OpMemberDecorate %31 8 Offset 31 
					                                                      OpMemberDecorate %31 9 Offset 31 
					                                                      OpMemberDecorate %31 10 RelaxedPrecision 
					                                                      OpMemberDecorate %31 10 Offset 31 
					                                                      OpMemberDecorate %31 11 RelaxedPrecision 
					                                                      OpMemberDecorate %31 11 Offset 31 
					                                                      OpMemberDecorate %31 12 RelaxedPrecision 
					                                                      OpMemberDecorate %31 12 Offset 31 
					                                                      OpMemberDecorate %31 13 RelaxedPrecision 
					                                                      OpMemberDecorate %31 13 Offset 31 
					                                                      OpMemberDecorate %31 14 RelaxedPrecision 
					                                                      OpMemberDecorate %31 14 Offset 31 
					                                                      OpMemberDecorate %31 15 RelaxedPrecision 
					                                                      OpMemberDecorate %31 15 Offset 31 
					                                                      OpMemberDecorate %31 16 RelaxedPrecision 
					                                                      OpMemberDecorate %31 16 Offset 31 
					                                                      OpDecorate %31 Block 
					                                                      OpDecorate %33 DescriptorSet 33 
					                                                      OpDecorate %33 Binding 33 
					                                                      OpDecorate %69 ArrayStride 69 
					                                                      OpMemberDecorate %70 0 Offset 70 
					                                                      OpMemberDecorate %70 1 Offset 70 
					                                                      OpMemberDecorate %70 2 Offset 70 
					                                                      OpMemberDecorate %70 3 Offset 70 
					                                                      OpDecorate %70 Block 
					                                                      OpDecorate %72 DescriptorSet 72 
					                                                      OpDecorate %72 Binding 72 
					                                                      OpMemberDecorate %104 0 BuiltIn 104 
					                                                      OpMemberDecorate %104 1 BuiltIn 104 
					                                                      OpMemberDecorate %104 2 BuiltIn 104 
					                                                      OpDecorate %104 Block 
					                                                      OpDecorate vs_TEXCOORD1 Location 120 
					                                                      OpDecorate %145 Location 145 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 183 
					                                                      OpDecorate vs_TEXCOORD3 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD3 Location 197 
					                                                      OpDecorate vs_TEXCOORD8 Location 199 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Output %7 
					                                 Output f32_4* %9 = OpVariable Output 
					                                              %10 = OpTypePointer Input %7 
					                                 Input f32_4* %11 = OpVariable Input 
					                                              %13 = OpTypeVector %6 2 
					                                              %14 = OpTypePointer Output %13 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                              %16 = OpTypePointer Input %13 
					                                 Input f32_2* %17 = OpVariable Input 
					                                              %19 = OpTypeVector %6 3 
					                                              %20 = OpTypePointer Private %19 
					                               Private f32_3* %21 = OpVariable Private 
					                                 Input f32_4* %22 = OpVariable Input 
					                                              %25 = OpTypeInt 32 0 
					                                          u32 %26 = OpConstant 4 
					                                              %27 = OpTypeArray %7 %26 
					                                              %28 = OpTypeArray %7 %26 
					                                          u32 %29 = OpConstant 2 
					                                              %30 = OpTypeArray %7 %29 
					                                              %31 = OpTypeStruct %27 %28 %7 %7 %7 %30 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
					                                              %32 = OpTypePointer Uniform %31 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %33 = OpVariable Uniform 
					                                              %34 = OpTypeInt 32 1 
					                                          i32 %35 = OpConstant 0 
					                                          i32 %36 = OpConstant 1 
					                                              %37 = OpTypePointer Uniform %7 
					                                          i32 %50 = OpConstant 2 
					                                          i32 %60 = OpConstant 3 
					                                              %65 = OpTypePointer Private %7 
					                               Private f32_4* %66 = OpVariable Private 
					                                              %69 = OpTypeArray %7 %26 
					                                              %70 = OpTypeStruct %19 %7 %7 %69 
					                                              %71 = OpTypePointer Uniform %70 
					Uniform struct {f32_3; f32_4; f32_4; f32_4[4];}* %72 = OpVariable Uniform 
					                                              %94 = OpTypePointer Private %6 
					                                 Private f32* %95 = OpVariable Private 
					                                          u32 %98 = OpConstant 1 
					                                              %99 = OpTypePointer Uniform %6 
					                                             %103 = OpTypeArray %6 %98 
					                                             %104 = OpTypeStruct %7 %6 %103 
					                                             %105 = OpTypePointer Output %104 
					        Output struct {f32_4; f32; f32[1];}* %106 = OpVariable Output 
					                                         f32 %111 = OpConstant 3.674022E-40 
					                                         f32 %118 = OpConstant 3.674022E-40 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                         u32 %125 = OpConstant 3 
					                                             %129 = OpTypePointer Output %6 
					                                             %140 = OpTypePointer Uniform %19 
					                                             %144 = OpTypePointer Input %19 
					                                Input f32_3* %145 = OpVariable Input 
					                                         u32 %151 = OpConstant 0 
					                                         f32 %171 = OpConstant 3.674022E-40 
					                                             %182 = OpTypePointer Output %19 
					                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
					                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
					                       Output f32_3* vs_TEXCOORD8 = OpVariable Output 
					                                       f32_3 %200 = OpConstantComposite %118 %118 %118 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %12 = OpLoad %11 
					                                                      OpStore %9 %12 
					                                        f32_2 %18 = OpLoad %17 
					                                                      OpStore vs_TEXCOORD0 %18 
					                                        f32_4 %23 = OpLoad %22 
					                                        f32_3 %24 = OpVectorShuffle %23 %23 1 1 1 
					                               Uniform f32_4* %38 = OpAccessChain %33 %35 %36 
					                                        f32_4 %39 = OpLoad %38 
					                                        f32_3 %40 = OpVectorShuffle %39 %39 0 1 2 
					                                        f32_3 %41 = OpFMul %24 %40 
					                                                      OpStore %21 %41 
					                               Uniform f32_4* %42 = OpAccessChain %33 %35 %35 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_3 %44 = OpVectorShuffle %43 %43 0 1 2 
					                                        f32_4 %45 = OpLoad %22 
					                                        f32_3 %46 = OpVectorShuffle %45 %45 0 0 0 
					                                        f32_3 %47 = OpFMul %44 %46 
					                                        f32_3 %48 = OpLoad %21 
					                                        f32_3 %49 = OpFAdd %47 %48 
					                                                      OpStore %21 %49 
					                               Uniform f32_4* %51 = OpAccessChain %33 %35 %50 
					                                        f32_4 %52 = OpLoad %51 
					                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
					                                        f32_4 %54 = OpLoad %22 
					                                        f32_3 %55 = OpVectorShuffle %54 %54 2 2 2 
					                                        f32_3 %56 = OpFMul %53 %55 
					                                        f32_3 %57 = OpLoad %21 
					                                        f32_3 %58 = OpFAdd %56 %57 
					                                                      OpStore %21 %58 
					                                        f32_3 %59 = OpLoad %21 
					                               Uniform f32_4* %61 = OpAccessChain %33 %35 %60 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_3 %63 = OpVectorShuffle %62 %62 0 1 2 
					                                        f32_3 %64 = OpFAdd %59 %63 
					                                                      OpStore %21 %64 
					                                        f32_3 %67 = OpLoad %21 
					                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
					                               Uniform f32_4* %73 = OpAccessChain %72 %60 %36 
					                                        f32_4 %74 = OpLoad %73 
					                                        f32_4 %75 = OpFMul %68 %74 
					                                                      OpStore %66 %75 
					                               Uniform f32_4* %76 = OpAccessChain %72 %60 %35 
					                                        f32_4 %77 = OpLoad %76 
					                                        f32_3 %78 = OpLoad %21 
					                                        f32_4 %79 = OpVectorShuffle %78 %78 0 0 0 0 
					                                        f32_4 %80 = OpFMul %77 %79 
					                                        f32_4 %81 = OpLoad %66 
					                                        f32_4 %82 = OpFAdd %80 %81 
					                                                      OpStore %66 %82 
					                               Uniform f32_4* %83 = OpAccessChain %72 %60 %50 
					                                        f32_4 %84 = OpLoad %83 
					                                        f32_3 %85 = OpLoad %21 
					                                        f32_4 %86 = OpVectorShuffle %85 %85 2 2 2 2 
					                                        f32_4 %87 = OpFMul %84 %86 
					                                        f32_4 %88 = OpLoad %66 
					                                        f32_4 %89 = OpFAdd %87 %88 
					                                                      OpStore %66 %89 
					                                        f32_4 %90 = OpLoad %66 
					                               Uniform f32_4* %91 = OpAccessChain %72 %60 %60 
					                                        f32_4 %92 = OpLoad %91 
					                                        f32_4 %93 = OpFAdd %90 %92 
					                                                      OpStore %66 %93 
					                                 Private f32* %96 = OpAccessChain %66 %29 
					                                          f32 %97 = OpLoad %96 
					                                Uniform f32* %100 = OpAccessChain %72 %36 %98 
					                                         f32 %101 = OpLoad %100 
					                                         f32 %102 = OpFDiv %97 %101 
					                                                      OpStore %95 %102 
					                                       f32_4 %107 = OpLoad %66 
					                               Output f32_4* %108 = OpAccessChain %106 %35 
					                                                      OpStore %108 %107 
					                                         f32 %109 = OpLoad %95 
					                                         f32 %110 = OpFNegate %109 
					                                         f32 %112 = OpFAdd %110 %111 
					                                                      OpStore %95 %112 
					                                         f32 %113 = OpLoad %95 
					                                Uniform f32* %114 = OpAccessChain %72 %36 %29 
					                                         f32 %115 = OpLoad %114 
					                                         f32 %116 = OpFMul %113 %115 
					                                                      OpStore %95 %116 
					                                         f32 %117 = OpLoad %95 
					                                         f32 %119 = OpExtInst %1 40 %117 %118 
					                                                      OpStore %95 %119 
					                                         f32 %121 = OpLoad %95 
					                                Uniform f32* %122 = OpAccessChain %72 %50 %29 
					                                         f32 %123 = OpLoad %122 
					                                         f32 %124 = OpFMul %121 %123 
					                                Uniform f32* %126 = OpAccessChain %72 %50 %125 
					                                         f32 %127 = OpLoad %126 
					                                         f32 %128 = OpFAdd %124 %127 
					                                 Output f32* %130 = OpAccessChain vs_TEXCOORD1 %125 
					                                                      OpStore %130 %128 
					                                 Output f32* %131 = OpAccessChain vs_TEXCOORD1 %125 
					                                         f32 %132 = OpLoad %131 
					                                         f32 %133 = OpExtInst %1 43 %132 %118 %111 
					                                 Output f32* %134 = OpAccessChain vs_TEXCOORD1 %125 
					                                                      OpStore %134 %133 
					                                       f32_3 %135 = OpLoad %21 
					                                       f32_4 %136 = OpLoad vs_TEXCOORD1 
					                                       f32_4 %137 = OpVectorShuffle %136 %135 4 5 6 3 
					                                                      OpStore vs_TEXCOORD1 %137 
					                                       f32_3 %138 = OpLoad %21 
					                                       f32_3 %139 = OpFNegate %138 
					                              Uniform f32_3* %141 = OpAccessChain %72 %35 
					                                       f32_3 %142 = OpLoad %141 
					                                       f32_3 %143 = OpFAdd %139 %142 
					                                                      OpStore %21 %143 
					                                       f32_3 %146 = OpLoad %145 
					                              Uniform f32_4* %147 = OpAccessChain %33 %36 %35 
					                                       f32_4 %148 = OpLoad %147 
					                                       f32_3 %149 = OpVectorShuffle %148 %148 0 1 2 
					                                         f32 %150 = OpDot %146 %149 
					                                Private f32* %152 = OpAccessChain %66 %151 
					                                                      OpStore %152 %150 
					                                       f32_3 %153 = OpLoad %145 
					                              Uniform f32_4* %154 = OpAccessChain %33 %36 %36 
					                                       f32_4 %155 = OpLoad %154 
					                                       f32_3 %156 = OpVectorShuffle %155 %155 0 1 2 
					                                         f32 %157 = OpDot %153 %156 
					                                Private f32* %158 = OpAccessChain %66 %98 
					                                                      OpStore %158 %157 
					                                       f32_3 %159 = OpLoad %145 
					                              Uniform f32_4* %160 = OpAccessChain %33 %36 %50 
					                                       f32_4 %161 = OpLoad %160 
					                                       f32_3 %162 = OpVectorShuffle %161 %161 0 1 2 
					                                         f32 %163 = OpDot %159 %162 
					                                Private f32* %164 = OpAccessChain %66 %29 
					                                                      OpStore %164 %163 
					                                       f32_4 %165 = OpLoad %66 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                       f32_4 %167 = OpLoad %66 
					                                       f32_3 %168 = OpVectorShuffle %167 %167 0 1 2 
					                                         f32 %169 = OpDot %166 %168 
					                                                      OpStore %95 %169 
					                                         f32 %170 = OpLoad %95 
					                                         f32 %172 = OpExtInst %1 40 %170 %171 
					                                                      OpStore %95 %172 
					                                         f32 %173 = OpLoad %95 
					                                         f32 %174 = OpExtInst %1 32 %173 
					                                                      OpStore %95 %174 
					                                         f32 %175 = OpLoad %95 
					                                       f32_3 %176 = OpCompositeConstruct %175 %175 %175 
					                                       f32_4 %177 = OpLoad %66 
					                                       f32_3 %178 = OpVectorShuffle %177 %177 0 1 2 
					                                       f32_3 %179 = OpFMul %176 %178 
					                                       f32_4 %180 = OpLoad %66 
					                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
					                                                      OpStore %66 %181 
					                                       f32_4 %184 = OpLoad %66 
					                                       f32_3 %185 = OpVectorShuffle %184 %184 0 1 2 
					                                                      OpStore vs_TEXCOORD2 %185 
					                                       f32_3 %186 = OpLoad %21 
					                                       f32_3 %187 = OpLoad %21 
					                                         f32 %188 = OpDot %186 %187 
					                                                      OpStore %95 %188 
					                                         f32 %189 = OpLoad %95 
					                                         f32 %190 = OpExtInst %1 40 %189 %171 
					                                                      OpStore %95 %190 
					                                         f32 %191 = OpLoad %95 
					                                         f32 %192 = OpExtInst %1 32 %191 
					                                                      OpStore %95 %192 
					                                         f32 %193 = OpLoad %95 
					                                       f32_3 %194 = OpCompositeConstruct %193 %193 %193 
					                                       f32_3 %195 = OpLoad %21 
					                                       f32_3 %196 = OpFMul %194 %195 
					                                                      OpStore %21 %196 
					                                       f32_3 %198 = OpLoad %21 
					                                                      OpStore vs_TEXCOORD3 %198 
					                                                      OpStore vs_TEXCOORD8 %200 
					                                 Output f32* %201 = OpAccessChain %106 %35 %98 
					                                         f32 %202 = OpLoad %201 
					                                         f32 %203 = OpFNegate %202 
					                                 Output f32* %204 = OpAccessChain %106 %35 %98 
					                                                      OpStore %204 %203 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 97
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %22 %45 %84 %90 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %12 RelaxedPrecision 
					                                                      OpDecorate %12 DescriptorSet 12 
					                                                      OpDecorate %12 Binding 12 
					                                                      OpDecorate %13 RelaxedPrecision 
					                                                      OpDecorate %16 RelaxedPrecision 
					                                                      OpDecorate %16 DescriptorSet 16 
					                                                      OpDecorate %16 Binding 16 
					                                                      OpDecorate %17 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 22 
					                                                      OpDecorate %25 RelaxedPrecision 
					                                                      OpDecorate %26 RelaxedPrecision 
					                                                      OpMemberDecorate %27 0 Offset 27 
					                                                      OpMemberDecorate %27 1 Offset 27 
					                                                      OpMemberDecorate %27 2 Offset 27 
					                                                      OpMemberDecorate %27 3 RelaxedPrecision 
					                                                      OpMemberDecorate %27 3 Offset 27 
					                                                      OpMemberDecorate %27 4 RelaxedPrecision 
					                                                      OpMemberDecorate %27 4 Offset 27 
					                                                      OpMemberDecorate %27 5 RelaxedPrecision 
					                                                      OpMemberDecorate %27 5 Offset 27 
					                                                      OpMemberDecorate %27 6 RelaxedPrecision 
					                                                      OpMemberDecorate %27 6 Offset 27 
					                                                      OpMemberDecorate %27 7 RelaxedPrecision 
					                                                      OpMemberDecorate %27 7 Offset 27 
					                                                      OpMemberDecorate %27 8 RelaxedPrecision 
					                                                      OpMemberDecorate %27 8 Offset 27 
					                                                      OpDecorate %27 Block 
					                                                      OpDecorate %29 DescriptorSet 29 
					                                                      OpDecorate %29 Binding 29 
					                                                      OpDecorate %34 RelaxedPrecision 
					                                                      OpDecorate %35 RelaxedPrecision 
					                                                      OpDecorate %38 RelaxedPrecision 
					                                                      OpDecorate %43 RelaxedPrecision 
					                                                      OpDecorate %45 RelaxedPrecision 
					                                                      OpDecorate %45 Location 45 
					                                                      OpDecorate %48 RelaxedPrecision 
					                                                      OpDecorate %49 RelaxedPrecision 
					                                                      OpDecorate %53 RelaxedPrecision 
					                                                      OpDecorate %54 RelaxedPrecision 
					                                                      OpDecorate %55 RelaxedPrecision 
					                                                      OpDecorate %58 RelaxedPrecision 
					                                                      OpDecorate %59 RelaxedPrecision 
					                                                      OpDecorate %60 RelaxedPrecision 
					                                                      OpDecorate %65 RelaxedPrecision 
					                                                      OpDecorate %78 RelaxedPrecision 
					                                                      OpDecorate %79 RelaxedPrecision 
					                                                      OpDecorate %80 RelaxedPrecision 
					                                                      OpDecorate %81 RelaxedPrecision 
					                                                      OpDecorate %82 RelaxedPrecision 
					                                                      OpDecorate %84 RelaxedPrecision 
					                                                      OpDecorate %84 Location 84 
					                                                      OpDecorate %86 RelaxedPrecision 
					                                                      OpDecorate %89 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD1 Location 90 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %11 = OpTypePointer UniformConstant %10 
					         UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                              %14 = OpTypeSampler 
					                                              %15 = OpTypePointer UniformConstant %14 
					                     UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                              %18 = OpTypeSampledImage %10 
					                                              %20 = OpTypeVector %6 2 
					                                              %21 = OpTypePointer Input %20 
					                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                               Private f32_4* %25 = OpVariable Private 
					                                              %27 = OpTypeStruct %7 %7 %7 %7 %7 %7 %6 %6 %6 
					                                              %28 = OpTypePointer Uniform %27 
					Uniform struct {f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32; f32; f32;}* %29 = OpVariable Uniform 
					                                              %30 = OpTypeInt 32 1 
					                                          i32 %31 = OpConstant 3 
					                                              %32 = OpTypePointer Uniform %7 
					                                              %36 = OpTypeVector %6 3 
					                                              %37 = OpTypePointer Private %36 
					                               Private f32_3* %38 = OpVariable Private 
					                                              %39 = OpTypeInt 32 0 
					                                          u32 %40 = OpConstant 3 
					                                              %41 = OpTypePointer Private %6 
					                                              %44 = OpTypePointer Input %7 
					                                 Input f32_4* %45 = OpVariable Input 
					                                              %46 = OpTypePointer Input %6 
					                                          i32 %50 = OpConstant 6 
					                                              %51 = OpTypePointer Uniform %6 
					                                          u32 %56 = OpConstant 0 
					                                              %61 = OpTypeBool 
					                                              %62 = OpTypePointer Private %61 
					                                Private bool* %63 = OpVariable Private 
					                                          f32 %66 = OpConstant 3.674022E-40 
					                                          i32 %69 = OpConstant 0 
					                                          i32 %70 = OpConstant 1 
					                                          i32 %72 = OpConstant -1 
					                                              %83 = OpTypePointer Output %7 
					                                Output f32_4* %84 = OpVariable Output 
					                                              %87 = OpTypePointer Output %6 
					                        Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                          read_only Texture2D %13 = OpLoad %12 
					                                      sampler %17 = OpLoad %16 
					                   read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                        f32_2 %23 = OpLoad vs_TEXCOORD0 
					                                        f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                                      OpStore %9 %24 
					                                        f32_4 %26 = OpLoad %9 
					                               Uniform f32_4* %33 = OpAccessChain %29 %31 
					                                        f32_4 %34 = OpLoad %33 
					                                        f32_4 %35 = OpFMul %26 %34 
					                                                      OpStore %25 %35 
					                                 Private f32* %42 = OpAccessChain %25 %40 
					                                          f32 %43 = OpLoad %42 
					                                   Input f32* %47 = OpAccessChain %45 %40 
					                                          f32 %48 = OpLoad %47 
					                                          f32 %49 = OpFMul %43 %48 
					                                 Uniform f32* %52 = OpAccessChain %29 %50 
					                                          f32 %53 = OpLoad %52 
					                                          f32 %54 = OpFNegate %53 
					                                          f32 %55 = OpFAdd %49 %54 
					                                 Private f32* %57 = OpAccessChain %38 %56 
					                                                      OpStore %57 %55 
					                                        f32_4 %58 = OpLoad %25 
					                                        f32_4 %59 = OpLoad %45 
					                                        f32_4 %60 = OpFMul %58 %59 
					                                                      OpStore %25 %60 
					                                 Private f32* %64 = OpAccessChain %38 %56 
					                                          f32 %65 = OpLoad %64 
					                                         bool %67 = OpFOrdLessThan %65 %66 
					                                                      OpStore %63 %67 
					                                         bool %68 = OpLoad %63 
					                                          i32 %71 = OpSelect %68 %70 %69 
					                                          i32 %73 = OpIMul %71 %72 
					                                         bool %74 = OpINotEqual %73 %69 
					                                                      OpSelectionMerge %76 None 
					                                                      OpBranchConditional %74 %75 %76 
					                                              %75 = OpLabel 
					                                                      OpKill
					                                              %76 = OpLabel 
					                                        f32_4 %78 = OpLoad %25 
					                                        f32_3 %79 = OpVectorShuffle %78 %78 3 3 3 
					                                        f32_4 %80 = OpLoad %25 
					                                        f32_3 %81 = OpVectorShuffle %80 %80 0 1 2 
					                                        f32_3 %82 = OpFMul %79 %81 
					                                                      OpStore %38 %82 
					                                 Private f32* %85 = OpAccessChain %25 %40 
					                                          f32 %86 = OpLoad %85 
					                                  Output f32* %88 = OpAccessChain %84 %40 
					                                                      OpStore %88 %86 
					                                        f32_3 %89 = OpLoad %38 
					                                        f32_4 %91 = OpLoad vs_TEXCOORD1 
					                                        f32_3 %92 = OpVectorShuffle %91 %91 3 3 3 
					                                        f32_3 %93 = OpFMul %89 %92 
					                                        f32_4 %94 = OpLoad %84 
					                                        f32_4 %95 = OpVectorShuffle %94 %93 4 5 6 3 
					                                                      OpStore %84 %95 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "gles " {
					Keywords { "FOG_LINEAR" "_EMISSION" "_FLIPBOOKBLENDING_ON" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute mediump vec4 in_COLOR0;
					attribute highp vec4 in_TEXCOORD0;
					attribute highp float in_TEXCOORD1;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec3 vs_TEXCOORD2;
					varying mediump vec3 vs_TEXCOORD3;
					varying highp vec3 vs_TEXCOORD5;
					varying highp vec3 vs_TEXCOORD8;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
					    vs_TEXCOORD1.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
					    gl_Position = u_xlat1;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD0.zw;
					    vs_TEXCOORD5.z = in_TEXCOORD1;
					    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BaseColor;
					uniform 	mediump vec4 _EmissionColor;
					uniform lowp sampler2D _BaseMap;
					uniform lowp sampler2D _EmissionMap;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying highp vec3 vs_TEXCOORD5;
					#define SV_Target0 gl_FragData[0]
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					lowp vec4 u_xlat10_2;
					mediump vec3 u_xlat16_3;
					void main()
					{
					    u_xlat10_0.xyz = texture2D(_EmissionMap, vs_TEXCOORD5.xy).xyz;
					    u_xlat10_1.xyz = texture2D(_EmissionMap, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat10_0.xyz + (-u_xlat10_1.xyz);
					    u_xlat0.xyz = vs_TEXCOORD5.zzz * u_xlat16_0.xyz + u_xlat10_1.xyz;
					    u_xlat10_1 = texture2D(_BaseMap, vs_TEXCOORD5.xy);
					    u_xlat10_2 = texture2D(_BaseMap, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat10_1 + (-u_xlat10_2);
					    u_xlat1 = vs_TEXCOORD5.zzzz * u_xlat16_1 + u_xlat10_2;
					    u_xlat16_1 = u_xlat1 * _BaseColor;
					    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
					    u_xlat16_3.xyz = u_xlat0.xyz * _EmissionColor.xyz + u_xlat16_1.xyz;
					    SV_Target0.w = u_xlat16_1.w;
					    SV_Target0.xyz = u_xlat16_3.xyz * vs_TEXCOORD1.www;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "FOG_LINEAR" "_EMISSION" "_FLIPBOOKBLENDING_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					UNITY_BINDING(1) uniform UnityPerDraw {
					#endif
						UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
						UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
						UNITY_UNIFORM vec4 unity_LODFade;
						UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
						UNITY_UNIFORM mediump vec4 unity_LightData;
						UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
						UNITY_UNIFORM vec4 unity_ProbesOcclusion;
						UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
						UNITY_UNIFORM vec4 unity_LightmapST;
						UNITY_UNIFORM vec4 unity_DynamicLightmapST;
						UNITY_UNIFORM mediump vec4 unity_SHAr;
						UNITY_UNIFORM mediump vec4 unity_SHAg;
						UNITY_UNIFORM mediump vec4 unity_SHAb;
						UNITY_UNIFORM mediump vec4 unity_SHBr;
						UNITY_UNIFORM mediump vec4 unity_SHBg;
						UNITY_UNIFORM mediump vec4 unity_SHBb;
						UNITY_UNIFORM mediump vec4 unity_SHC;
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					};
					#endif
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec4 in_TEXCOORD0;
					in highp float in_TEXCOORD1;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out mediump vec3 vs_TEXCOORD2;
					out mediump vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD5;
					out highp vec3 vs_TEXCOORD8;
					vec3 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
					    vs_TEXCOORD1.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					#ifdef UNITY_ADRENO_ES3
					    vs_TEXCOORD1.w = min(max(vs_TEXCOORD1.w, 0.0), 1.0);
					#else
					    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
					#endif
					    gl_Position = u_xlat1;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = max(u_xlat6, 1.17549435e-38);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    vs_TEXCOORD5.xy = in_TEXCOORD0.zw;
					    vs_TEXCOORD5.z = in_TEXCOORD1;
					    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					UNITY_BINDING(0) uniform UnityPerMaterial {
					#endif
						UNITY_UNIFORM vec4 _SoftParticleFadeParams;
						UNITY_UNIFORM vec4 _CameraFadeParams;
						UNITY_UNIFORM vec4 _BaseMap_ST;
						UNITY_UNIFORM mediump vec4 _BaseColor;
						UNITY_UNIFORM mediump vec4 _EmissionColor;
						UNITY_UNIFORM mediump vec4 _BaseColorAddSubDiff;
						UNITY_UNIFORM mediump float _Cutoff;
						UNITY_UNIFORM mediump float _DistortionStrengthScaled;
						UNITY_UNIFORM mediump float _DistortionBlend;
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					};
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
					UNITY_LOCATION(1) uniform mediump sampler2D _EmissionMap;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec4 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					void main()
					{
					    u_xlat16_0.xyz = texture(_EmissionMap, vs_TEXCOORD5.xy).xyz;
					    u_xlat16_1.xyz = texture(_EmissionMap, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
					    u_xlat0.xyz = vs_TEXCOORD5.zzz * u_xlat16_0.xyz + u_xlat16_1.xyz;
					    u_xlat16_1 = texture(_BaseMap, vs_TEXCOORD5.xy);
					    u_xlat16_2 = texture(_BaseMap, vs_TEXCOORD0.xy);
					    u_xlat16_1 = u_xlat16_1 + (-u_xlat16_2);
					    u_xlat1 = vs_TEXCOORD5.zzzz * u_xlat16_1 + u_xlat16_2;
					    u_xlat16_1 = u_xlat1 * _BaseColor;
					    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
					    u_xlat16_3.xyz = u_xlat0.xyz * _EmissionColor.xyz + u_xlat16_1.xyz;
					    SV_Target0.w = u_xlat16_1.w;
					    SV_Target0.xyz = u_xlat16_3.xyz * vs_TEXCOORD1.www;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					Keywords { "FOG_LINEAR" "_EMISSION" "_FLIPBOOKBLENDING_ON" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 215
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %9 %11 %15 %16 %22 %106 %120 %145 %183 %197 %199 %205 %208 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
					                                                      OpName vs_TEXCOORD8 "vs_TEXCOORD8" 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %9 Location 9 
					                                                      OpDecorate %11 RelaxedPrecision 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %12 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 15 
					                                                      OpDecorate %16 Location 16 
					                                                      OpDecorate %22 Location 22 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpDecorate %28 ArrayStride 28 
					                                                      OpDecorate %30 ArrayStride 30 
					                                                      OpMemberDecorate %31 0 Offset 31 
					                                                      OpMemberDecorate %31 1 Offset 31 
					                                                      OpMemberDecorate %31 2 Offset 31 
					                                                      OpMemberDecorate %31 3 RelaxedPrecision 
					                                                      OpMemberDecorate %31 3 Offset 31 
					                                                      OpMemberDecorate %31 4 RelaxedPrecision 
					                                                      OpMemberDecorate %31 4 Offset 31 
					                                                      OpMemberDecorate %31 5 RelaxedPrecision 
					                                                      OpMemberDecorate %31 5 Offset 31 
					                                                      OpMemberDecorate %31 6 Offset 31 
					                                                      OpMemberDecorate %31 7 RelaxedPrecision 
					                                                      OpMemberDecorate %31 7 Offset 31 
					                                                      OpMemberDecorate %31 8 Offset 31 
					                                                      OpMemberDecorate %31 9 Offset 31 
					                                                      OpMemberDecorate %31 10 RelaxedPrecision 
					                                                      OpMemberDecorate %31 10 Offset 31 
					                                                      OpMemberDecorate %31 11 RelaxedPrecision 
					                                                      OpMemberDecorate %31 11 Offset 31 
					                                                      OpMemberDecorate %31 12 RelaxedPrecision 
					                                                      OpMemberDecorate %31 12 Offset 31 
					                                                      OpMemberDecorate %31 13 RelaxedPrecision 
					                                                      OpMemberDecorate %31 13 Offset 31 
					                                                      OpMemberDecorate %31 14 RelaxedPrecision 
					                                                      OpMemberDecorate %31 14 Offset 31 
					                                                      OpMemberDecorate %31 15 RelaxedPrecision 
					                                                      OpMemberDecorate %31 15 Offset 31 
					                                                      OpMemberDecorate %31 16 RelaxedPrecision 
					                                                      OpMemberDecorate %31 16 Offset 31 
					                                                      OpDecorate %31 Block 
					                                                      OpDecorate %33 DescriptorSet 33 
					                                                      OpDecorate %33 Binding 33 
					                                                      OpDecorate %69 ArrayStride 69 
					                                                      OpMemberDecorate %70 0 Offset 70 
					                                                      OpMemberDecorate %70 1 Offset 70 
					                                                      OpMemberDecorate %70 2 Offset 70 
					                                                      OpMemberDecorate %70 3 Offset 70 
					                                                      OpDecorate %70 Block 
					                                                      OpDecorate %72 DescriptorSet 72 
					                                                      OpDecorate %72 Binding 72 
					                                                      OpMemberDecorate %104 0 BuiltIn 104 
					                                                      OpMemberDecorate %104 1 BuiltIn 104 
					                                                      OpMemberDecorate %104 2 BuiltIn 104 
					                                                      OpDecorate %104 Block 
					                                                      OpDecorate vs_TEXCOORD1 Location 120 
					                                                      OpDecorate %145 Location 145 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 183 
					                                                      OpDecorate vs_TEXCOORD3 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD3 Location 197 
					                                                      OpDecorate vs_TEXCOORD5 Location 199 
					                                                      OpDecorate %205 Location 205 
					                                                      OpDecorate vs_TEXCOORD8 Location 208 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Output %7 
					                                 Output f32_4* %9 = OpVariable Output 
					                                              %10 = OpTypePointer Input %7 
					                                 Input f32_4* %11 = OpVariable Input 
					                                              %13 = OpTypeVector %6 2 
					                                              %14 = OpTypePointer Output %13 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                 Input f32_4* %16 = OpVariable Input 
					                                              %19 = OpTypeVector %6 3 
					                                              %20 = OpTypePointer Private %19 
					                               Private f32_3* %21 = OpVariable Private 
					                                 Input f32_4* %22 = OpVariable Input 
					                                              %25 = OpTypeInt 32 0 
					                                          u32 %26 = OpConstant 4 
					                                              %27 = OpTypeArray %7 %26 
					                                              %28 = OpTypeArray %7 %26 
					                                          u32 %29 = OpConstant 2 
					                                              %30 = OpTypeArray %7 %29 
					                                              %31 = OpTypeStruct %27 %28 %7 %7 %7 %30 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
					                                              %32 = OpTypePointer Uniform %31 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %33 = OpVariable Uniform 
					                                              %34 = OpTypeInt 32 1 
					                                          i32 %35 = OpConstant 0 
					                                          i32 %36 = OpConstant 1 
					                                              %37 = OpTypePointer Uniform %7 
					                                          i32 %50 = OpConstant 2 
					                                          i32 %60 = OpConstant 3 
					                                              %65 = OpTypePointer Private %7 
					                               Private f32_4* %66 = OpVariable Private 
					                                              %69 = OpTypeArray %7 %26 
					                                              %70 = OpTypeStruct %19 %7 %7 %69 
					                                              %71 = OpTypePointer Uniform %70 
					Uniform struct {f32_3; f32_4; f32_4; f32_4[4];}* %72 = OpVariable Uniform 
					                                              %94 = OpTypePointer Private %6 
					                                 Private f32* %95 = OpVariable Private 
					                                          u32 %98 = OpConstant 1 
					                                              %99 = OpTypePointer Uniform %6 
					                                             %103 = OpTypeArray %6 %98 
					                                             %104 = OpTypeStruct %7 %6 %103 
					                                             %105 = OpTypePointer Output %104 
					        Output struct {f32_4; f32; f32[1];}* %106 = OpVariable Output 
					                                         f32 %111 = OpConstant 3.674022E-40 
					                                         f32 %118 = OpConstant 3.674022E-40 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                         u32 %125 = OpConstant 3 
					                                             %129 = OpTypePointer Output %6 
					                                             %140 = OpTypePointer Uniform %19 
					                                             %144 = OpTypePointer Input %19 
					                                Input f32_3* %145 = OpVariable Input 
					                                         u32 %151 = OpConstant 0 
					                                         f32 %171 = OpConstant 3.674022E-40 
					                                             %182 = OpTypePointer Output %19 
					                       Output f32_3* vs_TEXCOORD2 = OpVariable Output 
					                       Output f32_3* vs_TEXCOORD3 = OpVariable Output 
					                       Output f32_3* vs_TEXCOORD5 = OpVariable Output 
					                                             %204 = OpTypePointer Input %6 
					                                  Input f32* %205 = OpVariable Input 
					                       Output f32_3* vs_TEXCOORD8 = OpVariable Output 
					                                       f32_3 %209 = OpConstantComposite %118 %118 %118 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %12 = OpLoad %11 
					                                                      OpStore %9 %12 
					                                        f32_4 %17 = OpLoad %16 
					                                        f32_2 %18 = OpVectorShuffle %17 %17 0 1 
					                                                      OpStore vs_TEXCOORD0 %18 
					                                        f32_4 %23 = OpLoad %22 
					                                        f32_3 %24 = OpVectorShuffle %23 %23 1 1 1 
					                               Uniform f32_4* %38 = OpAccessChain %33 %35 %36 
					                                        f32_4 %39 = OpLoad %38 
					                                        f32_3 %40 = OpVectorShuffle %39 %39 0 1 2 
					                                        f32_3 %41 = OpFMul %24 %40 
					                                                      OpStore %21 %41 
					                               Uniform f32_4* %42 = OpAccessChain %33 %35 %35 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_3 %44 = OpVectorShuffle %43 %43 0 1 2 
					                                        f32_4 %45 = OpLoad %22 
					                                        f32_3 %46 = OpVectorShuffle %45 %45 0 0 0 
					                                        f32_3 %47 = OpFMul %44 %46 
					                                        f32_3 %48 = OpLoad %21 
					                                        f32_3 %49 = OpFAdd %47 %48 
					                                                      OpStore %21 %49 
					                               Uniform f32_4* %51 = OpAccessChain %33 %35 %50 
					                                        f32_4 %52 = OpLoad %51 
					                                        f32_3 %53 = OpVectorShuffle %52 %52 0 1 2 
					                                        f32_4 %54 = OpLoad %22 
					                                        f32_3 %55 = OpVectorShuffle %54 %54 2 2 2 
					                                        f32_3 %56 = OpFMul %53 %55 
					                                        f32_3 %57 = OpLoad %21 
					                                        f32_3 %58 = OpFAdd %56 %57 
					                                                      OpStore %21 %58 
					                                        f32_3 %59 = OpLoad %21 
					                               Uniform f32_4* %61 = OpAccessChain %33 %35 %60 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_3 %63 = OpVectorShuffle %62 %62 0 1 2 
					                                        f32_3 %64 = OpFAdd %59 %63 
					                                                      OpStore %21 %64 
					                                        f32_3 %67 = OpLoad %21 
					                                        f32_4 %68 = OpVectorShuffle %67 %67 1 1 1 1 
					                               Uniform f32_4* %73 = OpAccessChain %72 %60 %36 
					                                        f32_4 %74 = OpLoad %73 
					                                        f32_4 %75 = OpFMul %68 %74 
					                                                      OpStore %66 %75 
					                               Uniform f32_4* %76 = OpAccessChain %72 %60 %35 
					                                        f32_4 %77 = OpLoad %76 
					                                        f32_3 %78 = OpLoad %21 
					                                        f32_4 %79 = OpVectorShuffle %78 %78 0 0 0 0 
					                                        f32_4 %80 = OpFMul %77 %79 
					                                        f32_4 %81 = OpLoad %66 
					                                        f32_4 %82 = OpFAdd %80 %81 
					                                                      OpStore %66 %82 
					                               Uniform f32_4* %83 = OpAccessChain %72 %60 %50 
					                                        f32_4 %84 = OpLoad %83 
					                                        f32_3 %85 = OpLoad %21 
					                                        f32_4 %86 = OpVectorShuffle %85 %85 2 2 2 2 
					                                        f32_4 %87 = OpFMul %84 %86 
					                                        f32_4 %88 = OpLoad %66 
					                                        f32_4 %89 = OpFAdd %87 %88 
					                                                      OpStore %66 %89 
					                                        f32_4 %90 = OpLoad %66 
					                               Uniform f32_4* %91 = OpAccessChain %72 %60 %60 
					                                        f32_4 %92 = OpLoad %91 
					                                        f32_4 %93 = OpFAdd %90 %92 
					                                                      OpStore %66 %93 
					                                 Private f32* %96 = OpAccessChain %66 %29 
					                                          f32 %97 = OpLoad %96 
					                                Uniform f32* %100 = OpAccessChain %72 %36 %98 
					                                         f32 %101 = OpLoad %100 
					                                         f32 %102 = OpFDiv %97 %101 
					                                                      OpStore %95 %102 
					                                       f32_4 %107 = OpLoad %66 
					                               Output f32_4* %108 = OpAccessChain %106 %35 
					                                                      OpStore %108 %107 
					                                         f32 %109 = OpLoad %95 
					                                         f32 %110 = OpFNegate %109 
					                                         f32 %112 = OpFAdd %110 %111 
					                                                      OpStore %95 %112 
					                                         f32 %113 = OpLoad %95 
					                                Uniform f32* %114 = OpAccessChain %72 %36 %29 
					                                         f32 %115 = OpLoad %114 
					                                         f32 %116 = OpFMul %113 %115 
					                                                      OpStore %95 %116 
					                                         f32 %117 = OpLoad %95 
					                                         f32 %119 = OpExtInst %1 40 %117 %118 
					                                                      OpStore %95 %119 
					                                         f32 %121 = OpLoad %95 
					                                Uniform f32* %122 = OpAccessChain %72 %50 %29 
					                                         f32 %123 = OpLoad %122 
					                                         f32 %124 = OpFMul %121 %123 
					                                Uniform f32* %126 = OpAccessChain %72 %50 %125 
					                                         f32 %127 = OpLoad %126 
					                                         f32 %128 = OpFAdd %124 %127 
					                                 Output f32* %130 = OpAccessChain vs_TEXCOORD1 %125 
					                                                      OpStore %130 %128 
					                                 Output f32* %131 = OpAccessChain vs_TEXCOORD1 %125 
					                                         f32 %132 = OpLoad %131 
					                                         f32 %133 = OpExtInst %1 43 %132 %118 %111 
					                                 Output f32* %134 = OpAccessChain vs_TEXCOORD1 %125 
					                                                      OpStore %134 %133 
					                                       f32_3 %135 = OpLoad %21 
					                                       f32_4 %136 = OpLoad vs_TEXCOORD1 
					                                       f32_4 %137 = OpVectorShuffle %136 %135 4 5 6 3 
					                                                      OpStore vs_TEXCOORD1 %137 
					                                       f32_3 %138 = OpLoad %21 
					                                       f32_3 %139 = OpFNegate %138 
					                              Uniform f32_3* %141 = OpAccessChain %72 %35 
					                                       f32_3 %142 = OpLoad %141 
					                                       f32_3 %143 = OpFAdd %139 %142 
					                                                      OpStore %21 %143 
					                                       f32_3 %146 = OpLoad %145 
					                              Uniform f32_4* %147 = OpAccessChain %33 %36 %35 
					                                       f32_4 %148 = OpLoad %147 
					                                       f32_3 %149 = OpVectorShuffle %148 %148 0 1 2 
					                                         f32 %150 = OpDot %146 %149 
					                                Private f32* %152 = OpAccessChain %66 %151 
					                                                      OpStore %152 %150 
					                                       f32_3 %153 = OpLoad %145 
					                              Uniform f32_4* %154 = OpAccessChain %33 %36 %36 
					                                       f32_4 %155 = OpLoad %154 
					                                       f32_3 %156 = OpVectorShuffle %155 %155 0 1 2 
					                                         f32 %157 = OpDot %153 %156 
					                                Private f32* %158 = OpAccessChain %66 %98 
					                                                      OpStore %158 %157 
					                                       f32_3 %159 = OpLoad %145 
					                              Uniform f32_4* %160 = OpAccessChain %33 %36 %50 
					                                       f32_4 %161 = OpLoad %160 
					                                       f32_3 %162 = OpVectorShuffle %161 %161 0 1 2 
					                                         f32 %163 = OpDot %159 %162 
					                                Private f32* %164 = OpAccessChain %66 %29 
					                                                      OpStore %164 %163 
					                                       f32_4 %165 = OpLoad %66 
					                                       f32_3 %166 = OpVectorShuffle %165 %165 0 1 2 
					                                       f32_4 %167 = OpLoad %66 
					                                       f32_3 %168 = OpVectorShuffle %167 %167 0 1 2 
					                                         f32 %169 = OpDot %166 %168 
					                                                      OpStore %95 %169 
					                                         f32 %170 = OpLoad %95 
					                                         f32 %172 = OpExtInst %1 40 %170 %171 
					                                                      OpStore %95 %172 
					                                         f32 %173 = OpLoad %95 
					                                         f32 %174 = OpExtInst %1 32 %173 
					                                                      OpStore %95 %174 
					                                         f32 %175 = OpLoad %95 
					                                       f32_3 %176 = OpCompositeConstruct %175 %175 %175 
					                                       f32_4 %177 = OpLoad %66 
					                                       f32_3 %178 = OpVectorShuffle %177 %177 0 1 2 
					                                       f32_3 %179 = OpFMul %176 %178 
					                                       f32_4 %180 = OpLoad %66 
					                                       f32_4 %181 = OpVectorShuffle %180 %179 4 5 6 3 
					                                                      OpStore %66 %181 
					                                       f32_4 %184 = OpLoad %66 
					                                       f32_3 %185 = OpVectorShuffle %184 %184 0 1 2 
					                                                      OpStore vs_TEXCOORD2 %185 
					                                       f32_3 %186 = OpLoad %21 
					                                       f32_3 %187 = OpLoad %21 
					                                         f32 %188 = OpDot %186 %187 
					                                                      OpStore %95 %188 
					                                         f32 %189 = OpLoad %95 
					                                         f32 %190 = OpExtInst %1 40 %189 %171 
					                                                      OpStore %95 %190 
					                                         f32 %191 = OpLoad %95 
					                                         f32 %192 = OpExtInst %1 32 %191 
					                                                      OpStore %95 %192 
					                                         f32 %193 = OpLoad %95 
					                                       f32_3 %194 = OpCompositeConstruct %193 %193 %193 
					                                       f32_3 %195 = OpLoad %21 
					                                       f32_3 %196 = OpFMul %194 %195 
					                                                      OpStore %21 %196 
					                                       f32_3 %198 = OpLoad %21 
					                                                      OpStore vs_TEXCOORD3 %198 
					                                       f32_4 %200 = OpLoad %16 
					                                       f32_2 %201 = OpVectorShuffle %200 %200 2 3 
					                                       f32_3 %202 = OpLoad vs_TEXCOORD5 
					                                       f32_3 %203 = OpVectorShuffle %202 %201 3 4 2 
					                                                      OpStore vs_TEXCOORD5 %203 
					                                         f32 %206 = OpLoad %205 
					                                 Output f32* %207 = OpAccessChain vs_TEXCOORD5 %29 
					                                                      OpStore %207 %206 
					                                                      OpStore vs_TEXCOORD8 %209 
					                                 Output f32* %210 = OpAccessChain %106 %35 %98 
					                                         f32 %211 = OpLoad %210 
					                                         f32 %212 = OpFNegate %211 
					                                 Output f32* %213 = OpAccessChain %106 %35 %98 
					                                                      OpStore %213 %212 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 122
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %21 %34 %92 %106 %115 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD5 "vs_TEXCOORD5" 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %12 RelaxedPrecision 
					                                                      OpDecorate %12 DescriptorSet 12 
					                                                      OpDecorate %12 Binding 12 
					                                                      OpDecorate %13 RelaxedPrecision 
					                                                      OpDecorate %16 RelaxedPrecision 
					                                                      OpDecorate %16 DescriptorSet 16 
					                                                      OpDecorate %16 Binding 16 
					                                                      OpDecorate %17 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD5 Location 21 
					                                                      OpDecorate %27 RelaxedPrecision 
					                                                      OpDecorate %29 RelaxedPrecision 
					                                                      OpDecorate %30 RelaxedPrecision 
					                                                      OpDecorate %31 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 34 
					                                                      OpDecorate %37 RelaxedPrecision 
					                                                      OpDecorate %40 RelaxedPrecision 
					                                                      OpDecorate %41 RelaxedPrecision 
					                                                      OpDecorate %42 RelaxedPrecision 
					                                                      OpDecorate %43 RelaxedPrecision 
					                                                      OpDecorate %44 RelaxedPrecision 
					                                                      OpDecorate %45 RelaxedPrecision 
					                                                      OpDecorate %49 RelaxedPrecision 
					                                                      OpDecorate %51 RelaxedPrecision 
					                                                      OpDecorate %52 RelaxedPrecision 
					                                                      OpDecorate %54 RelaxedPrecision 
					                                                      OpDecorate %54 DescriptorSet 54 
					                                                      OpDecorate %54 Binding 54 
					                                                      OpDecorate %55 RelaxedPrecision 
					                                                      OpDecorate %56 RelaxedPrecision 
					                                                      OpDecorate %56 DescriptorSet 56 
					                                                      OpDecorate %56 Binding 56 
					                                                      OpDecorate %57 RelaxedPrecision 
					                                                      OpDecorate %62 RelaxedPrecision 
					                                                      OpDecorate %63 RelaxedPrecision 
					                                                      OpDecorate %64 RelaxedPrecision 
					                                                      OpDecorate %68 RelaxedPrecision 
					                                                      OpDecorate %69 RelaxedPrecision 
					                                                      OpDecorate %70 RelaxedPrecision 
					                                                      OpDecorate %71 RelaxedPrecision 
					                                                      OpDecorate %72 RelaxedPrecision 
					                                                      OpDecorate %76 RelaxedPrecision 
					                                                      OpDecorate %78 RelaxedPrecision 
					                                                      OpMemberDecorate %81 0 Offset 81 
					                                                      OpMemberDecorate %81 1 Offset 81 
					                                                      OpMemberDecorate %81 2 Offset 81 
					                                                      OpMemberDecorate %81 3 RelaxedPrecision 
					                                                      OpMemberDecorate %81 3 Offset 81 
					                                                      OpMemberDecorate %81 4 RelaxedPrecision 
					                                                      OpMemberDecorate %81 4 Offset 81 
					                                                      OpMemberDecorate %81 5 RelaxedPrecision 
					                                                      OpMemberDecorate %81 5 Offset 81 
					                                                      OpMemberDecorate %81 6 RelaxedPrecision 
					                                                      OpMemberDecorate %81 6 Offset 81 
					                                                      OpMemberDecorate %81 7 RelaxedPrecision 
					                                                      OpMemberDecorate %81 7 Offset 81 
					                                                      OpMemberDecorate %81 8 RelaxedPrecision 
					                                                      OpMemberDecorate %81 8 Offset 81 
					                                                      OpDecorate %81 Block 
					                                                      OpDecorate %83 DescriptorSet 83 
					                                                      OpDecorate %83 Binding 83 
					                                                      OpDecorate %88 RelaxedPrecision 
					                                                      OpDecorate %90 RelaxedPrecision 
					                                                      OpDecorate %92 RelaxedPrecision 
					                                                      OpDecorate %92 Location 92 
					                                                      OpDecorate %93 RelaxedPrecision 
					                                                      OpDecorate %94 RelaxedPrecision 
					                                                      OpDecorate %95 RelaxedPrecision 
					                                                      OpDecorate %99 RelaxedPrecision 
					                                                      OpDecorate %100 RelaxedPrecision 
					                                                      OpDecorate %102 RelaxedPrecision 
					                                                      OpDecorate %103 RelaxedPrecision 
					                                                      OpDecorate %106 RelaxedPrecision 
					                                                      OpDecorate %106 Location 106 
					                                                      OpDecorate %111 RelaxedPrecision 
					                                                      OpDecorate %114 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD1 Location 115 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 3 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_3* %9 = OpVariable Private 
					                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %11 = OpTypePointer UniformConstant %10 
					         UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                              %14 = OpTypeSampler 
					                                              %15 = OpTypePointer UniformConstant %14 
					                     UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                              %18 = OpTypeSampledImage %10 
					                                              %20 = OpTypePointer Input %7 
					                        Input f32_3* vs_TEXCOORD5 = OpVariable Input 
					                                              %22 = OpTypeVector %6 2 
					                                              %25 = OpTypeVector %6 4 
					                                              %28 = OpTypePointer Private %25 
					                               Private f32_4* %29 = OpVariable Private 
					                                              %33 = OpTypePointer Input %22 
					                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                               Private f32_3* %40 = OpVariable Private 
					                               Private f32_3* %46 = OpVariable Private 
					         UniformConstant read_only Texture2D* %54 = OpVariable UniformConstant 
					                     UniformConstant sampler* %56 = OpVariable UniformConstant 
					                               Private f32_4* %62 = OpVariable Private 
					                               Private f32_4* %68 = OpVariable Private 
					                               Private f32_4* %73 = OpVariable Private 
					                                              %81 = OpTypeStruct %25 %25 %25 %25 %25 %25 %6 %6 %6 
					                                              %82 = OpTypePointer Uniform %81 
					Uniform struct {f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32; f32; f32;}* %83 = OpVariable Uniform 
					                                              %84 = OpTypeInt 32 1 
					                                          i32 %85 = OpConstant 3 
					                                              %86 = OpTypePointer Uniform %25 
					                                              %91 = OpTypePointer Input %25 
					                                 Input f32_4* %92 = OpVariable Input 
					                               Private f32_3* %95 = OpVariable Private 
					                                          i32 %97 = OpConstant 4 
					                                             %105 = OpTypePointer Output %25 
					                               Output f32_4* %106 = OpVariable Output 
					                                             %107 = OpTypeInt 32 0 
					                                         u32 %108 = OpConstant 3 
					                                             %109 = OpTypePointer Private %6 
					                                             %112 = OpTypePointer Output %6 
					                        Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                          read_only Texture2D %13 = OpLoad %12 
					                                      sampler %17 = OpLoad %16 
					                   read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                        f32_3 %23 = OpLoad vs_TEXCOORD5 
					                                        f32_2 %24 = OpVectorShuffle %23 %23 0 1 
					                                        f32_4 %26 = OpImageSampleImplicitLod %19 %24 
					                                        f32_3 %27 = OpVectorShuffle %26 %26 0 1 2 
					                                                      OpStore %9 %27 
					                          read_only Texture2D %30 = OpLoad %12 
					                                      sampler %31 = OpLoad %16 
					                   read_only Texture2DSampled %32 = OpSampledImage %30 %31 
					                                        f32_2 %35 = OpLoad vs_TEXCOORD0 
					                                        f32_4 %36 = OpImageSampleImplicitLod %32 %35 
					                                        f32_3 %37 = OpVectorShuffle %36 %36 0 1 2 
					                                        f32_4 %38 = OpLoad %29 
					                                        f32_4 %39 = OpVectorShuffle %38 %37 4 5 6 3 
					                                                      OpStore %29 %39 
					                                        f32_3 %41 = OpLoad %9 
					                                        f32_4 %42 = OpLoad %29 
					                                        f32_3 %43 = OpVectorShuffle %42 %42 0 1 2 
					                                        f32_3 %44 = OpFNegate %43 
					                                        f32_3 %45 = OpFAdd %41 %44 
					                                                      OpStore %40 %45 
					                                        f32_3 %47 = OpLoad vs_TEXCOORD5 
					                                        f32_3 %48 = OpVectorShuffle %47 %47 2 2 2 
					                                        f32_3 %49 = OpLoad %40 
					                                        f32_3 %50 = OpFMul %48 %49 
					                                        f32_4 %51 = OpLoad %29 
					                                        f32_3 %52 = OpVectorShuffle %51 %51 0 1 2 
					                                        f32_3 %53 = OpFAdd %50 %52 
					                                                      OpStore %46 %53 
					                          read_only Texture2D %55 = OpLoad %54 
					                                      sampler %57 = OpLoad %56 
					                   read_only Texture2DSampled %58 = OpSampledImage %55 %57 
					                                        f32_3 %59 = OpLoad vs_TEXCOORD5 
					                                        f32_2 %60 = OpVectorShuffle %59 %59 0 1 
					                                        f32_4 %61 = OpImageSampleImplicitLod %58 %60 
					                                                      OpStore %29 %61 
					                          read_only Texture2D %63 = OpLoad %54 
					                                      sampler %64 = OpLoad %56 
					                   read_only Texture2DSampled %65 = OpSampledImage %63 %64 
					                                        f32_2 %66 = OpLoad vs_TEXCOORD0 
					                                        f32_4 %67 = OpImageSampleImplicitLod %65 %66 
					                                                      OpStore %62 %67 
					                                        f32_4 %69 = OpLoad %29 
					                                        f32_4 %70 = OpLoad %62 
					                                        f32_4 %71 = OpFNegate %70 
					                                        f32_4 %72 = OpFAdd %69 %71 
					                                                      OpStore %68 %72 
					                                        f32_3 %74 = OpLoad vs_TEXCOORD5 
					                                        f32_4 %75 = OpVectorShuffle %74 %74 2 2 2 2 
					                                        f32_4 %76 = OpLoad %68 
					                                        f32_4 %77 = OpFMul %75 %76 
					                                        f32_4 %78 = OpLoad %62 
					                                        f32_4 %79 = OpFAdd %77 %78 
					                                                      OpStore %73 %79 
					                                        f32_4 %80 = OpLoad %73 
					                               Uniform f32_4* %87 = OpAccessChain %83 %85 
					                                        f32_4 %88 = OpLoad %87 
					                                        f32_4 %89 = OpFMul %80 %88 
					                                                      OpStore %68 %89 
					                                        f32_4 %90 = OpLoad %68 
					                                        f32_4 %93 = OpLoad %92 
					                                        f32_4 %94 = OpFMul %90 %93 
					                                                      OpStore %68 %94 
					                                        f32_3 %96 = OpLoad %46 
					                               Uniform f32_4* %98 = OpAccessChain %83 %97 
					                                        f32_4 %99 = OpLoad %98 
					                                       f32_3 %100 = OpVectorShuffle %99 %99 0 1 2 
					                                       f32_3 %101 = OpFMul %96 %100 
					                                       f32_4 %102 = OpLoad %68 
					                                       f32_3 %103 = OpVectorShuffle %102 %102 0 1 2 
					                                       f32_3 %104 = OpFAdd %101 %103 
					                                                      OpStore %95 %104 
					                                Private f32* %110 = OpAccessChain %68 %108 
					                                         f32 %111 = OpLoad %110 
					                                 Output f32* %113 = OpAccessChain %106 %108 
					                                                      OpStore %113 %111 
					                                       f32_3 %114 = OpLoad %95 
					                                       f32_4 %116 = OpLoad vs_TEXCOORD1 
					                                       f32_3 %117 = OpVectorShuffle %116 %116 3 3 3 
					                                       f32_3 %118 = OpFMul %114 %117 
					                                       f32_4 %119 = OpLoad %106 
					                                       f32_4 %120 = OpVectorShuffle %119 %118 4 5 6 3 
					                                                      OpStore %106 %120 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "gles " {
					Keywords { "FOG_LINEAR" "_ALPHAMODULATE_ON" "_NORMALMAP" }
					"!!GLES
					#ifdef VERTEX
					#version 100
					
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
					uniform 	mediump vec4 unity_WorldTransformParams;
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					attribute highp vec4 in_POSITION0;
					attribute highp vec3 in_NORMAL0;
					attribute mediump vec4 in_COLOR0;
					attribute highp vec2 in_TEXCOORD0;
					attribute highp vec4 in_TANGENT0;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					varying mediump vec4 vs_TEXCOORD2;
					varying mediump vec4 vs_TEXCOORD3;
					varying mediump vec4 vs_TEXCOORD4;
					varying highp vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					float u_xlat16;
					float u_xlat17;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
					    vs_TEXCOORD1.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
					    gl_Position = u_xlat1;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 1.17549435e-38);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyw = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = max(u_xlat17, 1.17549435e-38);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat1.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    vs_TEXCOORD2 = u_xlat1;
					    u_xlat2.w = u_xlat0.y;
					    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
					    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
					    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
					    u_xlat16_4.x = dot(u_xlat3.xyz, in_TANGENT0.xyz);
					    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
					    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
					    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
					    u_xlat16_4.y = dot(u_xlat3.xyz, in_TANGENT0.xyz);
					    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
					    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
					    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
					    u_xlat16_4.z = dot(u_xlat3.xyz, in_TANGENT0.xyz);
					    u_xlat16 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
					    u_xlat16 = max(u_xlat16, 1.17549435e-38);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat16_4.xyz;
					    vs_TEXCOORD3 = u_xlat2;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
					    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    vs_TEXCOORD4 = u_xlat0;
					    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 100
					
					#ifdef GL_FRAGMENT_PRECISION_HIGH
					    precision highp float;
					#else
					    precision mediump float;
					#endif
					precision highp int;
					uniform 	mediump vec4 _BaseColor;
					uniform lowp sampler2D _BaseMap;
					varying mediump vec4 vs_COLOR0;
					varying highp vec2 vs_TEXCOORD0;
					varying highp vec4 vs_TEXCOORD1;
					#define SV_Target0 gl_FragData[0]
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_2;
					void main()
					{
					    u_xlat10_0 = texture2D(_BaseMap, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat10_0 * _BaseColor;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat16_2 = u_xlat16_0.w * vs_COLOR0.w;
					    u_xlat16_1.xyz = vec3(u_xlat16_2) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
					    SV_Target0.w = u_xlat16_2;
					    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD1.www;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 " {
					Keywords { "FOG_LINEAR" "_ALPHAMODULATE_ON" "_NORMALMAP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					UNITY_BINDING(1) uniform UnityPerDraw {
					#endif
						UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
						UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
						UNITY_UNIFORM vec4 unity_LODFade;
						UNITY_UNIFORM mediump vec4 unity_WorldTransformParams;
						UNITY_UNIFORM mediump vec4 unity_LightData;
						UNITY_UNIFORM mediump vec4 unity_LightIndices[2];
						UNITY_UNIFORM vec4 unity_ProbesOcclusion;
						UNITY_UNIFORM mediump vec4 unity_SpecCube0_HDR;
						UNITY_UNIFORM vec4 unity_LightmapST;
						UNITY_UNIFORM vec4 unity_DynamicLightmapST;
						UNITY_UNIFORM mediump vec4 unity_SHAr;
						UNITY_UNIFORM mediump vec4 unity_SHAg;
						UNITY_UNIFORM mediump vec4 unity_SHAb;
						UNITY_UNIFORM mediump vec4 unity_SHBr;
						UNITY_UNIFORM mediump vec4 unity_SHBg;
						UNITY_UNIFORM mediump vec4 unity_SHBb;
						UNITY_UNIFORM mediump vec4 unity_SHC;
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					};
					#endif
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					in highp vec4 in_TANGENT0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out mediump vec4 vs_TEXCOORD2;
					out mediump vec4 vs_TEXCOORD3;
					out mediump vec4 vs_TEXCOORD4;
					out highp vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_4;
					float u_xlat15;
					float u_xlat16;
					float u_xlat17;
					void main()
					{
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
					    vs_TEXCOORD1.w = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
					#ifdef UNITY_ADRENO_ES3
					    vs_TEXCOORD1.w = min(max(vs_TEXCOORD1.w, 0.0), 1.0);
					#else
					    vs_TEXCOORD1.w = clamp(vs_TEXCOORD1.w, 0.0, 1.0);
					#endif
					    gl_Position = u_xlat1;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = max(u_xlat15, 1.17549435e-38);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyw = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1.w = u_xlat0.x;
					    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = max(u_xlat17, 1.17549435e-38);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat1.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    vs_TEXCOORD2 = u_xlat1;
					    u_xlat2.w = u_xlat0.y;
					    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].x;
					    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].x;
					    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].x;
					    u_xlat16_4.x = dot(u_xlat3.xyz, in_TANGENT0.xyz);
					    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y;
					    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].y;
					    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].y;
					    u_xlat16_4.y = dot(u_xlat3.xyz, in_TANGENT0.xyz);
					    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[0].z;
					    u_xlat3.y = hlslcc_mtx4x4unity_ObjectToWorld[1].z;
					    u_xlat3.z = hlslcc_mtx4x4unity_ObjectToWorld[2].z;
					    u_xlat16_4.z = dot(u_xlat3.xyz, in_TANGENT0.xyz);
					    u_xlat16 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
					    u_xlat16 = max(u_xlat16, 1.17549435e-38);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat16_4.xyz;
					    vs_TEXCOORD3 = u_xlat2;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx;
					    u_xlat1.xyz = u_xlat1.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    vs_TEXCOORD4 = u_xlat0;
					    vs_TEXCOORD8.xyz = vec3(0.0, 0.0, 0.0);
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp float;
					precision highp int;
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					UNITY_BINDING(0) uniform UnityPerMaterial {
					#endif
						UNITY_UNIFORM vec4 _SoftParticleFadeParams;
						UNITY_UNIFORM vec4 _CameraFadeParams;
						UNITY_UNIFORM vec4 _BaseMap_ST;
						UNITY_UNIFORM mediump vec4 _BaseColor;
						UNITY_UNIFORM mediump vec4 _EmissionColor;
						UNITY_UNIFORM mediump vec4 _BaseColorAddSubDiff;
						UNITY_UNIFORM mediump float _Cutoff;
						UNITY_UNIFORM mediump float _DistortionStrengthScaled;
						UNITY_UNIFORM mediump float _DistortionBlend;
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					};
					#endif
					UNITY_LOCATION(0) uniform mediump sampler2D _BaseMap;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					mediump vec3 u_xlat16_1;
					mediump float u_xlat16_2;
					void main()
					{
					    u_xlat16_0 = texture(_BaseMap, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat16_0 * _BaseColor;
					    u_xlat16_1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat16_2 = u_xlat16_0.w * vs_COLOR0.w;
					    u_xlat16_1.xyz = vec3(u_xlat16_2) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
					    SV_Target0.w = u_xlat16_2;
					    SV_Target0.xyz = u_xlat16_1.xyz * vs_TEXCOORD1.www;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					Keywords { "FOG_LINEAR" "_ALPHAMODULATE_ON" "_NORMALMAP" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 322
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %9 %11 %15 %17 %21 %116 %130 %181 %217 %235 %282 %312 %315 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpName vs_TEXCOORD2 "vs_TEXCOORD2" 
					                                                      OpName vs_TEXCOORD3 "vs_TEXCOORD3" 
					                                                      OpName vs_TEXCOORD4 "vs_TEXCOORD4" 
					                                                      OpName vs_TEXCOORD8 "vs_TEXCOORD8" 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %9 Location 9 
					                                                      OpDecorate %11 RelaxedPrecision 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %12 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 15 
					                                                      OpDecorate %17 Location 17 
					                                                      OpDecorate %21 Location 21 
					                                                      OpDecorate %27 ArrayStride 27 
					                                                      OpDecorate %28 ArrayStride 28 
					                                                      OpDecorate %30 ArrayStride 30 
					                                                      OpMemberDecorate %31 0 Offset 31 
					                                                      OpMemberDecorate %31 1 Offset 31 
					                                                      OpMemberDecorate %31 2 Offset 31 
					                                                      OpMemberDecorate %31 3 RelaxedPrecision 
					                                                      OpMemberDecorate %31 3 Offset 31 
					                                                      OpMemberDecorate %31 4 RelaxedPrecision 
					                                                      OpMemberDecorate %31 4 Offset 31 
					                                                      OpMemberDecorate %31 5 RelaxedPrecision 
					                                                      OpMemberDecorate %31 5 Offset 31 
					                                                      OpMemberDecorate %31 6 Offset 31 
					                                                      OpMemberDecorate %31 7 RelaxedPrecision 
					                                                      OpMemberDecorate %31 7 Offset 31 
					                                                      OpMemberDecorate %31 8 Offset 31 
					                                                      OpMemberDecorate %31 9 Offset 31 
					                                                      OpMemberDecorate %31 10 RelaxedPrecision 
					                                                      OpMemberDecorate %31 10 Offset 31 
					                                                      OpMemberDecorate %31 11 RelaxedPrecision 
					                                                      OpMemberDecorate %31 11 Offset 31 
					                                                      OpMemberDecorate %31 12 RelaxedPrecision 
					                                                      OpMemberDecorate %31 12 Offset 31 
					                                                      OpMemberDecorate %31 13 RelaxedPrecision 
					                                                      OpMemberDecorate %31 13 Offset 31 
					                                                      OpMemberDecorate %31 14 RelaxedPrecision 
					                                                      OpMemberDecorate %31 14 Offset 31 
					                                                      OpMemberDecorate %31 15 RelaxedPrecision 
					                                                      OpMemberDecorate %31 15 Offset 31 
					                                                      OpMemberDecorate %31 16 RelaxedPrecision 
					                                                      OpMemberDecorate %31 16 Offset 31 
					                                                      OpDecorate %31 Block 
					                                                      OpDecorate %33 DescriptorSet 33 
					                                                      OpDecorate %33 Binding 33 
					                                                      OpDecorate %79 ArrayStride 79 
					                                                      OpMemberDecorate %80 0 Offset 80 
					                                                      OpMemberDecorate %80 1 Offset 80 
					                                                      OpMemberDecorate %80 2 Offset 80 
					                                                      OpMemberDecorate %80 3 Offset 80 
					                                                      OpDecorate %80 Block 
					                                                      OpDecorate %82 DescriptorSet 82 
					                                                      OpDecorate %82 Binding 82 
					                                                      OpMemberDecorate %114 0 BuiltIn 114 
					                                                      OpMemberDecorate %114 1 BuiltIn 114 
					                                                      OpMemberDecorate %114 2 BuiltIn 114 
					                                                      OpDecorate %114 Block 
					                                                      OpDecorate vs_TEXCOORD1 Location 130 
					                                                      OpDecorate %181 Location 181 
					                                                      OpDecorate vs_TEXCOORD2 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD2 Location 217 
					                                                      OpDecorate %233 RelaxedPrecision 
					                                                      OpDecorate %235 Location 235 
					                                                      OpDecorate %269 RelaxedPrecision 
					                                                      OpDecorate %270 RelaxedPrecision 
					                                                      OpDecorate %271 RelaxedPrecision 
					                                                      OpDecorate %277 RelaxedPrecision 
					                                                      OpDecorate %278 RelaxedPrecision 
					                                                      OpDecorate %279 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD3 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD3 Location 282 
					                                                      OpDecorate %303 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD4 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD4 Location 312 
					                                                      OpDecorate vs_TEXCOORD8 Location 315 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Output %7 
					                                 Output f32_4* %9 = OpVariable Output 
					                                              %10 = OpTypePointer Input %7 
					                                 Input f32_4* %11 = OpVariable Input 
					                                              %13 = OpTypeVector %6 2 
					                                              %14 = OpTypePointer Output %13 
					                       Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                              %16 = OpTypePointer Input %13 
					                                 Input f32_2* %17 = OpVariable Input 
					                                              %19 = OpTypePointer Private %7 
					                               Private f32_4* %20 = OpVariable Private 
					                                 Input f32_4* %21 = OpVariable Input 
					                                              %22 = OpTypeVector %6 3 
					                                              %25 = OpTypeInt 32 0 
					                                          u32 %26 = OpConstant 4 
					                                              %27 = OpTypeArray %7 %26 
					                                              %28 = OpTypeArray %7 %26 
					                                          u32 %29 = OpConstant 2 
					                                              %30 = OpTypeArray %7 %29 
					                                              %31 = OpTypeStruct %27 %28 %7 %7 %7 %30 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 %7 
					                                              %32 = OpTypePointer Uniform %31 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4; f32_4[2]; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32_4;}* %33 = OpVariable Uniform 
					                                              %34 = OpTypeInt 32 1 
					                                          i32 %35 = OpConstant 0 
					                                          i32 %36 = OpConstant 1 
					                                              %37 = OpTypePointer Uniform %7 
					                                          i32 %55 = OpConstant 2 
					                                          i32 %69 = OpConstant 3 
					                               Private f32_4* %76 = OpVariable Private 
					                                              %79 = OpTypeArray %7 %26 
					                                              %80 = OpTypeStruct %22 %7 %7 %79 
					                                              %81 = OpTypePointer Uniform %80 
					Uniform struct {f32_3; f32_4; f32_4; f32_4[4];}* %82 = OpVariable Uniform 
					                                             %104 = OpTypePointer Private %6 
					                                Private f32* %105 = OpVariable Private 
					                                         u32 %108 = OpConstant 1 
					                                             %109 = OpTypePointer Uniform %6 
					                                             %113 = OpTypeArray %6 %108 
					                                             %114 = OpTypeStruct %7 %6 %113 
					                                             %115 = OpTypePointer Output %114 
					        Output struct {f32_4; f32; f32[1];}* %116 = OpVariable Output 
					                                         f32 %121 = OpConstant 3.674022E-40 
					                                         f32 %128 = OpConstant 3.674022E-40 
					                       Output f32_4* vs_TEXCOORD1 = OpVariable Output 
					                                         u32 %135 = OpConstant 3 
					                                             %139 = OpTypePointer Output %6 
					                                             %152 = OpTypePointer Uniform %22 
					                                         f32 %164 = OpConstant 3.674022E-40 
					                                         u32 %175 = OpConstant 0 
					                              Private f32_4* %179 = OpVariable Private 
					                                             %180 = OpTypePointer Input %22 
					                                Input f32_3* %181 = OpVariable Input 
					                                Private f32* %200 = OpVariable Private 
					                       Output f32_4* vs_TEXCOORD2 = OpVariable Output 
					                                             %222 = OpTypePointer Private %22 
					                              Private f32_3* %223 = OpVariable Private 
					                              Private f32_3* %233 = OpVariable Private 
					                                Input f32_4* %235 = OpVariable Input 
					                                Private f32* %268 = OpVariable Private 
					                       Output f32_4* vs_TEXCOORD3 = OpVariable Output 
					                                             %299 = OpTypePointer Input %6 
					                       Output f32_4* vs_TEXCOORD4 = OpVariable Output 
					                                             %314 = OpTypePointer Output %22 
					                       Output f32_3* vs_TEXCOORD8 = OpVariable Output 
					                                       f32_3 %316 = OpConstantComposite %128 %128 %128 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %12 = OpLoad %11 
					                                                      OpStore %9 %12 
					                                        f32_2 %18 = OpLoad %17 
					                                                      OpStore vs_TEXCOORD0 %18 
					                                        f32_4 %23 = OpLoad %21 
					                                        f32_3 %24 = OpVectorShuffle %23 %23 1 1 1 
					                               Uniform f32_4* %38 = OpAccessChain %33 %35 %36 
					                                        f32_4 %39 = OpLoad %38 
					                                        f32_3 %40 = OpVectorShuffle %39 %39 0 1 2 
					                                        f32_3 %41 = OpFMul %24 %40 
					                                        f32_4 %42 = OpLoad %20 
					                                        f32_4 %43 = OpVectorShuffle %42 %41 4 5 6 3 
					                                                      OpStore %20 %43 
					                               Uniform f32_4* %44 = OpAccessChain %33 %35 %35 
					                                        f32_4 %45 = OpLoad %44 
					                                        f32_3 %46 = OpVectorShuffle %45 %45 0 1 2 
					                                        f32_4 %47 = OpLoad %21 
					                                        f32_3 %48 = OpVectorShuffle %47 %47 0 0 0 
					                                        f32_3 %49 = OpFMul %46 %48 
					                                        f32_4 %50 = OpLoad %20 
					                                        f32_3 %51 = OpVectorShuffle %50 %50 0 1 2 
					                                        f32_3 %52 = OpFAdd %49 %51 
					                                        f32_4 %53 = OpLoad %20 
					                                        f32_4 %54 = OpVectorShuffle %53 %52 4 5 6 3 
					                                                      OpStore %20 %54 
					                               Uniform f32_4* %56 = OpAccessChain %33 %35 %55 
					                                        f32_4 %57 = OpLoad %56 
					                                        f32_3 %58 = OpVectorShuffle %57 %57 0 1 2 
					                                        f32_4 %59 = OpLoad %21 
					                                        f32_3 %60 = OpVectorShuffle %59 %59 2 2 2 
					                                        f32_3 %61 = OpFMul %58 %60 
					                                        f32_4 %62 = OpLoad %20 
					                                        f32_3 %63 = OpVectorShuffle %62 %62 0 1 2 
					                                        f32_3 %64 = OpFAdd %61 %63 
					                                        f32_4 %65 = OpLoad %20 
					                                        f32_4 %66 = OpVectorShuffle %65 %64 4 5 6 3 
					                                                      OpStore %20 %66 
					                                        f32_4 %67 = OpLoad %20 
					                                        f32_3 %68 = OpVectorShuffle %67 %67 0 1 2 
					                               Uniform f32_4* %70 = OpAccessChain %33 %35 %69 
					                                        f32_4 %71 = OpLoad %70 
					                                        f32_3 %72 = OpVectorShuffle %71 %71 0 1 2 
					                                        f32_3 %73 = OpFAdd %68 %72 
					                                        f32_4 %74 = OpLoad %20 
					                                        f32_4 %75 = OpVectorShuffle %74 %73 4 5 6 3 
					                                                      OpStore %20 %75 
					                                        f32_4 %77 = OpLoad %20 
					                                        f32_4 %78 = OpVectorShuffle %77 %77 1 1 1 1 
					                               Uniform f32_4* %83 = OpAccessChain %82 %69 %36 
					                                        f32_4 %84 = OpLoad %83 
					                                        f32_4 %85 = OpFMul %78 %84 
					                                                      OpStore %76 %85 
					                               Uniform f32_4* %86 = OpAccessChain %82 %69 %35 
					                                        f32_4 %87 = OpLoad %86 
					                                        f32_4 %88 = OpLoad %20 
					                                        f32_4 %89 = OpVectorShuffle %88 %88 0 0 0 0 
					                                        f32_4 %90 = OpFMul %87 %89 
					                                        f32_4 %91 = OpLoad %76 
					                                        f32_4 %92 = OpFAdd %90 %91 
					                                                      OpStore %76 %92 
					                               Uniform f32_4* %93 = OpAccessChain %82 %69 %55 
					                                        f32_4 %94 = OpLoad %93 
					                                        f32_4 %95 = OpLoad %20 
					                                        f32_4 %96 = OpVectorShuffle %95 %95 2 2 2 2 
					                                        f32_4 %97 = OpFMul %94 %96 
					                                        f32_4 %98 = OpLoad %76 
					                                        f32_4 %99 = OpFAdd %97 %98 
					                                                      OpStore %76 %99 
					                                       f32_4 %100 = OpLoad %76 
					                              Uniform f32_4* %101 = OpAccessChain %82 %69 %69 
					                                       f32_4 %102 = OpLoad %101 
					                                       f32_4 %103 = OpFAdd %100 %102 
					                                                      OpStore %76 %103 
					                                Private f32* %106 = OpAccessChain %76 %29 
					                                         f32 %107 = OpLoad %106 
					                                Uniform f32* %110 = OpAccessChain %82 %36 %108 
					                                         f32 %111 = OpLoad %110 
					                                         f32 %112 = OpFDiv %107 %111 
					                                                      OpStore %105 %112 
					                                       f32_4 %117 = OpLoad %76 
					                               Output f32_4* %118 = OpAccessChain %116 %35 
					                                                      OpStore %118 %117 
					                                         f32 %119 = OpLoad %105 
					                                         f32 %120 = OpFNegate %119 
					                                         f32 %122 = OpFAdd %120 %121 
					                                                      OpStore %105 %122 
					                                         f32 %123 = OpLoad %105 
					                                Uniform f32* %124 = OpAccessChain %82 %36 %29 
					                                         f32 %125 = OpLoad %124 
					                                         f32 %126 = OpFMul %123 %125 
					                                                      OpStore %105 %126 
					                                         f32 %127 = OpLoad %105 
					                                         f32 %129 = OpExtInst %1 40 %127 %128 
					                                                      OpStore %105 %129 
					                                         f32 %131 = OpLoad %105 
					                                Uniform f32* %132 = OpAccessChain %82 %55 %29 
					                                         f32 %133 = OpLoad %132 
					                                         f32 %134 = OpFMul %131 %133 
					                                Uniform f32* %136 = OpAccessChain %82 %55 %135 
					                                         f32 %137 = OpLoad %136 
					                                         f32 %138 = OpFAdd %134 %137 
					                                 Output f32* %140 = OpAccessChain vs_TEXCOORD1 %135 
					                                                      OpStore %140 %138 
					                                 Output f32* %141 = OpAccessChain vs_TEXCOORD1 %135 
					                                         f32 %142 = OpLoad %141 
					                                         f32 %143 = OpExtInst %1 43 %142 %128 %121 
					                                 Output f32* %144 = OpAccessChain vs_TEXCOORD1 %135 
					                                                      OpStore %144 %143 
					                                       f32_4 %145 = OpLoad %20 
					                                       f32_3 %146 = OpVectorShuffle %145 %145 0 1 2 
					                                       f32_4 %147 = OpLoad vs_TEXCOORD1 
					                                       f32_4 %148 = OpVectorShuffle %147 %146 4 5 6 3 
					                                                      OpStore vs_TEXCOORD1 %148 
					                                       f32_4 %149 = OpLoad %20 
					                                       f32_3 %150 = OpVectorShuffle %149 %149 0 1 2 
					                                       f32_3 %151 = OpFNegate %150 
					                              Uniform f32_3* %153 = OpAccessChain %82 %35 
					                                       f32_3 %154 = OpLoad %153 
					                                       f32_3 %155 = OpFAdd %151 %154 
					                                       f32_4 %156 = OpLoad %20 
					                                       f32_4 %157 = OpVectorShuffle %156 %155 4 5 6 3 
					                                                      OpStore %20 %157 
					                                       f32_4 %158 = OpLoad %20 
					                                       f32_3 %159 = OpVectorShuffle %158 %158 0 1 2 
					                                       f32_4 %160 = OpLoad %20 
					                                       f32_3 %161 = OpVectorShuffle %160 %160 0 1 2 
					                                         f32 %162 = OpDot %159 %161 
					                                                      OpStore %105 %162 
					                                         f32 %163 = OpLoad %105 
					                                         f32 %165 = OpExtInst %1 40 %163 %164 
					                                                      OpStore %105 %165 
					                                         f32 %166 = OpLoad %105 
					                                         f32 %167 = OpExtInst %1 32 %166 
					                                                      OpStore %105 %167 
					                                         f32 %168 = OpLoad %105 
					                                       f32_3 %169 = OpCompositeConstruct %168 %168 %168 
					                                       f32_4 %170 = OpLoad %20 
					                                       f32_3 %171 = OpVectorShuffle %170 %170 0 1 2 
					                                       f32_3 %172 = OpFMul %169 %171 
					                                       f32_4 %173 = OpLoad %20 
					                                       f32_4 %174 = OpVectorShuffle %173 %172 4 5 2 6 
					                                                      OpStore %20 %174 
					                                Private f32* %176 = OpAccessChain %20 %175 
					                                         f32 %177 = OpLoad %176 
					                                Private f32* %178 = OpAccessChain %76 %135 
					                                                      OpStore %178 %177 
					                                       f32_3 %182 = OpLoad %181 
					                              Uniform f32_4* %183 = OpAccessChain %33 %36 %35 
					                                       f32_4 %184 = OpLoad %183 
					                                       f32_3 %185 = OpVectorShuffle %184 %184 0 1 2 
					                                         f32 %186 = OpDot %182 %185 
					                                Private f32* %187 = OpAccessChain %179 %175 
					                                                      OpStore %187 %186 
					                                       f32_3 %188 = OpLoad %181 
					                              Uniform f32_4* %189 = OpAccessChain %33 %36 %36 
					                                       f32_4 %190 = OpLoad %189 
					                                       f32_3 %191 = OpVectorShuffle %190 %190 0 1 2 
					                                         f32 %192 = OpDot %188 %191 
					                                Private f32* %193 = OpAccessChain %179 %108 
					                                                      OpStore %193 %192 
					                                       f32_3 %194 = OpLoad %181 
					                              Uniform f32_4* %195 = OpAccessChain %33 %36 %55 
					                                       f32_4 %196 = OpLoad %195 
					                                       f32_3 %197 = OpVectorShuffle %196 %196 0 1 2 
					                                         f32 %198 = OpDot %194 %197 
					                                Private f32* %199 = OpAccessChain %179 %29 
					                                                      OpStore %199 %198 
					                                       f32_4 %201 = OpLoad %179 
					                                       f32_3 %202 = OpVectorShuffle %201 %201 0 1 2 
					                                       f32_4 %203 = OpLoad %179 
					                                       f32_3 %204 = OpVectorShuffle %203 %203 0 1 2 
					                                         f32 %205 = OpDot %202 %204 
					                                                      OpStore %200 %205 
					                                         f32 %206 = OpLoad %200 
					                                         f32 %207 = OpExtInst %1 40 %206 %164 
					                                                      OpStore %200 %207 
					                                         f32 %208 = OpLoad %200 
					                                         f32 %209 = OpExtInst %1 32 %208 
					                                                      OpStore %200 %209 
					                                         f32 %210 = OpLoad %200 
					                                       f32_3 %211 = OpCompositeConstruct %210 %210 %210 
					                                       f32_4 %212 = OpLoad %179 
					                                       f32_3 %213 = OpVectorShuffle %212 %212 0 1 2 
					                                       f32_3 %214 = OpFMul %211 %213 
					                                       f32_4 %215 = OpLoad %76 
					                                       f32_4 %216 = OpVectorShuffle %215 %214 4 5 6 3 
					                                                      OpStore %76 %216 
					                                       f32_4 %218 = OpLoad %76 
					                                                      OpStore vs_TEXCOORD2 %218 
					                                Private f32* %219 = OpAccessChain %20 %108 
					                                         f32 %220 = OpLoad %219 
					                                Private f32* %221 = OpAccessChain %179 %135 
					                                                      OpStore %221 %220 
					                                Uniform f32* %224 = OpAccessChain %33 %35 %35 %175 
					                                         f32 %225 = OpLoad %224 
					                                Private f32* %226 = OpAccessChain %223 %175 
					                                                      OpStore %226 %225 
					                                Uniform f32* %227 = OpAccessChain %33 %35 %36 %175 
					                                         f32 %228 = OpLoad %227 
					                                Private f32* %229 = OpAccessChain %223 %108 
					                                                      OpStore %229 %228 
					                                Uniform f32* %230 = OpAccessChain %33 %35 %55 %175 
					                                         f32 %231 = OpLoad %230 
					                                Private f32* %232 = OpAccessChain %223 %29 
					                                                      OpStore %232 %231 
					                                       f32_3 %234 = OpLoad %223 
					                                       f32_4 %236 = OpLoad %235 
					                                       f32_3 %237 = OpVectorShuffle %236 %236 0 1 2 
					                                         f32 %238 = OpDot %234 %237 
					                                Private f32* %239 = OpAccessChain %233 %175 
					                                                      OpStore %239 %238 
					                                Uniform f32* %240 = OpAccessChain %33 %35 %35 %108 
					                                         f32 %241 = OpLoad %240 
					                                Private f32* %242 = OpAccessChain %223 %175 
					                                                      OpStore %242 %241 
					                                Uniform f32* %243 = OpAccessChain %33 %35 %36 %108 
					                                         f32 %244 = OpLoad %243 
					                                Private f32* %245 = OpAccessChain %223 %108 
					                                                      OpStore %245 %244 
					                                Uniform f32* %246 = OpAccessChain %33 %35 %55 %108 
					                                         f32 %247 = OpLoad %246 
					                                Private f32* %248 = OpAccessChain %223 %29 
					                                                      OpStore %248 %247 
					                                       f32_3 %249 = OpLoad %223 
					                                       f32_4 %250 = OpLoad %235 
					                                       f32_3 %251 = OpVectorShuffle %250 %250 0 1 2 
					                                         f32 %252 = OpDot %249 %251 
					                                Private f32* %253 = OpAccessChain %233 %108 
					                                                      OpStore %253 %252 
					                                Uniform f32* %254 = OpAccessChain %33 %35 %35 %29 
					                                         f32 %255 = OpLoad %254 
					                                Private f32* %256 = OpAccessChain %223 %175 
					                                                      OpStore %256 %255 
					                                Uniform f32* %257 = OpAccessChain %33 %35 %36 %29 
					                                         f32 %258 = OpLoad %257 
					                                Private f32* %259 = OpAccessChain %223 %108 
					                                                      OpStore %259 %258 
					                                Uniform f32* %260 = OpAccessChain %33 %35 %55 %29 
					                                         f32 %261 = OpLoad %260 
					                                Private f32* %262 = OpAccessChain %223 %29 
					                                                      OpStore %262 %261 
					                                       f32_3 %263 = OpLoad %223 
					                                       f32_4 %264 = OpLoad %235 
					                                       f32_3 %265 = OpVectorShuffle %264 %264 0 1 2 
					                                         f32 %266 = OpDot %263 %265 
					                                Private f32* %267 = OpAccessChain %233 %29 
					                                                      OpStore %267 %266 
					                                       f32_3 %269 = OpLoad %233 
					                                       f32_3 %270 = OpLoad %233 
					                                         f32 %271 = OpDot %269 %270 
					                                                      OpStore %268 %271 
					                                         f32 %272 = OpLoad %268 
					                                         f32 %273 = OpExtInst %1 40 %272 %164 
					                                                      OpStore %268 %273 
					                                         f32 %274 = OpLoad %268 
					                                         f32 %275 = OpExtInst %1 32 %274 
					                                                      OpStore %268 %275 
					                                         f32 %276 = OpLoad %268 
					                                       f32_3 %277 = OpCompositeConstruct %276 %276 %276 
					                                       f32_3 %278 = OpLoad %233 
					                                       f32_3 %279 = OpFMul %277 %278 
					                                       f32_4 %280 = OpLoad %179 
					                                       f32_4 %281 = OpVectorShuffle %280 %279 4 5 6 3 
					                                                      OpStore %179 %281 
					                                       f32_4 %283 = OpLoad %179 
					                                                      OpStore vs_TEXCOORD3 %283 
					                                       f32_4 %284 = OpLoad %76 
					                                       f32_3 %285 = OpVectorShuffle %284 %284 2 0 1 
					                                       f32_4 %286 = OpLoad %179 
					                                       f32_3 %287 = OpVectorShuffle %286 %286 1 2 0 
					                                       f32_3 %288 = OpFMul %285 %287 
					                                                      OpStore %223 %288 
					                                       f32_4 %289 = OpLoad %76 
					                                       f32_3 %290 = OpVectorShuffle %289 %289 1 2 0 
					                                       f32_4 %291 = OpLoad %179 
					                                       f32_3 %292 = OpVectorShuffle %291 %291 2 0 1 
					                                       f32_3 %293 = OpFMul %290 %292 
					                                       f32_3 %294 = OpLoad %223 
					                                       f32_3 %295 = OpFNegate %294 
					                                       f32_3 %296 = OpFAdd %293 %295 
					                                       f32_4 %297 = OpLoad %76 
					                                       f32_4 %298 = OpVectorShuffle %297 %296 4 5 6 3 
					                                                      OpStore %76 %298 
					                                  Input f32* %300 = OpAccessChain %235 %135 
					                                         f32 %301 = OpLoad %300 
					                                Uniform f32* %302 = OpAccessChain %33 %69 %135 
					                                         f32 %303 = OpLoad %302 
					                                         f32 %304 = OpFMul %301 %303 
					                                                      OpStore %268 %304 
					                                         f32 %305 = OpLoad %268 
					                                       f32_3 %306 = OpCompositeConstruct %305 %305 %305 
					                                       f32_4 %307 = OpLoad %76 
					                                       f32_3 %308 = OpVectorShuffle %307 %307 0 1 2 
					                                       f32_3 %309 = OpFMul %306 %308 
					                                       f32_4 %310 = OpLoad %20 
					                                       f32_4 %311 = OpVectorShuffle %310 %309 4 5 6 3 
					                                                      OpStore %20 %311 
					                                       f32_4 %313 = OpLoad %20 
					                                                      OpStore vs_TEXCOORD4 %313 
					                                                      OpStore vs_TEXCOORD8 %316 
					                                 Output f32* %317 = OpAccessChain %116 %35 %108 
					                                         f32 %318 = OpLoad %317 
					                                         f32 %319 = OpFNegate %318 
					                                 Output f32* %320 = OpAccessChain %116 %35 %108 
					                                                      OpStore %320 %319 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 79
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %22 %42 %67 %72 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                      OpName vs_TEXCOORD1 "vs_TEXCOORD1" 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %12 RelaxedPrecision 
					                                                      OpDecorate %12 DescriptorSet 12 
					                                                      OpDecorate %12 Binding 12 
					                                                      OpDecorate %13 RelaxedPrecision 
					                                                      OpDecorate %16 RelaxedPrecision 
					                                                      OpDecorate %16 DescriptorSet 16 
					                                                      OpDecorate %16 Binding 16 
					                                                      OpDecorate %17 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD0 Location 22 
					                                                      OpDecorate %25 RelaxedPrecision 
					                                                      OpDecorate %26 RelaxedPrecision 
					                                                      OpMemberDecorate %27 0 Offset 27 
					                                                      OpMemberDecorate %27 1 Offset 27 
					                                                      OpMemberDecorate %27 2 Offset 27 
					                                                      OpMemberDecorate %27 3 RelaxedPrecision 
					                                                      OpMemberDecorate %27 3 Offset 27 
					                                                      OpMemberDecorate %27 4 RelaxedPrecision 
					                                                      OpMemberDecorate %27 4 Offset 27 
					                                                      OpMemberDecorate %27 5 RelaxedPrecision 
					                                                      OpMemberDecorate %27 5 Offset 27 
					                                                      OpMemberDecorate %27 6 RelaxedPrecision 
					                                                      OpMemberDecorate %27 6 Offset 27 
					                                                      OpMemberDecorate %27 7 RelaxedPrecision 
					                                                      OpMemberDecorate %27 7 Offset 27 
					                                                      OpMemberDecorate %27 8 RelaxedPrecision 
					                                                      OpMemberDecorate %27 8 Offset 27 
					                                                      OpDecorate %27 Block 
					                                                      OpDecorate %29 DescriptorSet 29 
					                                                      OpDecorate %29 Binding 29 
					                                                      OpDecorate %34 RelaxedPrecision 
					                                                      OpDecorate %35 RelaxedPrecision 
					                                                      OpDecorate %38 RelaxedPrecision 
					                                                      OpDecorate %39 RelaxedPrecision 
					                                                      OpDecorate %40 RelaxedPrecision 
					                                                      OpDecorate %42 RelaxedPrecision 
					                                                      OpDecorate %42 Location 42 
					                                                      OpDecorate %43 RelaxedPrecision 
					                                                      OpDecorate %44 RelaxedPrecision 
					                                                      OpDecorate %45 RelaxedPrecision 
					                                                      OpDecorate %48 RelaxedPrecision 
					                                                      OpDecorate %50 RelaxedPrecision 
					                                                      OpDecorate %54 RelaxedPrecision 
					                                                      OpDecorate %57 RelaxedPrecision 
					                                                      OpDecorate %58 RelaxedPrecision 
					                                                      OpDecorate %59 RelaxedPrecision 
					                                                      OpDecorate %60 RelaxedPrecision 
					                                                      OpDecorate %61 RelaxedPrecision 
					                                                      OpDecorate %62 RelaxedPrecision 
					                                                      OpDecorate %65 RelaxedPrecision 
					                                                      OpDecorate %67 RelaxedPrecision 
					                                                      OpDecorate %67 Location 67 
					                                                      OpDecorate %68 RelaxedPrecision 
					                                                      OpDecorate %71 RelaxedPrecision 
					                                                      OpDecorate vs_TEXCOORD1 Location 72 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %11 = OpTypePointer UniformConstant %10 
					         UniformConstant read_only Texture2D* %12 = OpVariable UniformConstant 
					                                              %14 = OpTypeSampler 
					                                              %15 = OpTypePointer UniformConstant %14 
					                     UniformConstant sampler* %16 = OpVariable UniformConstant 
					                                              %18 = OpTypeSampledImage %10 
					                                              %20 = OpTypeVector %6 2 
					                                              %21 = OpTypePointer Input %20 
					                        Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                               Private f32_4* %25 = OpVariable Private 
					                                              %27 = OpTypeStruct %7 %7 %7 %7 %7 %7 %6 %6 %6 
					                                              %28 = OpTypePointer Uniform %27 
					Uniform struct {f32_4; f32_4; f32_4; f32_4; f32_4; f32_4; f32; f32; f32;}* %29 = OpVariable Uniform 
					                                              %30 = OpTypeInt 32 1 
					                                          i32 %31 = OpConstant 3 
					                                              %32 = OpTypePointer Uniform %7 
					                                              %36 = OpTypeVector %6 3 
					                                              %37 = OpTypePointer Private %36 
					                               Private f32_3* %38 = OpVariable Private 
					                                              %41 = OpTypePointer Input %7 
					                                 Input f32_4* %42 = OpVariable Input 
					                                          f32 %46 = OpConstant 3.674022E-40 
					                                        f32_3 %47 = OpConstantComposite %46 %46 %46 
					                                              %49 = OpTypePointer Private %6 
					                                 Private f32* %50 = OpVariable Private 
					                                              %51 = OpTypeInt 32 0 
					                                          u32 %52 = OpConstant 3 
					                                              %55 = OpTypePointer Input %6 
					                                          f32 %63 = OpConstant 3.674022E-40 
					                                        f32_3 %64 = OpConstantComposite %63 %63 %63 
					                                              %66 = OpTypePointer Output %7 
					                                Output f32_4* %67 = OpVariable Output 
					                                              %69 = OpTypePointer Output %6 
					                        Input f32_4* vs_TEXCOORD1 = OpVariable Input 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                          read_only Texture2D %13 = OpLoad %12 
					                                      sampler %17 = OpLoad %16 
					                   read_only Texture2DSampled %19 = OpSampledImage %13 %17 
					                                        f32_2 %23 = OpLoad vs_TEXCOORD0 
					                                        f32_4 %24 = OpImageSampleImplicitLod %19 %23 
					                                                      OpStore %9 %24 
					                                        f32_4 %26 = OpLoad %9 
					                               Uniform f32_4* %33 = OpAccessChain %29 %31 
					                                        f32_4 %34 = OpLoad %33 
					                                        f32_4 %35 = OpFMul %26 %34 
					                                                      OpStore %25 %35 
					                                        f32_4 %39 = OpLoad %25 
					                                        f32_3 %40 = OpVectorShuffle %39 %39 0 1 2 
					                                        f32_4 %43 = OpLoad %42 
					                                        f32_3 %44 = OpVectorShuffle %43 %43 0 1 2 
					                                        f32_3 %45 = OpFMul %40 %44 
					                                        f32_3 %48 = OpFAdd %45 %47 
					                                                      OpStore %38 %48 
					                                 Private f32* %53 = OpAccessChain %25 %52 
					                                          f32 %54 = OpLoad %53 
					                                   Input f32* %56 = OpAccessChain %42 %52 
					                                          f32 %57 = OpLoad %56 
					                                          f32 %58 = OpFMul %54 %57 
					                                                      OpStore %50 %58 
					                                          f32 %59 = OpLoad %50 
					                                        f32_3 %60 = OpCompositeConstruct %59 %59 %59 
					                                        f32_3 %61 = OpLoad %38 
					                                        f32_3 %62 = OpFMul %60 %61 
					                                        f32_3 %65 = OpFAdd %62 %64 
					                                                      OpStore %38 %65 
					                                          f32 %68 = OpLoad %50 
					                                  Output f32* %70 = OpAccessChain %67 %52 
					                                                      OpStore %70 %68 
					                                        f32_3 %71 = OpLoad %38 
					                                        f32_4 %73 = OpLoad vs_TEXCOORD1 
					                                        f32_3 %74 = OpVectorShuffle %73 %73 3 3 3 
					                                        f32_3 %75 = OpFMul %71 %74 
					                                        f32_4 %76 = OpLoad %67 
					                                        f32_4 %77 = OpVectorShuffle %76 %75 4 5 6 3 
					                                                      OpStore %67 %77 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
			}
			Program "fp" {
				SubProgram "gles " {
					"!!GLES"
				}
				SubProgram "gles3 " {
					"!!GLES3"
				}
				SubProgram "vulkan " {
					"spirv"
				}
				SubProgram "gles " {
					Keywords { "_ALPHAPREMULTIPLY_ON" "_ALPHATEST_ON" }
					"!!GLES"
				}
				SubProgram "gles3 " {
					Keywords { "_ALPHAPREMULTIPLY_ON" "_ALPHATEST_ON" }
					"!!GLES3"
				}
				SubProgram "vulkan " {
					Keywords { "_ALPHAPREMULTIPLY_ON" "_ALPHATEST_ON" }
					"spirv"
				}
				SubProgram "gles " {
					Keywords { "_EMISSION" "_FLIPBOOKBLENDING_ON" }
					"!!GLES"
				}
				SubProgram "gles3 " {
					Keywords { "_EMISSION" "_FLIPBOOKBLENDING_ON" }
					"!!GLES3"
				}
				SubProgram "vulkan " {
					Keywords { "_EMISSION" "_FLIPBOOKBLENDING_ON" }
					"spirv"
				}
				SubProgram "gles " {
					Keywords { "_ALPHAMODULATE_ON" "_NORMALMAP" }
					"!!GLES"
				}
				SubProgram "gles3 " {
					Keywords { "_ALPHAMODULATE_ON" "_NORMALMAP" }
					"!!GLES3"
				}
				SubProgram "vulkan " {
					Keywords { "_ALPHAMODULATE_ON" "_NORMALMAP" }
					"spirv"
				}
				SubProgram "gles " {
					Keywords { "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles3 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES3"
				}
				SubProgram "vulkan " {
					Keywords { "FOG_LINEAR" }
					"spirv"
				}
				SubProgram "gles " {
					Keywords { "FOG_LINEAR" "_ALPHAPREMULTIPLY_ON" "_ALPHATEST_ON" }
					"!!GLES"
				}
				SubProgram "gles3 " {
					Keywords { "FOG_LINEAR" "_ALPHAPREMULTIPLY_ON" "_ALPHATEST_ON" }
					"!!GLES3"
				}
				SubProgram "vulkan " {
					Keywords { "FOG_LINEAR" "_ALPHAPREMULTIPLY_ON" "_ALPHATEST_ON" }
					"spirv"
				}
				SubProgram "gles " {
					Keywords { "FOG_LINEAR" "_EMISSION" "_FLIPBOOKBLENDING_ON" }
					"!!GLES"
				}
				SubProgram "gles3 " {
					Keywords { "FOG_LINEAR" "_EMISSION" "_FLIPBOOKBLENDING_ON" }
					"!!GLES3"
				}
				SubProgram "vulkan " {
					Keywords { "FOG_LINEAR" "_EMISSION" "_FLIPBOOKBLENDING_ON" }
					"spirv"
				}
				SubProgram "gles " {
					Keywords { "FOG_LINEAR" "_ALPHAMODULATE_ON" "_NORMALMAP" }
					"!!GLES"
				}
				SubProgram "gles3 " {
					Keywords { "FOG_LINEAR" "_ALPHAMODULATE_ON" "_NORMALMAP" }
					"!!GLES3"
				}
				SubProgram "vulkan " {
					Keywords { "FOG_LINEAR" "_ALPHAMODULATE_ON" "_NORMALMAP" }
					"spirv"
				}
			}
		}
	}
	CustomEditor "UnityEditor.Rendering.Universal.ShaderGUI.ParticlesUnlitShader"
}