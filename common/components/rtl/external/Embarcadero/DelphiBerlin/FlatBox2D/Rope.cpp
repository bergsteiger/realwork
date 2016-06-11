#include "Rope.h"


// ------------------ class b2RopeDef ------------------
b2RopeDef __cdecl b2RopeDef_b2RopeDef_1() {
  return  b2RopeDef();
}

// ------------------ class b2RopeDef ------------------


// ------------------ class b2RopeWrapper ------------------
b2RopeHandle __cdecl b2Rope_b2Rope_1() {
  return new b2Rope();
}

void __cdecl b2Rope_dtor(b2RopeHandle handle) {
  delete handle;
}


void __cdecl b2Rope_Initialize(b2RopeHandle handle, const b2RopeDef* def) {
  b2Rope* classPtr = static_cast<b2Rope*>(handle);
  assert(classPtr != 0);
  return (classPtr->Initialize(def));
}

void __cdecl b2Rope_Step(b2RopeHandle handle, float timeStep, int iterations) {
  b2Rope* classPtr = static_cast<b2Rope*>(handle);
  assert(classPtr != 0);
  return (classPtr->Step(timeStep, iterations));
}

int __cdecl b2Rope_GetVertexCount(b2RopeHandle handle) {
  b2Rope* classPtr = static_cast<b2Rope*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetVertexCount());
}

const b2Vec2* __cdecl b2Rope_GetVertices(b2RopeHandle handle) {
  b2Rope* classPtr = static_cast<b2Rope*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetVertices());
}

void __cdecl b2Rope_Draw(b2RopeHandle handle, b2Draw* draw) {
  b2Rope* classPtr = static_cast<b2Rope*>(handle);
  assert(classPtr != 0);
  return (classPtr->Draw(draw));
}

void __cdecl b2Rope_SetAngle(b2RopeHandle handle, float angle) {
  b2Rope* classPtr = static_cast<b2Rope*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetAngle(angle));
}

// ------------------ class b2RopeWrapper ------------------

