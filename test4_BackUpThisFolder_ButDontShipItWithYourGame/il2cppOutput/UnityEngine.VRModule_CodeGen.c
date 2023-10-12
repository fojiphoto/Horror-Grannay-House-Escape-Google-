#include "pch-c.h"
#ifndef _MSC_VER
# include <alloca.h>
#else
# include <malloc.h>
#endif


#include "codegen/il2cpp-codegen-metadata.h"





// 0x00000001 System.Boolean UnityEngine.XR.XRSettings::get_enabled()
extern void XRSettings_get_enabled_m5ECD63DA0B306F7A3FBFD6B67A5B0702F8AEFB54 (void);
// 0x00000002 UnityEngine.RenderTextureDescriptor UnityEngine.XR.XRSettings::get_eyeTextureDesc()
extern void XRSettings_get_eyeTextureDesc_m5E3192C4B94BF8173315571B335444CB4644D324 (void);
// 0x00000003 System.Void UnityEngine.XR.XRSettings::get_eyeTextureDesc_Injected(UnityEngine.RenderTextureDescriptor&)
extern void XRSettings_get_eyeTextureDesc_Injected_m34E7723D7493113CDE5A18D5C7A9F051E5C9DDC3 (void);
// 0x00000004 System.Void UnityEngine.XR.XRDevice::InvokeDeviceLoaded(System.String)
extern void XRDevice_InvokeDeviceLoaded_m07DEE6645B38728C7B8615DAAD6BE592C1DC59F9 (void);
static Il2CppMethodPointer s_methodPointers[4] = 
{
	XRSettings_get_enabled_m5ECD63DA0B306F7A3FBFD6B67A5B0702F8AEFB54,
	XRSettings_get_eyeTextureDesc_m5E3192C4B94BF8173315571B335444CB4644D324,
	XRSettings_get_eyeTextureDesc_Injected_m34E7723D7493113CDE5A18D5C7A9F051E5C9DDC3,
	XRDevice_InvokeDeviceLoaded_m07DEE6645B38728C7B8615DAAD6BE592C1DC59F9,
};
static const int32_t s_InvokerIndices[4] = 
{
	7731,
	7764,
	7637,
	7648,
};
IL2CPP_EXTERN_C const Il2CppCodeGenModule g_UnityEngine_VRModule_CodeGenModule;
const Il2CppCodeGenModule g_UnityEngine_VRModule_CodeGenModule = 
{
	"UnityEngine.VRModule.dll",
	4,
	s_methodPointers,
	0,
	NULL,
	s_InvokerIndices,
	0,
	NULL,
	0,
	NULL,
	0,
	NULL,
	NULL,
	NULL, // module initializer,
	NULL,
	NULL,
	NULL,
};
