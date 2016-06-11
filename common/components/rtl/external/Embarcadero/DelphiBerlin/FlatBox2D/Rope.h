#ifndef RopeH
#define RopeH

// ==========================================================================
//
//   Copyright(c) 2012-2014 Embarcadero Technologies, Inc.
//
// ==========================================================================

//
// Delphi-C++ Library Bridge
// Interface for library FlatBox2D
//

#include <System.hpp>

#include "Box2D\Common\b2Math.h"
#include "Box2D\Rope\b2Rope.h"


typedef b2Rope* b2RopeHandle;
typedef b2RopeDef* b2RopeDefHandle;

#if defined(__cplusplus)
extern "C" {
#endif


// ------------------ class b2RopeDef ------------------
__declspec(dllexport) b2RopeDef __cdecl b2RopeDef_b2RopeDef_1();
// ------------------ class b2RopeDef ------------------


// ------------------ class b2RopeWrapper ------------------
__declspec(dllexport) b2RopeHandle __cdecl b2Rope_b2Rope_1();
__declspec(dllexport) void __cdecl b2Rope_dtor(b2RopeHandle handle);

__declspec(dllexport) void __cdecl b2Rope_Initialize(b2RopeHandle handle, const b2RopeDef* def);
__declspec(dllexport) void __cdecl b2Rope_Step(b2RopeHandle handle, float timeStep, int iterations);
__declspec(dllexport) int __cdecl b2Rope_GetVertexCount(b2RopeHandle handle);
__declspec(dllexport) const b2Vec2* __cdecl b2Rope_GetVertices(b2RopeHandle handle);
__declspec(dllexport) void __cdecl b2Rope_Draw(b2RopeHandle handle, b2Draw* draw);
__declspec(dllexport) void __cdecl b2Rope_SetAngle(b2RopeHandle handle, float angle);
// ------------------ class b2RopeWrapper ------------------


#if defined(__cplusplus)
};
#endif

#endif // RopeH
