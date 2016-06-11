#include "Common.h"

// ------------------ class b2Draw delegate ------------------
class b2Draw_delegate : public b2Draw {
  Ib2Draw* _intf;
public:
    b2Draw_delegate(Ib2Draw* _i) : _intf(_i) {
    _intf->AddRef();
  }

  virtual ~b2Draw_delegate() {
    _intf->Release();
  }

virtual void DrawPolygon(const b2Vec2* vertices, int vertexCount, const b2Color& color) {
  return (_intf->DrawPolygon(vertices, vertexCount, color));
}
virtual void DrawSolidPolygon(const b2Vec2* vertices, int vertexCount, const b2Color& color) {
  return (_intf->DrawSolidPolygon(vertices, vertexCount, color));
}
virtual void DrawCircle(const b2Vec2& center, float radius, const b2Color& color) {
  return (_intf->DrawCircle(center, radius, color));
}
virtual void DrawSolidCircle(const b2Vec2& center, float radius, const b2Vec2& axis, const b2Color& color) {
  return (_intf->DrawSolidCircle(center, radius, axis, color));
}
virtual void DrawSegment(const b2Vec2& p1, const b2Vec2& p2, const b2Color& color) {
  return (_intf->DrawSegment(p1, p2, color));
}
virtual void DrawTransform(const b2Transform& xf) {
  return (_intf->DrawTransform(xf));
}


private:
  b2Draw_delegate(const b2Draw_delegate&);
  b2Draw_delegate& operator=(const b2Draw_delegate&);
};


b2DrawHandle __cdecl Create_b2Draw_delegate(Ib2Draw* intf) {
  return new b2Draw_delegate(intf);
}
void __cdecl Destroy_b2Draw_delegate(b2DrawHandle handle) {
 delete handle;
}


// ------------------ class b2Version ------------------
b2Version __cdecl b2Version_b2Version() {
  return  b2Version();
}

// ------------------ class b2Version ------------------


// ------------------ class b2BlockAllocatorWrapper ------------------
b2BlockAllocatorHandle __cdecl b2BlockAllocator_b2BlockAllocator_1() {
  return new b2BlockAllocator();
}

void __cdecl b2BlockAllocator_dtor(b2BlockAllocatorHandle handle) {
  delete handle;
}


void* __cdecl b2BlockAllocator_Allocate(b2BlockAllocatorHandle handle, int size) {
  b2BlockAllocator* classPtr = static_cast<b2BlockAllocator*>(handle);
  assert(classPtr != 0);
  return (classPtr->Allocate(size));
}

void __cdecl b2BlockAllocator_Free(b2BlockAllocatorHandle handle, void* p, int size) {
  b2BlockAllocator* classPtr = static_cast<b2BlockAllocator*>(handle);
  assert(classPtr != 0);
  return (classPtr->Free(p, size));
}

void __cdecl b2BlockAllocator_Clear(b2BlockAllocatorHandle handle) {
  b2BlockAllocator* classPtr = static_cast<b2BlockAllocator*>(handle);
  assert(classPtr != 0);
  return (classPtr->Clear());
}

// ------------------ class b2BlockAllocatorWrapper ------------------


// ------------------ class b2Vec2 ------------------
b2Vec2 __cdecl b2Vec2_b2Vec2_1() {
  return  b2Vec2();
}

b2Vec2 __cdecl b2Vec2_b2Vec2_2(float x, float y) {
  return  b2Vec2(x, y);
}



void __cdecl b2Vec2_SetZero(b2Vec2Handle handle) {
  b2Vec2* classPtr = static_cast<b2Vec2*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetZero());
}

void __cdecl b2Vec2_Set(b2Vec2Handle handle, float x_, float y_) {
  b2Vec2* classPtr = static_cast<b2Vec2*>(handle);
  assert(classPtr != 0);
  return (classPtr->Set(x_, y_));
}

float __cdecl b2Vec2_Length(b2Vec2Handle handle) {
  b2Vec2* classPtr = static_cast<b2Vec2*>(handle);
  assert(classPtr != 0);
  return (classPtr->Length());
}

float __cdecl b2Vec2_LengthSquared(b2Vec2Handle handle) {
  b2Vec2* classPtr = static_cast<b2Vec2*>(handle);
  assert(classPtr != 0);
  return (classPtr->LengthSquared());
}

float __cdecl b2Vec2_Normalize(b2Vec2Handle handle) {
  b2Vec2* classPtr = static_cast<b2Vec2*>(handle);
  assert(classPtr != 0);
  return (classPtr->Normalize());
}

bool __cdecl b2Vec2_IsValid(b2Vec2Handle handle) {
  b2Vec2* classPtr = static_cast<b2Vec2*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsValid());
}

b2Vec2 __cdecl b2Vec2_Skew(b2Vec2Handle handle) {
  b2Vec2* classPtr = static_cast<b2Vec2*>(handle);
  assert(classPtr != 0);
  return (classPtr->Skew());
}

// ------------------ class b2Vec2 ------------------


// ------------------ class b2Vec3 ------------------
b2Vec3 __cdecl b2Vec3_b2Vec3_1() {
  return  b2Vec3();
}

b2Vec3 __cdecl b2Vec3_b2Vec3_2(float x, float y, float z) {
  return  b2Vec3(x, y, z);
}

void __cdecl b2Vec3_SetZero(b2Vec3Handle handle) {
  b2Vec3* classPtr = static_cast<b2Vec3*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetZero());
}

void __cdecl b2Vec3_Set(b2Vec3Handle handle, float x_, float y_, float z_) {
  b2Vec3* classPtr = static_cast<b2Vec3*>(handle);
  assert(classPtr != 0);
  return (classPtr->Set(x_, y_, z_));
}

// ------------------ class b2Vec3 ------------------


// ------------------ class b2Mat22 ------------------
b2Mat22 __cdecl b2Mat22_b2Mat22_1() {
  return  b2Mat22();
}

b2Mat22 __cdecl b2Mat22_b2Mat22_2(const b2Vec2& c1, const b2Vec2& c2) {
  return  b2Mat22(c1, c2);
}

b2Mat22 __cdecl b2Mat22_b2Mat22_3(float a11, float a12, float a21, float a22) {
  return  b2Mat22(a11, a12, a21, a22);
}

void __cdecl b2Mat22_Set(b2Mat22Handle handle, const b2Vec2& c1, const b2Vec2& c2) {
  b2Mat22* classPtr = static_cast<b2Mat22*>(handle);
  assert(classPtr != 0);
  return (classPtr->Set(c1, c2));
}

void __cdecl b2Mat22_SetIdentity(b2Mat22Handle handle) {
  b2Mat22* classPtr = static_cast<b2Mat22*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetIdentity());
}

void __cdecl b2Mat22_SetZero(b2Mat22Handle handle) {
  b2Mat22* classPtr = static_cast<b2Mat22*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetZero());
}

b2Mat22 __cdecl b2Mat22_GetInverse(b2Mat22Handle handle) {
  b2Mat22* classPtr = static_cast<b2Mat22*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetInverse());
}

b2Vec2 __cdecl b2Mat22_Solve(b2Mat22Handle handle, const b2Vec2& b) {
  b2Mat22* classPtr = static_cast<b2Mat22*>(handle);
  assert(classPtr != 0);
  return (classPtr->Solve(b));
}

// ------------------ class b2Mat22 ------------------


// ------------------ class b2Mat33 ------------------
b2Mat33 __cdecl b2Mat33_b2Mat33_1() {
  return  b2Mat33();
}

b2Mat33 __cdecl b2Mat33_b2Mat33_2(const b2Vec3& c1, const b2Vec3& c2, const b2Vec3& c3) {
  return  b2Mat33(c1, c2, c3);
}

void __cdecl b2Mat33_SetZero(b2Mat33Handle handle) {
  b2Mat33* classPtr = static_cast<b2Mat33*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetZero());
}

b2Vec3 __cdecl b2Mat33_Solve33(b2Mat33Handle handle, const b2Vec3& b) {
  b2Mat33* classPtr = static_cast<b2Mat33*>(handle);
  assert(classPtr != 0);
  return (classPtr->Solve33(b));
}

b2Vec2 __cdecl b2Mat33_Solve22(b2Mat33Handle handle, const b2Vec2& b) {
  b2Mat33* classPtr = static_cast<b2Mat33*>(handle);
  assert(classPtr != 0);
  return (classPtr->Solve22(b));
}

void __cdecl b2Mat33_GetInverse22(b2Mat33Handle handle, b2Mat33* M) {
  b2Mat33* classPtr = static_cast<b2Mat33*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetInverse22(M));
}

void __cdecl b2Mat33_GetSymInverse33(b2Mat33Handle handle, b2Mat33* M) {
  b2Mat33* classPtr = static_cast<b2Mat33*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetSymInverse33(M));
}

// ------------------ class b2Mat33 ------------------


// ------------------ class b2Rot ------------------
b2Rot __cdecl b2Rot_b2Rot_1() {
  return  b2Rot();
}

b2Rot __cdecl b2Rot_b2Rot_2(float angle) {
  return  b2Rot(angle);
}

void __cdecl b2Rot_Set(b2RotHandle handle, float angle) {
  b2Rot* classPtr = static_cast<b2Rot*>(handle);
  assert(classPtr != 0);
  return (classPtr->Set(angle));
}

void __cdecl b2Rot_SetIdentity(b2RotHandle handle) {
  b2Rot* classPtr = static_cast<b2Rot*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetIdentity());
}

float __cdecl b2Rot_GetAngle(b2RotHandle handle) {
  b2Rot* classPtr = static_cast<b2Rot*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAngle());
}

b2Vec2 __cdecl b2Rot_GetXAxis(b2RotHandle handle) {
  b2Rot* classPtr = static_cast<b2Rot*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetXAxis());
}

b2Vec2 __cdecl b2Rot_GetYAxis(b2RotHandle handle) {
  b2Rot* classPtr = static_cast<b2Rot*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetYAxis());
}

// ------------------ class b2Rot ------------------


// ------------------ class b2Transform ------------------
b2Transform __cdecl b2Transform_b2Transform_1() {
  return  b2Transform();
}

b2Transform __cdecl b2Transform_b2Transform_2(const b2Vec2& position, const b2Rot& rotation) {
  return  b2Transform(position, rotation);
}

void __cdecl b2Transform_SetIdentity(b2TransformHandle handle) {
  b2Transform* classPtr = static_cast<b2Transform*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetIdentity());
}

void __cdecl b2Transform_Set(b2TransformHandle handle, const b2Vec2& position, float angle) {
  b2Transform* classPtr = static_cast<b2Transform*>(handle);
  assert(classPtr != 0);
  return (classPtr->Set(position, angle));
}

// ------------------ class b2Transform ------------------


// ------------------ class b2Sweep ------------------
b2Sweep __cdecl b2Sweep_b2Sweep() {
  return  b2Sweep();
}

void __cdecl b2Sweep_GetTransform(b2SweepHandle handle, b2Transform* xfb, float beta) {
  b2Sweep* classPtr = static_cast<b2Sweep*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTransform(xfb, beta));
}

void __cdecl b2Sweep_Advance(b2SweepHandle handle, float alpha) {
  b2Sweep* classPtr = static_cast<b2Sweep*>(handle);
  assert(classPtr != 0);
  return (classPtr->Advance(alpha));
}

void __cdecl b2Sweep_Normalize(b2SweepHandle handle) {
  b2Sweep* classPtr = static_cast<b2Sweep*>(handle);
  assert(classPtr != 0);
  return (classPtr->Normalize());
}

// ------------------ class b2Sweep ------------------


// ------------------ class b2Color ------------------
b2Color __cdecl b2Color_b2Color_1() {
  return  b2Color();
}

b2Color __cdecl b2Color_b2Color_2(float r, float g, float b, float a) {
  return  b2Color(r, g, b, a);
}

void __cdecl b2Color_Set(b2ColorHandle handle, float ri, float gi, float bi, float ai) {
  b2Color* classPtr = static_cast<b2Color*>(handle);
  assert(classPtr != 0);
  return (classPtr->Set(ri, gi, bi, ai));
}

// ------------------ class b2Color ------------------


// ------------------ class b2DrawWrapper ------------------

void __cdecl b2Draw_SetFlags(b2DrawHandle handle, unsigned int flags) {
  b2Draw* classPtr = static_cast<b2Draw*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetFlags(flags));
}

unsigned int __cdecl b2Draw_GetFlags(b2DrawHandle handle) {
  b2Draw* classPtr = static_cast<b2Draw*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFlags());
}

void __cdecl b2Draw_AppendFlags(b2DrawHandle handle, unsigned int flags) {
  b2Draw* classPtr = static_cast<b2Draw*>(handle);
  assert(classPtr != 0);
  return (classPtr->AppendFlags(flags));
}

void __cdecl b2Draw_ClearFlags(b2DrawHandle handle, unsigned int flags) {
  b2Draw* classPtr = static_cast<b2Draw*>(handle);
  assert(classPtr != 0);
  return (classPtr->ClearFlags(flags));
}

void __cdecl b2Draw_DrawPolygon(b2DrawHandle handle, const b2Vec2* vertices, int vertexCount, const b2Color& color) {
  b2Draw* classPtr = static_cast<b2Draw*>(handle);
  assert(classPtr != 0);
  return (classPtr->DrawPolygon(vertices, vertexCount, color));
}

void __cdecl b2Draw_DrawSolidPolygon(b2DrawHandle handle, const b2Vec2* vertices, int vertexCount, const b2Color& color) {
  b2Draw* classPtr = static_cast<b2Draw*>(handle);
  assert(classPtr != 0);
  return (classPtr->DrawSolidPolygon(vertices, vertexCount, color));
}

void __cdecl b2Draw_DrawCircle(b2DrawHandle handle, const b2Vec2& center, float radius, const b2Color& color) {
  b2Draw* classPtr = static_cast<b2Draw*>(handle);
  assert(classPtr != 0);
  return (classPtr->DrawCircle(center, radius, color));
}

void __cdecl b2Draw_DrawSolidCircle(b2DrawHandle handle, const b2Vec2& center, float radius, const b2Vec2& axis, const b2Color& color) {
  b2Draw* classPtr = static_cast<b2Draw*>(handle);
  assert(classPtr != 0);
  return (classPtr->DrawSolidCircle(center, radius, axis, color));
}

void __cdecl b2Draw_DrawSegment(b2DrawHandle handle, const b2Vec2& p1, const b2Vec2& p2, const b2Color& color) {
  b2Draw* classPtr = static_cast<b2Draw*>(handle);
  assert(classPtr != 0);
  return (classPtr->DrawSegment(p1, p2, color));
}

void __cdecl b2Draw_DrawTransform(b2DrawHandle handle, const b2Transform& xf) {
  b2Draw* classPtr = static_cast<b2Draw*>(handle);
  assert(classPtr != 0);
  return (classPtr->DrawTransform(xf));
}

// ------------------ class b2DrawWrapper ------------------


// ------------------ class b2StackEntry ------------------
b2StackEntry __cdecl b2StackEntry_b2StackEntry() {
  return  b2StackEntry();
}

// ------------------ class b2StackEntry ------------------


// ------------------ class b2StackAllocatorWrapper ------------------
b2StackAllocatorHandle __cdecl b2StackAllocator_b2StackAllocator_1() {
  return new b2StackAllocator();
}

void __cdecl b2StackAllocator_dtor(b2StackAllocatorHandle handle) {
  delete handle;
}


void* __cdecl b2StackAllocator_Allocate(b2StackAllocatorHandle handle, int size) {
  b2StackAllocator* classPtr = static_cast<b2StackAllocator*>(handle);
  assert(classPtr != 0);
  return (classPtr->Allocate(size));
}

void __cdecl b2StackAllocator_Free(b2StackAllocatorHandle handle, void* p) {
  b2StackAllocator* classPtr = static_cast<b2StackAllocator*>(handle);
  assert(classPtr != 0);
  return (classPtr->Free(p));
}

int __cdecl b2StackAllocator_GetMaxAllocation(b2StackAllocatorHandle handle) {
  b2StackAllocator* classPtr = static_cast<b2StackAllocator*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMaxAllocation());
}

// ------------------ class b2StackAllocatorWrapper ------------------


// ------------------ class b2Timer ------------------
b2Timer __cdecl b2Timer_b2Timer_1() {
  return  b2Timer();
}

void __cdecl b2Timer_Reset(b2TimerHandle handle) {
  b2Timer* classPtr = static_cast<b2Timer*>(handle);
  assert(classPtr != 0);
  return (classPtr->Reset());
}

float __cdecl b2Timer_GetMilliseconds(b2TimerHandle handle) {
  b2Timer* classPtr = static_cast<b2Timer*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMilliseconds());
}

// ------------------ class b2Timer ------------------

b2Version __cdecl Get_b2_version() {
  return b2_version;
}

void __cdecl Set_b2_version(b2Version newVal) {
  b2_version = newVal;
}

const b2Vec2 __cdecl Get_b2Vec2_zero() {
  return b2Vec2_zero;
}


void* __cdecl Common_b2Alloc(int size) {
  return (b2Alloc(size));
}

void __cdecl Common_b2Free(void* mem) {
  return (b2Free(mem));
}

bool __cdecl Common_b2IsValid(float x) {
  return (b2IsValid(x));
}

float __cdecl Common_b2InvSqrt(float x) {
  return (b2InvSqrt(x));
}

float __cdecl Common_b2Dot(const b2Vec2& a, const b2Vec2& b) {
  return (b2Dot(a, b));
}

float __cdecl Common_b2Cross(const b2Vec2& a, const b2Vec2& b) {
  return (b2Cross(a, b));
}

b2Vec2 __cdecl Common_b2Cross2(const b2Vec2& a, float s) {
  return (b2Cross(a, s));
}

b2Vec2 __cdecl Common_b2Cross3(float s, const b2Vec2& a) {
  return (b2Cross(s, a));
}

b2Vec2 __cdecl Common_b2Mul(const b2Mat22& A, const b2Vec2& v) {
  return (b2Mul(A, v));
}

b2Vec2 __cdecl Common_b2MulT(const b2Mat22& A, const b2Vec2& v) {
  return (b2MulT(A, v));
}

float __cdecl Common_b2Distance(const b2Vec2& a, const b2Vec2& b) {
  return (b2Distance(a, b));
}

float __cdecl Common_b2DistanceSquared(const b2Vec2& a, const b2Vec2& b) {
  return (b2DistanceSquared(a, b));
}

float __cdecl Common_b2Dot2(const b2Vec3& a, const b2Vec3& b) {
  return (b2Dot(a, b));
}

b2Vec3 __cdecl Common_b2Cross4(const b2Vec3& a, const b2Vec3& b) {
  return (b2Cross(a, b));
}

b2Mat22 __cdecl Common_b2Mul2(const b2Mat22& A, const b2Mat22& B) {
  return (b2Mul(A, B));
}

b2Mat22 __cdecl Common_b2MulT2(const b2Mat22& A, const b2Mat22& B) {
  return (b2MulT(A, B));
}

b2Vec3 __cdecl Common_b2Mul3(const b2Mat33& A, const b2Vec3& v) {
  return (b2Mul(A, v));
}

b2Vec2 __cdecl Common_b2Mul22(const b2Mat33& A, const b2Vec2& v) {
  return (b2Mul22(A, v));
}

b2Rot __cdecl Common_b2Mul4(const b2Rot& q, const b2Rot& r) {
  return (b2Mul(q, r));
}

b2Rot __cdecl Common_b2MulT3(const b2Rot& q, const b2Rot& r) {
  return (b2MulT(q, r));
}

b2Vec2 __cdecl Common_b2Mul5(const b2Rot& q, const b2Vec2& v) {
  return (b2Mul(q, v));
}

b2Vec2 __cdecl Common_b2MulT4(const b2Rot& q, const b2Vec2& v) {
  return (b2MulT(q, v));
}

b2Vec2 __cdecl Common_b2Mul6(const b2Transform& T, const b2Vec2& v) {
  return (b2Mul(T, v));
}

b2Vec2 __cdecl Common_b2MulT5(const b2Transform& T, const b2Vec2& v) {
  return (b2MulT(T, v));
}

b2Transform __cdecl Common_b2Mul7(const b2Transform& A, const b2Transform& B) {
  return (b2Mul(A, B));
}

b2Transform __cdecl Common_b2MulT6(const b2Transform& A, const b2Transform& B) {
  return (b2MulT(A, B));
}

b2Vec2 __cdecl Common_b2Abs(const b2Vec2& a) {
  return (b2Abs(a));
}

b2Mat22 __cdecl Common_b2Abs2(const b2Mat22& A) {
  return (b2Abs(A));
}

b2Vec2 __cdecl Common_b2Min(const b2Vec2& a, const b2Vec2& b) {
  return (b2Min(a, b));
}

b2Vec2 __cdecl Common_b2Max(const b2Vec2& a, const b2Vec2& b) {
  return (b2Max(a, b));
}

b2Vec2 __cdecl Common_b2Clamp(const b2Vec2& a, const b2Vec2& low, const b2Vec2& high) {
  return (b2Clamp(a, low, high));
}

unsigned int __cdecl Common_b2NextPowerOfTwo(unsigned int x) {
  return (b2NextPowerOfTwo(x));
}

bool __cdecl Common_b2IsPowerOfTwo(unsigned int x) {
  return (b2IsPowerOfTwo(x));
}

