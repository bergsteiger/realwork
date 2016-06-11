#ifndef CommonH
#define CommonH

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

#include "Box2D\Common\b2BlockAllocator.h"
#include "Box2D\Common\b2Draw.h"
#include "Box2D\Common\b2Math.h"
#include "Box2D\Common\b2Settings.h"
#include "Box2D\Common\b2StackAllocator.h"
#include "Box2D\Common\b2Timer.h"


typedef b2BlockAllocator* b2BlockAllocatorHandle;
typedef b2Color* b2ColorHandle;
typedef b2Draw* b2DrawHandle;
typedef b2Mat22* b2Mat22Handle;
typedef b2Mat33* b2Mat33Handle;
typedef b2Rot* b2RotHandle;
typedef b2StackAllocator* b2StackAllocatorHandle;
typedef b2StackEntry* b2StackEntryHandle;
typedef b2Sweep* b2SweepHandle;
typedef b2Timer* b2TimerHandle;
typedef b2Transform* b2TransformHandle;
typedef b2Vec2* b2Vec2Handle;
typedef b2Vec3* b2Vec3Handle;
typedef b2Version* b2VersionHandle;

// ------------------ Ib2Draw interface for class b2Draw ------------------
struct __declspec(uuid("{251796EC-5843-2641-5E13-EF05F9D46768}")) Ib2Draw : public IUnknown {
virtual void DrawPolygon(const b2Vec2* vertices, int vertexCount, const b2Color& color) = 0;
virtual void DrawSolidPolygon(const b2Vec2* vertices, int vertexCount, const b2Color& color) = 0;
virtual void DrawCircle(const b2Vec2& center, float radius, const b2Color& color) = 0;
virtual void DrawSolidCircle(const b2Vec2& center, float radius, const b2Vec2& axis, const b2Color& color) = 0;
virtual void DrawSegment(const b2Vec2& p1, const b2Vec2& p2, const b2Color& color) = 0;
virtual void DrawTransform(const b2Transform& xf) = 0;
};


#if defined(__cplusplus)
extern "C" {
#endif

__declspec(dllexport) b2DrawHandle __cdecl Create_b2Draw_delegate(Ib2Draw* intf);__declspec(dllexport) void __cdecl Destroy_b2Draw_delegate(b2DrawHandle handle);


// ------------------ class b2Version ------------------
__declspec(dllexport) b2Version __cdecl b2Version_b2Version();
// ------------------ class b2Version ------------------


// ------------------ class b2BlockAllocatorWrapper ------------------
__declspec(dllexport) b2BlockAllocatorHandle __cdecl b2BlockAllocator_b2BlockAllocator_1();
__declspec(dllexport) void __cdecl b2BlockAllocator_dtor(b2BlockAllocatorHandle handle);

__declspec(dllexport) void* __cdecl b2BlockAllocator_Allocate(b2BlockAllocatorHandle handle, int size);
__declspec(dllexport) void __cdecl b2BlockAllocator_Free(b2BlockAllocatorHandle handle, void* p, int size);
__declspec(dllexport) void __cdecl b2BlockAllocator_Clear(b2BlockAllocatorHandle handle);
// ------------------ class b2BlockAllocatorWrapper ------------------


// ------------------ class b2Vec2 ------------------
__declspec(dllexport) b2Vec2 __cdecl b2Vec2_b2Vec2_1();
__declspec(dllexport) b2Vec2 __cdecl b2Vec2_b2Vec2_2(float x, float y);


__declspec(dllexport) void __cdecl b2Vec2_SetZero(b2Vec2Handle handle);
__declspec(dllexport) void __cdecl b2Vec2_Set(b2Vec2Handle handle, float x_, float y_);
__declspec(dllexport) float __cdecl b2Vec2_Length(b2Vec2Handle handle);
__declspec(dllexport) float __cdecl b2Vec2_LengthSquared(b2Vec2Handle handle);
__declspec(dllexport) float __cdecl b2Vec2_Normalize(b2Vec2Handle handle);
__declspec(dllexport) bool __cdecl b2Vec2_IsValid(b2Vec2Handle handle);
__declspec(dllexport) b2Vec2 __cdecl b2Vec2_Skew(b2Vec2Handle handle);
// ------------------ class b2Vec2 ------------------


// ------------------ class b2Vec3 ------------------
__declspec(dllexport) b2Vec3 __cdecl b2Vec3_b2Vec3_1();
__declspec(dllexport) b2Vec3 __cdecl b2Vec3_b2Vec3_2(float x, float y, float z);
__declspec(dllexport) void __cdecl b2Vec3_SetZero(b2Vec3Handle handle);
__declspec(dllexport) void __cdecl b2Vec3_Set(b2Vec3Handle handle, float x_, float y_, float z_);
// ------------------ class b2Vec3 ------------------


// ------------------ class b2Mat22 ------------------
__declspec(dllexport) b2Mat22 __cdecl b2Mat22_b2Mat22_1();
__declspec(dllexport) b2Mat22 __cdecl b2Mat22_b2Mat22_2(const b2Vec2& c1, const b2Vec2& c2);
__declspec(dllexport) b2Mat22 __cdecl b2Mat22_b2Mat22_3(float a11, float a12, float a21, float a22);
__declspec(dllexport) void __cdecl b2Mat22_Set(b2Mat22Handle handle, const b2Vec2& c1, const b2Vec2& c2);
__declspec(dllexport) void __cdecl b2Mat22_SetIdentity(b2Mat22Handle handle);
__declspec(dllexport) void __cdecl b2Mat22_SetZero(b2Mat22Handle handle);
__declspec(dllexport) b2Mat22 __cdecl b2Mat22_GetInverse(b2Mat22Handle handle);
__declspec(dllexport) b2Vec2 __cdecl b2Mat22_Solve(b2Mat22Handle handle, const b2Vec2& b);
// ------------------ class b2Mat22 ------------------


// ------------------ class b2Mat33 ------------------
__declspec(dllexport) b2Mat33 __cdecl b2Mat33_b2Mat33_1();
__declspec(dllexport) b2Mat33 __cdecl b2Mat33_b2Mat33_2(const b2Vec3& c1, const b2Vec3& c2, const b2Vec3& c3);
__declspec(dllexport) void __cdecl b2Mat33_SetZero(b2Mat33Handle handle);
__declspec(dllexport) b2Vec3 __cdecl b2Mat33_Solve33(b2Mat33Handle handle, const b2Vec3& b);
__declspec(dllexport) b2Vec2 __cdecl b2Mat33_Solve22(b2Mat33Handle handle, const b2Vec2& b);
__declspec(dllexport) void __cdecl b2Mat33_GetInverse22(b2Mat33Handle handle, b2Mat33* M);
__declspec(dllexport) void __cdecl b2Mat33_GetSymInverse33(b2Mat33Handle handle, b2Mat33* M);
// ------------------ class b2Mat33 ------------------


// ------------------ class b2Rot ------------------
__declspec(dllexport) b2Rot __cdecl b2Rot_b2Rot_1();
__declspec(dllexport) b2Rot __cdecl b2Rot_b2Rot_2(float angle);
__declspec(dllexport) void __cdecl b2Rot_Set(b2RotHandle handle, float angle);
__declspec(dllexport) void __cdecl b2Rot_SetIdentity(b2RotHandle handle);
__declspec(dllexport) float __cdecl b2Rot_GetAngle(b2RotHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2Rot_GetXAxis(b2RotHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2Rot_GetYAxis(b2RotHandle handle);
// ------------------ class b2Rot ------------------


// ------------------ class b2Transform ------------------
__declspec(dllexport) b2Transform __cdecl b2Transform_b2Transform_1();
__declspec(dllexport) b2Transform __cdecl b2Transform_b2Transform_2(const b2Vec2& position, const b2Rot& rotation);
__declspec(dllexport) void __cdecl b2Transform_SetIdentity(b2TransformHandle handle);
__declspec(dllexport) void __cdecl b2Transform_Set(b2TransformHandle handle, const b2Vec2& position, float angle);
// ------------------ class b2Transform ------------------


// ------------------ class b2Sweep ------------------
__declspec(dllexport) b2Sweep __cdecl b2Sweep_b2Sweep();
__declspec(dllexport) void __cdecl b2Sweep_GetTransform(b2SweepHandle handle, b2Transform* xfb, float beta);
__declspec(dllexport) void __cdecl b2Sweep_Advance(b2SweepHandle handle, float alpha);
__declspec(dllexport) void __cdecl b2Sweep_Normalize(b2SweepHandle handle);
// ------------------ class b2Sweep ------------------


// ------------------ class b2Color ------------------
__declspec(dllexport) b2Color __cdecl b2Color_b2Color_1();
__declspec(dllexport) b2Color __cdecl b2Color_b2Color_2(float r, float g, float b, float a);
__declspec(dllexport) void __cdecl b2Color_Set(b2ColorHandle handle, float ri, float gi, float bi, float ai);
// ------------------ class b2Color ------------------


// ------------------ class b2DrawWrapper ------------------

__declspec(dllexport) void __cdecl b2Draw_SetFlags(b2DrawHandle handle, unsigned int flags);
__declspec(dllexport) unsigned int __cdecl b2Draw_GetFlags(b2DrawHandle handle);
__declspec(dllexport) void __cdecl b2Draw_AppendFlags(b2DrawHandle handle, unsigned int flags);
__declspec(dllexport) void __cdecl b2Draw_ClearFlags(b2DrawHandle handle, unsigned int flags);
__declspec(dllexport) void __cdecl b2Draw_DrawPolygon(b2DrawHandle handle, const b2Vec2* vertices, int vertexCount, const b2Color& color);
__declspec(dllexport) void __cdecl b2Draw_DrawSolidPolygon(b2DrawHandle handle, const b2Vec2* vertices, int vertexCount, const b2Color& color);
__declspec(dllexport) void __cdecl b2Draw_DrawCircle(b2DrawHandle handle, const b2Vec2& center, float radius, const b2Color& color);
__declspec(dllexport) void __cdecl b2Draw_DrawSolidCircle(b2DrawHandle handle, const b2Vec2& center, float radius, const b2Vec2& axis, const b2Color& color);
__declspec(dllexport) void __cdecl b2Draw_DrawSegment(b2DrawHandle handle, const b2Vec2& p1, const b2Vec2& p2, const b2Color& color);
__declspec(dllexport) void __cdecl b2Draw_DrawTransform(b2DrawHandle handle, const b2Transform& xf);
// ------------------ class b2DrawWrapper ------------------


// ------------------ class b2StackEntry ------------------
__declspec(dllexport) b2StackEntry __cdecl b2StackEntry_b2StackEntry();
// ------------------ class b2StackEntry ------------------


// ------------------ class b2StackAllocatorWrapper ------------------
__declspec(dllexport) b2StackAllocatorHandle __cdecl b2StackAllocator_b2StackAllocator_1();
__declspec(dllexport) void __cdecl b2StackAllocator_dtor(b2StackAllocatorHandle handle);

__declspec(dllexport) void* __cdecl b2StackAllocator_Allocate(b2StackAllocatorHandle handle, int size);
__declspec(dllexport) void __cdecl b2StackAllocator_Free(b2StackAllocatorHandle handle, void* p);
__declspec(dllexport) int __cdecl b2StackAllocator_GetMaxAllocation(b2StackAllocatorHandle handle);
// ------------------ class b2StackAllocatorWrapper ------------------


// ------------------ class b2Timer ------------------
__declspec(dllexport) b2Timer __cdecl b2Timer_b2Timer_1();
__declspec(dllexport) void __cdecl b2Timer_Reset(b2TimerHandle handle);
__declspec(dllexport) float __cdecl b2Timer_GetMilliseconds(b2TimerHandle handle);
// ------------------ class b2Timer ------------------


// Accessors for the global variable 'b2_version'
__declspec(dllexport) b2Version __cdecl Get_b2_version();
__declspec(dllexport) void __cdecl Set_b2_version(b2Version);

// Accessors for the global variable 'b2Vec2_zero'
__declspec(dllexport) const b2Vec2 __cdecl Get_b2Vec2_zero();

__declspec(dllexport) void* __cdecl Common_b2Alloc(int size);
__declspec(dllexport) void __cdecl Common_b2Free(void* mem);
__declspec(dllexport) bool __cdecl Common_b2IsValid(float x);
__declspec(dllexport) float __cdecl Common_b2InvSqrt(float x);
__declspec(dllexport) float __cdecl Common_b2Dot(const b2Vec2& a, const b2Vec2& b);
__declspec(dllexport) float __cdecl Common_b2Cross(const b2Vec2& a, const b2Vec2& b);
__declspec(dllexport) b2Vec2 __cdecl Common_b2Cross2(const b2Vec2& a, float s);
__declspec(dllexport) b2Vec2 __cdecl Common_b2Cross3(float s, const b2Vec2& a);
__declspec(dllexport) b2Vec2 __cdecl Common_b2Mul(const b2Mat22& A, const b2Vec2& v);
__declspec(dllexport) b2Vec2 __cdecl Common_b2MulT(const b2Mat22& A, const b2Vec2& v);
__declspec(dllexport) float __cdecl Common_b2Distance(const b2Vec2& a, const b2Vec2& b);
__declspec(dllexport) float __cdecl Common_b2DistanceSquared(const b2Vec2& a, const b2Vec2& b);
__declspec(dllexport) float __cdecl Common_b2Dot2(const b2Vec3& a, const b2Vec3& b);
__declspec(dllexport) b2Vec3 __cdecl Common_b2Cross4(const b2Vec3& a, const b2Vec3& b);
__declspec(dllexport) b2Mat22 __cdecl Common_b2Mul2(const b2Mat22& A, const b2Mat22& B);
__declspec(dllexport) b2Mat22 __cdecl Common_b2MulT2(const b2Mat22& A, const b2Mat22& B);
__declspec(dllexport) b2Vec3 __cdecl Common_b2Mul3(const b2Mat33& A, const b2Vec3& v);
__declspec(dllexport) b2Vec2 __cdecl Common_b2Mul22(const b2Mat33& A, const b2Vec2& v);
__declspec(dllexport) b2Rot __cdecl Common_b2Mul4(const b2Rot& q, const b2Rot& r);
__declspec(dllexport) b2Rot __cdecl Common_b2MulT3(const b2Rot& q, const b2Rot& r);
__declspec(dllexport) b2Vec2 __cdecl Common_b2Mul5(const b2Rot& q, const b2Vec2& v);
__declspec(dllexport) b2Vec2 __cdecl Common_b2MulT4(const b2Rot& q, const b2Vec2& v);
__declspec(dllexport) b2Vec2 __cdecl Common_b2Mul6(const b2Transform& T, const b2Vec2& v);
__declspec(dllexport) b2Vec2 __cdecl Common_b2MulT5(const b2Transform& T, const b2Vec2& v);
__declspec(dllexport) b2Transform __cdecl Common_b2Mul7(const b2Transform& A, const b2Transform& B);
__declspec(dllexport) b2Transform __cdecl Common_b2MulT6(const b2Transform& A, const b2Transform& B);
__declspec(dllexport) b2Vec2 __cdecl Common_b2Abs(const b2Vec2& a);
__declspec(dllexport) b2Mat22 __cdecl Common_b2Abs2(const b2Mat22& A);
__declspec(dllexport) b2Vec2 __cdecl Common_b2Min(const b2Vec2& a, const b2Vec2& b);
__declspec(dllexport) b2Vec2 __cdecl Common_b2Max(const b2Vec2& a, const b2Vec2& b);
__declspec(dllexport) b2Vec2 __cdecl Common_b2Clamp(const b2Vec2& a, const b2Vec2& low, const b2Vec2& high);
__declspec(dllexport) unsigned int __cdecl Common_b2NextPowerOfTwo(unsigned int x);
__declspec(dllexport) bool __cdecl Common_b2IsPowerOfTwo(unsigned int x);


#if defined(__cplusplus)
};
#endif

#endif // CommonH
