#include "Dynamics.h"

// ------------------ class b2DestructionListener delegate ------------------
class b2DestructionListener_delegate : public b2DestructionListener {
  Ib2DestructionListener* _intf;
public:
    b2DestructionListener_delegate(Ib2DestructionListener* _i) : _intf(_i) {
    _intf->AddRef();
  }

  virtual ~b2DestructionListener_delegate() {
    _intf->Release();
  }

virtual void SayGoodbye(b2Joint* joint) {
  return (_intf->SayGoodbye(joint));
}
virtual void SayGoodbye(b2Fixture* fixture) {
  return (_intf->SayGoodbye(fixture));
}


private:
  b2DestructionListener_delegate(const b2DestructionListener_delegate&);
  b2DestructionListener_delegate& operator=(const b2DestructionListener_delegate&);
};


b2DestructionListenerHandle __cdecl Create_b2DestructionListener_delegate(Ib2DestructionListener* intf) {
  return new b2DestructionListener_delegate(intf);
}
void __cdecl Destroy_b2DestructionListener_delegate(b2DestructionListenerHandle handle) {
 delete handle;
}

// ------------------ class b2ContactFilter delegate ------------------
class b2ContactFilter_delegate : public b2ContactFilter {
  Ib2ContactFilter* _intf;
public:
    b2ContactFilter_delegate(Ib2ContactFilter* _i) : _intf(_i) {
    _intf->AddRef();
  }

  virtual ~b2ContactFilter_delegate() {
    _intf->Release();
  }

virtual bool ShouldCollide(b2Fixture* fixtureA, b2Fixture* fixtureB) {
  return (_intf->ShouldCollide(fixtureA, fixtureB));
}


private:
  b2ContactFilter_delegate(const b2ContactFilter_delegate&);
  b2ContactFilter_delegate& operator=(const b2ContactFilter_delegate&);
};


b2ContactFilterHandle __cdecl Create_b2ContactFilter_delegate(Ib2ContactFilter* intf) {
  return new b2ContactFilter_delegate(intf);
}
void __cdecl Destroy_b2ContactFilter_delegate(b2ContactFilterHandle handle) {
 delete handle;
}

// ------------------ class b2ContactListener delegate ------------------
class b2ContactListener_delegate : public b2ContactListener {
  Ib2ContactListener* _intf;
public:
    b2ContactListener_delegate(Ib2ContactListener* _i) : _intf(_i) {
    _intf->AddRef();
  }

  virtual ~b2ContactListener_delegate() {
    _intf->Release();
  }

virtual void BeginContact(b2Contact* contact) {
  return (_intf->BeginContact(contact));
}
virtual void EndContact(b2Contact* contact) {
  return (_intf->EndContact(contact));
}
virtual void PreSolve(b2Contact* contact, const b2Manifold* oldManifold) {
  return (_intf->PreSolve(contact, oldManifold));
}
virtual void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse) {
  return (_intf->PostSolve(contact, impulse));
}


private:
  b2ContactListener_delegate(const b2ContactListener_delegate&);
  b2ContactListener_delegate& operator=(const b2ContactListener_delegate&);
};


b2ContactListenerHandle __cdecl Create_b2ContactListener_delegate(Ib2ContactListener* intf) {
  return new b2ContactListener_delegate(intf);
}
void __cdecl Destroy_b2ContactListener_delegate(b2ContactListenerHandle handle) {
 delete handle;
}

// ------------------ class b2QueryCallback delegate ------------------
class b2QueryCallback_delegate : public b2QueryCallback {
  Ib2QueryCallback* _intf;
public:
    b2QueryCallback_delegate(Ib2QueryCallback* _i) : _intf(_i) {
    _intf->AddRef();
  }

  virtual ~b2QueryCallback_delegate() {
    _intf->Release();
  }

virtual bool ReportFixture(b2Fixture* fixture) {
  return (_intf->ReportFixture(fixture));
}


private:
  b2QueryCallback_delegate(const b2QueryCallback_delegate&);
  b2QueryCallback_delegate& operator=(const b2QueryCallback_delegate&);
};


b2QueryCallbackHandle __cdecl Create_b2QueryCallback_delegate(Ib2QueryCallback* intf) {
  return new b2QueryCallback_delegate(intf);
}
void __cdecl Destroy_b2QueryCallback_delegate(b2QueryCallbackHandle handle) {
 delete handle;
}

// ------------------ class b2RayCastCallback delegate ------------------
class b2RayCastCallback_delegate : public b2RayCastCallback {
  Ib2RayCastCallback* _intf;
public:
    b2RayCastCallback_delegate(Ib2RayCastCallback* _i) : _intf(_i) {
    _intf->AddRef();
  }

  virtual ~b2RayCastCallback_delegate() {
    _intf->Release();
  }

virtual float ReportFixture(b2Fixture* fixture, const b2Vec2& point, const b2Vec2& normal, float fraction) {
  return (_intf->ReportFixture(fixture, point, normal, fraction));
}


private:
  b2RayCastCallback_delegate(const b2RayCastCallback_delegate&);
  b2RayCastCallback_delegate& operator=(const b2RayCastCallback_delegate&);
};


b2RayCastCallbackHandle __cdecl Create_b2RayCastCallback_delegate(Ib2RayCastCallback* intf) {
  return new b2RayCastCallback_delegate(intf);
}
void __cdecl Destroy_b2RayCastCallback_delegate(b2RayCastCallbackHandle handle) {
 delete handle;
}


// ------------------ class b2BodyDef ------------------
b2BodyDef __cdecl b2BodyDef_b2BodyDef_1() {
  return  b2BodyDef();
}

// ------------------ class b2BodyDef ------------------


// ------------------ class b2BodyWrapper ------------------

b2Fixture* __cdecl b2Body_CreateFixture(b2BodyHandle handle, const b2FixtureDef* def) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->CreateFixture(def));
}

b2Fixture* __cdecl b2Body_CreateFixture2(b2BodyHandle handle, const b2Shape* shape, float density) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->CreateFixture(shape, density));
}

void __cdecl b2Body_DestroyFixture(b2BodyHandle handle, b2Fixture* fixture) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->DestroyFixture(fixture));
}

void __cdecl b2Body_SetTransform(b2BodyHandle handle, const b2Vec2& position, float angle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetTransform(position, angle));
}

const b2Transform& __cdecl b2Body_GetTransform(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTransform());
}

const b2Vec2& __cdecl b2Body_GetPosition(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetPosition());
}

float __cdecl b2Body_GetAngle(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAngle());
}

const b2Vec2& __cdecl b2Body_GetWorldCenter(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetWorldCenter());
}

const b2Vec2& __cdecl b2Body_GetLocalCenter(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalCenter());
}

void __cdecl b2Body_SetLinearVelocity(b2BodyHandle handle, const b2Vec2& v) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetLinearVelocity(v));
}

const b2Vec2& __cdecl b2Body_GetLinearVelocity(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLinearVelocity());
}

void __cdecl b2Body_SetAngularVelocity(b2BodyHandle handle, float omega) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetAngularVelocity(omega));
}

float __cdecl b2Body_GetAngularVelocity(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAngularVelocity());
}

void __cdecl b2Body_ApplyForce(b2BodyHandle handle, const b2Vec2& force, const b2Vec2& point, bool wake) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->ApplyForce(force, point, wake));
}

void __cdecl b2Body_ApplyForceToCenter(b2BodyHandle handle, const b2Vec2& force, bool wake) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->ApplyForceToCenter(force, wake));
}

void __cdecl b2Body_ApplyTorque(b2BodyHandle handle, float torque, bool wake) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->ApplyTorque(torque, wake));
}

void __cdecl b2Body_ApplyLinearImpulse(b2BodyHandle handle, const b2Vec2& impulse, const b2Vec2& point, bool wake) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->ApplyLinearImpulse(impulse, point, wake));
}

void __cdecl b2Body_ApplyAngularImpulse(b2BodyHandle handle, float impulse, bool wake) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->ApplyAngularImpulse(impulse, wake));
}

float __cdecl b2Body_GetMass(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMass());
}

float __cdecl b2Body_GetInertia(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetInertia());
}

void __cdecl b2Body_GetMassData(b2BodyHandle handle, b2MassData* data) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMassData(data));
}

void __cdecl b2Body_SetMassData(b2BodyHandle handle, const b2MassData* data) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetMassData(data));
}

void __cdecl b2Body_ResetMassData(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetMassData());
}

b2Vec2 __cdecl b2Body_GetWorldPoint(b2BodyHandle handle, const b2Vec2& localPoint) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetWorldPoint(localPoint));
}

b2Vec2 __cdecl b2Body_GetWorldVector(b2BodyHandle handle, const b2Vec2& localVector) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetWorldVector(localVector));
}

b2Vec2 __cdecl b2Body_GetLocalPoint(b2BodyHandle handle, const b2Vec2& worldPoint) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalPoint(worldPoint));
}

b2Vec2 __cdecl b2Body_GetLocalVector(b2BodyHandle handle, const b2Vec2& worldVector) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalVector(worldVector));
}

b2Vec2 __cdecl b2Body_GetLinearVelocityFromWorldPoint(b2BodyHandle handle, const b2Vec2& worldPoint) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLinearVelocityFromWorldPoint(worldPoint));
}

b2Vec2 __cdecl b2Body_GetLinearVelocityFromLocalPoint(b2BodyHandle handle, const b2Vec2& localPoint) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLinearVelocityFromLocalPoint(localPoint));
}

float __cdecl b2Body_GetLinearDamping(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLinearDamping());
}

void __cdecl b2Body_SetLinearDamping(b2BodyHandle handle, float linearDamping) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetLinearDamping(linearDamping));
}

float __cdecl b2Body_GetAngularDamping(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAngularDamping());
}

void __cdecl b2Body_SetAngularDamping(b2BodyHandle handle, float angularDamping) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetAngularDamping(angularDamping));
}

float __cdecl b2Body_GetGravityScale(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetGravityScale());
}

void __cdecl b2Body_SetGravityScale(b2BodyHandle handle, float scale) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetGravityScale(scale));
}

void __cdecl b2Body_SetType(b2BodyHandle handle, b2BodyType type) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetType(type));
}

b2BodyType __cdecl b2Body_GetType(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

void __cdecl b2Body_SetBullet(b2BodyHandle handle, bool flag) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetBullet(flag));
}

bool __cdecl b2Body_IsBullet(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsBullet());
}

void __cdecl b2Body_SetSleepingAllowed(b2BodyHandle handle, bool flag) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetSleepingAllowed(flag));
}

bool __cdecl b2Body_IsSleepingAllowed(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsSleepingAllowed());
}

void __cdecl b2Body_SetAwake(b2BodyHandle handle, bool flag) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetAwake(flag));
}

bool __cdecl b2Body_IsAwake(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsAwake());
}

void __cdecl b2Body_SetActive(b2BodyHandle handle, bool flag) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetActive(flag));
}

bool __cdecl b2Body_IsActive(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsActive());
}

void __cdecl b2Body_SetFixedRotation(b2BodyHandle handle, bool flag) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetFixedRotation(flag));
}

bool __cdecl b2Body_IsFixedRotation(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsFixedRotation());
}

b2Fixture* __cdecl b2Body_GetFixtureList(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureList());
}

b2JointEdge* __cdecl b2Body_GetJointList(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetJointList());
}

b2ContactEdge* __cdecl b2Body_GetContactList(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetContactList());
}

b2Body* __cdecl b2Body_GetNext(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

void* __cdecl b2Body_GetUserData(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUserData());
}

void __cdecl b2Body_SetUserData(b2BodyHandle handle, void* data) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetUserData(data));
}

b2World* __cdecl b2Body_GetWorld(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetWorld());
}

void __cdecl b2Body_Dump(b2BodyHandle handle) {
  b2Body* classPtr = static_cast<b2Body*>(handle);
  assert(classPtr != 0);
  return (classPtr->Dump());
}

// ------------------ class b2BodyWrapper ------------------


// ------------------ class b2ContactManagerWrapper ------------------
b2ContactManagerHandle __cdecl b2ContactManager_b2ContactManager_1() {
  return new b2ContactManager();
}

void __cdecl b2ContactManager_dtor(b2ContactManagerHandle handle) {
  delete handle;
}


void __cdecl b2ContactManager_AddPair(b2ContactManagerHandle handle, void* proxyUserDataA, void* proxyUserDataB) {
  b2ContactManager* classPtr = static_cast<b2ContactManager*>(handle);
  assert(classPtr != 0);
  return (classPtr->AddPair(proxyUserDataA, proxyUserDataB));
}

void __cdecl b2ContactManager_FindNewContacts(b2ContactManagerHandle handle) {
  b2ContactManager* classPtr = static_cast<b2ContactManager*>(handle);
  assert(classPtr != 0);
  return (classPtr->FindNewContacts());
}

void __cdecl b2ContactManager_Destroy(b2ContactManagerHandle handle, b2Contact* c) {
  b2ContactManager* classPtr = static_cast<b2ContactManager*>(handle);
  assert(classPtr != 0);
  return (classPtr->Destroy(c));
}

void __cdecl b2ContactManager_Collide(b2ContactManagerHandle handle) {
  b2ContactManager* classPtr = static_cast<b2ContactManager*>(handle);
  assert(classPtr != 0);
  return (classPtr->Collide());
}


b2BroadPhase* __cdecl b2ContactManager_Get_m_broadPhase(b2ContactManagerHandle handle) {
  return &(handle->m_broadPhase);
}

void __cdecl b2ContactManager_Set_m_broadPhase(b2ContactManagerHandle handle, b2BroadPhase* newValue) {
 handle->m_broadPhase = *newValue;
};


b2Contact* __cdecl b2ContactManager_Get_m_contactList(b2ContactManagerHandle handle) {
  return (handle->m_contactList);
}

void __cdecl b2ContactManager_Set_m_contactList(b2ContactManagerHandle handle, b2Contact* newValue) {
 handle->m_contactList = newValue;
};


int __cdecl b2ContactManager_Get_m_contactCount(b2ContactManagerHandle handle) {
  return (handle->m_contactCount);
}

void __cdecl b2ContactManager_Set_m_contactCount(b2ContactManagerHandle handle, int newValue) {
 handle->m_contactCount = newValue;
};


b2ContactFilter* __cdecl b2ContactManager_Get_m_contactFilter(b2ContactManagerHandle handle) {
  return (handle->m_contactFilter);
}

void __cdecl b2ContactManager_Set_m_contactFilter(b2ContactManagerHandle handle, b2ContactFilter* newValue) {
 handle->m_contactFilter = newValue;
};


b2ContactListener* __cdecl b2ContactManager_Get_m_contactListener(b2ContactManagerHandle handle) {
  return (handle->m_contactListener);
}

void __cdecl b2ContactManager_Set_m_contactListener(b2ContactManagerHandle handle, b2ContactListener* newValue) {
 handle->m_contactListener = newValue;
};


b2BlockAllocator* __cdecl b2ContactManager_Get_m_allocator(b2ContactManagerHandle handle) {
  return (handle->m_allocator);
}

void __cdecl b2ContactManager_Set_m_allocator(b2ContactManagerHandle handle, b2BlockAllocator* newValue) {
 handle->m_allocator = newValue;
};

// ------------------ class b2ContactManagerWrapper ------------------


// ------------------ class b2Filter ------------------
b2Filter __cdecl b2Filter_b2Filter_1() {
  return  b2Filter();
}

// ------------------ class b2Filter ------------------


// ------------------ class b2FixtureDef ------------------
b2FixtureDef __cdecl b2FixtureDef_b2FixtureDef_1() {
  return  b2FixtureDef();
}

// ------------------ class b2FixtureDef ------------------


// ------------------ class b2FixtureProxy ------------------
b2FixtureProxy __cdecl b2FixtureProxy_b2FixtureProxy() {
  return  b2FixtureProxy();
}

// ------------------ class b2FixtureProxy ------------------


// ------------------ class b2Fixture ------------------
b2Shape::Type __cdecl b2Fixture_GetType(b2FixtureHandle handle) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

b2Shape* __cdecl b2Fixture_GetShape(b2FixtureHandle handle) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetShape());
}

void __cdecl b2Fixture_SetSensor(b2FixtureHandle handle, bool sensor) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetSensor(sensor));
}

bool __cdecl b2Fixture_IsSensor(b2FixtureHandle handle) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsSensor());
}

void __cdecl b2Fixture_SetFilterData(b2FixtureHandle handle, const b2Filter& filter) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetFilterData(filter));
}

const b2Filter& __cdecl b2Fixture_GetFilterData(b2FixtureHandle handle) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFilterData());
}

void __cdecl b2Fixture_Refilter(b2FixtureHandle handle) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->Refilter());
}

b2Body* __cdecl b2Fixture_GetBody(b2FixtureHandle handle) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBody());
}

b2Fixture* __cdecl b2Fixture_GetNext(b2FixtureHandle handle) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

void* __cdecl b2Fixture_GetUserData(b2FixtureHandle handle) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUserData());
}

void __cdecl b2Fixture_SetUserData(b2FixtureHandle handle, void* data) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetUserData(data));
}

bool __cdecl b2Fixture_TestPoint(b2FixtureHandle handle, const b2Vec2& p) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->TestPoint(p));
}

bool __cdecl b2Fixture_RayCast(b2FixtureHandle handle, b2RayCastOutput* output, const b2RayCastInput& input, int childIndex) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->RayCast(output, input, childIndex));
}

void __cdecl b2Fixture_GetMassData(b2FixtureHandle handle, b2MassData* massData) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMassData(massData));
}

void __cdecl b2Fixture_SetDensity(b2FixtureHandle handle, float density) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetDensity(density));
}

float __cdecl b2Fixture_GetDensity(b2FixtureHandle handle) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetDensity());
}

float __cdecl b2Fixture_GetFriction(b2FixtureHandle handle) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFriction());
}

void __cdecl b2Fixture_SetFriction(b2FixtureHandle handle, float friction) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetFriction(friction));
}

float __cdecl b2Fixture_GetRestitution(b2FixtureHandle handle) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetRestitution());
}

void __cdecl b2Fixture_SetRestitution(b2FixtureHandle handle, float restitution) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetRestitution(restitution));
}

const b2AABB& __cdecl b2Fixture_GetAABB(b2FixtureHandle handle, int childIndex) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAABB(childIndex));
}

void __cdecl b2Fixture_Dump(b2FixtureHandle handle, int bodyIndex) {
  b2Fixture* classPtr = static_cast<b2Fixture*>(handle);
  assert(classPtr != 0);
  return (classPtr->Dump(bodyIndex));
}

// ------------------ class b2Fixture ------------------


// ------------------ class b2Profile ------------------
b2Profile __cdecl b2Profile_b2Profile() {
  return  b2Profile();
}

// ------------------ class b2Profile ------------------


// ------------------ class b2TimeStep ------------------
b2TimeStep __cdecl b2TimeStep_b2TimeStep() {
  return  b2TimeStep();
}

// ------------------ class b2TimeStep ------------------


// ------------------ class b2Position ------------------
b2Position __cdecl b2Position_b2Position() {
  return  b2Position();
}

// ------------------ class b2Position ------------------


// ------------------ class b2Velocity ------------------
b2Velocity __cdecl b2Velocity_b2Velocity() {
  return  b2Velocity();
}

// ------------------ class b2Velocity ------------------


// ------------------ class b2SolverData ------------------
b2SolverData __cdecl b2SolverData_b2SolverData() {
  return  b2SolverData();
}

// ------------------ class b2SolverData ------------------


// ------------------ class b2IslandWrapper ------------------
b2IslandHandle __cdecl b2Island_b2Island_1(int bodyCapacity, int contactCapacity, int jointCapacity, b2StackAllocator* allocator, b2ContactListener* listener) {
  return new b2Island(bodyCapacity, contactCapacity, jointCapacity, allocator, listener);
}

void __cdecl b2Island_dtor(b2IslandHandle handle) {
  delete handle;
}


void __cdecl b2Island_Clear(b2IslandHandle handle) {
  b2Island* classPtr = static_cast<b2Island*>(handle);
  assert(classPtr != 0);
  return (classPtr->Clear());
}

void __cdecl b2Island_Solve(b2IslandHandle handle, b2Profile* profile, const b2TimeStep& step, const b2Vec2& gravity, bool allowSleep) {
  b2Island* classPtr = static_cast<b2Island*>(handle);
  assert(classPtr != 0);
  return (classPtr->Solve(profile, step, gravity, allowSleep));
}

void __cdecl b2Island_SolveTOI(b2IslandHandle handle, const b2TimeStep& subStep, int toiIndexA, int toiIndexB) {
  b2Island* classPtr = static_cast<b2Island*>(handle);
  assert(classPtr != 0);
  return (classPtr->SolveTOI(subStep, toiIndexA, toiIndexB));
}

void __cdecl b2Island_Add(b2IslandHandle handle, b2Body* body) {
  b2Island* classPtr = static_cast<b2Island*>(handle);
  assert(classPtr != 0);
  return (classPtr->Add(body));
}

void __cdecl b2Island_Add2(b2IslandHandle handle, b2Contact* contact) {
  b2Island* classPtr = static_cast<b2Island*>(handle);
  assert(classPtr != 0);
  return (classPtr->Add(contact));
}

void __cdecl b2Island_Add3(b2IslandHandle handle, b2Joint* joint) {
  b2Island* classPtr = static_cast<b2Island*>(handle);
  assert(classPtr != 0);
  return (classPtr->Add(joint));
}

void __cdecl b2Island_Report(b2IslandHandle handle, const b2ContactVelocityConstraint* constraints) {
  b2Island* classPtr = static_cast<b2Island*>(handle);
  assert(classPtr != 0);
  return (classPtr->Report(constraints));
}


b2StackAllocator* __cdecl b2Island_Get_m_allocator(b2IslandHandle handle) {
  return (handle->m_allocator);
}

void __cdecl b2Island_Set_m_allocator(b2IslandHandle handle, b2StackAllocator* newValue) {
 handle->m_allocator = newValue;
};


b2ContactListener* __cdecl b2Island_Get_m_listener(b2IslandHandle handle) {
  return (handle->m_listener);
}

void __cdecl b2Island_Set_m_listener(b2IslandHandle handle, b2ContactListener* newValue) {
 handle->m_listener = newValue;
};


b2Body** __cdecl b2Island_Get_m_bodies(b2IslandHandle handle) {
  return (handle->m_bodies);
}

void __cdecl b2Island_Set_m_bodies(b2IslandHandle handle, b2Body** newValue) {
 handle->m_bodies = newValue;
};


b2Contact** __cdecl b2Island_Get_m_contacts(b2IslandHandle handle) {
  return (handle->m_contacts);
}

void __cdecl b2Island_Set_m_contacts(b2IslandHandle handle, b2Contact** newValue) {
 handle->m_contacts = newValue;
};


b2Joint** __cdecl b2Island_Get_m_joints(b2IslandHandle handle) {
  return (handle->m_joints);
}

void __cdecl b2Island_Set_m_joints(b2IslandHandle handle, b2Joint** newValue) {
 handle->m_joints = newValue;
};


b2Position* __cdecl b2Island_Get_m_positions(b2IslandHandle handle) {
  return (handle->m_positions);
}

void __cdecl b2Island_Set_m_positions(b2IslandHandle handle, b2Position* newValue) {
 handle->m_positions = newValue;
};


b2Velocity* __cdecl b2Island_Get_m_velocities(b2IslandHandle handle) {
  return (handle->m_velocities);
}

void __cdecl b2Island_Set_m_velocities(b2IslandHandle handle, b2Velocity* newValue) {
 handle->m_velocities = newValue;
};


int __cdecl b2Island_Get_m_bodyCount(b2IslandHandle handle) {
  return (handle->m_bodyCount);
}

void __cdecl b2Island_Set_m_bodyCount(b2IslandHandle handle, int newValue) {
 handle->m_bodyCount = newValue;
};


int __cdecl b2Island_Get_m_jointCount(b2IslandHandle handle) {
  return (handle->m_jointCount);
}

void __cdecl b2Island_Set_m_jointCount(b2IslandHandle handle, int newValue) {
 handle->m_jointCount = newValue;
};


int __cdecl b2Island_Get_m_contactCount(b2IslandHandle handle) {
  return (handle->m_contactCount);
}

void __cdecl b2Island_Set_m_contactCount(b2IslandHandle handle, int newValue) {
 handle->m_contactCount = newValue;
};


int __cdecl b2Island_Get_m_bodyCapacity(b2IslandHandle handle) {
  return (handle->m_bodyCapacity);
}

void __cdecl b2Island_Set_m_bodyCapacity(b2IslandHandle handle, int newValue) {
 handle->m_bodyCapacity = newValue;
};


int __cdecl b2Island_Get_m_contactCapacity(b2IslandHandle handle) {
  return (handle->m_contactCapacity);
}

void __cdecl b2Island_Set_m_contactCapacity(b2IslandHandle handle, int newValue) {
 handle->m_contactCapacity = newValue;
};


int __cdecl b2Island_Get_m_jointCapacity(b2IslandHandle handle) {
  return (handle->m_jointCapacity);
}

void __cdecl b2Island_Set_m_jointCapacity(b2IslandHandle handle, int newValue) {
 handle->m_jointCapacity = newValue;
};

// ------------------ class b2IslandWrapper ------------------


// ------------------ class b2DestructionListenerWrapper ------------------

void __cdecl b2DestructionListener_SayGoodbye(b2DestructionListenerHandle handle, b2Joint* joint) {
  b2DestructionListener* classPtr = static_cast<b2DestructionListener*>(handle);
  assert(classPtr != 0);
  return (classPtr->SayGoodbye(joint));
}

void __cdecl b2DestructionListener_SayGoodbye2(b2DestructionListenerHandle handle, b2Fixture* fixture) {
  b2DestructionListener* classPtr = static_cast<b2DestructionListener*>(handle);
  assert(classPtr != 0);
  return (classPtr->SayGoodbye(fixture));
}

// ------------------ class b2DestructionListenerWrapper ------------------


// ------------------ class b2ContactFilterWrapper ------------------
b2ContactFilterHandle __cdecl b2ContactFilter_b2ContactFilter() {
  return new b2ContactFilter();
}

void __cdecl b2ContactFilter_dtor(b2ContactFilterHandle handle) {
  delete handle;
}


bool __cdecl b2ContactFilter_ShouldCollide(b2ContactFilterHandle handle, b2Fixture* fixtureA, b2Fixture* fixtureB) {
  b2ContactFilter* classPtr = static_cast<b2ContactFilter*>(handle);
  assert(classPtr != 0);
  return (classPtr->ShouldCollide(fixtureA, fixtureB));
}

// ------------------ class b2ContactFilterWrapper ------------------


// ------------------ class b2ContactImpulse ------------------
b2ContactImpulse __cdecl b2ContactImpulse_b2ContactImpulse() {
  return  b2ContactImpulse();
}

// ------------------ class b2ContactImpulse ------------------


// ------------------ class b2ContactListenerWrapper ------------------
b2ContactListenerHandle __cdecl b2ContactListener_b2ContactListener() {
  return new b2ContactListener();
}

void __cdecl b2ContactListener_dtor(b2ContactListenerHandle handle) {
  delete handle;
}


void __cdecl b2ContactListener_BeginContact(b2ContactListenerHandle handle, b2Contact* contact) {
  b2ContactListener* classPtr = static_cast<b2ContactListener*>(handle);
  assert(classPtr != 0);
  return (classPtr->BeginContact(contact));
}

void __cdecl b2ContactListener_EndContact(b2ContactListenerHandle handle, b2Contact* contact) {
  b2ContactListener* classPtr = static_cast<b2ContactListener*>(handle);
  assert(classPtr != 0);
  return (classPtr->EndContact(contact));
}

void __cdecl b2ContactListener_PreSolve(b2ContactListenerHandle handle, b2Contact* contact, const b2Manifold* oldManifold) {
  b2ContactListener* classPtr = static_cast<b2ContactListener*>(handle);
  assert(classPtr != 0);
  return (classPtr->PreSolve(contact, oldManifold));
}

void __cdecl b2ContactListener_PostSolve(b2ContactListenerHandle handle, b2Contact* contact, const b2ContactImpulse* impulse) {
  b2ContactListener* classPtr = static_cast<b2ContactListener*>(handle);
  assert(classPtr != 0);
  return (classPtr->PostSolve(contact, impulse));
}

// ------------------ class b2ContactListenerWrapper ------------------


// ------------------ class b2QueryCallbackWrapper ------------------

bool __cdecl b2QueryCallback_ReportFixture(b2QueryCallbackHandle handle, b2Fixture* fixture) {
  b2QueryCallback* classPtr = static_cast<b2QueryCallback*>(handle);
  assert(classPtr != 0);
  return (classPtr->ReportFixture(fixture));
}

// ------------------ class b2QueryCallbackWrapper ------------------


// ------------------ class b2RayCastCallbackWrapper ------------------

float __cdecl b2RayCastCallback_ReportFixture(b2RayCastCallbackHandle handle, b2Fixture* fixture, const b2Vec2& point, const b2Vec2& normal, float fraction) {
  b2RayCastCallback* classPtr = static_cast<b2RayCastCallback*>(handle);
  assert(classPtr != 0);
  return (classPtr->ReportFixture(fixture, point, normal, fraction));
}

// ------------------ class b2RayCastCallbackWrapper ------------------


// ------------------ class b2WorldWrapper ------------------
b2WorldHandle __cdecl b2World_b2World_1(const b2Vec2& gravity) {
  return new b2World(gravity);
}

void __cdecl b2World_dtor(b2WorldHandle handle) {
  delete handle;
}


void __cdecl b2World_SetDestructionListener(b2WorldHandle handle, b2DestructionListener* listener) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetDestructionListener(listener));
}

void __cdecl b2World_SetContactFilter(b2WorldHandle handle, b2ContactFilter* filter) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetContactFilter(filter));
}

void __cdecl b2World_SetContactListener(b2WorldHandle handle, b2ContactListener* listener) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetContactListener(listener));
}

void __cdecl b2World_SetDebugDraw(b2WorldHandle handle, b2Draw* debugDraw) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetDebugDraw(debugDraw));
}

b2Body* __cdecl b2World_CreateBody(b2WorldHandle handle, const b2BodyDef* def) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->CreateBody(def));
}

void __cdecl b2World_DestroyBody(b2WorldHandle handle, b2Body* body) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->DestroyBody(body));
}

b2Joint* __cdecl b2World_CreateJoint(b2WorldHandle handle, const b2JointDef* def) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->CreateJoint(def));
}

void __cdecl b2World_DestroyJoint(b2WorldHandle handle, b2Joint* joint) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->DestroyJoint(joint));
}

void __cdecl b2World_Step(b2WorldHandle handle, float timeStep, int velocityIterations, int positionIterations) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->Step(timeStep, velocityIterations, positionIterations));
}

void __cdecl b2World_ClearForces(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->ClearForces());
}

void __cdecl b2World_DrawDebugData(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->DrawDebugData());
}

void __cdecl b2World_QueryAABB(b2WorldHandle handle, b2QueryCallback* callback, const b2AABB& aabb) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->QueryAABB(callback, aabb));
}

void __cdecl b2World_RayCast(b2WorldHandle handle, b2RayCastCallback* callback, const b2Vec2& point1, const b2Vec2& point2) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->RayCast(callback, point1, point2));
}

b2Body* __cdecl b2World_GetBodyList(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyList());
}

b2Joint* __cdecl b2World_GetJointList(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetJointList());
}

b2Contact* __cdecl b2World_GetContactList(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetContactList());
}

void __cdecl b2World_SetAllowSleeping(b2WorldHandle handle, bool flag) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetAllowSleeping(flag));
}

bool __cdecl b2World_GetAllowSleeping(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAllowSleeping());
}

void __cdecl b2World_SetWarmStarting(b2WorldHandle handle, bool flag) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetWarmStarting(flag));
}

bool __cdecl b2World_GetWarmStarting(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetWarmStarting());
}

void __cdecl b2World_SetContinuousPhysics(b2WorldHandle handle, bool flag) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetContinuousPhysics(flag));
}

bool __cdecl b2World_GetContinuousPhysics(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetContinuousPhysics());
}

void __cdecl b2World_SetSubStepping(b2WorldHandle handle, bool flag) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetSubStepping(flag));
}

bool __cdecl b2World_GetSubStepping(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetSubStepping());
}

int __cdecl b2World_GetProxyCount(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetProxyCount());
}

int __cdecl b2World_GetBodyCount(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyCount());
}

int __cdecl b2World_GetJointCount(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetJointCount());
}

int __cdecl b2World_GetContactCount(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetContactCount());
}

int __cdecl b2World_GetTreeHeight(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTreeHeight());
}

int __cdecl b2World_GetTreeBalance(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTreeBalance());
}

float __cdecl b2World_GetTreeQuality(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTreeQuality());
}

void __cdecl b2World_SetGravity(b2WorldHandle handle, const b2Vec2& gravity) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetGravity(gravity));
}

b2Vec2 __cdecl b2World_GetGravity(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetGravity());
}

bool __cdecl b2World_IsLocked(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsLocked());
}

void __cdecl b2World_SetAutoClearForces(b2WorldHandle handle, bool flag) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetAutoClearForces(flag));
}

bool __cdecl b2World_GetAutoClearForces(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAutoClearForces());
}

void __cdecl b2World_ShiftOrigin(b2WorldHandle handle, const b2Vec2& newOrigin) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->ShiftOrigin(newOrigin));
}

const b2ContactManager* __cdecl b2World_GetContactManager(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return &(classPtr->GetContactManager());
}

const b2Profile& __cdecl b2World_GetProfile(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetProfile());
}

void __cdecl b2World_Dump(b2WorldHandle handle) {
  b2World* classPtr = static_cast<b2World*>(handle);
  assert(classPtr != 0);
  return (classPtr->Dump());
}

// ------------------ class b2WorldWrapper ------------------


// ------------------ class b2ContactRegister ------------------
b2ContactRegister __cdecl b2ContactRegister_b2ContactRegister() {
  return  b2ContactRegister();
}

// ------------------ class b2ContactRegister ------------------


// ------------------ class b2ContactEdge ------------------
b2ContactEdge __cdecl b2ContactEdge_b2ContactEdge_1() {
  return  b2ContactEdge();
}

// ------------------ class b2ContactEdge ------------------


// ------------------ class b2ContactWrapper ------------------

b2Manifold* __cdecl b2Contact_GetManifold(b2ContactHandle handle) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetManifold());
}

void __cdecl b2Contact_GetWorldManifold(b2ContactHandle handle, b2WorldManifold* worldManifold) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetWorldManifold(worldManifold));
}

bool __cdecl b2Contact_IsTouching(b2ContactHandle handle) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsTouching());
}

void __cdecl b2Contact_SetEnabled(b2ContactHandle handle, bool flag) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetEnabled(flag));
}

bool __cdecl b2Contact_IsEnabled(b2ContactHandle handle) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsEnabled());
}

b2Contact* __cdecl b2Contact_GetNext(b2ContactHandle handle) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

b2Fixture* __cdecl b2Contact_GetFixtureA(b2ContactHandle handle) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureA());
}

int __cdecl b2Contact_GetChildIndexA(b2ContactHandle handle) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildIndexA());
}

b2Fixture* __cdecl b2Contact_GetFixtureB(b2ContactHandle handle) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureB());
}

int __cdecl b2Contact_GetChildIndexB(b2ContactHandle handle) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildIndexB());
}

void __cdecl b2Contact_SetFriction(b2ContactHandle handle, float friction) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetFriction(friction));
}

float __cdecl b2Contact_GetFriction(b2ContactHandle handle) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFriction());
}

void __cdecl b2Contact_ResetFriction(b2ContactHandle handle) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetFriction());
}

void __cdecl b2Contact_SetRestitution(b2ContactHandle handle, float restitution) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetRestitution(restitution));
}

float __cdecl b2Contact_GetRestitution(b2ContactHandle handle) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetRestitution());
}

void __cdecl b2Contact_ResetRestitution(b2ContactHandle handle) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetRestitution());
}

void __cdecl b2Contact_SetTangentSpeed(b2ContactHandle handle, float speed) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetTangentSpeed(speed));
}

float __cdecl b2Contact_GetTangentSpeed(b2ContactHandle handle) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTangentSpeed());
}

void __cdecl b2Contact_Evaluate(b2ContactHandle handle, b2Manifold* manifold, const b2Transform& xfA, const b2Transform& xfB) {
  b2Contact* classPtr = static_cast<b2Contact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Evaluate(manifold, xfA, xfB));
}

// ------------------ class b2ContactWrapper ------------------


// ------------------ class b2ChainAndCircleContactWrapper ------------------
b2ChainAndCircleContactHandle __cdecl b2ChainAndCircleContact_b2ChainAndCircleContact_1(b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB) {
  return new b2ChainAndCircleContact(fixtureA, indexA, fixtureB, indexB);
}

void __cdecl b2ChainAndCircleContact_dtor(b2ChainAndCircleContactHandle handle) {
  delete handle;
}


b2Manifold* __cdecl b2ChainAndCircleContact_GetManifold(b2ChainAndCircleContactHandle handle) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetManifold());
}

void __cdecl b2ChainAndCircleContact_GetWorldManifold(b2ChainAndCircleContactHandle handle, b2WorldManifold* worldManifold) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetWorldManifold(worldManifold));
}

bool __cdecl b2ChainAndCircleContact_IsTouching(b2ChainAndCircleContactHandle handle) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsTouching());
}

void __cdecl b2ChainAndCircleContact_SetEnabled(b2ChainAndCircleContactHandle handle, bool flag) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetEnabled(flag));
}

bool __cdecl b2ChainAndCircleContact_IsEnabled(b2ChainAndCircleContactHandle handle) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsEnabled());
}

b2Contact* __cdecl b2ChainAndCircleContact_GetNext(b2ChainAndCircleContactHandle handle) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

b2Fixture* __cdecl b2ChainAndCircleContact_GetFixtureA(b2ChainAndCircleContactHandle handle) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureA());
}

int __cdecl b2ChainAndCircleContact_GetChildIndexA(b2ChainAndCircleContactHandle handle) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildIndexA());
}

b2Fixture* __cdecl b2ChainAndCircleContact_GetFixtureB(b2ChainAndCircleContactHandle handle) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureB());
}

int __cdecl b2ChainAndCircleContact_GetChildIndexB(b2ChainAndCircleContactHandle handle) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildIndexB());
}

void __cdecl b2ChainAndCircleContact_SetFriction(b2ChainAndCircleContactHandle handle, float friction) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetFriction(friction));
}

float __cdecl b2ChainAndCircleContact_GetFriction(b2ChainAndCircleContactHandle handle) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFriction());
}

void __cdecl b2ChainAndCircleContact_ResetFriction(b2ChainAndCircleContactHandle handle) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetFriction());
}

void __cdecl b2ChainAndCircleContact_SetRestitution(b2ChainAndCircleContactHandle handle, float restitution) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetRestitution(restitution));
}

float __cdecl b2ChainAndCircleContact_GetRestitution(b2ChainAndCircleContactHandle handle) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetRestitution());
}

void __cdecl b2ChainAndCircleContact_ResetRestitution(b2ChainAndCircleContactHandle handle) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetRestitution());
}

void __cdecl b2ChainAndCircleContact_SetTangentSpeed(b2ChainAndCircleContactHandle handle, float speed) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetTangentSpeed(speed));
}

float __cdecl b2ChainAndCircleContact_GetTangentSpeed(b2ChainAndCircleContactHandle handle) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTangentSpeed());
}

void __cdecl b2ChainAndCircleContact_Evaluate(b2ChainAndCircleContactHandle handle, b2Manifold* manifold, const b2Transform& xfA, const b2Transform& xfB) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Evaluate(manifold, xfA, xfB));
}

b2Contact* __cdecl b2ChainAndCircleContact_Create(b2ChainAndCircleContactHandle handle, b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB, b2BlockAllocator* allocator) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Create(fixtureA, indexA, fixtureB, indexB, allocator));
}

void __cdecl b2ChainAndCircleContact_Destroy(b2ChainAndCircleContactHandle handle, b2Contact* contact, b2BlockAllocator* allocator) {
  b2ChainAndCircleContact* classPtr = static_cast<b2ChainAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Destroy(contact, allocator));
}

// ------------------ class b2ChainAndCircleContactWrapper ------------------


// ------------------ class b2ChainAndPolygonContactWrapper ------------------
b2ChainAndPolygonContactHandle __cdecl b2ChainAndPolygonContact_b2ChainAndPolygonContact_1(b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB) {
  return new b2ChainAndPolygonContact(fixtureA, indexA, fixtureB, indexB);
}

void __cdecl b2ChainAndPolygonContact_dtor(b2ChainAndPolygonContactHandle handle) {
  delete handle;
}


b2Manifold* __cdecl b2ChainAndPolygonContact_GetManifold(b2ChainAndPolygonContactHandle handle) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetManifold());
}

void __cdecl b2ChainAndPolygonContact_GetWorldManifold(b2ChainAndPolygonContactHandle handle, b2WorldManifold* worldManifold) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetWorldManifold(worldManifold));
}

bool __cdecl b2ChainAndPolygonContact_IsTouching(b2ChainAndPolygonContactHandle handle) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsTouching());
}

void __cdecl b2ChainAndPolygonContact_SetEnabled(b2ChainAndPolygonContactHandle handle, bool flag) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetEnabled(flag));
}

bool __cdecl b2ChainAndPolygonContact_IsEnabled(b2ChainAndPolygonContactHandle handle) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsEnabled());
}

b2Contact* __cdecl b2ChainAndPolygonContact_GetNext(b2ChainAndPolygonContactHandle handle) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

b2Fixture* __cdecl b2ChainAndPolygonContact_GetFixtureA(b2ChainAndPolygonContactHandle handle) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureA());
}

int __cdecl b2ChainAndPolygonContact_GetChildIndexA(b2ChainAndPolygonContactHandle handle) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildIndexA());
}

b2Fixture* __cdecl b2ChainAndPolygonContact_GetFixtureB(b2ChainAndPolygonContactHandle handle) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureB());
}

int __cdecl b2ChainAndPolygonContact_GetChildIndexB(b2ChainAndPolygonContactHandle handle) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildIndexB());
}

void __cdecl b2ChainAndPolygonContact_SetFriction(b2ChainAndPolygonContactHandle handle, float friction) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetFriction(friction));
}

float __cdecl b2ChainAndPolygonContact_GetFriction(b2ChainAndPolygonContactHandle handle) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFriction());
}

void __cdecl b2ChainAndPolygonContact_ResetFriction(b2ChainAndPolygonContactHandle handle) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetFriction());
}

void __cdecl b2ChainAndPolygonContact_SetRestitution(b2ChainAndPolygonContactHandle handle, float restitution) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetRestitution(restitution));
}

float __cdecl b2ChainAndPolygonContact_GetRestitution(b2ChainAndPolygonContactHandle handle) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetRestitution());
}

void __cdecl b2ChainAndPolygonContact_ResetRestitution(b2ChainAndPolygonContactHandle handle) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetRestitution());
}

void __cdecl b2ChainAndPolygonContact_SetTangentSpeed(b2ChainAndPolygonContactHandle handle, float speed) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetTangentSpeed(speed));
}

float __cdecl b2ChainAndPolygonContact_GetTangentSpeed(b2ChainAndPolygonContactHandle handle) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTangentSpeed());
}

void __cdecl b2ChainAndPolygonContact_Evaluate(b2ChainAndPolygonContactHandle handle, b2Manifold* manifold, const b2Transform& xfA, const b2Transform& xfB) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Evaluate(manifold, xfA, xfB));
}

b2Contact* __cdecl b2ChainAndPolygonContact_Create(b2ChainAndPolygonContactHandle handle, b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB, b2BlockAllocator* allocator) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Create(fixtureA, indexA, fixtureB, indexB, allocator));
}

void __cdecl b2ChainAndPolygonContact_Destroy(b2ChainAndPolygonContactHandle handle, b2Contact* contact, b2BlockAllocator* allocator) {
  b2ChainAndPolygonContact* classPtr = static_cast<b2ChainAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Destroy(contact, allocator));
}

// ------------------ class b2ChainAndPolygonContactWrapper ------------------


// ------------------ class b2CircleContactWrapper ------------------
b2CircleContactHandle __cdecl b2CircleContact_b2CircleContact_1(b2Fixture* fixtureA, b2Fixture* fixtureB) {
  return new b2CircleContact(fixtureA, fixtureB);
}

void __cdecl b2CircleContact_dtor(b2CircleContactHandle handle) {
  delete handle;
}


b2Manifold* __cdecl b2CircleContact_GetManifold(b2CircleContactHandle handle) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetManifold());
}

void __cdecl b2CircleContact_GetWorldManifold(b2CircleContactHandle handle, b2WorldManifold* worldManifold) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetWorldManifold(worldManifold));
}

bool __cdecl b2CircleContact_IsTouching(b2CircleContactHandle handle) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsTouching());
}

void __cdecl b2CircleContact_SetEnabled(b2CircleContactHandle handle, bool flag) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetEnabled(flag));
}

bool __cdecl b2CircleContact_IsEnabled(b2CircleContactHandle handle) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsEnabled());
}

b2Contact* __cdecl b2CircleContact_GetNext(b2CircleContactHandle handle) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

b2Fixture* __cdecl b2CircleContact_GetFixtureA(b2CircleContactHandle handle) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureA());
}

int __cdecl b2CircleContact_GetChildIndexA(b2CircleContactHandle handle) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildIndexA());
}

b2Fixture* __cdecl b2CircleContact_GetFixtureB(b2CircleContactHandle handle) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureB());
}

int __cdecl b2CircleContact_GetChildIndexB(b2CircleContactHandle handle) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildIndexB());
}

void __cdecl b2CircleContact_SetFriction(b2CircleContactHandle handle, float friction) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetFriction(friction));
}

float __cdecl b2CircleContact_GetFriction(b2CircleContactHandle handle) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFriction());
}

void __cdecl b2CircleContact_ResetFriction(b2CircleContactHandle handle) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetFriction());
}

void __cdecl b2CircleContact_SetRestitution(b2CircleContactHandle handle, float restitution) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetRestitution(restitution));
}

float __cdecl b2CircleContact_GetRestitution(b2CircleContactHandle handle) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetRestitution());
}

void __cdecl b2CircleContact_ResetRestitution(b2CircleContactHandle handle) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetRestitution());
}

void __cdecl b2CircleContact_SetTangentSpeed(b2CircleContactHandle handle, float speed) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetTangentSpeed(speed));
}

float __cdecl b2CircleContact_GetTangentSpeed(b2CircleContactHandle handle) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTangentSpeed());
}

void __cdecl b2CircleContact_Evaluate(b2CircleContactHandle handle, b2Manifold* manifold, const b2Transform& xfA, const b2Transform& xfB) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Evaluate(manifold, xfA, xfB));
}

b2Contact* __cdecl b2CircleContact_Create(b2CircleContactHandle handle, b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB, b2BlockAllocator* allocator) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Create(fixtureA, indexA, fixtureB, indexB, allocator));
}

void __cdecl b2CircleContact_Destroy(b2CircleContactHandle handle, b2Contact* contact, b2BlockAllocator* allocator) {
  b2CircleContact* classPtr = static_cast<b2CircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Destroy(contact, allocator));
}

// ------------------ class b2CircleContactWrapper ------------------


// ------------------ class b2VelocityConstraintPoint ------------------
b2VelocityConstraintPoint __cdecl b2VelocityConstraintPoint_b2VelocityConstraintPoint() {
  return  b2VelocityConstraintPoint();
}

// ------------------ class b2VelocityConstraintPoint ------------------


// ------------------ class b2ContactVelocityConstraint ------------------
b2ContactVelocityConstraint __cdecl b2ContactVelocityConstraint_b2ContactVelocityConstraint() {
  return  b2ContactVelocityConstraint();
}

// ------------------ class b2ContactVelocityConstraint ------------------


// ------------------ class b2ContactSolverDef ------------------
b2ContactSolverDef __cdecl b2ContactSolverDef_b2ContactSolverDef() {
  return  b2ContactSolverDef();
}

// ------------------ class b2ContactSolverDef ------------------


// ------------------ class b2ContactSolverWrapper ------------------
b2ContactSolverHandle __cdecl b2ContactSolver_b2ContactSolver_1(b2ContactSolverDef* def) {
  return new b2ContactSolver(def);
}

void __cdecl b2ContactSolver_dtor(b2ContactSolverHandle handle) {
  delete handle;
}


void __cdecl b2ContactSolver_InitializeVelocityConstraints(b2ContactSolverHandle handle) {
  b2ContactSolver* classPtr = static_cast<b2ContactSolver*>(handle);
  assert(classPtr != 0);
  return (classPtr->InitializeVelocityConstraints());
}

void __cdecl b2ContactSolver_WarmStart(b2ContactSolverHandle handle) {
  b2ContactSolver* classPtr = static_cast<b2ContactSolver*>(handle);
  assert(classPtr != 0);
  return (classPtr->WarmStart());
}

void __cdecl b2ContactSolver_SolveVelocityConstraints(b2ContactSolverHandle handle) {
  b2ContactSolver* classPtr = static_cast<b2ContactSolver*>(handle);
  assert(classPtr != 0);
  return (classPtr->SolveVelocityConstraints());
}

void __cdecl b2ContactSolver_StoreImpulses(b2ContactSolverHandle handle) {
  b2ContactSolver* classPtr = static_cast<b2ContactSolver*>(handle);
  assert(classPtr != 0);
  return (classPtr->StoreImpulses());
}

bool __cdecl b2ContactSolver_SolvePositionConstraints(b2ContactSolverHandle handle) {
  b2ContactSolver* classPtr = static_cast<b2ContactSolver*>(handle);
  assert(classPtr != 0);
  return (classPtr->SolvePositionConstraints());
}

bool __cdecl b2ContactSolver_SolveTOIPositionConstraints(b2ContactSolverHandle handle, int toiIndexA, int toiIndexB) {
  b2ContactSolver* classPtr = static_cast<b2ContactSolver*>(handle);
  assert(classPtr != 0);
  return (classPtr->SolveTOIPositionConstraints(toiIndexA, toiIndexB));
}


b2TimeStep __cdecl b2ContactSolver_Get_m_step(b2ContactSolverHandle handle) {
  return (handle->m_step);
}

void __cdecl b2ContactSolver_Set_m_step(b2ContactSolverHandle handle, b2TimeStep newValue) {
 handle->m_step = newValue;
};

b2TimeStep* __cdecl b2ContactSolver_Get_m_step_P(b2ContactSolverHandle handle) {
  return &(handle->m_step);
}


b2Position* __cdecl b2ContactSolver_Get_m_positions(b2ContactSolverHandle handle) {
  return (handle->m_positions);
}

void __cdecl b2ContactSolver_Set_m_positions(b2ContactSolverHandle handle, b2Position* newValue) {
 handle->m_positions = newValue;
};


b2Velocity* __cdecl b2ContactSolver_Get_m_velocities(b2ContactSolverHandle handle) {
  return (handle->m_velocities);
}

void __cdecl b2ContactSolver_Set_m_velocities(b2ContactSolverHandle handle, b2Velocity* newValue) {
 handle->m_velocities = newValue;
};


b2StackAllocator* __cdecl b2ContactSolver_Get_m_allocator(b2ContactSolverHandle handle) {
  return (handle->m_allocator);
}

void __cdecl b2ContactSolver_Set_m_allocator(b2ContactSolverHandle handle, b2StackAllocator* newValue) {
 handle->m_allocator = newValue;
};


b2ContactVelocityConstraint* __cdecl b2ContactSolver_Get_m_velocityConstraints(b2ContactSolverHandle handle) {
  return (handle->m_velocityConstraints);
}

void __cdecl b2ContactSolver_Set_m_velocityConstraints(b2ContactSolverHandle handle, b2ContactVelocityConstraint* newValue) {
 handle->m_velocityConstraints = newValue;
};


b2Contact** __cdecl b2ContactSolver_Get_m_contacts(b2ContactSolverHandle handle) {
  return (handle->m_contacts);
}

void __cdecl b2ContactSolver_Set_m_contacts(b2ContactSolverHandle handle, b2Contact** newValue) {
 handle->m_contacts = newValue;
};


int __cdecl b2ContactSolver_Get_m_count(b2ContactSolverHandle handle) {
  return (handle->m_count);
}

void __cdecl b2ContactSolver_Set_m_count(b2ContactSolverHandle handle, int newValue) {
 handle->m_count = newValue;
};

// ------------------ class b2ContactSolverWrapper ------------------


// ------------------ class b2EdgeAndCircleContactWrapper ------------------
b2EdgeAndCircleContactHandle __cdecl b2EdgeAndCircleContact_b2EdgeAndCircleContact_1(b2Fixture* fixtureA, b2Fixture* fixtureB) {
  return new b2EdgeAndCircleContact(fixtureA, fixtureB);
}

void __cdecl b2EdgeAndCircleContact_dtor(b2EdgeAndCircleContactHandle handle) {
  delete handle;
}


b2Manifold* __cdecl b2EdgeAndCircleContact_GetManifold(b2EdgeAndCircleContactHandle handle) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetManifold());
}

void __cdecl b2EdgeAndCircleContact_GetWorldManifold(b2EdgeAndCircleContactHandle handle, b2WorldManifold* worldManifold) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetWorldManifold(worldManifold));
}

bool __cdecl b2EdgeAndCircleContact_IsTouching(b2EdgeAndCircleContactHandle handle) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsTouching());
}

void __cdecl b2EdgeAndCircleContact_SetEnabled(b2EdgeAndCircleContactHandle handle, bool flag) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetEnabled(flag));
}

bool __cdecl b2EdgeAndCircleContact_IsEnabled(b2EdgeAndCircleContactHandle handle) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsEnabled());
}

b2Contact* __cdecl b2EdgeAndCircleContact_GetNext(b2EdgeAndCircleContactHandle handle) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

b2Fixture* __cdecl b2EdgeAndCircleContact_GetFixtureA(b2EdgeAndCircleContactHandle handle) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureA());
}

int __cdecl b2EdgeAndCircleContact_GetChildIndexA(b2EdgeAndCircleContactHandle handle) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildIndexA());
}

b2Fixture* __cdecl b2EdgeAndCircleContact_GetFixtureB(b2EdgeAndCircleContactHandle handle) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureB());
}

int __cdecl b2EdgeAndCircleContact_GetChildIndexB(b2EdgeAndCircleContactHandle handle) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildIndexB());
}

void __cdecl b2EdgeAndCircleContact_SetFriction(b2EdgeAndCircleContactHandle handle, float friction) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetFriction(friction));
}

float __cdecl b2EdgeAndCircleContact_GetFriction(b2EdgeAndCircleContactHandle handle) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFriction());
}

void __cdecl b2EdgeAndCircleContact_ResetFriction(b2EdgeAndCircleContactHandle handle) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetFriction());
}

void __cdecl b2EdgeAndCircleContact_SetRestitution(b2EdgeAndCircleContactHandle handle, float restitution) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetRestitution(restitution));
}

float __cdecl b2EdgeAndCircleContact_GetRestitution(b2EdgeAndCircleContactHandle handle) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetRestitution());
}

void __cdecl b2EdgeAndCircleContact_ResetRestitution(b2EdgeAndCircleContactHandle handle) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetRestitution());
}

void __cdecl b2EdgeAndCircleContact_SetTangentSpeed(b2EdgeAndCircleContactHandle handle, float speed) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetTangentSpeed(speed));
}

float __cdecl b2EdgeAndCircleContact_GetTangentSpeed(b2EdgeAndCircleContactHandle handle) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTangentSpeed());
}

void __cdecl b2EdgeAndCircleContact_Evaluate(b2EdgeAndCircleContactHandle handle, b2Manifold* manifold, const b2Transform& xfA, const b2Transform& xfB) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Evaluate(manifold, xfA, xfB));
}

b2Contact* __cdecl b2EdgeAndCircleContact_Create(b2EdgeAndCircleContactHandle handle, b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB, b2BlockAllocator* allocator) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Create(fixtureA, indexA, fixtureB, indexB, allocator));
}

void __cdecl b2EdgeAndCircleContact_Destroy(b2EdgeAndCircleContactHandle handle, b2Contact* contact, b2BlockAllocator* allocator) {
  b2EdgeAndCircleContact* classPtr = static_cast<b2EdgeAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Destroy(contact, allocator));
}

// ------------------ class b2EdgeAndCircleContactWrapper ------------------


// ------------------ class b2EdgeAndPolygonContactWrapper ------------------
b2EdgeAndPolygonContactHandle __cdecl b2EdgeAndPolygonContact_b2EdgeAndPolygonContact_1(b2Fixture* fixtureA, b2Fixture* fixtureB) {
  return new b2EdgeAndPolygonContact(fixtureA, fixtureB);
}

void __cdecl b2EdgeAndPolygonContact_dtor(b2EdgeAndPolygonContactHandle handle) {
  delete handle;
}


b2Manifold* __cdecl b2EdgeAndPolygonContact_GetManifold(b2EdgeAndPolygonContactHandle handle) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetManifold());
}

void __cdecl b2EdgeAndPolygonContact_GetWorldManifold(b2EdgeAndPolygonContactHandle handle, b2WorldManifold* worldManifold) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetWorldManifold(worldManifold));
}

bool __cdecl b2EdgeAndPolygonContact_IsTouching(b2EdgeAndPolygonContactHandle handle) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsTouching());
}

void __cdecl b2EdgeAndPolygonContact_SetEnabled(b2EdgeAndPolygonContactHandle handle, bool flag) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetEnabled(flag));
}

bool __cdecl b2EdgeAndPolygonContact_IsEnabled(b2EdgeAndPolygonContactHandle handle) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsEnabled());
}

b2Contact* __cdecl b2EdgeAndPolygonContact_GetNext(b2EdgeAndPolygonContactHandle handle) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

b2Fixture* __cdecl b2EdgeAndPolygonContact_GetFixtureA(b2EdgeAndPolygonContactHandle handle) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureA());
}

int __cdecl b2EdgeAndPolygonContact_GetChildIndexA(b2EdgeAndPolygonContactHandle handle) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildIndexA());
}

b2Fixture* __cdecl b2EdgeAndPolygonContact_GetFixtureB(b2EdgeAndPolygonContactHandle handle) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureB());
}

int __cdecl b2EdgeAndPolygonContact_GetChildIndexB(b2EdgeAndPolygonContactHandle handle) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildIndexB());
}

void __cdecl b2EdgeAndPolygonContact_SetFriction(b2EdgeAndPolygonContactHandle handle, float friction) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetFriction(friction));
}

float __cdecl b2EdgeAndPolygonContact_GetFriction(b2EdgeAndPolygonContactHandle handle) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFriction());
}

void __cdecl b2EdgeAndPolygonContact_ResetFriction(b2EdgeAndPolygonContactHandle handle) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetFriction());
}

void __cdecl b2EdgeAndPolygonContact_SetRestitution(b2EdgeAndPolygonContactHandle handle, float restitution) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetRestitution(restitution));
}

float __cdecl b2EdgeAndPolygonContact_GetRestitution(b2EdgeAndPolygonContactHandle handle) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetRestitution());
}

void __cdecl b2EdgeAndPolygonContact_ResetRestitution(b2EdgeAndPolygonContactHandle handle) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetRestitution());
}

void __cdecl b2EdgeAndPolygonContact_SetTangentSpeed(b2EdgeAndPolygonContactHandle handle, float speed) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetTangentSpeed(speed));
}

float __cdecl b2EdgeAndPolygonContact_GetTangentSpeed(b2EdgeAndPolygonContactHandle handle) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTangentSpeed());
}

void __cdecl b2EdgeAndPolygonContact_Evaluate(b2EdgeAndPolygonContactHandle handle, b2Manifold* manifold, const b2Transform& xfA, const b2Transform& xfB) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Evaluate(manifold, xfA, xfB));
}

b2Contact* __cdecl b2EdgeAndPolygonContact_Create(b2EdgeAndPolygonContactHandle handle, b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB, b2BlockAllocator* allocator) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Create(fixtureA, indexA, fixtureB, indexB, allocator));
}

void __cdecl b2EdgeAndPolygonContact_Destroy(b2EdgeAndPolygonContactHandle handle, b2Contact* contact, b2BlockAllocator* allocator) {
  b2EdgeAndPolygonContact* classPtr = static_cast<b2EdgeAndPolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Destroy(contact, allocator));
}

// ------------------ class b2EdgeAndPolygonContactWrapper ------------------


// ------------------ class b2PolygonAndCircleContactWrapper ------------------
b2PolygonAndCircleContactHandle __cdecl b2PolygonAndCircleContact_b2PolygonAndCircleContact_1(b2Fixture* fixtureA, b2Fixture* fixtureB) {
  return new b2PolygonAndCircleContact(fixtureA, fixtureB);
}

void __cdecl b2PolygonAndCircleContact_dtor(b2PolygonAndCircleContactHandle handle) {
  delete handle;
}


b2Manifold* __cdecl b2PolygonAndCircleContact_GetManifold(b2PolygonAndCircleContactHandle handle) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetManifold());
}

void __cdecl b2PolygonAndCircleContact_GetWorldManifold(b2PolygonAndCircleContactHandle handle, b2WorldManifold* worldManifold) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetWorldManifold(worldManifold));
}

bool __cdecl b2PolygonAndCircleContact_IsTouching(b2PolygonAndCircleContactHandle handle) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsTouching());
}

void __cdecl b2PolygonAndCircleContact_SetEnabled(b2PolygonAndCircleContactHandle handle, bool flag) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetEnabled(flag));
}

bool __cdecl b2PolygonAndCircleContact_IsEnabled(b2PolygonAndCircleContactHandle handle) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsEnabled());
}

b2Contact* __cdecl b2PolygonAndCircleContact_GetNext(b2PolygonAndCircleContactHandle handle) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

b2Fixture* __cdecl b2PolygonAndCircleContact_GetFixtureA(b2PolygonAndCircleContactHandle handle) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureA());
}

int __cdecl b2PolygonAndCircleContact_GetChildIndexA(b2PolygonAndCircleContactHandle handle) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildIndexA());
}

b2Fixture* __cdecl b2PolygonAndCircleContact_GetFixtureB(b2PolygonAndCircleContactHandle handle) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureB());
}

int __cdecl b2PolygonAndCircleContact_GetChildIndexB(b2PolygonAndCircleContactHandle handle) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildIndexB());
}

void __cdecl b2PolygonAndCircleContact_SetFriction(b2PolygonAndCircleContactHandle handle, float friction) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetFriction(friction));
}

float __cdecl b2PolygonAndCircleContact_GetFriction(b2PolygonAndCircleContactHandle handle) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFriction());
}

void __cdecl b2PolygonAndCircleContact_ResetFriction(b2PolygonAndCircleContactHandle handle) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetFriction());
}

void __cdecl b2PolygonAndCircleContact_SetRestitution(b2PolygonAndCircleContactHandle handle, float restitution) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetRestitution(restitution));
}

float __cdecl b2PolygonAndCircleContact_GetRestitution(b2PolygonAndCircleContactHandle handle) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetRestitution());
}

void __cdecl b2PolygonAndCircleContact_ResetRestitution(b2PolygonAndCircleContactHandle handle) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetRestitution());
}

void __cdecl b2PolygonAndCircleContact_SetTangentSpeed(b2PolygonAndCircleContactHandle handle, float speed) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetTangentSpeed(speed));
}

float __cdecl b2PolygonAndCircleContact_GetTangentSpeed(b2PolygonAndCircleContactHandle handle) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTangentSpeed());
}

void __cdecl b2PolygonAndCircleContact_Evaluate(b2PolygonAndCircleContactHandle handle, b2Manifold* manifold, const b2Transform& xfA, const b2Transform& xfB) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Evaluate(manifold, xfA, xfB));
}

b2Contact* __cdecl b2PolygonAndCircleContact_Create(b2PolygonAndCircleContactHandle handle, b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB, b2BlockAllocator* allocator) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Create(fixtureA, indexA, fixtureB, indexB, allocator));
}

void __cdecl b2PolygonAndCircleContact_Destroy(b2PolygonAndCircleContactHandle handle, b2Contact* contact, b2BlockAllocator* allocator) {
  b2PolygonAndCircleContact* classPtr = static_cast<b2PolygonAndCircleContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Destroy(contact, allocator));
}

// ------------------ class b2PolygonAndCircleContactWrapper ------------------


// ------------------ class b2PolygonContactWrapper ------------------
b2PolygonContactHandle __cdecl b2PolygonContact_b2PolygonContact_1(b2Fixture* fixtureA, b2Fixture* fixtureB) {
  return new b2PolygonContact(fixtureA, fixtureB);
}

void __cdecl b2PolygonContact_dtor(b2PolygonContactHandle handle) {
  delete handle;
}


b2Manifold* __cdecl b2PolygonContact_GetManifold(b2PolygonContactHandle handle) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetManifold());
}

void __cdecl b2PolygonContact_GetWorldManifold(b2PolygonContactHandle handle, b2WorldManifold* worldManifold) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetWorldManifold(worldManifold));
}

bool __cdecl b2PolygonContact_IsTouching(b2PolygonContactHandle handle) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsTouching());
}

void __cdecl b2PolygonContact_SetEnabled(b2PolygonContactHandle handle, bool flag) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetEnabled(flag));
}

bool __cdecl b2PolygonContact_IsEnabled(b2PolygonContactHandle handle) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsEnabled());
}

b2Contact* __cdecl b2PolygonContact_GetNext(b2PolygonContactHandle handle) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

b2Fixture* __cdecl b2PolygonContact_GetFixtureA(b2PolygonContactHandle handle) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureA());
}

int __cdecl b2PolygonContact_GetChildIndexA(b2PolygonContactHandle handle) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildIndexA());
}

b2Fixture* __cdecl b2PolygonContact_GetFixtureB(b2PolygonContactHandle handle) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFixtureB());
}

int __cdecl b2PolygonContact_GetChildIndexB(b2PolygonContactHandle handle) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetChildIndexB());
}

void __cdecl b2PolygonContact_SetFriction(b2PolygonContactHandle handle, float friction) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetFriction(friction));
}

float __cdecl b2PolygonContact_GetFriction(b2PolygonContactHandle handle) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFriction());
}

void __cdecl b2PolygonContact_ResetFriction(b2PolygonContactHandle handle) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetFriction());
}

void __cdecl b2PolygonContact_SetRestitution(b2PolygonContactHandle handle, float restitution) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetRestitution(restitution));
}

float __cdecl b2PolygonContact_GetRestitution(b2PolygonContactHandle handle) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetRestitution());
}

void __cdecl b2PolygonContact_ResetRestitution(b2PolygonContactHandle handle) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->ResetRestitution());
}

void __cdecl b2PolygonContact_SetTangentSpeed(b2PolygonContactHandle handle, float speed) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetTangentSpeed(speed));
}

float __cdecl b2PolygonContact_GetTangentSpeed(b2PolygonContactHandle handle) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTangentSpeed());
}

void __cdecl b2PolygonContact_Evaluate(b2PolygonContactHandle handle, b2Manifold* manifold, const b2Transform& xfA, const b2Transform& xfB) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Evaluate(manifold, xfA, xfB));
}

b2Contact* __cdecl b2PolygonContact_Create(b2PolygonContactHandle handle, b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB, b2BlockAllocator* allocator) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Create(fixtureA, indexA, fixtureB, indexB, allocator));
}

void __cdecl b2PolygonContact_Destroy(b2PolygonContactHandle handle, b2Contact* contact, b2BlockAllocator* allocator) {
  b2PolygonContact* classPtr = static_cast<b2PolygonContact*>(handle);
  assert(classPtr != 0);
  return (classPtr->Destroy(contact, allocator));
}

// ------------------ class b2PolygonContactWrapper ------------------


// ------------------ class b2Jacobian ------------------
b2Jacobian __cdecl b2Jacobian_b2Jacobian() {
  return  b2Jacobian();
}

// ------------------ class b2Jacobian ------------------


// ------------------ class b2JointEdge ------------------
b2JointEdge __cdecl b2JointEdge_b2JointEdge() {
  return  b2JointEdge();
}

// ------------------ class b2JointEdge ------------------


// ------------------ class b2JointDef ------------------
b2JointDef __cdecl b2JointDef_b2JointDef_1() {
  return  b2JointDef();
}

// ------------------ class b2JointDef ------------------


// ------------------ class b2JointWrapper ------------------

b2JointType __cdecl b2Joint_GetType(b2JointHandle handle) {
  b2Joint* classPtr = static_cast<b2Joint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

b2Body* __cdecl b2Joint_GetBodyA(b2JointHandle handle) {
  b2Joint* classPtr = static_cast<b2Joint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyA());
}

b2Body* __cdecl b2Joint_GetBodyB(b2JointHandle handle) {
  b2Joint* classPtr = static_cast<b2Joint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyB());
}

b2Vec2 __cdecl b2Joint_GetAnchorA(b2JointHandle handle) {
  b2Joint* classPtr = static_cast<b2Joint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorA());
}

b2Vec2 __cdecl b2Joint_GetAnchorB(b2JointHandle handle) {
  b2Joint* classPtr = static_cast<b2Joint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorB());
}

b2Vec2 __cdecl b2Joint_GetReactionForce(b2JointHandle handle, float inv_dt) {
  b2Joint* classPtr = static_cast<b2Joint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionForce(inv_dt));
}

float __cdecl b2Joint_GetReactionTorque(b2JointHandle handle, float inv_dt) {
  b2Joint* classPtr = static_cast<b2Joint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionTorque(inv_dt));
}

b2Joint* __cdecl b2Joint_GetNext(b2JointHandle handle) {
  b2Joint* classPtr = static_cast<b2Joint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

void* __cdecl b2Joint_GetUserData(b2JointHandle handle) {
  b2Joint* classPtr = static_cast<b2Joint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUserData());
}

void __cdecl b2Joint_SetUserData(b2JointHandle handle, void* data) {
  b2Joint* classPtr = static_cast<b2Joint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetUserData(data));
}

bool __cdecl b2Joint_IsActive(b2JointHandle handle) {
  b2Joint* classPtr = static_cast<b2Joint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsActive());
}

bool __cdecl b2Joint_GetCollideConnected(b2JointHandle handle) {
  b2Joint* classPtr = static_cast<b2Joint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetCollideConnected());
}

void __cdecl b2Joint_Dump(b2JointHandle handle) {
  b2Joint* classPtr = static_cast<b2Joint*>(handle);
  assert(classPtr != 0);
  return (classPtr->Dump());
}

void __cdecl b2Joint_ShiftOrigin(b2JointHandle handle, const b2Vec2& newOrigin) {
  b2Joint* classPtr = static_cast<b2Joint*>(handle);
  assert(classPtr != 0);
  return (classPtr->ShiftOrigin(newOrigin));
}

// ------------------ class b2JointWrapper ------------------


// ------------------ class b2DistanceJointDef ------------------
b2DistanceJointDef __cdecl b2DistanceJointDef_b2DistanceJointDef_1() {
  return  b2DistanceJointDef();
}

void __cdecl b2DistanceJointDef_Initialize(b2DistanceJointDefHandle handle, b2Body* bodyA, b2Body* bodyB, const b2Vec2& anchorA, const b2Vec2& anchorB) {
  b2DistanceJointDef* classPtr = static_cast<b2DistanceJointDef*>(handle);
  assert(classPtr != 0);
  return (classPtr->Initialize(bodyA, bodyB, anchorA, anchorB));
}

// ------------------ class b2DistanceJointDef ------------------


// ------------------ class b2DistanceJointWrapper ------------------
void __cdecl b2DistanceJoint_dtor(b2DistanceJointHandle handle) {
  delete handle;
}


b2JointType __cdecl b2DistanceJoint_GetType(b2DistanceJointHandle handle) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

b2Body* __cdecl b2DistanceJoint_GetBodyA(b2DistanceJointHandle handle) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyA());
}

b2Body* __cdecl b2DistanceJoint_GetBodyB(b2DistanceJointHandle handle) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyB());
}

b2Vec2 __cdecl b2DistanceJoint_GetAnchorA(b2DistanceJointHandle handle) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorA());
}

b2Vec2 __cdecl b2DistanceJoint_GetAnchorB(b2DistanceJointHandle handle) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorB());
}

b2Vec2 __cdecl b2DistanceJoint_GetReactionForce(b2DistanceJointHandle handle, float inv_dt) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionForce(inv_dt));
}

float __cdecl b2DistanceJoint_GetReactionTorque(b2DistanceJointHandle handle, float inv_dt) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionTorque(inv_dt));
}

b2Joint* __cdecl b2DistanceJoint_GetNext(b2DistanceJointHandle handle) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

void* __cdecl b2DistanceJoint_GetUserData(b2DistanceJointHandle handle) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUserData());
}

void __cdecl b2DistanceJoint_SetUserData(b2DistanceJointHandle handle, void* data) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetUserData(data));
}

bool __cdecl b2DistanceJoint_IsActive(b2DistanceJointHandle handle) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsActive());
}

bool __cdecl b2DistanceJoint_GetCollideConnected(b2DistanceJointHandle handle) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetCollideConnected());
}

void __cdecl b2DistanceJoint_Dump(b2DistanceJointHandle handle) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->Dump());
}

void __cdecl b2DistanceJoint_ShiftOrigin(b2DistanceJointHandle handle, const b2Vec2& newOrigin) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->ShiftOrigin(newOrigin));
}

const b2Vec2& __cdecl b2DistanceJoint_GetLocalAnchorA(b2DistanceJointHandle handle) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalAnchorA());
}

const b2Vec2& __cdecl b2DistanceJoint_GetLocalAnchorB(b2DistanceJointHandle handle) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalAnchorB());
}

void __cdecl b2DistanceJoint_SetLength(b2DistanceJointHandle handle, float length) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetLength(length));
}

float __cdecl b2DistanceJoint_GetLength(b2DistanceJointHandle handle) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLength());
}

void __cdecl b2DistanceJoint_SetFrequency(b2DistanceJointHandle handle, float hz) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetFrequency(hz));
}

float __cdecl b2DistanceJoint_GetFrequency(b2DistanceJointHandle handle) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFrequency());
}

void __cdecl b2DistanceJoint_SetDampingRatio(b2DistanceJointHandle handle, float ratio) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetDampingRatio(ratio));
}

float __cdecl b2DistanceJoint_GetDampingRatio(b2DistanceJointHandle handle) {
  b2DistanceJoint* classPtr = static_cast<b2DistanceJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetDampingRatio());
}

// ------------------ class b2DistanceJointWrapper ------------------


// ------------------ class b2FrictionJointDef ------------------
b2FrictionJointDef __cdecl b2FrictionJointDef_b2FrictionJointDef_1() {
  return  b2FrictionJointDef();
}

void __cdecl b2FrictionJointDef_Initialize(b2FrictionJointDefHandle handle, b2Body* bodyA, b2Body* bodyB, const b2Vec2& anchor) {
  b2FrictionJointDef* classPtr = static_cast<b2FrictionJointDef*>(handle);
  assert(classPtr != 0);
  return (classPtr->Initialize(bodyA, bodyB, anchor));
}

// ------------------ class b2FrictionJointDef ------------------


// ------------------ class b2FrictionJointWrapper ------------------
void __cdecl b2FrictionJoint_dtor(b2FrictionJointHandle handle) {
  delete handle;
}


b2JointType __cdecl b2FrictionJoint_GetType(b2FrictionJointHandle handle) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

b2Body* __cdecl b2FrictionJoint_GetBodyA(b2FrictionJointHandle handle) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyA());
}

b2Body* __cdecl b2FrictionJoint_GetBodyB(b2FrictionJointHandle handle) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyB());
}

b2Vec2 __cdecl b2FrictionJoint_GetAnchorA(b2FrictionJointHandle handle) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorA());
}

b2Vec2 __cdecl b2FrictionJoint_GetAnchorB(b2FrictionJointHandle handle) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorB());
}

b2Vec2 __cdecl b2FrictionJoint_GetReactionForce(b2FrictionJointHandle handle, float inv_dt) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionForce(inv_dt));
}

float __cdecl b2FrictionJoint_GetReactionTorque(b2FrictionJointHandle handle, float inv_dt) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionTorque(inv_dt));
}

b2Joint* __cdecl b2FrictionJoint_GetNext(b2FrictionJointHandle handle) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

void* __cdecl b2FrictionJoint_GetUserData(b2FrictionJointHandle handle) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUserData());
}

void __cdecl b2FrictionJoint_SetUserData(b2FrictionJointHandle handle, void* data) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetUserData(data));
}

bool __cdecl b2FrictionJoint_IsActive(b2FrictionJointHandle handle) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsActive());
}

bool __cdecl b2FrictionJoint_GetCollideConnected(b2FrictionJointHandle handle) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetCollideConnected());
}

void __cdecl b2FrictionJoint_Dump(b2FrictionJointHandle handle) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->Dump());
}

void __cdecl b2FrictionJoint_ShiftOrigin(b2FrictionJointHandle handle, const b2Vec2& newOrigin) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->ShiftOrigin(newOrigin));
}

const b2Vec2& __cdecl b2FrictionJoint_GetLocalAnchorA(b2FrictionJointHandle handle) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalAnchorA());
}

const b2Vec2& __cdecl b2FrictionJoint_GetLocalAnchorB(b2FrictionJointHandle handle) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalAnchorB());
}

void __cdecl b2FrictionJoint_SetMaxForce(b2FrictionJointHandle handle, float force) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetMaxForce(force));
}

float __cdecl b2FrictionJoint_GetMaxForce(b2FrictionJointHandle handle) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMaxForce());
}

void __cdecl b2FrictionJoint_SetMaxTorque(b2FrictionJointHandle handle, float torque) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetMaxTorque(torque));
}

float __cdecl b2FrictionJoint_GetMaxTorque(b2FrictionJointHandle handle) {
  b2FrictionJoint* classPtr = static_cast<b2FrictionJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMaxTorque());
}

// ------------------ class b2FrictionJointWrapper ------------------


// ------------------ class b2GearJointDef ------------------
b2GearJointDef __cdecl b2GearJointDef_b2GearJointDef_1() {
  return  b2GearJointDef();
}

// ------------------ class b2GearJointDef ------------------


// ------------------ class b2GearJointWrapper ------------------
void __cdecl b2GearJoint_dtor(b2GearJointHandle handle) {
  delete handle;
}


b2JointType __cdecl b2GearJoint_GetType(b2GearJointHandle handle) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

b2Body* __cdecl b2GearJoint_GetBodyA(b2GearJointHandle handle) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyA());
}

b2Body* __cdecl b2GearJoint_GetBodyB(b2GearJointHandle handle) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyB());
}

b2Vec2 __cdecl b2GearJoint_GetAnchorA(b2GearJointHandle handle) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorA());
}

b2Vec2 __cdecl b2GearJoint_GetAnchorB(b2GearJointHandle handle) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorB());
}

b2Vec2 __cdecl b2GearJoint_GetReactionForce(b2GearJointHandle handle, float inv_dt) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionForce(inv_dt));
}

float __cdecl b2GearJoint_GetReactionTorque(b2GearJointHandle handle, float inv_dt) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionTorque(inv_dt));
}

b2Joint* __cdecl b2GearJoint_GetNext(b2GearJointHandle handle) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

void* __cdecl b2GearJoint_GetUserData(b2GearJointHandle handle) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUserData());
}

void __cdecl b2GearJoint_SetUserData(b2GearJointHandle handle, void* data) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetUserData(data));
}

bool __cdecl b2GearJoint_IsActive(b2GearJointHandle handle) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsActive());
}

bool __cdecl b2GearJoint_GetCollideConnected(b2GearJointHandle handle) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetCollideConnected());
}

void __cdecl b2GearJoint_Dump(b2GearJointHandle handle) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->Dump());
}

void __cdecl b2GearJoint_ShiftOrigin(b2GearJointHandle handle, const b2Vec2& newOrigin) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->ShiftOrigin(newOrigin));
}

b2Joint* __cdecl b2GearJoint_GetJoint1(b2GearJointHandle handle) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetJoint1());
}

b2Joint* __cdecl b2GearJoint_GetJoint2(b2GearJointHandle handle) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetJoint2());
}

void __cdecl b2GearJoint_SetRatio(b2GearJointHandle handle, float ratio) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetRatio(ratio));
}

float __cdecl b2GearJoint_GetRatio(b2GearJointHandle handle) {
  b2GearJoint* classPtr = static_cast<b2GearJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetRatio());
}

// ------------------ class b2GearJointWrapper ------------------


// ------------------ class b2MotorJointDef ------------------
b2MotorJointDef __cdecl b2MotorJointDef_b2MotorJointDef_1() {
  return  b2MotorJointDef();
}

void __cdecl b2MotorJointDef_Initialize(b2MotorJointDefHandle handle, b2Body* bodyA, b2Body* bodyB) {
  b2MotorJointDef* classPtr = static_cast<b2MotorJointDef*>(handle);
  assert(classPtr != 0);
  return (classPtr->Initialize(bodyA, bodyB));
}

// ------------------ class b2MotorJointDef ------------------


// ------------------ class b2MotorJointWrapper ------------------
void __cdecl b2MotorJoint_dtor(b2MotorJointHandle handle) {
  delete handle;
}


b2JointType __cdecl b2MotorJoint_GetType(b2MotorJointHandle handle) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

b2Body* __cdecl b2MotorJoint_GetBodyA(b2MotorJointHandle handle) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyA());
}

b2Body* __cdecl b2MotorJoint_GetBodyB(b2MotorJointHandle handle) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyB());
}

b2Vec2 __cdecl b2MotorJoint_GetAnchorA(b2MotorJointHandle handle) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorA());
}

b2Vec2 __cdecl b2MotorJoint_GetAnchorB(b2MotorJointHandle handle) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorB());
}

b2Vec2 __cdecl b2MotorJoint_GetReactionForce(b2MotorJointHandle handle, float inv_dt) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionForce(inv_dt));
}

float __cdecl b2MotorJoint_GetReactionTorque(b2MotorJointHandle handle, float inv_dt) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionTorque(inv_dt));
}

b2Joint* __cdecl b2MotorJoint_GetNext(b2MotorJointHandle handle) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

void* __cdecl b2MotorJoint_GetUserData(b2MotorJointHandle handle) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUserData());
}

void __cdecl b2MotorJoint_SetUserData(b2MotorJointHandle handle, void* data) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetUserData(data));
}

bool __cdecl b2MotorJoint_IsActive(b2MotorJointHandle handle) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsActive());
}

bool __cdecl b2MotorJoint_GetCollideConnected(b2MotorJointHandle handle) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetCollideConnected());
}

void __cdecl b2MotorJoint_Dump(b2MotorJointHandle handle) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->Dump());
}

void __cdecl b2MotorJoint_ShiftOrigin(b2MotorJointHandle handle, const b2Vec2& newOrigin) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->ShiftOrigin(newOrigin));
}

void __cdecl b2MotorJoint_SetLinearOffset(b2MotorJointHandle handle, const b2Vec2& linearOffset) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetLinearOffset(linearOffset));
}

const b2Vec2& __cdecl b2MotorJoint_GetLinearOffset(b2MotorJointHandle handle) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLinearOffset());
}

void __cdecl b2MotorJoint_SetAngularOffset(b2MotorJointHandle handle, float angularOffset) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetAngularOffset(angularOffset));
}

float __cdecl b2MotorJoint_GetAngularOffset(b2MotorJointHandle handle) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAngularOffset());
}

void __cdecl b2MotorJoint_SetMaxForce(b2MotorJointHandle handle, float force) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetMaxForce(force));
}

float __cdecl b2MotorJoint_GetMaxForce(b2MotorJointHandle handle) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMaxForce());
}

void __cdecl b2MotorJoint_SetMaxTorque(b2MotorJointHandle handle, float torque) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetMaxTorque(torque));
}

float __cdecl b2MotorJoint_GetMaxTorque(b2MotorJointHandle handle) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMaxTorque());
}

void __cdecl b2MotorJoint_SetCorrectionFactor(b2MotorJointHandle handle, float factor) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetCorrectionFactor(factor));
}

float __cdecl b2MotorJoint_GetCorrectionFactor(b2MotorJointHandle handle) {
  b2MotorJoint* classPtr = static_cast<b2MotorJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetCorrectionFactor());
}

// ------------------ class b2MotorJointWrapper ------------------


// ------------------ class b2MouseJointDef ------------------
b2MouseJointDef __cdecl b2MouseJointDef_b2MouseJointDef_1() {
  return  b2MouseJointDef();
}

// ------------------ class b2MouseJointDef ------------------


// ------------------ class b2MouseJointWrapper ------------------
void __cdecl b2MouseJoint_dtor(b2MouseJointHandle handle) {
  delete handle;
}


b2JointType __cdecl b2MouseJoint_GetType(b2MouseJointHandle handle) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

b2Body* __cdecl b2MouseJoint_GetBodyA(b2MouseJointHandle handle) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyA());
}

b2Body* __cdecl b2MouseJoint_GetBodyB(b2MouseJointHandle handle) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyB());
}

b2Vec2 __cdecl b2MouseJoint_GetAnchorA(b2MouseJointHandle handle) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorA());
}

b2Vec2 __cdecl b2MouseJoint_GetAnchorB(b2MouseJointHandle handle) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorB());
}

b2Vec2 __cdecl b2MouseJoint_GetReactionForce(b2MouseJointHandle handle, float inv_dt) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionForce(inv_dt));
}

float __cdecl b2MouseJoint_GetReactionTorque(b2MouseJointHandle handle, float inv_dt) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionTorque(inv_dt));
}

b2Joint* __cdecl b2MouseJoint_GetNext(b2MouseJointHandle handle) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

void* __cdecl b2MouseJoint_GetUserData(b2MouseJointHandle handle) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUserData());
}

void __cdecl b2MouseJoint_SetUserData(b2MouseJointHandle handle, void* data) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetUserData(data));
}

bool __cdecl b2MouseJoint_IsActive(b2MouseJointHandle handle) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsActive());
}

bool __cdecl b2MouseJoint_GetCollideConnected(b2MouseJointHandle handle) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetCollideConnected());
}

void __cdecl b2MouseJoint_Dump(b2MouseJointHandle handle) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->Dump());
}

void __cdecl b2MouseJoint_ShiftOrigin(b2MouseJointHandle handle, const b2Vec2& newOrigin) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->ShiftOrigin(newOrigin));
}

void __cdecl b2MouseJoint_SetTarget(b2MouseJointHandle handle, const b2Vec2& target) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetTarget(target));
}

const b2Vec2& __cdecl b2MouseJoint_GetTarget(b2MouseJointHandle handle) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetTarget());
}

void __cdecl b2MouseJoint_SetMaxForce(b2MouseJointHandle handle, float force) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetMaxForce(force));
}

float __cdecl b2MouseJoint_GetMaxForce(b2MouseJointHandle handle) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMaxForce());
}

void __cdecl b2MouseJoint_SetFrequency(b2MouseJointHandle handle, float hz) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetFrequency(hz));
}

float __cdecl b2MouseJoint_GetFrequency(b2MouseJointHandle handle) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFrequency());
}

void __cdecl b2MouseJoint_SetDampingRatio(b2MouseJointHandle handle, float ratio) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetDampingRatio(ratio));
}

float __cdecl b2MouseJoint_GetDampingRatio(b2MouseJointHandle handle) {
  b2MouseJoint* classPtr = static_cast<b2MouseJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetDampingRatio());
}

// ------------------ class b2MouseJointWrapper ------------------


// ------------------ class b2PrismaticJointDef ------------------
b2PrismaticJointDef __cdecl b2PrismaticJointDef_b2PrismaticJointDef_1() {
  return  b2PrismaticJointDef();
}

void __cdecl b2PrismaticJointDef_Initialize(b2PrismaticJointDefHandle handle, b2Body* bodyA, b2Body* bodyB, const b2Vec2& anchor, const b2Vec2& axis) {
  b2PrismaticJointDef* classPtr = static_cast<b2PrismaticJointDef*>(handle);
  assert(classPtr != 0);
  return (classPtr->Initialize(bodyA, bodyB, anchor, axis));
}

// ------------------ class b2PrismaticJointDef ------------------


// ------------------ class b2PrismaticJointWrapper ------------------
void __cdecl b2PrismaticJoint_dtor(b2PrismaticJointHandle handle) {
  delete handle;
}


b2JointType __cdecl b2PrismaticJoint_GetType(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

b2Body* __cdecl b2PrismaticJoint_GetBodyA(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyA());
}

b2Body* __cdecl b2PrismaticJoint_GetBodyB(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyB());
}

b2Vec2 __cdecl b2PrismaticJoint_GetAnchorA(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorA());
}

b2Vec2 __cdecl b2PrismaticJoint_GetAnchorB(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorB());
}

b2Vec2 __cdecl b2PrismaticJoint_GetReactionForce(b2PrismaticJointHandle handle, float inv_dt) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionForce(inv_dt));
}

float __cdecl b2PrismaticJoint_GetReactionTorque(b2PrismaticJointHandle handle, float inv_dt) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionTorque(inv_dt));
}

b2Joint* __cdecl b2PrismaticJoint_GetNext(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

void* __cdecl b2PrismaticJoint_GetUserData(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUserData());
}

void __cdecl b2PrismaticJoint_SetUserData(b2PrismaticJointHandle handle, void* data) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetUserData(data));
}

bool __cdecl b2PrismaticJoint_IsActive(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsActive());
}

bool __cdecl b2PrismaticJoint_GetCollideConnected(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetCollideConnected());
}

void __cdecl b2PrismaticJoint_Dump(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->Dump());
}

void __cdecl b2PrismaticJoint_ShiftOrigin(b2PrismaticJointHandle handle, const b2Vec2& newOrigin) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->ShiftOrigin(newOrigin));
}

const b2Vec2& __cdecl b2PrismaticJoint_GetLocalAnchorA(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalAnchorA());
}

const b2Vec2& __cdecl b2PrismaticJoint_GetLocalAnchorB(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalAnchorB());
}

const b2Vec2& __cdecl b2PrismaticJoint_GetLocalAxisA(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalAxisA());
}

float __cdecl b2PrismaticJoint_GetReferenceAngle(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReferenceAngle());
}

float __cdecl b2PrismaticJoint_GetJointTranslation(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetJointTranslation());
}

float __cdecl b2PrismaticJoint_GetJointSpeed(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetJointSpeed());
}

bool __cdecl b2PrismaticJoint_IsLimitEnabled(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsLimitEnabled());
}

void __cdecl b2PrismaticJoint_EnableLimit(b2PrismaticJointHandle handle, bool flag) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->EnableLimit(flag));
}

float __cdecl b2PrismaticJoint_GetLowerLimit(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLowerLimit());
}

float __cdecl b2PrismaticJoint_GetUpperLimit(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUpperLimit());
}

void __cdecl b2PrismaticJoint_SetLimits(b2PrismaticJointHandle handle, float lower, float upper) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetLimits(lower, upper));
}

bool __cdecl b2PrismaticJoint_IsMotorEnabled(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsMotorEnabled());
}

void __cdecl b2PrismaticJoint_EnableMotor(b2PrismaticJointHandle handle, bool flag) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->EnableMotor(flag));
}

void __cdecl b2PrismaticJoint_SetMotorSpeed(b2PrismaticJointHandle handle, float speed) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetMotorSpeed(speed));
}

float __cdecl b2PrismaticJoint_GetMotorSpeed(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMotorSpeed());
}

void __cdecl b2PrismaticJoint_SetMaxMotorForce(b2PrismaticJointHandle handle, float force) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetMaxMotorForce(force));
}

float __cdecl b2PrismaticJoint_GetMaxMotorForce(b2PrismaticJointHandle handle) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMaxMotorForce());
}

float __cdecl b2PrismaticJoint_GetMotorForce(b2PrismaticJointHandle handle, float inv_dt) {
  b2PrismaticJoint* classPtr = static_cast<b2PrismaticJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMotorForce(inv_dt));
}

// ------------------ class b2PrismaticJointWrapper ------------------


// ------------------ class b2PulleyJointDef ------------------
b2PulleyJointDef __cdecl b2PulleyJointDef_b2PulleyJointDef_1() {
  return  b2PulleyJointDef();
}

void __cdecl b2PulleyJointDef_Initialize(b2PulleyJointDefHandle handle, b2Body* bodyA, b2Body* bodyB, const b2Vec2& groundAnchorA, const b2Vec2& groundAnchorB, const b2Vec2& anchorA, const b2Vec2& anchorB, float ratio) {
  b2PulleyJointDef* classPtr = static_cast<b2PulleyJointDef*>(handle);
  assert(classPtr != 0);
  return (classPtr->Initialize(bodyA, bodyB, groundAnchorA, groundAnchorB, anchorA, anchorB, ratio));
}

// ------------------ class b2PulleyJointDef ------------------


// ------------------ class b2PulleyJointWrapper ------------------
void __cdecl b2PulleyJoint_dtor(b2PulleyJointHandle handle) {
  delete handle;
}


b2JointType __cdecl b2PulleyJoint_GetType(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

b2Body* __cdecl b2PulleyJoint_GetBodyA(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyA());
}

b2Body* __cdecl b2PulleyJoint_GetBodyB(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyB());
}

b2Vec2 __cdecl b2PulleyJoint_GetAnchorA(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorA());
}

b2Vec2 __cdecl b2PulleyJoint_GetAnchorB(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorB());
}

b2Vec2 __cdecl b2PulleyJoint_GetReactionForce(b2PulleyJointHandle handle, float inv_dt) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionForce(inv_dt));
}

float __cdecl b2PulleyJoint_GetReactionTorque(b2PulleyJointHandle handle, float inv_dt) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionTorque(inv_dt));
}

b2Joint* __cdecl b2PulleyJoint_GetNext(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

void* __cdecl b2PulleyJoint_GetUserData(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUserData());
}

void __cdecl b2PulleyJoint_SetUserData(b2PulleyJointHandle handle, void* data) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetUserData(data));
}

bool __cdecl b2PulleyJoint_IsActive(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsActive());
}

bool __cdecl b2PulleyJoint_GetCollideConnected(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetCollideConnected());
}

void __cdecl b2PulleyJoint_Dump(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->Dump());
}

void __cdecl b2PulleyJoint_ShiftOrigin(b2PulleyJointHandle handle, const b2Vec2& newOrigin) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->ShiftOrigin(newOrigin));
}

b2Vec2 __cdecl b2PulleyJoint_GetGroundAnchorA(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetGroundAnchorA());
}

b2Vec2 __cdecl b2PulleyJoint_GetGroundAnchorB(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetGroundAnchorB());
}

float __cdecl b2PulleyJoint_GetLengthA(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLengthA());
}

float __cdecl b2PulleyJoint_GetLengthB(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLengthB());
}

float __cdecl b2PulleyJoint_GetRatio(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetRatio());
}

float __cdecl b2PulleyJoint_GetCurrentLengthA(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetCurrentLengthA());
}

float __cdecl b2PulleyJoint_GetCurrentLengthB(b2PulleyJointHandle handle) {
  b2PulleyJoint* classPtr = static_cast<b2PulleyJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetCurrentLengthB());
}

// ------------------ class b2PulleyJointWrapper ------------------


// ------------------ class b2RevoluteJointDef ------------------
b2RevoluteJointDef __cdecl b2RevoluteJointDef_b2RevoluteJointDef_1() {
  return  b2RevoluteJointDef();
}

void __cdecl b2RevoluteJointDef_Initialize(b2RevoluteJointDefHandle handle, b2Body* bodyA, b2Body* bodyB, const b2Vec2& anchor) {
  b2RevoluteJointDef* classPtr = static_cast<b2RevoluteJointDef*>(handle);
  assert(classPtr != 0);
  return (classPtr->Initialize(bodyA, bodyB, anchor));
}

// ------------------ class b2RevoluteJointDef ------------------


// ------------------ class b2RevoluteJointWrapper ------------------
void __cdecl b2RevoluteJoint_dtor(b2RevoluteJointHandle handle) {
  delete handle;
}


b2JointType __cdecl b2RevoluteJoint_GetType(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

b2Body* __cdecl b2RevoluteJoint_GetBodyA(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyA());
}

b2Body* __cdecl b2RevoluteJoint_GetBodyB(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyB());
}

b2Vec2 __cdecl b2RevoluteJoint_GetAnchorA(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorA());
}

b2Vec2 __cdecl b2RevoluteJoint_GetAnchorB(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorB());
}

b2Vec2 __cdecl b2RevoluteJoint_GetReactionForce(b2RevoluteJointHandle handle, float inv_dt) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionForce(inv_dt));
}

float __cdecl b2RevoluteJoint_GetReactionTorque(b2RevoluteJointHandle handle, float inv_dt) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionTorque(inv_dt));
}

b2Joint* __cdecl b2RevoluteJoint_GetNext(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

void* __cdecl b2RevoluteJoint_GetUserData(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUserData());
}

void __cdecl b2RevoluteJoint_SetUserData(b2RevoluteJointHandle handle, void* data) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetUserData(data));
}

bool __cdecl b2RevoluteJoint_IsActive(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsActive());
}

bool __cdecl b2RevoluteJoint_GetCollideConnected(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetCollideConnected());
}

void __cdecl b2RevoluteJoint_Dump(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->Dump());
}

void __cdecl b2RevoluteJoint_ShiftOrigin(b2RevoluteJointHandle handle, const b2Vec2& newOrigin) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->ShiftOrigin(newOrigin));
}

const b2Vec2& __cdecl b2RevoluteJoint_GetLocalAnchorA(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalAnchorA());
}

const b2Vec2& __cdecl b2RevoluteJoint_GetLocalAnchorB(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalAnchorB());
}

float __cdecl b2RevoluteJoint_GetReferenceAngle(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReferenceAngle());
}

float __cdecl b2RevoluteJoint_GetJointAngle(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetJointAngle());
}

float __cdecl b2RevoluteJoint_GetJointSpeed(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetJointSpeed());
}

bool __cdecl b2RevoluteJoint_IsLimitEnabled(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsLimitEnabled());
}

void __cdecl b2RevoluteJoint_EnableLimit(b2RevoluteJointHandle handle, bool flag) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->EnableLimit(flag));
}

float __cdecl b2RevoluteJoint_GetLowerLimit(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLowerLimit());
}

float __cdecl b2RevoluteJoint_GetUpperLimit(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUpperLimit());
}

void __cdecl b2RevoluteJoint_SetLimits(b2RevoluteJointHandle handle, float lower, float upper) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetLimits(lower, upper));
}

bool __cdecl b2RevoluteJoint_IsMotorEnabled(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsMotorEnabled());
}

void __cdecl b2RevoluteJoint_EnableMotor(b2RevoluteJointHandle handle, bool flag) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->EnableMotor(flag));
}

void __cdecl b2RevoluteJoint_SetMotorSpeed(b2RevoluteJointHandle handle, float speed) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetMotorSpeed(speed));
}

float __cdecl b2RevoluteJoint_GetMotorSpeed(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMotorSpeed());
}

void __cdecl b2RevoluteJoint_SetMaxMotorTorque(b2RevoluteJointHandle handle, float torque) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetMaxMotorTorque(torque));
}

float __cdecl b2RevoluteJoint_GetMaxMotorTorque(b2RevoluteJointHandle handle) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMaxMotorTorque());
}

float __cdecl b2RevoluteJoint_GetMotorTorque(b2RevoluteJointHandle handle, float inv_dt) {
  b2RevoluteJoint* classPtr = static_cast<b2RevoluteJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMotorTorque(inv_dt));
}

// ------------------ class b2RevoluteJointWrapper ------------------


// ------------------ class b2RopeJointDef ------------------
b2RopeJointDef __cdecl b2RopeJointDef_b2RopeJointDef_1() {
  return  b2RopeJointDef();
}

// ------------------ class b2RopeJointDef ------------------


// ------------------ class b2RopeJointWrapper ------------------
void __cdecl b2RopeJoint_dtor(b2RopeJointHandle handle) {
  delete handle;
}


b2JointType __cdecl b2RopeJoint_GetType(b2RopeJointHandle handle) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

b2Body* __cdecl b2RopeJoint_GetBodyA(b2RopeJointHandle handle) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyA());
}

b2Body* __cdecl b2RopeJoint_GetBodyB(b2RopeJointHandle handle) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyB());
}

b2Vec2 __cdecl b2RopeJoint_GetAnchorA(b2RopeJointHandle handle) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorA());
}

b2Vec2 __cdecl b2RopeJoint_GetAnchorB(b2RopeJointHandle handle) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorB());
}

b2Vec2 __cdecl b2RopeJoint_GetReactionForce(b2RopeJointHandle handle, float inv_dt) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionForce(inv_dt));
}

float __cdecl b2RopeJoint_GetReactionTorque(b2RopeJointHandle handle, float inv_dt) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionTorque(inv_dt));
}

b2Joint* __cdecl b2RopeJoint_GetNext(b2RopeJointHandle handle) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

void* __cdecl b2RopeJoint_GetUserData(b2RopeJointHandle handle) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUserData());
}

void __cdecl b2RopeJoint_SetUserData(b2RopeJointHandle handle, void* data) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetUserData(data));
}

bool __cdecl b2RopeJoint_IsActive(b2RopeJointHandle handle) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsActive());
}

bool __cdecl b2RopeJoint_GetCollideConnected(b2RopeJointHandle handle) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetCollideConnected());
}

void __cdecl b2RopeJoint_Dump(b2RopeJointHandle handle) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->Dump());
}

void __cdecl b2RopeJoint_ShiftOrigin(b2RopeJointHandle handle, const b2Vec2& newOrigin) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->ShiftOrigin(newOrigin));
}

const b2Vec2& __cdecl b2RopeJoint_GetLocalAnchorA(b2RopeJointHandle handle) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalAnchorA());
}

const b2Vec2& __cdecl b2RopeJoint_GetLocalAnchorB(b2RopeJointHandle handle) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalAnchorB());
}

void __cdecl b2RopeJoint_SetMaxLength(b2RopeJointHandle handle, float length) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetMaxLength(length));
}

float __cdecl b2RopeJoint_GetMaxLength(b2RopeJointHandle handle) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMaxLength());
}

b2LimitState __cdecl b2RopeJoint_GetLimitState(b2RopeJointHandle handle) {
  b2RopeJoint* classPtr = static_cast<b2RopeJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLimitState());
}

// ------------------ class b2RopeJointWrapper ------------------


// ------------------ class b2WeldJointDef ------------------
b2WeldJointDef __cdecl b2WeldJointDef_b2WeldJointDef_1() {
  return  b2WeldJointDef();
}

void __cdecl b2WeldJointDef_Initialize(b2WeldJointDefHandle handle, b2Body* bodyA, b2Body* bodyB, const b2Vec2& anchor) {
  b2WeldJointDef* classPtr = static_cast<b2WeldJointDef*>(handle);
  assert(classPtr != 0);
  return (classPtr->Initialize(bodyA, bodyB, anchor));
}

// ------------------ class b2WeldJointDef ------------------


// ------------------ class b2WeldJointWrapper ------------------
void __cdecl b2WeldJoint_dtor(b2WeldJointHandle handle) {
  delete handle;
}


b2JointType __cdecl b2WeldJoint_GetType(b2WeldJointHandle handle) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

b2Body* __cdecl b2WeldJoint_GetBodyA(b2WeldJointHandle handle) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyA());
}

b2Body* __cdecl b2WeldJoint_GetBodyB(b2WeldJointHandle handle) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyB());
}

b2Vec2 __cdecl b2WeldJoint_GetAnchorA(b2WeldJointHandle handle) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorA());
}

b2Vec2 __cdecl b2WeldJoint_GetAnchorB(b2WeldJointHandle handle) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorB());
}

b2Vec2 __cdecl b2WeldJoint_GetReactionForce(b2WeldJointHandle handle, float inv_dt) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionForce(inv_dt));
}

float __cdecl b2WeldJoint_GetReactionTorque(b2WeldJointHandle handle, float inv_dt) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionTorque(inv_dt));
}

b2Joint* __cdecl b2WeldJoint_GetNext(b2WeldJointHandle handle) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

void* __cdecl b2WeldJoint_GetUserData(b2WeldJointHandle handle) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUserData());
}

void __cdecl b2WeldJoint_SetUserData(b2WeldJointHandle handle, void* data) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetUserData(data));
}

bool __cdecl b2WeldJoint_IsActive(b2WeldJointHandle handle) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsActive());
}

bool __cdecl b2WeldJoint_GetCollideConnected(b2WeldJointHandle handle) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetCollideConnected());
}

void __cdecl b2WeldJoint_Dump(b2WeldJointHandle handle) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->Dump());
}

void __cdecl b2WeldJoint_ShiftOrigin(b2WeldJointHandle handle, const b2Vec2& newOrigin) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->ShiftOrigin(newOrigin));
}

const b2Vec2& __cdecl b2WeldJoint_GetLocalAnchorA(b2WeldJointHandle handle) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalAnchorA());
}

const b2Vec2& __cdecl b2WeldJoint_GetLocalAnchorB(b2WeldJointHandle handle) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalAnchorB());
}

float __cdecl b2WeldJoint_GetReferenceAngle(b2WeldJointHandle handle) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReferenceAngle());
}

void __cdecl b2WeldJoint_SetFrequency(b2WeldJointHandle handle, float hz) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetFrequency(hz));
}

float __cdecl b2WeldJoint_GetFrequency(b2WeldJointHandle handle) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetFrequency());
}

void __cdecl b2WeldJoint_SetDampingRatio(b2WeldJointHandle handle, float ratio) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetDampingRatio(ratio));
}

float __cdecl b2WeldJoint_GetDampingRatio(b2WeldJointHandle handle) {
  b2WeldJoint* classPtr = static_cast<b2WeldJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetDampingRatio());
}

// ------------------ class b2WeldJointWrapper ------------------


// ------------------ class b2WheelJointDef ------------------
b2WheelJointDef __cdecl b2WheelJointDef_b2WheelJointDef_1() {
  return  b2WheelJointDef();
}

void __cdecl b2WheelJointDef_Initialize(b2WheelJointDefHandle handle, b2Body* bodyA, b2Body* bodyB, const b2Vec2& anchor, const b2Vec2& axis) {
  b2WheelJointDef* classPtr = static_cast<b2WheelJointDef*>(handle);
  assert(classPtr != 0);
  return (classPtr->Initialize(bodyA, bodyB, anchor, axis));
}

// ------------------ class b2WheelJointDef ------------------


// ------------------ class b2WheelJointWrapper ------------------
void __cdecl b2WheelJoint_dtor(b2WheelJointHandle handle) {
  delete handle;
}


b2JointType __cdecl b2WheelJoint_GetType(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetType());
}

b2Body* __cdecl b2WheelJoint_GetBodyA(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyA());
}

b2Body* __cdecl b2WheelJoint_GetBodyB(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetBodyB());
}

b2Vec2 __cdecl b2WheelJoint_GetAnchorA(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorA());
}

b2Vec2 __cdecl b2WheelJoint_GetAnchorB(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetAnchorB());
}

b2Vec2 __cdecl b2WheelJoint_GetReactionForce(b2WheelJointHandle handle, float inv_dt) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionForce(inv_dt));
}

float __cdecl b2WheelJoint_GetReactionTorque(b2WheelJointHandle handle, float inv_dt) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetReactionTorque(inv_dt));
}

b2Joint* __cdecl b2WheelJoint_GetNext(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetNext());
}

void* __cdecl b2WheelJoint_GetUserData(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetUserData());
}

void __cdecl b2WheelJoint_SetUserData(b2WheelJointHandle handle, void* data) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetUserData(data));
}

bool __cdecl b2WheelJoint_IsActive(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsActive());
}

bool __cdecl b2WheelJoint_GetCollideConnected(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetCollideConnected());
}

void __cdecl b2WheelJoint_Dump(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->Dump());
}

void __cdecl b2WheelJoint_ShiftOrigin(b2WheelJointHandle handle, const b2Vec2& newOrigin) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->ShiftOrigin(newOrigin));
}

const b2Vec2& __cdecl b2WheelJoint_GetLocalAnchorA(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalAnchorA());
}

const b2Vec2& __cdecl b2WheelJoint_GetLocalAnchorB(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalAnchorB());
}

const b2Vec2& __cdecl b2WheelJoint_GetLocalAxisA(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetLocalAxisA());
}

float __cdecl b2WheelJoint_GetJointTranslation(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetJointTranslation());
}

float __cdecl b2WheelJoint_GetJointSpeed(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetJointSpeed());
}

bool __cdecl b2WheelJoint_IsMotorEnabled(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->IsMotorEnabled());
}

void __cdecl b2WheelJoint_EnableMotor(b2WheelJointHandle handle, bool flag) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->EnableMotor(flag));
}

void __cdecl b2WheelJoint_SetMotorSpeed(b2WheelJointHandle handle, float speed) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetMotorSpeed(speed));
}

float __cdecl b2WheelJoint_GetMotorSpeed(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMotorSpeed());
}

void __cdecl b2WheelJoint_SetMaxMotorTorque(b2WheelJointHandle handle, float torque) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetMaxMotorTorque(torque));
}

float __cdecl b2WheelJoint_GetMaxMotorTorque(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMaxMotorTorque());
}

float __cdecl b2WheelJoint_GetMotorTorque(b2WheelJointHandle handle, float inv_dt) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetMotorTorque(inv_dt));
}

void __cdecl b2WheelJoint_SetSpringFrequencyHz(b2WheelJointHandle handle, float hz) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetSpringFrequencyHz(hz));
}

float __cdecl b2WheelJoint_GetSpringFrequencyHz(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetSpringFrequencyHz());
}

void __cdecl b2WheelJoint_SetSpringDampingRatio(b2WheelJointHandle handle, float ratio) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->SetSpringDampingRatio(ratio));
}

float __cdecl b2WheelJoint_GetSpringDampingRatio(b2WheelJointHandle handle) {
  b2WheelJoint* classPtr = static_cast<b2WheelJoint*>(handle);
  assert(classPtr != 0);
  return (classPtr->GetSpringDampingRatio());
}

// ------------------ class b2WheelJointWrapper ------------------

float __cdecl Dynamics_b2MixFriction(float friction1, float friction2) {
  return (b2MixFriction(friction1, friction2));
}

float __cdecl Dynamics_b2MixRestitution(float restitution1, float restitution2) {
  return (b2MixRestitution(restitution1, restitution2));
}

