#include "Collision.h"


// ------------------ class b2ContactFeature ------------------
b2ContactFeature __cdecl b2ContactFeature_b2ContactFeature() {
  return  b2ContactFeature();
}

// ------------------ class b2ContactFeature ------------------


// ------------------ class b2ContactID ------------------
b2ContactID __cdecl b2ContactID_b2ContactID() {
  return  b2ContactID();
}

// ------------------ class b2ContactID ------------------


// ------------------ class b2ManifoldPoint ------------------
b2ManifoldPoint __cdecl b2ManifoldPoint_b2ManifoldPoint() {
  return  b2ManifoldPoint();
}

// ------------------ class b2ManifoldPoint ------------------


// ------------------ class b2Manifold ------------------
b2Manifold __cdecl b2Manifold_b2Manifold() {
  return  b2Manifold();
}

// ------------------ class b2Manifold ------------------


// ------------------ class b2WorldManifold ------------------
b2WorldManifold __cdecl b2WorldManifold_b2WorldManifold() {
  return  b2WorldManifold();
}

void __cdecl b2WorldManifold_Initialize(b2WorldManifoldHandle handle, const b2Manifold* manifold, const b2Transform& xfA, float radiusA, const b2Transform& xfB, float radiusB) {
  b2WorldManifold* classPtr = static_cast<b2WorldManifold*>(handle);
  assert(classPtr != 0);
  return (classPtr->Initialize(manifold, xfA, radiusA, xfB, radiusB));
}

// ------------------ class b2WorldManifold ------------------


// ------------------ class b2ClipVertex ------------------
b2ClipVertex __cdecl b2ClipVertex_b2ClipVertex() {
  return  b2ClipVertex();
}

// ------------------ class b2ClipVertex ------------------


// ------------------ class b2RayCastInput ------------------
b2RayCastInput __cdecl b2RayCastInput_b2RayCastInput_1() {
  return  b2RayCastInput();
}

// ------------------ class b2RayCastInput ------------------


// ------------------ class b2RayCastOutput ------------------
b2RayCastOutput __cdecl b2RayCastOutput_b2RayCastOutput() {
  return  b2RayCastOutput();
}

// ------------------ class b2RayCastOutput ------------------


// ------------------ class b2AABB ------------------
b2AABB __cdecl b2AABB_b2AABB_1() {
  return  b2AABB();
}

bool __cdecl b2AABB_IsValid(b2AABBHandle handle) {
  b2AABB* classPtr = static_cast<b2AABB*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsValid());
}

b2Vec2 __cdecl b2AABB_GetCenter(b2AABBHandle handle) {
  b2AABB* classPtr = static_cast<b2AABB*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetCenter());
}

b2Vec2 __cdecl b2AABB_GetExtents(b2AABBHandle handle) {
  b2AABB* classPtr = static_cast<b2AABB*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetExtents());
}

float __cdecl b2AABB_GetPerimeter(b2AABBHandle handle) {
  b2AABB* classPtr = static_cast<b2AABB*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetPerimeter());
}

void __cdecl b2AABB_Combine(b2AABBHandle handle, const b2AABB& aabb) {
  b2AABB* classPtr = static_cast<b2AABB*>(handle);
  assert(classPtr != 0);
  return (classPtr->Combine(aabb));
}

void __cdecl b2AABB_Combine2(b2AABBHandle handle, const b2AABB& aabb1, const b2AABB& aabb2) {
  b2AABB* classPtr = static_cast<b2AABB*>(handle);
  assert(classPtr != 0);
  return (classPtr->Combine(aabb1, aabb2));
}

bool __cdecl b2AABB_Contains(b2AABBHandle handle, const b2AABB& aabb) {
  b2AABB* classPtr = static_cast<b2AABB*>(handle);
  assert(classPtr != 0);
  return (classPtr->Contains(aabb));
}

bool __cdecl b2AABB_RayCast(b2AABBHandle handle, b2RayCastOutput* output, const b2RayCastInput& input) {
  b2AABB* classPtr = static_cast<b2AABB*>(handle);
  assert(classPtr != 0);
  return (classPtr->RayCast(output, input));
}

// ------------------ class b2AABB ------------------


// ------------------ class b2TreeNode ------------------
b2TreeNode __cdecl b2TreeNode_b2TreeNode() {
  return  b2TreeNode();
}

bool __cdecl b2TreeNode_IsLeaf(b2TreeNodeHandle handle) {
  b2TreeNode* classPtr = static_cast<b2TreeNode*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsLeaf());
}

// ------------------ class b2TreeNode ------------------


// ------------------ class b2DynamicTreeWrapper ------------------
b2DynamicTreeHandle __cdecl b2DynamicTree_b2DynamicTree_1() {
  return new b2DynamicTree();
}

void __cdecl b2DynamicTree_dtor(b2DynamicTreeHandle handle) {
  delete handle;
}


int __cdecl b2DynamicTree_CreateProxy(b2DynamicTreeHandle handle, const b2AABB& aabb, void* userData) {
  b2DynamicTree* classPtr = static_cast<b2DynamicTree*>(handle);
  assert(classPtr != 0);
  return (classPtr->CreateProxy(aabb, userData));
}

void __cdecl b2DynamicTree_DestroyProxy(b2DynamicTreeHandle handle, int proxyId) {
  b2DynamicTree* classPtr = static_cast<b2DynamicTree*>(handle);
  assert(classPtr != 0);
  return (classPtr->DestroyProxy(proxyId));
}

bool __cdecl b2DynamicTree_MoveProxy(b2DynamicTreeHandle handle, int proxyId, const b2AABB& aabb1, const b2Vec2& displacement) {
  b2DynamicTree* classPtr = static_cast<b2DynamicTree*>(handle);
  assert(classPtr != 0);
  return (classPtr->MoveProxy(proxyId, aabb1, displacement));
}

void* __cdecl b2DynamicTree_GetUserData(b2DynamicTreeHandle handle, int proxyId) {
  b2DynamicTree* classPtr = static_cast<b2DynamicTree*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUserData(proxyId));
}

const b2AABB& __cdecl b2DynamicTree_GetFatAABB(b2DynamicTreeHandle handle, int proxyId) {
  b2DynamicTree* classPtr = static_cast<b2DynamicTree*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFatAABB(proxyId));
}

void __cdecl b2DynamicTree_Validate(b2DynamicTreeHandle handle) {
  b2DynamicTree* classPtr = static_cast<b2DynamicTree*>(handle);
  assert(classPtr != 0);
  return (classPtr->Validate());
}

int __cdecl b2DynamicTree_GetHeight(b2DynamicTreeHandle handle) {
  b2DynamicTree* classPtr = static_cast<b2DynamicTree*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetHeight());
}

int __cdecl b2DynamicTree_GetMaxBalance(b2DynamicTreeHandle handle) {
  b2DynamicTree* classPtr = static_cast<b2DynamicTree*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMaxBalance());
}

float __cdecl b2DynamicTree_GetAreaRatio(b2DynamicTreeHandle handle) {
  b2DynamicTree* classPtr = static_cast<b2DynamicTree*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAreaRatio());
}

void __cdecl b2DynamicTree_RebuildBottomUp(b2DynamicTreeHandle handle) {
  b2DynamicTree* classPtr = static_cast<b2DynamicTree*>(handle);
  assert(classPtr != 0);
  return (classPtr->RebuildBottomUp());
}

void __cdecl b2DynamicTree_ShiftOrigin(b2DynamicTreeHandle handle, const b2Vec2& newOrigin) {
  b2DynamicTree* classPtr = static_cast<b2DynamicTree*>(handle);
  assert(classPtr != 0);
  return (classPtr->ShiftOrigin(newOrigin));
}

// ------------------ class b2DynamicTreeWrapper ------------------


// ------------------ class b2Pair ------------------
b2Pair __cdecl b2Pair_b2Pair() {
  return  b2Pair();
}

// ------------------ class b2Pair ------------------


// ------------------ class b2BroadPhaseWrapper ------------------
b2BroadPhaseHandle __cdecl b2BroadPhase_b2BroadPhase_1() {
  return new b2BroadPhase();
}

void __cdecl b2BroadPhase_dtor(b2BroadPhaseHandle handle) {
  delete handle;
}


int __cdecl b2BroadPhase_CreateProxy(b2BroadPhaseHandle handle, const b2AABB& aabb, void* userData) {
  b2BroadPhase* classPtr = static_cast<b2BroadPhase*>(handle);
  assert(classPtr != 0);
  return (classPtr->CreateProxy(aabb, userData));
}

void __cdecl b2BroadPhase_DestroyProxy(b2BroadPhaseHandle handle, int proxyId) {
  b2BroadPhase* classPtr = static_cast<b2BroadPhase*>(handle);
  assert(classPtr != 0);
  return (classPtr->DestroyProxy(proxyId));
}

void __cdecl b2BroadPhase_MoveProxy(b2BroadPhaseHandle handle, int proxyId, const b2AABB& aabb, const b2Vec2& displacement) {
  b2BroadPhase* classPtr = static_cast<b2BroadPhase*>(handle);
  assert(classPtr != 0);
  return (classPtr->MoveProxy(proxyId, aabb, displacement));
}

void __cdecl b2BroadPhase_TouchProxy(b2BroadPhaseHandle handle, int proxyId) {
  b2BroadPhase* classPtr = static_cast<b2BroadPhase*>(handle);
  assert(classPtr != 0);
  return (classPtr->TouchProxy(proxyId));
}

const b2AABB& __cdecl b2BroadPhase_GetFatAABB(b2BroadPhaseHandle handle, int proxyId) {
  b2BroadPhase* classPtr = static_cast<b2BroadPhase*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFatAABB(proxyId));
}

void* __cdecl b2BroadPhase_GetUserData(b2BroadPhaseHandle handle, int proxyId) {
  b2BroadPhase* classPtr = static_cast<b2BroadPhase*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUserData(proxyId));
}

bool __cdecl b2BroadPhase_TestOverlap(b2BroadPhaseHandle handle, int proxyIdA, int proxyIdB) {
  b2BroadPhase* classPtr = static_cast<b2BroadPhase*>(handle);
  assert(classPtr != 0);
  return (classPtr->TestOverlap(proxyIdA, proxyIdB));
}

int __cdecl b2BroadPhase_GetProxyCount(b2BroadPhaseHandle handle) {
  b2BroadPhase* classPtr = static_cast<b2BroadPhase*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetProxyCount());
}

int __cdecl b2BroadPhase_GetTreeHeight(b2BroadPhaseHandle handle) {
  b2BroadPhase* classPtr = static_cast<b2BroadPhase*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTreeHeight());
}

int __cdecl b2BroadPhase_GetTreeBalance(b2BroadPhaseHandle handle) {
  b2BroadPhase* classPtr = static_cast<b2BroadPhase*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTreeBalance());
}

float __cdecl b2BroadPhase_GetTreeQuality(b2BroadPhaseHandle handle) {
  b2BroadPhase* classPtr = static_cast<b2BroadPhase*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTreeQuality());
}

void __cdecl b2BroadPhase_ShiftOrigin(b2BroadPhaseHandle handle, const b2Vec2& newOrigin) {
  b2BroadPhase* classPtr = static_cast<b2BroadPhase*>(handle);
  assert(classPtr != 0);
  return (classPtr->ShiftOrigin(newOrigin));
}

// ------------------ class b2BroadPhaseWrapper ------------------


// ------------------ class b2DistanceProxy ------------------
b2DistanceProxy __cdecl b2DistanceProxy_b2DistanceProxy_1() {
  return  b2DistanceProxy();
}

void __cdecl b2DistanceProxy_Set(b2DistanceProxyHandle handle, const b2Shape* shape, int index) {
  b2DistanceProxy* classPtr = static_cast<b2DistanceProxy*>(handle);
  assert(classPtr != 0);
  return (classPtr->Set(shape, index));
}

int __cdecl b2DistanceProxy_GetSupport(b2DistanceProxyHandle handle, const b2Vec2& d) {
  b2DistanceProxy* classPtr = static_cast<b2DistanceProxy*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetSupport(d));
}

const b2Vec2& __cdecl b2DistanceProxy_GetSupportVertex(b2DistanceProxyHandle handle, const b2Vec2& d) {
  b2DistanceProxy* classPtr = static_cast<b2DistanceProxy*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetSupportVertex(d));
}

int __cdecl b2DistanceProxy_GetVertexCount(b2DistanceProxyHandle handle) {
  b2DistanceProxy* classPtr = static_cast<b2DistanceProxy*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetVertexCount());
}

const b2Vec2& __cdecl b2DistanceProxy_GetVertex(b2DistanceProxyHandle handle, int index) {
  b2DistanceProxy* classPtr = static_cast<b2DistanceProxy*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetVertex(index));
}

// ------------------ class b2DistanceProxy ------------------


// ------------------ class b2SimplexCache ------------------
b2SimplexCache __cdecl b2SimplexCache_b2SimplexCache() {
  return  b2SimplexCache();
}

// ------------------ class b2SimplexCache ------------------


// ------------------ class b2DistanceInput ------------------
b2DistanceInput __cdecl b2DistanceInput_b2DistanceInput() {
  return  b2DistanceInput();
}

// ------------------ class b2DistanceInput ------------------


// ------------------ class b2DistanceOutput ------------------
b2DistanceOutput __cdecl b2DistanceOutput_b2DistanceOutput() {
  return  b2DistanceOutput();
}

// ------------------ class b2DistanceOutput ------------------


// ------------------ class b2TOIInput ------------------
b2TOIInput __cdecl b2TOIInput_b2TOIInput() {
  return  b2TOIInput();
}

// ------------------ class b2TOIInput ------------------


// ------------------ class b2TOIOutput ------------------
b2TOIOutput __cdecl b2TOIOutput_b2TOIOutput() {
  return  b2TOIOutput();
}

// ------------------ class b2TOIOutput ------------------


// ------------------ class b2MassData ------------------
b2MassData __cdecl b2MassData_b2MassData() {
  return  b2MassData();
}

// ------------------ class b2MassData ------------------


// ------------------ class b2ShapeWrapper ------------------

b2Shape* __cdecl b2Shape_Clone(b2ShapeHandle handle, b2BlockAllocator* allocator) {
  b2Shape* classPtr = static_cast<b2Shape*>(handle);
  assert(classPtr != 0);
  return (classPtr->Clone(allocator));
}

b2Shape::Type __cdecl b2Shape_GetType(b2ShapeHandle handle) {
  b2Shape* classPtr = static_cast<b2Shape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

int __cdecl b2Shape_GetChildCount(b2ShapeHandle handle) {
  b2Shape* classPtr = static_cast<b2Shape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildCount());
}

bool __cdecl b2Shape_TestPoint(b2ShapeHandle handle, const b2Transform& xf, const b2Vec2& p) {
  b2Shape* classPtr = static_cast<b2Shape*>(handle);
  assert(classPtr != 0);
  return (classPtr->TestPoint(xf, p));
}

bool __cdecl b2Shape_RayCast(b2ShapeHandle handle, b2RayCastOutput* output, const b2RayCastInput& input, const b2Transform& transform, int childIndex) {
  b2Shape* classPtr = static_cast<b2Shape*>(handle);
  assert(classPtr != 0);
  return (classPtr->RayCast(output, input, transform, childIndex));
}

void __cdecl b2Shape_ComputeAABB(b2ShapeHandle handle, b2AABB* aabb, const b2Transform& xf, int childIndex) {
  b2Shape* classPtr = static_cast<b2Shape*>(handle);
  assert(classPtr != 0);
  return (classPtr->ComputeAABB(aabb, xf, childIndex));
}

void __cdecl b2Shape_ComputeMass(b2ShapeHandle handle, b2MassData* massData, float density) {
  b2Shape* classPtr = static_cast<b2Shape*>(handle);
  assert(classPtr != 0);
  return (classPtr->ComputeMass(massData, density));
}


b2Shape::Type __cdecl b2Shape_Get_m_type(b2ShapeHandle handle) {
  return (handle->m_type);
}

void __cdecl b2Shape_Set_m_type(b2ShapeHandle handle, b2Shape::Type newValue) {
 handle->m_type = newValue;
};


float __cdecl b2Shape_Get_m_radius(b2ShapeHandle handle) {
  return (handle->m_radius);
}

void __cdecl b2Shape_Set_m_radius(b2ShapeHandle handle, float newValue) {
 handle->m_radius = newValue;
};

// ------------------ class b2ShapeWrapper ------------------


// ------------------ class b2ChainShapeWrapper ------------------
b2ChainShapeHandle __cdecl b2ChainShape_b2ChainShape_1() {
  return new b2ChainShape();
}

void __cdecl b2ChainShape_dtor(b2ChainShapeHandle handle) {
  delete handle;
}


b2Shape* __cdecl b2ChainShape_Clone(b2ChainShapeHandle handle, b2BlockAllocator* allocator) {
  b2ChainShape* classPtr = static_cast<b2ChainShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->Clone(allocator));
}

b2Shape::Type __cdecl b2ChainShape_GetType(b2ChainShapeHandle handle) {
  b2ChainShape* classPtr = static_cast<b2ChainShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

int __cdecl b2ChainShape_GetChildCount(b2ChainShapeHandle handle) {
  b2ChainShape* classPtr = static_cast<b2ChainShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildCount());
}

bool __cdecl b2ChainShape_TestPoint(b2ChainShapeHandle handle, const b2Transform& xf, const b2Vec2& p) {
  b2ChainShape* classPtr = static_cast<b2ChainShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->TestPoint(xf, p));
}

bool __cdecl b2ChainShape_RayCast(b2ChainShapeHandle handle, b2RayCastOutput* output, const b2RayCastInput& input, const b2Transform& transform, int childIndex) {
  b2ChainShape* classPtr = static_cast<b2ChainShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->RayCast(output, input, transform, childIndex));
}

void __cdecl b2ChainShape_ComputeAABB(b2ChainShapeHandle handle, b2AABB* aabb, const b2Transform& xf, int childIndex) {
  b2ChainShape* classPtr = static_cast<b2ChainShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->ComputeAABB(aabb, xf, childIndex));
}

void __cdecl b2ChainShape_ComputeMass(b2ChainShapeHandle handle, b2MassData* massData, float density) {
  b2ChainShape* classPtr = static_cast<b2ChainShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->ComputeMass(massData, density));
}


b2Shape::Type __cdecl b2ChainShape_Get_m_type(b2ChainShapeHandle handle) {
  return (handle->m_type);
}

void __cdecl b2ChainShape_Set_m_type(b2ChainShapeHandle handle, b2Shape::Type newValue) {
 handle->m_type = newValue;
};


float __cdecl b2ChainShape_Get_m_radius(b2ChainShapeHandle handle) {
  return (handle->m_radius);
}

void __cdecl b2ChainShape_Set_m_radius(b2ChainShapeHandle handle, float newValue) {
 handle->m_radius = newValue;
};

void __cdecl b2ChainShape_Clear(b2ChainShapeHandle handle) {
  b2ChainShape* classPtr = static_cast<b2ChainShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->Clear());
}

void __cdecl b2ChainShape_CreateLoop(b2ChainShapeHandle handle, const b2Vec2* vertices, int count) {
  b2ChainShape* classPtr = static_cast<b2ChainShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->CreateLoop(vertices, count));
}

void __cdecl b2ChainShape_CreateChain(b2ChainShapeHandle handle, const b2Vec2* vertices, int count) {
  b2ChainShape* classPtr = static_cast<b2ChainShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->CreateChain(vertices, count));
}

void __cdecl b2ChainShape_SetPrevVertex(b2ChainShapeHandle handle, const b2Vec2& prevVertex) {
  b2ChainShape* classPtr = static_cast<b2ChainShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetPrevVertex(prevVertex));
}

void __cdecl b2ChainShape_SetNextVertex(b2ChainShapeHandle handle, const b2Vec2& nextVertex) {
  b2ChainShape* classPtr = static_cast<b2ChainShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetNextVertex(nextVertex));
}

void __cdecl b2ChainShape_GetChildEdge(b2ChainShapeHandle handle, b2EdgeShape* edge, int index) {
  b2ChainShape* classPtr = static_cast<b2ChainShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildEdge(edge, index));
}


b2Vec2* __cdecl b2ChainShape_Get_m_vertices(b2ChainShapeHandle handle) {
  return (handle->m_vertices);
}

void __cdecl b2ChainShape_Set_m_vertices(b2ChainShapeHandle handle, b2Vec2* newValue) {
 handle->m_vertices = newValue;
};


int __cdecl b2ChainShape_Get_m_count(b2ChainShapeHandle handle) {
  return (handle->m_count);
}

void __cdecl b2ChainShape_Set_m_count(b2ChainShapeHandle handle, int newValue) {
 handle->m_count = newValue;
};


b2Vec2 __cdecl b2ChainShape_Get_m_prevVertex(b2ChainShapeHandle handle) {
  return (handle->m_prevVertex);
}

void __cdecl b2ChainShape_Set_m_prevVertex(b2ChainShapeHandle handle, b2Vec2 newValue) {
 handle->m_prevVertex = newValue;
};

b2Vec2* __cdecl b2ChainShape_Get_m_prevVertex_P(b2ChainShapeHandle handle) {
  return &(handle->m_prevVertex);
}


b2Vec2 __cdecl b2ChainShape_Get_m_nextVertex(b2ChainShapeHandle handle) {
  return (handle->m_nextVertex);
}

void __cdecl b2ChainShape_Set_m_nextVertex(b2ChainShapeHandle handle, b2Vec2 newValue) {
 handle->m_nextVertex = newValue;
};

b2Vec2* __cdecl b2ChainShape_Get_m_nextVertex_P(b2ChainShapeHandle handle) {
  return &(handle->m_nextVertex);
}


bool __cdecl b2ChainShape_Get_m_hasPrevVertex(b2ChainShapeHandle handle) {
  return (handle->m_hasPrevVertex);
}

void __cdecl b2ChainShape_Set_m_hasPrevVertex(b2ChainShapeHandle handle, bool newValue) {
 handle->m_hasPrevVertex = newValue;
};


bool __cdecl b2ChainShape_Get_m_hasNextVertex(b2ChainShapeHandle handle) {
  return (handle->m_hasNextVertex);
}

void __cdecl b2ChainShape_Set_m_hasNextVertex(b2ChainShapeHandle handle, bool newValue) {
 handle->m_hasNextVertex = newValue;
};

// ------------------ class b2ChainShapeWrapper ------------------


// ------------------ class b2CircleShapeWrapper ------------------
b2CircleShapeHandle __cdecl b2CircleShape_b2CircleShape_1() {
  return new b2CircleShape();
}

void __cdecl b2CircleShape_dtor(b2CircleShapeHandle handle) {
  delete handle;
}


b2Shape* __cdecl b2CircleShape_Clone(b2CircleShapeHandle handle, b2BlockAllocator* allocator) {
  b2CircleShape* classPtr = static_cast<b2CircleShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->Clone(allocator));
}

b2Shape::Type __cdecl b2CircleShape_GetType(b2CircleShapeHandle handle) {
  b2CircleShape* classPtr = static_cast<b2CircleShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

int __cdecl b2CircleShape_GetChildCount(b2CircleShapeHandle handle) {
  b2CircleShape* classPtr = static_cast<b2CircleShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildCount());
}

bool __cdecl b2CircleShape_TestPoint(b2CircleShapeHandle handle, const b2Transform& xf, const b2Vec2& p) {
  b2CircleShape* classPtr = static_cast<b2CircleShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->TestPoint(xf, p));
}

bool __cdecl b2CircleShape_RayCast(b2CircleShapeHandle handle, b2RayCastOutput* output, const b2RayCastInput& input, const b2Transform& transform, int childIndex) {
  b2CircleShape* classPtr = static_cast<b2CircleShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->RayCast(output, input, transform, childIndex));
}

void __cdecl b2CircleShape_ComputeAABB(b2CircleShapeHandle handle, b2AABB* aabb, const b2Transform& xf, int childIndex) {
  b2CircleShape* classPtr = static_cast<b2CircleShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->ComputeAABB(aabb, xf, childIndex));
}

void __cdecl b2CircleShape_ComputeMass(b2CircleShapeHandle handle, b2MassData* massData, float density) {
  b2CircleShape* classPtr = static_cast<b2CircleShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->ComputeMass(massData, density));
}


b2Shape::Type __cdecl b2CircleShape_Get_m_type(b2CircleShapeHandle handle) {
  return (handle->m_type);
}

void __cdecl b2CircleShape_Set_m_type(b2CircleShapeHandle handle, b2Shape::Type newValue) {
 handle->m_type = newValue;
};


float __cdecl b2CircleShape_Get_m_radius(b2CircleShapeHandle handle) {
  return (handle->m_radius);
}

void __cdecl b2CircleShape_Set_m_radius(b2CircleShapeHandle handle, float newValue) {
 handle->m_radius = newValue;
};

int __cdecl b2CircleShape_GetSupport(b2CircleShapeHandle handle, const b2Vec2& d) {
  b2CircleShape* classPtr = static_cast<b2CircleShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetSupport(d));
}

const b2Vec2& __cdecl b2CircleShape_GetSupportVertex(b2CircleShapeHandle handle, const b2Vec2& d) {
  b2CircleShape* classPtr = static_cast<b2CircleShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetSupportVertex(d));
}

int __cdecl b2CircleShape_GetVertexCount(b2CircleShapeHandle handle) {
  b2CircleShape* classPtr = static_cast<b2CircleShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetVertexCount());
}

const b2Vec2& __cdecl b2CircleShape_GetVertex(b2CircleShapeHandle handle, int index) {
  b2CircleShape* classPtr = static_cast<b2CircleShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetVertex(index));
}


b2Vec2 __cdecl b2CircleShape_Get_m_p(b2CircleShapeHandle handle) {
  return (handle->m_p);
}

void __cdecl b2CircleShape_Set_m_p(b2CircleShapeHandle handle, b2Vec2 newValue) {
 handle->m_p = newValue;
};

b2Vec2* __cdecl b2CircleShape_Get_m_p_P(b2CircleShapeHandle handle) {
  return &(handle->m_p);
}

// ------------------ class b2CircleShapeWrapper ------------------


// ------------------ class b2EdgeShapeWrapper ------------------
b2EdgeShapeHandle __cdecl b2EdgeShape_b2EdgeShape_1() {
  return new b2EdgeShape();
}

void __cdecl b2EdgeShape_dtor(b2EdgeShapeHandle handle) {
  delete handle;
}


b2Shape* __cdecl b2EdgeShape_Clone(b2EdgeShapeHandle handle, b2BlockAllocator* allocator) {
  b2EdgeShape* classPtr = static_cast<b2EdgeShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->Clone(allocator));
}

b2Shape::Type __cdecl b2EdgeShape_GetType(b2EdgeShapeHandle handle) {
  b2EdgeShape* classPtr = static_cast<b2EdgeShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

int __cdecl b2EdgeShape_GetChildCount(b2EdgeShapeHandle handle) {
  b2EdgeShape* classPtr = static_cast<b2EdgeShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildCount());
}

bool __cdecl b2EdgeShape_TestPoint(b2EdgeShapeHandle handle, const b2Transform& xf, const b2Vec2& p) {
  b2EdgeShape* classPtr = static_cast<b2EdgeShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->TestPoint(xf, p));
}

bool __cdecl b2EdgeShape_RayCast(b2EdgeShapeHandle handle, b2RayCastOutput* output, const b2RayCastInput& input, const b2Transform& transform, int childIndex) {
  b2EdgeShape* classPtr = static_cast<b2EdgeShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->RayCast(output, input, transform, childIndex));
}

void __cdecl b2EdgeShape_ComputeAABB(b2EdgeShapeHandle handle, b2AABB* aabb, const b2Transform& xf, int childIndex) {
  b2EdgeShape* classPtr = static_cast<b2EdgeShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->ComputeAABB(aabb, xf, childIndex));
}

void __cdecl b2EdgeShape_ComputeMass(b2EdgeShapeHandle handle, b2MassData* massData, float density) {
  b2EdgeShape* classPtr = static_cast<b2EdgeShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->ComputeMass(massData, density));
}


b2Shape::Type __cdecl b2EdgeShape_Get_m_type(b2EdgeShapeHandle handle) {
  return (handle->m_type);
}

void __cdecl b2EdgeShape_Set_m_type(b2EdgeShapeHandle handle, b2Shape::Type newValue) {
 handle->m_type = newValue;
};


float __cdecl b2EdgeShape_Get_m_radius(b2EdgeShapeHandle handle) {
  return (handle->m_radius);
}

void __cdecl b2EdgeShape_Set_m_radius(b2EdgeShapeHandle handle, float newValue) {
 handle->m_radius = newValue;
};

void __cdecl b2EdgeShape_Set(b2EdgeShapeHandle handle, const b2Vec2& v1, const b2Vec2& v2) {
  b2EdgeShape* classPtr = static_cast<b2EdgeShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->Set(v1, v2));
}


b2Vec2 __cdecl b2EdgeShape_Get_m_vertex1(b2EdgeShapeHandle handle) {
  return (handle->m_vertex1);
}

void __cdecl b2EdgeShape_Set_m_vertex1(b2EdgeShapeHandle handle, b2Vec2 newValue) {
 handle->m_vertex1 = newValue;
};

b2Vec2* __cdecl b2EdgeShape_Get_m_vertex1_P(b2EdgeShapeHandle handle) {
  return &(handle->m_vertex1);
}


b2Vec2 __cdecl b2EdgeShape_Get_m_vertex2(b2EdgeShapeHandle handle) {
  return (handle->m_vertex2);
}

void __cdecl b2EdgeShape_Set_m_vertex2(b2EdgeShapeHandle handle, b2Vec2 newValue) {
 handle->m_vertex2 = newValue;
};

b2Vec2* __cdecl b2EdgeShape_Get_m_vertex2_P(b2EdgeShapeHandle handle) {
  return &(handle->m_vertex2);
}


b2Vec2 __cdecl b2EdgeShape_Get_m_vertex0(b2EdgeShapeHandle handle) {
  return (handle->m_vertex0);
}

void __cdecl b2EdgeShape_Set_m_vertex0(b2EdgeShapeHandle handle, b2Vec2 newValue) {
 handle->m_vertex0 = newValue;
};

b2Vec2* __cdecl b2EdgeShape_Get_m_vertex0_P(b2EdgeShapeHandle handle) {
  return &(handle->m_vertex0);
}


b2Vec2 __cdecl b2EdgeShape_Get_m_vertex3(b2EdgeShapeHandle handle) {
  return (handle->m_vertex3);
}

void __cdecl b2EdgeShape_Set_m_vertex3(b2EdgeShapeHandle handle, b2Vec2 newValue) {
 handle->m_vertex3 = newValue;
};

b2Vec2* __cdecl b2EdgeShape_Get_m_vertex3_P(b2EdgeShapeHandle handle) {
  return &(handle->m_vertex3);
}


bool __cdecl b2EdgeShape_Get_m_hasVertex0(b2EdgeShapeHandle handle) {
  return (handle->m_hasVertex0);
}

void __cdecl b2EdgeShape_Set_m_hasVertex0(b2EdgeShapeHandle handle, bool newValue) {
 handle->m_hasVertex0 = newValue;
};


bool __cdecl b2EdgeShape_Get_m_hasVertex3(b2EdgeShapeHandle handle) {
  return (handle->m_hasVertex3);
}

void __cdecl b2EdgeShape_Set_m_hasVertex3(b2EdgeShapeHandle handle, bool newValue) {
 handle->m_hasVertex3 = newValue;
};

// ------------------ class b2EdgeShapeWrapper ------------------


// ------------------ class b2PolygonShapeWrapper ------------------
b2PolygonShapeHandle __cdecl b2PolygonShape_b2PolygonShape_1() {
  return new b2PolygonShape();
}

void __cdecl b2PolygonShape_dtor(b2PolygonShapeHandle handle) {
  delete handle;
}


b2Shape* __cdecl b2PolygonShape_Clone(b2PolygonShapeHandle handle, b2BlockAllocator* allocator) {
  b2PolygonShape* classPtr = static_cast<b2PolygonShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->Clone(allocator));
}

b2Shape::Type __cdecl b2PolygonShape_GetType(b2PolygonShapeHandle handle) {
  b2PolygonShape* classPtr = static_cast<b2PolygonShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

int __cdecl b2PolygonShape_GetChildCount(b2PolygonShapeHandle handle) {
  b2PolygonShape* classPtr = static_cast<b2PolygonShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildCount());
}

bool __cdecl b2PolygonShape_TestPoint(b2PolygonShapeHandle handle, const b2Transform& xf, const b2Vec2& p) {
  b2PolygonShape* classPtr = static_cast<b2PolygonShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->TestPoint(xf, p));
}

bool __cdecl b2PolygonShape_RayCast(b2PolygonShapeHandle handle, b2RayCastOutput* output, const b2RayCastInput& input, const b2Transform& transform, int childIndex) {
  b2PolygonShape* classPtr = static_cast<b2PolygonShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->RayCast(output, input, transform, childIndex));
}

void __cdecl b2PolygonShape_ComputeAABB(b2PolygonShapeHandle handle, b2AABB* aabb, const b2Transform& xf, int childIndex) {
  b2PolygonShape* classPtr = static_cast<b2PolygonShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->ComputeAABB(aabb, xf, childIndex));
}

void __cdecl b2PolygonShape_ComputeMass(b2PolygonShapeHandle handle, b2MassData* massData, float density) {
  b2PolygonShape* classPtr = static_cast<b2PolygonShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->ComputeMass(massData, density));
}


b2Shape::Type __cdecl b2PolygonShape_Get_m_type(b2PolygonShapeHandle handle) {
  return (handle->m_type);
}

void __cdecl b2PolygonShape_Set_m_type(b2PolygonShapeHandle handle, b2Shape::Type newValue) {
 handle->m_type = newValue;
};


float __cdecl b2PolygonShape_Get_m_radius(b2PolygonShapeHandle handle) {
  return (handle->m_radius);
}

void __cdecl b2PolygonShape_Set_m_radius(b2PolygonShapeHandle handle, float newValue) {
 handle->m_radius = newValue;
};

void __cdecl b2PolygonShape_Set(b2PolygonShapeHandle handle, const b2Vec2* points, int count) {
  b2PolygonShape* classPtr = static_cast<b2PolygonShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->Set(points, count));
}

void __cdecl b2PolygonShape_SetAsBox(b2PolygonShapeHandle handle, float hx, float hy) {
  b2PolygonShape* classPtr = static_cast<b2PolygonShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetAsBox(hx, hy));
}

void __cdecl b2PolygonShape_SetAsBox2(b2PolygonShapeHandle handle, float hx, float hy, const b2Vec2& center, float angle) {
  b2PolygonShape* classPtr = static_cast<b2PolygonShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetAsBox(hx, hy, center, angle));
}

int __cdecl b2PolygonShape_GetVertexCount(b2PolygonShapeHandle handle) {
  b2PolygonShape* classPtr = static_cast<b2PolygonShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetVertexCount());
}

const b2Vec2& __cdecl b2PolygonShape_GetVertex(b2PolygonShapeHandle handle, int index) {
  b2PolygonShape* classPtr = static_cast<b2PolygonShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetVertex(index));
}

bool __cdecl b2PolygonShape_Validate(b2PolygonShapeHandle handle) {
  b2PolygonShape* classPtr = static_cast<b2PolygonShape*>(handle);
  assert(classPtr != 0);
  return (classPtr->Validate());
}


b2Vec2 __cdecl b2PolygonShape_Get_m_centroid(b2PolygonShapeHandle handle) {
  return (handle->m_centroid);
}

void __cdecl b2PolygonShape_Set_m_centroid(b2PolygonShapeHandle handle, b2Vec2 newValue) {
 handle->m_centroid = newValue;
};

b2Vec2* __cdecl b2PolygonShape_Get_m_centroid_P(b2PolygonShapeHandle handle) {
  return &(handle->m_centroid);
}


b2Vec2 __cdecl b2PolygonShape_Get_m_vertices(b2PolygonShapeHandle handle, int _idx_) {
  return (handle->m_vertices[_idx_]);
}

void __cdecl b2PolygonShape_Set_m_vertices(b2PolygonShapeHandle handle, int _idx_, b2Vec2 newValue) {
 handle->m_vertices[_idx_] = newValue;
};

b2Vec2* __cdecl b2PolygonShape_Get_m_vertices_P(b2PolygonShapeHandle handle, int _idx_) {
  return &(handle->m_vertices[_idx_]);
}


b2Vec2 __cdecl b2PolygonShape_Get_m_normals(b2PolygonShapeHandle handle, int _idx_) {
  return (handle->m_normals[_idx_]);
}

void __cdecl b2PolygonShape_Set_m_normals(b2PolygonShapeHandle handle, int _idx_, b2Vec2 newValue) {
 handle->m_normals[_idx_] = newValue;
};

b2Vec2* __cdecl b2PolygonShape_Get_m_normals_P(b2PolygonShapeHandle handle, int _idx_) {
  return &(handle->m_normals[_idx_]);
}


int __cdecl b2PolygonShape_Get_m_count(b2PolygonShapeHandle handle) {
  return (handle->m_count);
}

void __cdecl b2PolygonShape_Set_m_count(b2PolygonShapeHandle handle, int newValue) {
 handle->m_count = newValue;
};

// ------------------ class b2PolygonShapeWrapper ------------------

void __cdecl Collision_b2GetPointStates(b2PointState* state1, b2PointState* state2, const b2Manifold* manifold1, const b2Manifold* manifold2) {
  return (b2GetPointStates(state1, state2, manifold1, manifold2));
}

void __cdecl Collision_b2CollideCircles(b2Manifold* manifold, const b2CircleShape* circleA, const b2Transform& xfA, const b2CircleShape* circleB, const b2Transform& xfB) {
  return (b2CollideCircles(manifold, circleA, xfA, circleB, xfB));
}

void __cdecl Collision_b2CollidePolygonAndCircle(b2Manifold* manifold, const b2PolygonShape* polygonA, const b2Transform& xfA, const b2CircleShape* circleB, const b2Transform& xfB) {
  return (b2CollidePolygonAndCircle(manifold, polygonA, xfA, circleB, xfB));
}

void __cdecl Collision_b2CollidePolygons(b2Manifold* manifold, const b2PolygonShape* polygonA, const b2Transform& xfA, const b2PolygonShape* polygonB, const b2Transform& xfB) {
  return (b2CollidePolygons(manifold, polygonA, xfA, polygonB, xfB));
}

void __cdecl Collision_b2CollideEdgeAndCircle(b2Manifold* manifold, const b2EdgeShape* polygonA, const b2Transform& xfA, const b2CircleShape* circleB, const b2Transform& xfB) {
  return (b2CollideEdgeAndCircle(manifold, polygonA, xfA, circleB, xfB));
}

void __cdecl Collision_b2CollideEdgeAndPolygon(b2Manifold* manifold, const b2EdgeShape* edgeA, const b2Transform& xfA, const b2PolygonShape* circleB, const b2Transform& xfB) {
  return (b2CollideEdgeAndPolygon(manifold, edgeA, xfA, circleB, xfB));
}

int __cdecl Collision_b2ClipSegmentToLine(b2ClipVertex* vOut, const b2ClipVertex* vIn, const b2Vec2& normal, float offset, int vertexIndexA) {
  return (b2ClipSegmentToLine(vOut, vIn, normal, offset, vertexIndexA));
}

bool __cdecl Collision_b2TestOverlap(const b2Shape* shapeA, int indexA, const b2Shape* shapeB, int indexB, const b2Transform& xfA, const b2Transform& xfB) {
  return (b2TestOverlap(shapeA, indexA, shapeB, indexB, xfA, xfB));
}

bool __cdecl Collision_b2TestOverlap2(const b2AABB& a, const b2AABB& b) {
  return (b2TestOverlap(a, b));
}

bool __cdecl Collision_b2PairLessThan(const b2Pair& pair1, const b2Pair& pair2) {
  return (b2PairLessThan(pair1, pair2));
}

void __cdecl Collision_b2Distance(b2DistanceOutput* output, b2SimplexCache* cache, const b2DistanceInput* input) {
  return (b2Distance(output, cache, input));
}

void __cdecl Collision_b2TimeOfImpact(b2TOIOutput* output, const b2TOIInput* input) {
  return (b2TimeOfImpact(output, input));
}

