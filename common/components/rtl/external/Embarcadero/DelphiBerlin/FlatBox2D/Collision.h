#ifndef CollisionH
#define CollisionH

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

#include "Box2D\Collision\Shapes\b2ChainShape.h"
#include "Box2D\Collision\Shapes\b2CircleShape.h"
#include "Box2D\Collision\Shapes\b2EdgeShape.h"
#include "Box2D\Collision\Shapes\b2PolygonShape.h"
#include "Box2D\Collision\Shapes\b2Shape.h"
#include "Box2D\Collision\b2BroadPhase.h"
#include "Box2D\Collision\b2Collision.h"
#include "Box2D\Collision\b2Distance.h"
#include "Box2D\Collision\b2DynamicTree.h"
#include "Box2D\Collision\b2TimeOfImpact.h"
#include "Box2D\Common\b2BlockAllocator.h"
#include "Box2D\Common\b2Math.h"


typedef b2AABB* b2AABBHandle;
typedef b2BroadPhase* b2BroadPhaseHandle;
typedef b2ChainShape* b2ChainShapeHandle;
typedef b2CircleShape* b2CircleShapeHandle;
typedef b2ClipVertex* b2ClipVertexHandle;
typedef b2ContactFeature* b2ContactFeatureHandle;
typedef b2ContactID* b2ContactIDHandle;
typedef b2DistanceInput* b2DistanceInputHandle;
typedef b2DistanceOutput* b2DistanceOutputHandle;
typedef b2DistanceProxy* b2DistanceProxyHandle;
typedef b2DynamicTree* b2DynamicTreeHandle;
typedef b2EdgeShape* b2EdgeShapeHandle;
typedef b2Manifold* b2ManifoldHandle;
typedef b2ManifoldPoint* b2ManifoldPointHandle;
typedef b2MassData* b2MassDataHandle;
typedef b2Pair* b2PairHandle;
typedef b2PolygonShape* b2PolygonShapeHandle;
typedef b2RayCastInput* b2RayCastInputHandle;
typedef b2RayCastOutput* b2RayCastOutputHandle;
typedef b2Shape* b2ShapeHandle;
typedef b2SimplexCache* b2SimplexCacheHandle;
typedef b2TOIInput* b2TOIInputHandle;
typedef b2TOIOutput* b2TOIOutputHandle;
typedef b2TreeNode* b2TreeNodeHandle;
typedef b2WorldManifold* b2WorldManifoldHandle;

#if defined(__cplusplus)
extern "C" {
#endif


// ------------------ class b2ContactFeature ------------------
__declspec(dllexport) b2ContactFeature __cdecl b2ContactFeature_b2ContactFeature();
// ------------------ class b2ContactFeature ------------------


// ------------------ class b2ContactID ------------------
__declspec(dllexport) b2ContactID __cdecl b2ContactID_b2ContactID();
// ------------------ class b2ContactID ------------------


// ------------------ class b2ManifoldPoint ------------------
__declspec(dllexport) b2ManifoldPoint __cdecl b2ManifoldPoint_b2ManifoldPoint();
// ------------------ class b2ManifoldPoint ------------------


// ------------------ class b2Manifold ------------------
__declspec(dllexport) b2Manifold __cdecl b2Manifold_b2Manifold();
// ------------------ class b2Manifold ------------------


// ------------------ class b2WorldManifold ------------------
__declspec(dllexport) b2WorldManifold __cdecl b2WorldManifold_b2WorldManifold();
__declspec(dllexport) void __cdecl b2WorldManifold_Initialize(b2WorldManifoldHandle handle, const b2Manifold* manifold, const b2Transform& xfA, float radiusA, const b2Transform& xfB, float radiusB);
// ------------------ class b2WorldManifold ------------------


// ------------------ class b2ClipVertex ------------------
__declspec(dllexport) b2ClipVertex __cdecl b2ClipVertex_b2ClipVertex();
// ------------------ class b2ClipVertex ------------------


// ------------------ class b2RayCastInput ------------------
__declspec(dllexport) b2RayCastInput __cdecl b2RayCastInput_b2RayCastInput_1();
// ------------------ class b2RayCastInput ------------------


// ------------------ class b2RayCastOutput ------------------
__declspec(dllexport) b2RayCastOutput __cdecl b2RayCastOutput_b2RayCastOutput();
// ------------------ class b2RayCastOutput ------------------


// ------------------ class b2AABB ------------------
__declspec(dllexport) b2AABB __cdecl b2AABB_b2AABB_1();
__declspec(dllexport) bool __cdecl b2AABB_IsValid(b2AABBHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2AABB_GetCenter(b2AABBHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2AABB_GetExtents(b2AABBHandle handle);
__declspec(dllexport) float __cdecl b2AABB_GetPerimeter(b2AABBHandle handle);
__declspec(dllexport) void __cdecl b2AABB_Combine(b2AABBHandle handle, const b2AABB& aabb);
__declspec(dllexport) void __cdecl b2AABB_Combine2(b2AABBHandle handle, const b2AABB& aabb1, const b2AABB& aabb2);
__declspec(dllexport) bool __cdecl b2AABB_Contains(b2AABBHandle handle, const b2AABB& aabb);
__declspec(dllexport) bool __cdecl b2AABB_RayCast(b2AABBHandle handle, b2RayCastOutput* output, const b2RayCastInput& input);
// ------------------ class b2AABB ------------------


// ------------------ class b2TreeNode ------------------
__declspec(dllexport) b2TreeNode __cdecl b2TreeNode_b2TreeNode();
__declspec(dllexport) bool __cdecl b2TreeNode_IsLeaf(b2TreeNodeHandle handle);
// ------------------ class b2TreeNode ------------------


// ------------------ class b2DynamicTreeWrapper ------------------
__declspec(dllexport) b2DynamicTreeHandle __cdecl b2DynamicTree_b2DynamicTree_1();
__declspec(dllexport) void __cdecl b2DynamicTree_dtor(b2DynamicTreeHandle handle);

__declspec(dllexport) int __cdecl b2DynamicTree_CreateProxy(b2DynamicTreeHandle handle, const b2AABB& aabb, void* userData);
__declspec(dllexport) void __cdecl b2DynamicTree_DestroyProxy(b2DynamicTreeHandle handle, int proxyId);
__declspec(dllexport) bool __cdecl b2DynamicTree_MoveProxy(b2DynamicTreeHandle handle, int proxyId, const b2AABB& aabb1, const b2Vec2& displacement);
__declspec(dllexport) void* __cdecl b2DynamicTree_GetUserData(b2DynamicTreeHandle handle, int proxyId);
__declspec(dllexport) const b2AABB& __cdecl b2DynamicTree_GetFatAABB(b2DynamicTreeHandle handle, int proxyId);
__declspec(dllexport) void __cdecl b2DynamicTree_Validate(b2DynamicTreeHandle handle);
__declspec(dllexport) int __cdecl b2DynamicTree_GetHeight(b2DynamicTreeHandle handle);
__declspec(dllexport) int __cdecl b2DynamicTree_GetMaxBalance(b2DynamicTreeHandle handle);
__declspec(dllexport) float __cdecl b2DynamicTree_GetAreaRatio(b2DynamicTreeHandle handle);
__declspec(dllexport) void __cdecl b2DynamicTree_RebuildBottomUp(b2DynamicTreeHandle handle);
__declspec(dllexport) void __cdecl b2DynamicTree_ShiftOrigin(b2DynamicTreeHandle handle, const b2Vec2& newOrigin);
// ------------------ class b2DynamicTreeWrapper ------------------


// ------------------ class b2Pair ------------------
__declspec(dllexport) b2Pair __cdecl b2Pair_b2Pair();
// ------------------ class b2Pair ------------------


// ------------------ class b2BroadPhaseWrapper ------------------
__declspec(dllexport) b2BroadPhaseHandle __cdecl b2BroadPhase_b2BroadPhase_1();
__declspec(dllexport) void __cdecl b2BroadPhase_dtor(b2BroadPhaseHandle handle);

__declspec(dllexport) int __cdecl b2BroadPhase_CreateProxy(b2BroadPhaseHandle handle, const b2AABB& aabb, void* userData);
__declspec(dllexport) void __cdecl b2BroadPhase_DestroyProxy(b2BroadPhaseHandle handle, int proxyId);
__declspec(dllexport) void __cdecl b2BroadPhase_MoveProxy(b2BroadPhaseHandle handle, int proxyId, const b2AABB& aabb, const b2Vec2& displacement);
__declspec(dllexport) void __cdecl b2BroadPhase_TouchProxy(b2BroadPhaseHandle handle, int proxyId);
__declspec(dllexport) const b2AABB& __cdecl b2BroadPhase_GetFatAABB(b2BroadPhaseHandle handle, int proxyId);
__declspec(dllexport) void* __cdecl b2BroadPhase_GetUserData(b2BroadPhaseHandle handle, int proxyId);
__declspec(dllexport) bool __cdecl b2BroadPhase_TestOverlap(b2BroadPhaseHandle handle, int proxyIdA, int proxyIdB);
__declspec(dllexport) int __cdecl b2BroadPhase_GetProxyCount(b2BroadPhaseHandle handle);
__declspec(dllexport) int __cdecl b2BroadPhase_GetTreeHeight(b2BroadPhaseHandle handle);
__declspec(dllexport) int __cdecl b2BroadPhase_GetTreeBalance(b2BroadPhaseHandle handle);
__declspec(dllexport) float __cdecl b2BroadPhase_GetTreeQuality(b2BroadPhaseHandle handle);
__declspec(dllexport) void __cdecl b2BroadPhase_ShiftOrigin(b2BroadPhaseHandle handle, const b2Vec2& newOrigin);
// ------------------ class b2BroadPhaseWrapper ------------------


// ------------------ class b2DistanceProxy ------------------
__declspec(dllexport) b2DistanceProxy __cdecl b2DistanceProxy_b2DistanceProxy_1();
__declspec(dllexport) void __cdecl b2DistanceProxy_Set(b2DistanceProxyHandle handle, const b2Shape* shape, int index);
__declspec(dllexport) int __cdecl b2DistanceProxy_GetSupport(b2DistanceProxyHandle handle, const b2Vec2& d);
__declspec(dllexport) const b2Vec2& __cdecl b2DistanceProxy_GetSupportVertex(b2DistanceProxyHandle handle, const b2Vec2& d);
__declspec(dllexport) int __cdecl b2DistanceProxy_GetVertexCount(b2DistanceProxyHandle handle);
__declspec(dllexport) const b2Vec2& __cdecl b2DistanceProxy_GetVertex(b2DistanceProxyHandle handle, int index);
// ------------------ class b2DistanceProxy ------------------


// ------------------ class b2SimplexCache ------------------
__declspec(dllexport) b2SimplexCache __cdecl b2SimplexCache_b2SimplexCache();
// ------------------ class b2SimplexCache ------------------


// ------------------ class b2DistanceInput ------------------
__declspec(dllexport) b2DistanceInput __cdecl b2DistanceInput_b2DistanceInput();
// ------------------ class b2DistanceInput ------------------


// ------------------ class b2DistanceOutput ------------------
__declspec(dllexport) b2DistanceOutput __cdecl b2DistanceOutput_b2DistanceOutput();
// ------------------ class b2DistanceOutput ------------------


// ------------------ class b2TOIInput ------------------
__declspec(dllexport) b2TOIInput __cdecl b2TOIInput_b2TOIInput();
// ------------------ class b2TOIInput ------------------


// ------------------ class b2TOIOutput ------------------
__declspec(dllexport) b2TOIOutput __cdecl b2TOIOutput_b2TOIOutput();
// ------------------ class b2TOIOutput ------------------


// ------------------ class b2MassData ------------------
__declspec(dllexport) b2MassData __cdecl b2MassData_b2MassData();
// ------------------ class b2MassData ------------------


// ------------------ class b2ShapeWrapper ------------------

__declspec(dllexport) b2Shape* __cdecl b2Shape_Clone(b2ShapeHandle handle, b2BlockAllocator* allocator);
__declspec(dllexport) b2Shape::Type __cdecl b2Shape_GetType(b2ShapeHandle handle);
__declspec(dllexport) int __cdecl b2Shape_GetChildCount(b2ShapeHandle handle);
__declspec(dllexport) bool __cdecl b2Shape_TestPoint(b2ShapeHandle handle, const b2Transform& xf, const b2Vec2& p);
__declspec(dllexport) bool __cdecl b2Shape_RayCast(b2ShapeHandle handle, b2RayCastOutput* output, const b2RayCastInput& input, const b2Transform& transform, int childIndex);
__declspec(dllexport) void __cdecl b2Shape_ComputeAABB(b2ShapeHandle handle, b2AABB* aabb, const b2Transform& xf, int childIndex);
__declspec(dllexport) void __cdecl b2Shape_ComputeMass(b2ShapeHandle handle, b2MassData* massData, float density);

__declspec(dllexport) b2Shape::Type __cdecl b2Shape_Get_m_type(b2ShapeHandle handle);
__declspec(dllexport) void __cdecl b2Shape_Set_m_type(b2ShapeHandle handle, b2Shape::Type newValue);

__declspec(dllexport) float __cdecl b2Shape_Get_m_radius(b2ShapeHandle handle);
__declspec(dllexport) void __cdecl b2Shape_Set_m_radius(b2ShapeHandle handle, float newValue);
// ------------------ class b2ShapeWrapper ------------------


// ------------------ class b2ChainShapeWrapper ------------------
__declspec(dllexport) b2ChainShapeHandle __cdecl b2ChainShape_b2ChainShape_1();
__declspec(dllexport) void __cdecl b2ChainShape_dtor(b2ChainShapeHandle handle);

__declspec(dllexport) b2Shape* __cdecl b2ChainShape_Clone(b2ChainShapeHandle handle, b2BlockAllocator* allocator);
__declspec(dllexport) b2Shape::Type __cdecl b2ChainShape_GetType(b2ChainShapeHandle handle);
__declspec(dllexport) int __cdecl b2ChainShape_GetChildCount(b2ChainShapeHandle handle);
__declspec(dllexport) bool __cdecl b2ChainShape_TestPoint(b2ChainShapeHandle handle, const b2Transform& xf, const b2Vec2& p);
__declspec(dllexport) bool __cdecl b2ChainShape_RayCast(b2ChainShapeHandle handle, b2RayCastOutput* output, const b2RayCastInput& input, const b2Transform& transform, int childIndex);
__declspec(dllexport) void __cdecl b2ChainShape_ComputeAABB(b2ChainShapeHandle handle, b2AABB* aabb, const b2Transform& xf, int childIndex);
__declspec(dllexport) void __cdecl b2ChainShape_ComputeMass(b2ChainShapeHandle handle, b2MassData* massData, float density);

__declspec(dllexport) b2Shape::Type __cdecl b2ChainShape_Get_m_type(b2ChainShapeHandle handle);
__declspec(dllexport) void __cdecl b2ChainShape_Set_m_type(b2ChainShapeHandle handle, b2Shape::Type newValue);

__declspec(dllexport) float __cdecl b2ChainShape_Get_m_radius(b2ChainShapeHandle handle);
__declspec(dllexport) void __cdecl b2ChainShape_Set_m_radius(b2ChainShapeHandle handle, float newValue);
__declspec(dllexport) void __cdecl b2ChainShape_Clear(b2ChainShapeHandle handle);
__declspec(dllexport) void __cdecl b2ChainShape_CreateLoop(b2ChainShapeHandle handle, const b2Vec2* vertices, int count);
__declspec(dllexport) void __cdecl b2ChainShape_CreateChain(b2ChainShapeHandle handle, const b2Vec2* vertices, int count);
__declspec(dllexport) void __cdecl b2ChainShape_SetPrevVertex(b2ChainShapeHandle handle, const b2Vec2& prevVertex);
__declspec(dllexport) void __cdecl b2ChainShape_SetNextVertex(b2ChainShapeHandle handle, const b2Vec2& nextVertex);
__declspec(dllexport) void __cdecl b2ChainShape_GetChildEdge(b2ChainShapeHandle handle, b2EdgeShape* edge, int index);

__declspec(dllexport) b2Vec2* __cdecl b2ChainShape_Get_m_vertices(b2ChainShapeHandle handle);
__declspec(dllexport) void __cdecl b2ChainShape_Set_m_vertices(b2ChainShapeHandle handle, b2Vec2* newValue);

__declspec(dllexport) int __cdecl b2ChainShape_Get_m_count(b2ChainShapeHandle handle);
__declspec(dllexport) void __cdecl b2ChainShape_Set_m_count(b2ChainShapeHandle handle, int newValue);

__declspec(dllexport) b2Vec2 __cdecl b2ChainShape_Get_m_prevVertex(b2ChainShapeHandle handle);
__declspec(dllexport) void __cdecl b2ChainShape_Set_m_prevVertex(b2ChainShapeHandle handle, b2Vec2 newValue);
__declspec(dllexport) b2Vec2* __cdecl b2ChainShape_Get_m_prevVertex_P(b2ChainShapeHandle handle);

__declspec(dllexport) b2Vec2 __cdecl b2ChainShape_Get_m_nextVertex(b2ChainShapeHandle handle);
__declspec(dllexport) void __cdecl b2ChainShape_Set_m_nextVertex(b2ChainShapeHandle handle, b2Vec2 newValue);
__declspec(dllexport) b2Vec2* __cdecl b2ChainShape_Get_m_nextVertex_P(b2ChainShapeHandle handle);

__declspec(dllexport) bool __cdecl b2ChainShape_Get_m_hasPrevVertex(b2ChainShapeHandle handle);
__declspec(dllexport) void __cdecl b2ChainShape_Set_m_hasPrevVertex(b2ChainShapeHandle handle, bool newValue);

__declspec(dllexport) bool __cdecl b2ChainShape_Get_m_hasNextVertex(b2ChainShapeHandle handle);
__declspec(dllexport) void __cdecl b2ChainShape_Set_m_hasNextVertex(b2ChainShapeHandle handle, bool newValue);
// ------------------ class b2ChainShapeWrapper ------------------


// ------------------ class b2CircleShapeWrapper ------------------
__declspec(dllexport) b2CircleShapeHandle __cdecl b2CircleShape_b2CircleShape_1();
__declspec(dllexport) void __cdecl b2CircleShape_dtor(b2CircleShapeHandle handle);

__declspec(dllexport) b2Shape* __cdecl b2CircleShape_Clone(b2CircleShapeHandle handle, b2BlockAllocator* allocator);
__declspec(dllexport) b2Shape::Type __cdecl b2CircleShape_GetType(b2CircleShapeHandle handle);
__declspec(dllexport) int __cdecl b2CircleShape_GetChildCount(b2CircleShapeHandle handle);
__declspec(dllexport) bool __cdecl b2CircleShape_TestPoint(b2CircleShapeHandle handle, const b2Transform& xf, const b2Vec2& p);
__declspec(dllexport) bool __cdecl b2CircleShape_RayCast(b2CircleShapeHandle handle, b2RayCastOutput* output, const b2RayCastInput& input, const b2Transform& transform, int childIndex);
__declspec(dllexport) void __cdecl b2CircleShape_ComputeAABB(b2CircleShapeHandle handle, b2AABB* aabb, const b2Transform& xf, int childIndex);
__declspec(dllexport) void __cdecl b2CircleShape_ComputeMass(b2CircleShapeHandle handle, b2MassData* massData, float density);

__declspec(dllexport) b2Shape::Type __cdecl b2CircleShape_Get_m_type(b2CircleShapeHandle handle);
__declspec(dllexport) void __cdecl b2CircleShape_Set_m_type(b2CircleShapeHandle handle, b2Shape::Type newValue);

__declspec(dllexport) float __cdecl b2CircleShape_Get_m_radius(b2CircleShapeHandle handle);
__declspec(dllexport) void __cdecl b2CircleShape_Set_m_radius(b2CircleShapeHandle handle, float newValue);
__declspec(dllexport) int __cdecl b2CircleShape_GetSupport(b2CircleShapeHandle handle, const b2Vec2& d);
__declspec(dllexport) const b2Vec2& __cdecl b2CircleShape_GetSupportVertex(b2CircleShapeHandle handle, const b2Vec2& d);
__declspec(dllexport) int __cdecl b2CircleShape_GetVertexCount(b2CircleShapeHandle handle);
__declspec(dllexport) const b2Vec2& __cdecl b2CircleShape_GetVertex(b2CircleShapeHandle handle, int index);

__declspec(dllexport) b2Vec2 __cdecl b2CircleShape_Get_m_p(b2CircleShapeHandle handle);
__declspec(dllexport) void __cdecl b2CircleShape_Set_m_p(b2CircleShapeHandle handle, b2Vec2 newValue);
__declspec(dllexport) b2Vec2* __cdecl b2CircleShape_Get_m_p_P(b2CircleShapeHandle handle);
// ------------------ class b2CircleShapeWrapper ------------------


// ------------------ class b2EdgeShapeWrapper ------------------
__declspec(dllexport) b2EdgeShapeHandle __cdecl b2EdgeShape_b2EdgeShape_1();
__declspec(dllexport) void __cdecl b2EdgeShape_dtor(b2EdgeShapeHandle handle);

__declspec(dllexport) b2Shape* __cdecl b2EdgeShape_Clone(b2EdgeShapeHandle handle, b2BlockAllocator* allocator);
__declspec(dllexport) b2Shape::Type __cdecl b2EdgeShape_GetType(b2EdgeShapeHandle handle);
__declspec(dllexport) int __cdecl b2EdgeShape_GetChildCount(b2EdgeShapeHandle handle);
__declspec(dllexport) bool __cdecl b2EdgeShape_TestPoint(b2EdgeShapeHandle handle, const b2Transform& xf, const b2Vec2& p);
__declspec(dllexport) bool __cdecl b2EdgeShape_RayCast(b2EdgeShapeHandle handle, b2RayCastOutput* output, const b2RayCastInput& input, const b2Transform& transform, int childIndex);
__declspec(dllexport) void __cdecl b2EdgeShape_ComputeAABB(b2EdgeShapeHandle handle, b2AABB* aabb, const b2Transform& xf, int childIndex);
__declspec(dllexport) void __cdecl b2EdgeShape_ComputeMass(b2EdgeShapeHandle handle, b2MassData* massData, float density);

__declspec(dllexport) b2Shape::Type __cdecl b2EdgeShape_Get_m_type(b2EdgeShapeHandle handle);
__declspec(dllexport) void __cdecl b2EdgeShape_Set_m_type(b2EdgeShapeHandle handle, b2Shape::Type newValue);

__declspec(dllexport) float __cdecl b2EdgeShape_Get_m_radius(b2EdgeShapeHandle handle);
__declspec(dllexport) void __cdecl b2EdgeShape_Set_m_radius(b2EdgeShapeHandle handle, float newValue);
__declspec(dllexport) void __cdecl b2EdgeShape_Set(b2EdgeShapeHandle handle, const b2Vec2& v1, const b2Vec2& v2);

__declspec(dllexport) b2Vec2 __cdecl b2EdgeShape_Get_m_vertex1(b2EdgeShapeHandle handle);
__declspec(dllexport) void __cdecl b2EdgeShape_Set_m_vertex1(b2EdgeShapeHandle handle, b2Vec2 newValue);
__declspec(dllexport) b2Vec2* __cdecl b2EdgeShape_Get_m_vertex1_P(b2EdgeShapeHandle handle);

__declspec(dllexport) b2Vec2 __cdecl b2EdgeShape_Get_m_vertex2(b2EdgeShapeHandle handle);
__declspec(dllexport) void __cdecl b2EdgeShape_Set_m_vertex2(b2EdgeShapeHandle handle, b2Vec2 newValue);
__declspec(dllexport) b2Vec2* __cdecl b2EdgeShape_Get_m_vertex2_P(b2EdgeShapeHandle handle);

__declspec(dllexport) b2Vec2 __cdecl b2EdgeShape_Get_m_vertex0(b2EdgeShapeHandle handle);
__declspec(dllexport) void __cdecl b2EdgeShape_Set_m_vertex0(b2EdgeShapeHandle handle, b2Vec2 newValue);
__declspec(dllexport) b2Vec2* __cdecl b2EdgeShape_Get_m_vertex0_P(b2EdgeShapeHandle handle);

__declspec(dllexport) b2Vec2 __cdecl b2EdgeShape_Get_m_vertex3(b2EdgeShapeHandle handle);
__declspec(dllexport) void __cdecl b2EdgeShape_Set_m_vertex3(b2EdgeShapeHandle handle, b2Vec2 newValue);
__declspec(dllexport) b2Vec2* __cdecl b2EdgeShape_Get_m_vertex3_P(b2EdgeShapeHandle handle);

__declspec(dllexport) bool __cdecl b2EdgeShape_Get_m_hasVertex0(b2EdgeShapeHandle handle);
__declspec(dllexport) void __cdecl b2EdgeShape_Set_m_hasVertex0(b2EdgeShapeHandle handle, bool newValue);

__declspec(dllexport) bool __cdecl b2EdgeShape_Get_m_hasVertex3(b2EdgeShapeHandle handle);
__declspec(dllexport) void __cdecl b2EdgeShape_Set_m_hasVertex3(b2EdgeShapeHandle handle, bool newValue);
// ------------------ class b2EdgeShapeWrapper ------------------


// ------------------ class b2PolygonShapeWrapper ------------------
__declspec(dllexport) b2PolygonShapeHandle __cdecl b2PolygonShape_b2PolygonShape_1();
__declspec(dllexport) void __cdecl b2PolygonShape_dtor(b2PolygonShapeHandle handle);

__declspec(dllexport) b2Shape* __cdecl b2PolygonShape_Clone(b2PolygonShapeHandle handle, b2BlockAllocator* allocator);
__declspec(dllexport) b2Shape::Type __cdecl b2PolygonShape_GetType(b2PolygonShapeHandle handle);
__declspec(dllexport) int __cdecl b2PolygonShape_GetChildCount(b2PolygonShapeHandle handle);
__declspec(dllexport) bool __cdecl b2PolygonShape_TestPoint(b2PolygonShapeHandle handle, const b2Transform& xf, const b2Vec2& p);
__declspec(dllexport) bool __cdecl b2PolygonShape_RayCast(b2PolygonShapeHandle handle, b2RayCastOutput* output, const b2RayCastInput& input, const b2Transform& transform, int childIndex);
__declspec(dllexport) void __cdecl b2PolygonShape_ComputeAABB(b2PolygonShapeHandle handle, b2AABB* aabb, const b2Transform& xf, int childIndex);
__declspec(dllexport) void __cdecl b2PolygonShape_ComputeMass(b2PolygonShapeHandle handle, b2MassData* massData, float density);

__declspec(dllexport) b2Shape::Type __cdecl b2PolygonShape_Get_m_type(b2PolygonShapeHandle handle);
__declspec(dllexport) void __cdecl b2PolygonShape_Set_m_type(b2PolygonShapeHandle handle, b2Shape::Type newValue);

__declspec(dllexport) float __cdecl b2PolygonShape_Get_m_radius(b2PolygonShapeHandle handle);
__declspec(dllexport) void __cdecl b2PolygonShape_Set_m_radius(b2PolygonShapeHandle handle, float newValue);
__declspec(dllexport) void __cdecl b2PolygonShape_Set(b2PolygonShapeHandle handle, const b2Vec2* points, int count);
__declspec(dllexport) void __cdecl b2PolygonShape_SetAsBox(b2PolygonShapeHandle handle, float hx, float hy);
__declspec(dllexport) void __cdecl b2PolygonShape_SetAsBox2(b2PolygonShapeHandle handle, float hx, float hy, const b2Vec2& center, float angle);
__declspec(dllexport) int __cdecl b2PolygonShape_GetVertexCount(b2PolygonShapeHandle handle);
__declspec(dllexport) const b2Vec2& __cdecl b2PolygonShape_GetVertex(b2PolygonShapeHandle handle, int index);
__declspec(dllexport) bool __cdecl b2PolygonShape_Validate(b2PolygonShapeHandle handle);

__declspec(dllexport) b2Vec2 __cdecl b2PolygonShape_Get_m_centroid(b2PolygonShapeHandle handle);
__declspec(dllexport) void __cdecl b2PolygonShape_Set_m_centroid(b2PolygonShapeHandle handle, b2Vec2 newValue);
__declspec(dllexport) b2Vec2* __cdecl b2PolygonShape_Get_m_centroid_P(b2PolygonShapeHandle handle);

__declspec(dllexport) b2Vec2 __cdecl b2PolygonShape_Get_m_vertices(b2PolygonShapeHandle handle, int _idx_);
__declspec(dllexport) void __cdecl b2PolygonShape_Set_m_vertices(b2PolygonShapeHandle handle, int _idx_, b2Vec2 newValue);
__declspec(dllexport) b2Vec2* __cdecl b2PolygonShape_Get_m_vertices_P(b2PolygonShapeHandle handle, int _idx_);

__declspec(dllexport) b2Vec2 __cdecl b2PolygonShape_Get_m_normals(b2PolygonShapeHandle handle, int _idx_);
__declspec(dllexport) void __cdecl b2PolygonShape_Set_m_normals(b2PolygonShapeHandle handle, int _idx_, b2Vec2 newValue);
__declspec(dllexport) b2Vec2* __cdecl b2PolygonShape_Get_m_normals_P(b2PolygonShapeHandle handle, int _idx_);

__declspec(dllexport) int __cdecl b2PolygonShape_Get_m_count(b2PolygonShapeHandle handle);
__declspec(dllexport) void __cdecl b2PolygonShape_Set_m_count(b2PolygonShapeHandle handle, int newValue);
// ------------------ class b2PolygonShapeWrapper ------------------

__declspec(dllexport) void __cdecl Collision_b2GetPointStates(b2PointState* state1, b2PointState* state2, const b2Manifold* manifold1, const b2Manifold* manifold2);
__declspec(dllexport) void __cdecl Collision_b2CollideCircles(b2Manifold* manifold, const b2CircleShape* circleA, const b2Transform& xfA, const b2CircleShape* circleB, const b2Transform& xfB);
__declspec(dllexport) void __cdecl Collision_b2CollidePolygonAndCircle(b2Manifold* manifold, const b2PolygonShape* polygonA, const b2Transform& xfA, const b2CircleShape* circleB, const b2Transform& xfB);
__declspec(dllexport) void __cdecl Collision_b2CollidePolygons(b2Manifold* manifold, const b2PolygonShape* polygonA, const b2Transform& xfA, const b2PolygonShape* polygonB, const b2Transform& xfB);
__declspec(dllexport) void __cdecl Collision_b2CollideEdgeAndCircle(b2Manifold* manifold, const b2EdgeShape* polygonA, const b2Transform& xfA, const b2CircleShape* circleB, const b2Transform& xfB);
__declspec(dllexport) void __cdecl Collision_b2CollideEdgeAndPolygon(b2Manifold* manifold, const b2EdgeShape* edgeA, const b2Transform& xfA, const b2PolygonShape* circleB, const b2Transform& xfB);
__declspec(dllexport) int __cdecl Collision_b2ClipSegmentToLine(b2ClipVertex* vOut, const b2ClipVertex* vIn, const b2Vec2& normal, float offset, int vertexIndexA);
__declspec(dllexport) bool __cdecl Collision_b2TestOverlap(const b2Shape* shapeA, int indexA, const b2Shape* shapeB, int indexB, const b2Transform& xfA, const b2Transform& xfB);
__declspec(dllexport) bool __cdecl Collision_b2TestOverlap2(const b2AABB& a, const b2AABB& b);
__declspec(dllexport) bool __cdecl Collision_b2PairLessThan(const b2Pair& pair1, const b2Pair& pair2);
__declspec(dllexport) void __cdecl Collision_b2Distance(b2DistanceOutput* output, b2SimplexCache* cache, const b2DistanceInput* input);
__declspec(dllexport) void __cdecl Collision_b2TimeOfImpact(b2TOIOutput* output, const b2TOIInput* input);


#if defined(__cplusplus)
};
#endif

#endif // CollisionH
