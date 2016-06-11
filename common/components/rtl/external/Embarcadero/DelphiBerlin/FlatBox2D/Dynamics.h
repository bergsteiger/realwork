#ifndef DynamicsH
#define DynamicsH

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

#include "Box2D\Collision\Shapes\b2Shape.h"
#include "Box2D\Collision\b2BroadPhase.h"
#include "Box2D\Collision\b2Collision.h"
#include "Box2D\Common\b2BlockAllocator.h"
#include "Box2D\Common\b2Math.h"
#include "Box2D\Common\b2StackAllocator.h"
#include "Box2D\Dynamics\Contacts\b2ChainAndCircleContact.h"
#include "Box2D\Dynamics\Contacts\b2ChainAndPolygonContact.h"
#include "Box2D\Dynamics\Contacts\b2CircleContact.h"
#include "Box2D\Dynamics\Contacts\b2Contact.h"
#include "Box2D\Dynamics\Contacts\b2ContactSolver.h"
#include "Box2D\Dynamics\Contacts\b2EdgeAndCircleContact.h"
#include "Box2D\Dynamics\Contacts\b2EdgeAndPolygonContact.h"
#include "Box2D\Dynamics\Contacts\b2PolygonAndCircleContact.h"
#include "Box2D\Dynamics\Contacts\b2PolygonContact.h"
#include "Box2D\Dynamics\Joints\b2DistanceJoint.h"
#include "Box2D\Dynamics\Joints\b2FrictionJoint.h"
#include "Box2D\Dynamics\Joints\b2GearJoint.h"
#include "Box2D\Dynamics\Joints\b2Joint.h"
#include "Box2D\Dynamics\Joints\b2MotorJoint.h"
#include "Box2D\Dynamics\Joints\b2MouseJoint.h"
#include "Box2D\Dynamics\Joints\b2PrismaticJoint.h"
#include "Box2D\Dynamics\Joints\b2PulleyJoint.h"
#include "Box2D\Dynamics\Joints\b2RevoluteJoint.h"
#include "Box2D\Dynamics\Joints\b2RopeJoint.h"
#include "Box2D\Dynamics\Joints\b2WeldJoint.h"
#include "Box2D\Dynamics\Joints\b2WheelJoint.h"
#include "Box2D\Dynamics\b2Body.h"
#include "Box2D\Dynamics\b2ContactManager.h"
#include "Box2D\Dynamics\b2Fixture.h"
#include "Box2D\Dynamics\b2Island.h"
#include "Box2D\Dynamics\b2TimeStep.h"
#include "Box2D\Dynamics\b2World.h"
#include "Box2D\Dynamics\b2WorldCallbacks.h"


typedef b2Body* b2BodyHandle;
typedef b2BodyDef* b2BodyDefHandle;
typedef b2ChainAndCircleContact* b2ChainAndCircleContactHandle;
typedef b2ChainAndPolygonContact* b2ChainAndPolygonContactHandle;
typedef b2CircleContact* b2CircleContactHandle;
typedef b2Contact* b2ContactHandle;
typedef b2ContactEdge* b2ContactEdgeHandle;
typedef b2ContactFilter* b2ContactFilterHandle;
typedef b2ContactImpulse* b2ContactImpulseHandle;
typedef b2ContactListener* b2ContactListenerHandle;
typedef b2ContactManager* b2ContactManagerHandle;
typedef b2ContactRegister* b2ContactRegisterHandle;
typedef b2ContactSolver* b2ContactSolverHandle;
typedef b2ContactSolverDef* b2ContactSolverDefHandle;
typedef b2ContactVelocityConstraint* b2ContactVelocityConstraintHandle;
typedef b2DestructionListener* b2DestructionListenerHandle;
typedef b2DistanceJoint* b2DistanceJointHandle;
typedef b2DistanceJointDef* b2DistanceJointDefHandle;
typedef b2EdgeAndCircleContact* b2EdgeAndCircleContactHandle;
typedef b2EdgeAndPolygonContact* b2EdgeAndPolygonContactHandle;
typedef b2Filter* b2FilterHandle;
typedef b2Fixture* b2FixtureHandle;
typedef b2FixtureDef* b2FixtureDefHandle;
typedef b2FixtureProxy* b2FixtureProxyHandle;
typedef b2FrictionJoint* b2FrictionJointHandle;
typedef b2FrictionJointDef* b2FrictionJointDefHandle;
typedef b2GearJoint* b2GearJointHandle;
typedef b2GearJointDef* b2GearJointDefHandle;
typedef b2Island* b2IslandHandle;
typedef b2Jacobian* b2JacobianHandle;
typedef b2Joint* b2JointHandle;
typedef b2JointDef* b2JointDefHandle;
typedef b2JointEdge* b2JointEdgeHandle;
typedef b2MotorJoint* b2MotorJointHandle;
typedef b2MotorJointDef* b2MotorJointDefHandle;
typedef b2MouseJoint* b2MouseJointHandle;
typedef b2MouseJointDef* b2MouseJointDefHandle;
typedef b2PolygonAndCircleContact* b2PolygonAndCircleContactHandle;
typedef b2PolygonContact* b2PolygonContactHandle;
typedef b2Position* b2PositionHandle;
typedef b2PrismaticJoint* b2PrismaticJointHandle;
typedef b2PrismaticJointDef* b2PrismaticJointDefHandle;
typedef b2Profile* b2ProfileHandle;
typedef b2PulleyJoint* b2PulleyJointHandle;
typedef b2PulleyJointDef* b2PulleyJointDefHandle;
typedef b2QueryCallback* b2QueryCallbackHandle;
typedef b2RayCastCallback* b2RayCastCallbackHandle;
typedef b2RevoluteJoint* b2RevoluteJointHandle;
typedef b2RevoluteJointDef* b2RevoluteJointDefHandle;
typedef b2RopeJoint* b2RopeJointHandle;
typedef b2RopeJointDef* b2RopeJointDefHandle;
typedef b2SolverData* b2SolverDataHandle;
typedef b2TimeStep* b2TimeStepHandle;
typedef b2Velocity* b2VelocityHandle;
typedef b2VelocityConstraintPoint* b2VelocityConstraintPointHandle;
typedef b2WeldJoint* b2WeldJointHandle;
typedef b2WeldJointDef* b2WeldJointDefHandle;
typedef b2WheelJoint* b2WheelJointHandle;
typedef b2WheelJointDef* b2WheelJointDefHandle;
typedef b2World* b2WorldHandle;

// ------------------ Ib2DestructionListener interface for class b2DestructionListener ------------------
struct __declspec(uuid("{2DDB25E4-9B99-E391-EF9A-62D1BDC2ABAC}")) Ib2DestructionListener : public IUnknown {
virtual void SayGoodbye(b2Joint* joint) = 0;
virtual void SayGoodbye(b2Fixture* fixture) = 0;
};


// ------------------ Ib2ContactFilter interface for class b2ContactFilter ------------------
struct __declspec(uuid("{9BE3CC10-3001-AA1F-3A69-3AF908806081}")) Ib2ContactFilter : public IUnknown {
virtual bool ShouldCollide(b2Fixture* fixtureA, b2Fixture* fixtureB) = 0;
};


// ------------------ Ib2ContactListener interface for class b2ContactListener ------------------
struct __declspec(uuid("{457D45B8-C600-3A28-CE8D-7ED8741412D8}")) Ib2ContactListener : public IUnknown {
virtual void BeginContact(b2Contact* contact) = 0;
virtual void EndContact(b2Contact* contact) = 0;
virtual void PreSolve(b2Contact* contact, const b2Manifold* oldManifold) = 0;
virtual void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse) = 0;
};


// ------------------ Ib2QueryCallback interface for class b2QueryCallback ------------------
struct __declspec(uuid("{FA12D838-B458-10AB-2E02-61056056D805}")) Ib2QueryCallback : public IUnknown {
virtual bool ReportFixture(b2Fixture* fixture) = 0;
};


// ------------------ Ib2RayCastCallback interface for class b2RayCastCallback ------------------
struct __declspec(uuid("{8E1114AB-969E-8C96-98C4-41096DDCBFA5}")) Ib2RayCastCallback : public IUnknown {
virtual float ReportFixture(b2Fixture* fixture, const b2Vec2& point, const b2Vec2& normal, float fraction) = 0;
};


#if defined(__cplusplus)
extern "C" {
#endif

__declspec(dllexport) b2DestructionListenerHandle __cdecl Create_b2DestructionListener_delegate(Ib2DestructionListener* intf);__declspec(dllexport) void __cdecl Destroy_b2DestructionListener_delegate(b2DestructionListenerHandle handle);

__declspec(dllexport) b2ContactFilterHandle __cdecl Create_b2ContactFilter_delegate(Ib2ContactFilter* intf);__declspec(dllexport) void __cdecl Destroy_b2ContactFilter_delegate(b2ContactFilterHandle handle);

__declspec(dllexport) b2ContactListenerHandle __cdecl Create_b2ContactListener_delegate(Ib2ContactListener* intf);__declspec(dllexport) void __cdecl Destroy_b2ContactListener_delegate(b2ContactListenerHandle handle);

__declspec(dllexport) b2QueryCallbackHandle __cdecl Create_b2QueryCallback_delegate(Ib2QueryCallback* intf);__declspec(dllexport) void __cdecl Destroy_b2QueryCallback_delegate(b2QueryCallbackHandle handle);

__declspec(dllexport) b2RayCastCallbackHandle __cdecl Create_b2RayCastCallback_delegate(Ib2RayCastCallback* intf);__declspec(dllexport) void __cdecl Destroy_b2RayCastCallback_delegate(b2RayCastCallbackHandle handle);


// ------------------ class b2BodyDef ------------------
__declspec(dllexport) b2BodyDef __cdecl b2BodyDef_b2BodyDef_1();
// ------------------ class b2BodyDef ------------------


// ------------------ class b2BodyWrapper ------------------

__declspec(dllexport) b2Fixture* __cdecl b2Body_CreateFixture(b2BodyHandle handle, const b2FixtureDef* def);
__declspec(dllexport) b2Fixture* __cdecl b2Body_CreateFixture2(b2BodyHandle handle, const b2Shape* shape, float density);
__declspec(dllexport) void __cdecl b2Body_DestroyFixture(b2BodyHandle handle, b2Fixture* fixture);
__declspec(dllexport) void __cdecl b2Body_SetTransform(b2BodyHandle handle, const b2Vec2& position, float angle);
__declspec(dllexport) const b2Transform& __cdecl b2Body_GetTransform(b2BodyHandle handle);
__declspec(dllexport) const b2Vec2& __cdecl b2Body_GetPosition(b2BodyHandle handle);
__declspec(dllexport) float __cdecl b2Body_GetAngle(b2BodyHandle handle);
__declspec(dllexport) const b2Vec2& __cdecl b2Body_GetWorldCenter(b2BodyHandle handle);
__declspec(dllexport) const b2Vec2& __cdecl b2Body_GetLocalCenter(b2BodyHandle handle);
__declspec(dllexport) void __cdecl b2Body_SetLinearVelocity(b2BodyHandle handle, const b2Vec2& v);
__declspec(dllexport) const b2Vec2& __cdecl b2Body_GetLinearVelocity(b2BodyHandle handle);
__declspec(dllexport) void __cdecl b2Body_SetAngularVelocity(b2BodyHandle handle, float omega);
__declspec(dllexport) float __cdecl b2Body_GetAngularVelocity(b2BodyHandle handle);
__declspec(dllexport) void __cdecl b2Body_ApplyForce(b2BodyHandle handle, const b2Vec2& force, const b2Vec2& point, bool wake);
__declspec(dllexport) void __cdecl b2Body_ApplyForceToCenter(b2BodyHandle handle, const b2Vec2& force, bool wake);
__declspec(dllexport) void __cdecl b2Body_ApplyTorque(b2BodyHandle handle, float torque, bool wake);
__declspec(dllexport) void __cdecl b2Body_ApplyLinearImpulse(b2BodyHandle handle, const b2Vec2& impulse, const b2Vec2& point, bool wake);
__declspec(dllexport) void __cdecl b2Body_ApplyAngularImpulse(b2BodyHandle handle, float impulse, bool wake);
__declspec(dllexport) float __cdecl b2Body_GetMass(b2BodyHandle handle);
__declspec(dllexport) float __cdecl b2Body_GetInertia(b2BodyHandle handle);
__declspec(dllexport) void __cdecl b2Body_GetMassData(b2BodyHandle handle, b2MassData* data);
__declspec(dllexport) void __cdecl b2Body_SetMassData(b2BodyHandle handle, const b2MassData* data);
__declspec(dllexport) void __cdecl b2Body_ResetMassData(b2BodyHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2Body_GetWorldPoint(b2BodyHandle handle, const b2Vec2& localPoint);
__declspec(dllexport) b2Vec2 __cdecl b2Body_GetWorldVector(b2BodyHandle handle, const b2Vec2& localVector);
__declspec(dllexport) b2Vec2 __cdecl b2Body_GetLocalPoint(b2BodyHandle handle, const b2Vec2& worldPoint);
__declspec(dllexport) b2Vec2 __cdecl b2Body_GetLocalVector(b2BodyHandle handle, const b2Vec2& worldVector);
__declspec(dllexport) b2Vec2 __cdecl b2Body_GetLinearVelocityFromWorldPoint(b2BodyHandle handle, const b2Vec2& worldPoint);
__declspec(dllexport) b2Vec2 __cdecl b2Body_GetLinearVelocityFromLocalPoint(b2BodyHandle handle, const b2Vec2& localPoint);
__declspec(dllexport) float __cdecl b2Body_GetLinearDamping(b2BodyHandle handle);
__declspec(dllexport) void __cdecl b2Body_SetLinearDamping(b2BodyHandle handle, float linearDamping);
__declspec(dllexport) float __cdecl b2Body_GetAngularDamping(b2BodyHandle handle);
__declspec(dllexport) void __cdecl b2Body_SetAngularDamping(b2BodyHandle handle, float angularDamping);
__declspec(dllexport) float __cdecl b2Body_GetGravityScale(b2BodyHandle handle);
__declspec(dllexport) void __cdecl b2Body_SetGravityScale(b2BodyHandle handle, float scale);
__declspec(dllexport) void __cdecl b2Body_SetType(b2BodyHandle handle, b2BodyType type);
__declspec(dllexport) b2BodyType __cdecl b2Body_GetType(b2BodyHandle handle);
__declspec(dllexport) void __cdecl b2Body_SetBullet(b2BodyHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2Body_IsBullet(b2BodyHandle handle);
__declspec(dllexport) void __cdecl b2Body_SetSleepingAllowed(b2BodyHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2Body_IsSleepingAllowed(b2BodyHandle handle);
__declspec(dllexport) void __cdecl b2Body_SetAwake(b2BodyHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2Body_IsAwake(b2BodyHandle handle);
__declspec(dllexport) void __cdecl b2Body_SetActive(b2BodyHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2Body_IsActive(b2BodyHandle handle);
__declspec(dllexport) void __cdecl b2Body_SetFixedRotation(b2BodyHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2Body_IsFixedRotation(b2BodyHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2Body_GetFixtureList(b2BodyHandle handle);
__declspec(dllexport) b2JointEdge* __cdecl b2Body_GetJointList(b2BodyHandle handle);
__declspec(dllexport) b2ContactEdge* __cdecl b2Body_GetContactList(b2BodyHandle handle);
__declspec(dllexport) b2Body* __cdecl b2Body_GetNext(b2BodyHandle handle);
__declspec(dllexport) void* __cdecl b2Body_GetUserData(b2BodyHandle handle);
__declspec(dllexport) void __cdecl b2Body_SetUserData(b2BodyHandle handle, void* data);
__declspec(dllexport) b2World* __cdecl b2Body_GetWorld(b2BodyHandle handle);
__declspec(dllexport) void __cdecl b2Body_Dump(b2BodyHandle handle);
// ------------------ class b2BodyWrapper ------------------


// ------------------ class b2ContactManagerWrapper ------------------
__declspec(dllexport) b2ContactManagerHandle __cdecl b2ContactManager_b2ContactManager_1();
__declspec(dllexport) void __cdecl b2ContactManager_dtor(b2ContactManagerHandle handle);

__declspec(dllexport) void __cdecl b2ContactManager_AddPair(b2ContactManagerHandle handle, void* proxyUserDataA, void* proxyUserDataB);
__declspec(dllexport) void __cdecl b2ContactManager_FindNewContacts(b2ContactManagerHandle handle);
__declspec(dllexport) void __cdecl b2ContactManager_Destroy(b2ContactManagerHandle handle, b2Contact* c);
__declspec(dllexport) void __cdecl b2ContactManager_Collide(b2ContactManagerHandle handle);

__declspec(dllexport) b2BroadPhase* __cdecl b2ContactManager_Get_m_broadPhase(b2ContactManagerHandle handle);
__declspec(dllexport) void __cdecl b2ContactManager_Set_m_broadPhase(b2ContactManagerHandle handle, b2BroadPhase* newValue);

__declspec(dllexport) b2Contact* __cdecl b2ContactManager_Get_m_contactList(b2ContactManagerHandle handle);
__declspec(dllexport) void __cdecl b2ContactManager_Set_m_contactList(b2ContactManagerHandle handle, b2Contact* newValue);

__declspec(dllexport) int __cdecl b2ContactManager_Get_m_contactCount(b2ContactManagerHandle handle);
__declspec(dllexport) void __cdecl b2ContactManager_Set_m_contactCount(b2ContactManagerHandle handle, int newValue);

__declspec(dllexport) b2ContactFilter* __cdecl b2ContactManager_Get_m_contactFilter(b2ContactManagerHandle handle);
__declspec(dllexport) void __cdecl b2ContactManager_Set_m_contactFilter(b2ContactManagerHandle handle, b2ContactFilter* newValue);

__declspec(dllexport) b2ContactListener* __cdecl b2ContactManager_Get_m_contactListener(b2ContactManagerHandle handle);
__declspec(dllexport) void __cdecl b2ContactManager_Set_m_contactListener(b2ContactManagerHandle handle, b2ContactListener* newValue);

__declspec(dllexport) b2BlockAllocator* __cdecl b2ContactManager_Get_m_allocator(b2ContactManagerHandle handle);
__declspec(dllexport) void __cdecl b2ContactManager_Set_m_allocator(b2ContactManagerHandle handle, b2BlockAllocator* newValue);
// ------------------ class b2ContactManagerWrapper ------------------


// ------------------ class b2Filter ------------------
__declspec(dllexport) b2Filter __cdecl b2Filter_b2Filter_1();
// ------------------ class b2Filter ------------------


// ------------------ class b2FixtureDef ------------------
__declspec(dllexport) b2FixtureDef __cdecl b2FixtureDef_b2FixtureDef_1();
// ------------------ class b2FixtureDef ------------------


// ------------------ class b2FixtureProxy ------------------
__declspec(dllexport) b2FixtureProxy __cdecl b2FixtureProxy_b2FixtureProxy();
// ------------------ class b2FixtureProxy ------------------


// ------------------ class b2Fixture ------------------
__declspec(dllexport) b2Shape::Type __cdecl b2Fixture_GetType(b2FixtureHandle handle);
__declspec(dllexport) b2Shape* __cdecl b2Fixture_GetShape(b2FixtureHandle handle);
__declspec(dllexport) void __cdecl b2Fixture_SetSensor(b2FixtureHandle handle, bool sensor);
__declspec(dllexport) bool __cdecl b2Fixture_IsSensor(b2FixtureHandle handle);
__declspec(dllexport) void __cdecl b2Fixture_SetFilterData(b2FixtureHandle handle, const b2Filter& filter);
__declspec(dllexport) const b2Filter& __cdecl b2Fixture_GetFilterData(b2FixtureHandle handle);
__declspec(dllexport) void __cdecl b2Fixture_Refilter(b2FixtureHandle handle);
__declspec(dllexport) b2Body* __cdecl b2Fixture_GetBody(b2FixtureHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2Fixture_GetNext(b2FixtureHandle handle);
__declspec(dllexport) void* __cdecl b2Fixture_GetUserData(b2FixtureHandle handle);
__declspec(dllexport) void __cdecl b2Fixture_SetUserData(b2FixtureHandle handle, void* data);
__declspec(dllexport) bool __cdecl b2Fixture_TestPoint(b2FixtureHandle handle, const b2Vec2& p);
__declspec(dllexport) bool __cdecl b2Fixture_RayCast(b2FixtureHandle handle, b2RayCastOutput* output, const b2RayCastInput& input, int childIndex);
__declspec(dllexport) void __cdecl b2Fixture_GetMassData(b2FixtureHandle handle, b2MassData* massData);
__declspec(dllexport) void __cdecl b2Fixture_SetDensity(b2FixtureHandle handle, float density);
__declspec(dllexport) float __cdecl b2Fixture_GetDensity(b2FixtureHandle handle);
__declspec(dllexport) float __cdecl b2Fixture_GetFriction(b2FixtureHandle handle);
__declspec(dllexport) void __cdecl b2Fixture_SetFriction(b2FixtureHandle handle, float friction);
__declspec(dllexport) float __cdecl b2Fixture_GetRestitution(b2FixtureHandle handle);
__declspec(dllexport) void __cdecl b2Fixture_SetRestitution(b2FixtureHandle handle, float restitution);
__declspec(dllexport) const b2AABB& __cdecl b2Fixture_GetAABB(b2FixtureHandle handle, int childIndex);
__declspec(dllexport) void __cdecl b2Fixture_Dump(b2FixtureHandle handle, int bodyIndex);
// ------------------ class b2Fixture ------------------


// ------------------ class b2Profile ------------------
__declspec(dllexport) b2Profile __cdecl b2Profile_b2Profile();
// ------------------ class b2Profile ------------------


// ------------------ class b2TimeStep ------------------
__declspec(dllexport) b2TimeStep __cdecl b2TimeStep_b2TimeStep();
// ------------------ class b2TimeStep ------------------


// ------------------ class b2Position ------------------
__declspec(dllexport) b2Position __cdecl b2Position_b2Position();
// ------------------ class b2Position ------------------


// ------------------ class b2Velocity ------------------
__declspec(dllexport) b2Velocity __cdecl b2Velocity_b2Velocity();
// ------------------ class b2Velocity ------------------


// ------------------ class b2SolverData ------------------
__declspec(dllexport) b2SolverData __cdecl b2SolverData_b2SolverData();
// ------------------ class b2SolverData ------------------


// ------------------ class b2IslandWrapper ------------------
__declspec(dllexport) b2IslandHandle __cdecl b2Island_b2Island_1(int bodyCapacity, int contactCapacity, int jointCapacity, b2StackAllocator* allocator, b2ContactListener* listener);
__declspec(dllexport) void __cdecl b2Island_dtor(b2IslandHandle handle);

__declspec(dllexport) void __cdecl b2Island_Clear(b2IslandHandle handle);
__declspec(dllexport) void __cdecl b2Island_Solve(b2IslandHandle handle, b2Profile* profile, const b2TimeStep& step, const b2Vec2& gravity, bool allowSleep);
__declspec(dllexport) void __cdecl b2Island_SolveTOI(b2IslandHandle handle, const b2TimeStep& subStep, int toiIndexA, int toiIndexB);
__declspec(dllexport) void __cdecl b2Island_Add(b2IslandHandle handle, b2Body* body);
__declspec(dllexport) void __cdecl b2Island_Add2(b2IslandHandle handle, b2Contact* contact);
__declspec(dllexport) void __cdecl b2Island_Add3(b2IslandHandle handle, b2Joint* joint);
__declspec(dllexport) void __cdecl b2Island_Report(b2IslandHandle handle, const b2ContactVelocityConstraint* constraints);

__declspec(dllexport) b2StackAllocator* __cdecl b2Island_Get_m_allocator(b2IslandHandle handle);
__declspec(dllexport) void __cdecl b2Island_Set_m_allocator(b2IslandHandle handle, b2StackAllocator* newValue);

__declspec(dllexport) b2ContactListener* __cdecl b2Island_Get_m_listener(b2IslandHandle handle);
__declspec(dllexport) void __cdecl b2Island_Set_m_listener(b2IslandHandle handle, b2ContactListener* newValue);

__declspec(dllexport) b2Body** __cdecl b2Island_Get_m_bodies(b2IslandHandle handle);
__declspec(dllexport) void __cdecl b2Island_Set_m_bodies(b2IslandHandle handle, b2Body** newValue);

__declspec(dllexport) b2Contact** __cdecl b2Island_Get_m_contacts(b2IslandHandle handle);
__declspec(dllexport) void __cdecl b2Island_Set_m_contacts(b2IslandHandle handle, b2Contact** newValue);

__declspec(dllexport) b2Joint** __cdecl b2Island_Get_m_joints(b2IslandHandle handle);
__declspec(dllexport) void __cdecl b2Island_Set_m_joints(b2IslandHandle handle, b2Joint** newValue);

__declspec(dllexport) b2Position* __cdecl b2Island_Get_m_positions(b2IslandHandle handle);
__declspec(dllexport) void __cdecl b2Island_Set_m_positions(b2IslandHandle handle, b2Position* newValue);

__declspec(dllexport) b2Velocity* __cdecl b2Island_Get_m_velocities(b2IslandHandle handle);
__declspec(dllexport) void __cdecl b2Island_Set_m_velocities(b2IslandHandle handle, b2Velocity* newValue);

__declspec(dllexport) int __cdecl b2Island_Get_m_bodyCount(b2IslandHandle handle);
__declspec(dllexport) void __cdecl b2Island_Set_m_bodyCount(b2IslandHandle handle, int newValue);

__declspec(dllexport) int __cdecl b2Island_Get_m_jointCount(b2IslandHandle handle);
__declspec(dllexport) void __cdecl b2Island_Set_m_jointCount(b2IslandHandle handle, int newValue);

__declspec(dllexport) int __cdecl b2Island_Get_m_contactCount(b2IslandHandle handle);
__declspec(dllexport) void __cdecl b2Island_Set_m_contactCount(b2IslandHandle handle, int newValue);

__declspec(dllexport) int __cdecl b2Island_Get_m_bodyCapacity(b2IslandHandle handle);
__declspec(dllexport) void __cdecl b2Island_Set_m_bodyCapacity(b2IslandHandle handle, int newValue);

__declspec(dllexport) int __cdecl b2Island_Get_m_contactCapacity(b2IslandHandle handle);
__declspec(dllexport) void __cdecl b2Island_Set_m_contactCapacity(b2IslandHandle handle, int newValue);

__declspec(dllexport) int __cdecl b2Island_Get_m_jointCapacity(b2IslandHandle handle);
__declspec(dllexport) void __cdecl b2Island_Set_m_jointCapacity(b2IslandHandle handle, int newValue);
// ------------------ class b2IslandWrapper ------------------


// ------------------ class b2DestructionListenerWrapper ------------------

__declspec(dllexport) void __cdecl b2DestructionListener_SayGoodbye(b2DestructionListenerHandle handle, b2Joint* joint);
__declspec(dllexport) void __cdecl b2DestructionListener_SayGoodbye2(b2DestructionListenerHandle handle, b2Fixture* fixture);
// ------------------ class b2DestructionListenerWrapper ------------------


// ------------------ class b2ContactFilterWrapper ------------------
__declspec(dllexport) b2ContactFilterHandle __cdecl b2ContactFilter_b2ContactFilter();
__declspec(dllexport) void __cdecl b2ContactFilter_dtor(b2ContactFilterHandle handle);

__declspec(dllexport) bool __cdecl b2ContactFilter_ShouldCollide(b2ContactFilterHandle handle, b2Fixture* fixtureA, b2Fixture* fixtureB);
// ------------------ class b2ContactFilterWrapper ------------------


// ------------------ class b2ContactImpulse ------------------
__declspec(dllexport) b2ContactImpulse __cdecl b2ContactImpulse_b2ContactImpulse();
// ------------------ class b2ContactImpulse ------------------


// ------------------ class b2ContactListenerWrapper ------------------
__declspec(dllexport) b2ContactListenerHandle __cdecl b2ContactListener_b2ContactListener();
__declspec(dllexport) void __cdecl b2ContactListener_dtor(b2ContactListenerHandle handle);

__declspec(dllexport) void __cdecl b2ContactListener_BeginContact(b2ContactListenerHandle handle, b2Contact* contact);
__declspec(dllexport) void __cdecl b2ContactListener_EndContact(b2ContactListenerHandle handle, b2Contact* contact);
__declspec(dllexport) void __cdecl b2ContactListener_PreSolve(b2ContactListenerHandle handle, b2Contact* contact, const b2Manifold* oldManifold);
__declspec(dllexport) void __cdecl b2ContactListener_PostSolve(b2ContactListenerHandle handle, b2Contact* contact, const b2ContactImpulse* impulse);
// ------------------ class b2ContactListenerWrapper ------------------


// ------------------ class b2QueryCallbackWrapper ------------------

__declspec(dllexport) bool __cdecl b2QueryCallback_ReportFixture(b2QueryCallbackHandle handle, b2Fixture* fixture);
// ------------------ class b2QueryCallbackWrapper ------------------


// ------------------ class b2RayCastCallbackWrapper ------------------

__declspec(dllexport) float __cdecl b2RayCastCallback_ReportFixture(b2RayCastCallbackHandle handle, b2Fixture* fixture, const b2Vec2& point, const b2Vec2& normal, float fraction);
// ------------------ class b2RayCastCallbackWrapper ------------------


// ------------------ class b2WorldWrapper ------------------
__declspec(dllexport) b2WorldHandle __cdecl b2World_b2World_1(const b2Vec2& gravity);
__declspec(dllexport) void __cdecl b2World_dtor(b2WorldHandle handle);

__declspec(dllexport) void __cdecl b2World_SetDestructionListener(b2WorldHandle handle, b2DestructionListener* listener);
__declspec(dllexport) void __cdecl b2World_SetContactFilter(b2WorldHandle handle, b2ContactFilter* filter);
__declspec(dllexport) void __cdecl b2World_SetContactListener(b2WorldHandle handle, b2ContactListener* listener);
__declspec(dllexport) void __cdecl b2World_SetDebugDraw(b2WorldHandle handle, b2Draw* debugDraw);
__declspec(dllexport) b2Body* __cdecl b2World_CreateBody(b2WorldHandle handle, const b2BodyDef* def);
__declspec(dllexport) void __cdecl b2World_DestroyBody(b2WorldHandle handle, b2Body* body);
__declspec(dllexport) b2Joint* __cdecl b2World_CreateJoint(b2WorldHandle handle, const b2JointDef* def);
__declspec(dllexport) void __cdecl b2World_DestroyJoint(b2WorldHandle handle, b2Joint* joint);
__declspec(dllexport) void __cdecl b2World_Step(b2WorldHandle handle, float timeStep, int velocityIterations, int positionIterations);
__declspec(dllexport) void __cdecl b2World_ClearForces(b2WorldHandle handle);
__declspec(dllexport) void __cdecl b2World_DrawDebugData(b2WorldHandle handle);
__declspec(dllexport) void __cdecl b2World_QueryAABB(b2WorldHandle handle, b2QueryCallback* callback, const b2AABB& aabb);
__declspec(dllexport) void __cdecl b2World_RayCast(b2WorldHandle handle, b2RayCastCallback* callback, const b2Vec2& point1, const b2Vec2& point2);
__declspec(dllexport) b2Body* __cdecl b2World_GetBodyList(b2WorldHandle handle);
__declspec(dllexport) b2Joint* __cdecl b2World_GetJointList(b2WorldHandle handle);
__declspec(dllexport) b2Contact* __cdecl b2World_GetContactList(b2WorldHandle handle);
__declspec(dllexport) void __cdecl b2World_SetAllowSleeping(b2WorldHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2World_GetAllowSleeping(b2WorldHandle handle);
__declspec(dllexport) void __cdecl b2World_SetWarmStarting(b2WorldHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2World_GetWarmStarting(b2WorldHandle handle);
__declspec(dllexport) void __cdecl b2World_SetContinuousPhysics(b2WorldHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2World_GetContinuousPhysics(b2WorldHandle handle);
__declspec(dllexport) void __cdecl b2World_SetSubStepping(b2WorldHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2World_GetSubStepping(b2WorldHandle handle);
__declspec(dllexport) int __cdecl b2World_GetProxyCount(b2WorldHandle handle);
__declspec(dllexport) int __cdecl b2World_GetBodyCount(b2WorldHandle handle);
__declspec(dllexport) int __cdecl b2World_GetJointCount(b2WorldHandle handle);
__declspec(dllexport) int __cdecl b2World_GetContactCount(b2WorldHandle handle);
__declspec(dllexport) int __cdecl b2World_GetTreeHeight(b2WorldHandle handle);
__declspec(dllexport) int __cdecl b2World_GetTreeBalance(b2WorldHandle handle);
__declspec(dllexport) float __cdecl b2World_GetTreeQuality(b2WorldHandle handle);
__declspec(dllexport) void __cdecl b2World_SetGravity(b2WorldHandle handle, const b2Vec2& gravity);
__declspec(dllexport) b2Vec2 __cdecl b2World_GetGravity(b2WorldHandle handle);
__declspec(dllexport) bool __cdecl b2World_IsLocked(b2WorldHandle handle);
__declspec(dllexport) void __cdecl b2World_SetAutoClearForces(b2WorldHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2World_GetAutoClearForces(b2WorldHandle handle);
__declspec(dllexport) void __cdecl b2World_ShiftOrigin(b2WorldHandle handle, const b2Vec2& newOrigin);
__declspec(dllexport) const b2ContactManager* __cdecl b2World_GetContactManager(b2WorldHandle handle);
__declspec(dllexport) const b2Profile& __cdecl b2World_GetProfile(b2WorldHandle handle);
__declspec(dllexport) void __cdecl b2World_Dump(b2WorldHandle handle);
// ------------------ class b2WorldWrapper ------------------


// ------------------ class b2ContactRegister ------------------
__declspec(dllexport) b2ContactRegister __cdecl b2ContactRegister_b2ContactRegister();
// ------------------ class b2ContactRegister ------------------


// ------------------ class b2ContactEdge ------------------
__declspec(dllexport) b2ContactEdge __cdecl b2ContactEdge_b2ContactEdge_1();
// ------------------ class b2ContactEdge ------------------


// ------------------ class b2ContactWrapper ------------------

__declspec(dllexport) b2Manifold* __cdecl b2Contact_GetManifold(b2ContactHandle handle);
__declspec(dllexport) void __cdecl b2Contact_GetWorldManifold(b2ContactHandle handle, b2WorldManifold* worldManifold);
__declspec(dllexport) bool __cdecl b2Contact_IsTouching(b2ContactHandle handle);
__declspec(dllexport) void __cdecl b2Contact_SetEnabled(b2ContactHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2Contact_IsEnabled(b2ContactHandle handle);
__declspec(dllexport) b2Contact* __cdecl b2Contact_GetNext(b2ContactHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2Contact_GetFixtureA(b2ContactHandle handle);
__declspec(dllexport) int __cdecl b2Contact_GetChildIndexA(b2ContactHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2Contact_GetFixtureB(b2ContactHandle handle);
__declspec(dllexport) int __cdecl b2Contact_GetChildIndexB(b2ContactHandle handle);
__declspec(dllexport) void __cdecl b2Contact_SetFriction(b2ContactHandle handle, float friction);
__declspec(dllexport) float __cdecl b2Contact_GetFriction(b2ContactHandle handle);
__declspec(dllexport) void __cdecl b2Contact_ResetFriction(b2ContactHandle handle);
__declspec(dllexport) void __cdecl b2Contact_SetRestitution(b2ContactHandle handle, float restitution);
__declspec(dllexport) float __cdecl b2Contact_GetRestitution(b2ContactHandle handle);
__declspec(dllexport) void __cdecl b2Contact_ResetRestitution(b2ContactHandle handle);
__declspec(dllexport) void __cdecl b2Contact_SetTangentSpeed(b2ContactHandle handle, float speed);
__declspec(dllexport) float __cdecl b2Contact_GetTangentSpeed(b2ContactHandle handle);
__declspec(dllexport) void __cdecl b2Contact_Evaluate(b2ContactHandle handle, b2Manifold* manifold, const b2Transform& xfA, const b2Transform& xfB);
// ------------------ class b2ContactWrapper ------------------


// ------------------ class b2ChainAndCircleContactWrapper ------------------
__declspec(dllexport) b2ChainAndCircleContactHandle __cdecl b2ChainAndCircleContact_b2ChainAndCircleContact_1(b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB);
__declspec(dllexport) void __cdecl b2ChainAndCircleContact_dtor(b2ChainAndCircleContactHandle handle);

__declspec(dllexport) b2Manifold* __cdecl b2ChainAndCircleContact_GetManifold(b2ChainAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2ChainAndCircleContact_GetWorldManifold(b2ChainAndCircleContactHandle handle, b2WorldManifold* worldManifold);
__declspec(dllexport) bool __cdecl b2ChainAndCircleContact_IsTouching(b2ChainAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2ChainAndCircleContact_SetEnabled(b2ChainAndCircleContactHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2ChainAndCircleContact_IsEnabled(b2ChainAndCircleContactHandle handle);
__declspec(dllexport) b2Contact* __cdecl b2ChainAndCircleContact_GetNext(b2ChainAndCircleContactHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2ChainAndCircleContact_GetFixtureA(b2ChainAndCircleContactHandle handle);
__declspec(dllexport) int __cdecl b2ChainAndCircleContact_GetChildIndexA(b2ChainAndCircleContactHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2ChainAndCircleContact_GetFixtureB(b2ChainAndCircleContactHandle handle);
__declspec(dllexport) int __cdecl b2ChainAndCircleContact_GetChildIndexB(b2ChainAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2ChainAndCircleContact_SetFriction(b2ChainAndCircleContactHandle handle, float friction);
__declspec(dllexport) float __cdecl b2ChainAndCircleContact_GetFriction(b2ChainAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2ChainAndCircleContact_ResetFriction(b2ChainAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2ChainAndCircleContact_SetRestitution(b2ChainAndCircleContactHandle handle, float restitution);
__declspec(dllexport) float __cdecl b2ChainAndCircleContact_GetRestitution(b2ChainAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2ChainAndCircleContact_ResetRestitution(b2ChainAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2ChainAndCircleContact_SetTangentSpeed(b2ChainAndCircleContactHandle handle, float speed);
__declspec(dllexport) float __cdecl b2ChainAndCircleContact_GetTangentSpeed(b2ChainAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2ChainAndCircleContact_Evaluate(b2ChainAndCircleContactHandle handle, b2Manifold* manifold, const b2Transform& xfA, const b2Transform& xfB);
__declspec(dllexport) b2Contact* __cdecl b2ChainAndCircleContact_Create(b2ChainAndCircleContactHandle handle, b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB, b2BlockAllocator* allocator);
__declspec(dllexport) void __cdecl b2ChainAndCircleContact_Destroy(b2ChainAndCircleContactHandle handle, b2Contact* contact, b2BlockAllocator* allocator);
// ------------------ class b2ChainAndCircleContactWrapper ------------------


// ------------------ class b2ChainAndPolygonContactWrapper ------------------
__declspec(dllexport) b2ChainAndPolygonContactHandle __cdecl b2ChainAndPolygonContact_b2ChainAndPolygonContact_1(b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB);
__declspec(dllexport) void __cdecl b2ChainAndPolygonContact_dtor(b2ChainAndPolygonContactHandle handle);

__declspec(dllexport) b2Manifold* __cdecl b2ChainAndPolygonContact_GetManifold(b2ChainAndPolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2ChainAndPolygonContact_GetWorldManifold(b2ChainAndPolygonContactHandle handle, b2WorldManifold* worldManifold);
__declspec(dllexport) bool __cdecl b2ChainAndPolygonContact_IsTouching(b2ChainAndPolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2ChainAndPolygonContact_SetEnabled(b2ChainAndPolygonContactHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2ChainAndPolygonContact_IsEnabled(b2ChainAndPolygonContactHandle handle);
__declspec(dllexport) b2Contact* __cdecl b2ChainAndPolygonContact_GetNext(b2ChainAndPolygonContactHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2ChainAndPolygonContact_GetFixtureA(b2ChainAndPolygonContactHandle handle);
__declspec(dllexport) int __cdecl b2ChainAndPolygonContact_GetChildIndexA(b2ChainAndPolygonContactHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2ChainAndPolygonContact_GetFixtureB(b2ChainAndPolygonContactHandle handle);
__declspec(dllexport) int __cdecl b2ChainAndPolygonContact_GetChildIndexB(b2ChainAndPolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2ChainAndPolygonContact_SetFriction(b2ChainAndPolygonContactHandle handle, float friction);
__declspec(dllexport) float __cdecl b2ChainAndPolygonContact_GetFriction(b2ChainAndPolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2ChainAndPolygonContact_ResetFriction(b2ChainAndPolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2ChainAndPolygonContact_SetRestitution(b2ChainAndPolygonContactHandle handle, float restitution);
__declspec(dllexport) float __cdecl b2ChainAndPolygonContact_GetRestitution(b2ChainAndPolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2ChainAndPolygonContact_ResetRestitution(b2ChainAndPolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2ChainAndPolygonContact_SetTangentSpeed(b2ChainAndPolygonContactHandle handle, float speed);
__declspec(dllexport) float __cdecl b2ChainAndPolygonContact_GetTangentSpeed(b2ChainAndPolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2ChainAndPolygonContact_Evaluate(b2ChainAndPolygonContactHandle handle, b2Manifold* manifold, const b2Transform& xfA, const b2Transform& xfB);
__declspec(dllexport) b2Contact* __cdecl b2ChainAndPolygonContact_Create(b2ChainAndPolygonContactHandle handle, b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB, b2BlockAllocator* allocator);
__declspec(dllexport) void __cdecl b2ChainAndPolygonContact_Destroy(b2ChainAndPolygonContactHandle handle, b2Contact* contact, b2BlockAllocator* allocator);
// ------------------ class b2ChainAndPolygonContactWrapper ------------------


// ------------------ class b2CircleContactWrapper ------------------
__declspec(dllexport) b2CircleContactHandle __cdecl b2CircleContact_b2CircleContact_1(b2Fixture* fixtureA, b2Fixture* fixtureB);
__declspec(dllexport) void __cdecl b2CircleContact_dtor(b2CircleContactHandle handle);

__declspec(dllexport) b2Manifold* __cdecl b2CircleContact_GetManifold(b2CircleContactHandle handle);
__declspec(dllexport) void __cdecl b2CircleContact_GetWorldManifold(b2CircleContactHandle handle, b2WorldManifold* worldManifold);
__declspec(dllexport) bool __cdecl b2CircleContact_IsTouching(b2CircleContactHandle handle);
__declspec(dllexport) void __cdecl b2CircleContact_SetEnabled(b2CircleContactHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2CircleContact_IsEnabled(b2CircleContactHandle handle);
__declspec(dllexport) b2Contact* __cdecl b2CircleContact_GetNext(b2CircleContactHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2CircleContact_GetFixtureA(b2CircleContactHandle handle);
__declspec(dllexport) int __cdecl b2CircleContact_GetChildIndexA(b2CircleContactHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2CircleContact_GetFixtureB(b2CircleContactHandle handle);
__declspec(dllexport) int __cdecl b2CircleContact_GetChildIndexB(b2CircleContactHandle handle);
__declspec(dllexport) void __cdecl b2CircleContact_SetFriction(b2CircleContactHandle handle, float friction);
__declspec(dllexport) float __cdecl b2CircleContact_GetFriction(b2CircleContactHandle handle);
__declspec(dllexport) void __cdecl b2CircleContact_ResetFriction(b2CircleContactHandle handle);
__declspec(dllexport) void __cdecl b2CircleContact_SetRestitution(b2CircleContactHandle handle, float restitution);
__declspec(dllexport) float __cdecl b2CircleContact_GetRestitution(b2CircleContactHandle handle);
__declspec(dllexport) void __cdecl b2CircleContact_ResetRestitution(b2CircleContactHandle handle);
__declspec(dllexport) void __cdecl b2CircleContact_SetTangentSpeed(b2CircleContactHandle handle, float speed);
__declspec(dllexport) float __cdecl b2CircleContact_GetTangentSpeed(b2CircleContactHandle handle);
__declspec(dllexport) void __cdecl b2CircleContact_Evaluate(b2CircleContactHandle handle, b2Manifold* manifold, const b2Transform& xfA, const b2Transform& xfB);
__declspec(dllexport) b2Contact* __cdecl b2CircleContact_Create(b2CircleContactHandle handle, b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB, b2BlockAllocator* allocator);
__declspec(dllexport) void __cdecl b2CircleContact_Destroy(b2CircleContactHandle handle, b2Contact* contact, b2BlockAllocator* allocator);
// ------------------ class b2CircleContactWrapper ------------------


// ------------------ class b2VelocityConstraintPoint ------------------
__declspec(dllexport) b2VelocityConstraintPoint __cdecl b2VelocityConstraintPoint_b2VelocityConstraintPoint();
// ------------------ class b2VelocityConstraintPoint ------------------


// ------------------ class b2ContactVelocityConstraint ------------------
__declspec(dllexport) b2ContactVelocityConstraint __cdecl b2ContactVelocityConstraint_b2ContactVelocityConstraint();
// ------------------ class b2ContactVelocityConstraint ------------------


// ------------------ class b2ContactSolverDef ------------------
__declspec(dllexport) b2ContactSolverDef __cdecl b2ContactSolverDef_b2ContactSolverDef();
// ------------------ class b2ContactSolverDef ------------------


// ------------------ class b2ContactSolverWrapper ------------------
__declspec(dllexport) b2ContactSolverHandle __cdecl b2ContactSolver_b2ContactSolver_1(b2ContactSolverDef* def);
__declspec(dllexport) void __cdecl b2ContactSolver_dtor(b2ContactSolverHandle handle);

__declspec(dllexport) void __cdecl b2ContactSolver_InitializeVelocityConstraints(b2ContactSolverHandle handle);
__declspec(dllexport) void __cdecl b2ContactSolver_WarmStart(b2ContactSolverHandle handle);
__declspec(dllexport) void __cdecl b2ContactSolver_SolveVelocityConstraints(b2ContactSolverHandle handle);
__declspec(dllexport) void __cdecl b2ContactSolver_StoreImpulses(b2ContactSolverHandle handle);
__declspec(dllexport) bool __cdecl b2ContactSolver_SolvePositionConstraints(b2ContactSolverHandle handle);
__declspec(dllexport) bool __cdecl b2ContactSolver_SolveTOIPositionConstraints(b2ContactSolverHandle handle, int toiIndexA, int toiIndexB);

__declspec(dllexport) b2TimeStep __cdecl b2ContactSolver_Get_m_step(b2ContactSolverHandle handle);
__declspec(dllexport) void __cdecl b2ContactSolver_Set_m_step(b2ContactSolverHandle handle, b2TimeStep newValue);
__declspec(dllexport) b2TimeStep* __cdecl b2ContactSolver_Get_m_step_P(b2ContactSolverHandle handle);

__declspec(dllexport) b2Position* __cdecl b2ContactSolver_Get_m_positions(b2ContactSolverHandle handle);
__declspec(dllexport) void __cdecl b2ContactSolver_Set_m_positions(b2ContactSolverHandle handle, b2Position* newValue);

__declspec(dllexport) b2Velocity* __cdecl b2ContactSolver_Get_m_velocities(b2ContactSolverHandle handle);
__declspec(dllexport) void __cdecl b2ContactSolver_Set_m_velocities(b2ContactSolverHandle handle, b2Velocity* newValue);

__declspec(dllexport) b2StackAllocator* __cdecl b2ContactSolver_Get_m_allocator(b2ContactSolverHandle handle);
__declspec(dllexport) void __cdecl b2ContactSolver_Set_m_allocator(b2ContactSolverHandle handle, b2StackAllocator* newValue);

__declspec(dllexport) b2ContactVelocityConstraint* __cdecl b2ContactSolver_Get_m_velocityConstraints(b2ContactSolverHandle handle);
__declspec(dllexport) void __cdecl b2ContactSolver_Set_m_velocityConstraints(b2ContactSolverHandle handle, b2ContactVelocityConstraint* newValue);

__declspec(dllexport) b2Contact** __cdecl b2ContactSolver_Get_m_contacts(b2ContactSolverHandle handle);
__declspec(dllexport) void __cdecl b2ContactSolver_Set_m_contacts(b2ContactSolverHandle handle, b2Contact** newValue);

__declspec(dllexport) int __cdecl b2ContactSolver_Get_m_count(b2ContactSolverHandle handle);
__declspec(dllexport) void __cdecl b2ContactSolver_Set_m_count(b2ContactSolverHandle handle, int newValue);
// ------------------ class b2ContactSolverWrapper ------------------


// ------------------ class b2EdgeAndCircleContactWrapper ------------------
__declspec(dllexport) b2EdgeAndCircleContactHandle __cdecl b2EdgeAndCircleContact_b2EdgeAndCircleContact_1(b2Fixture* fixtureA, b2Fixture* fixtureB);
__declspec(dllexport) void __cdecl b2EdgeAndCircleContact_dtor(b2EdgeAndCircleContactHandle handle);

__declspec(dllexport) b2Manifold* __cdecl b2EdgeAndCircleContact_GetManifold(b2EdgeAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2EdgeAndCircleContact_GetWorldManifold(b2EdgeAndCircleContactHandle handle, b2WorldManifold* worldManifold);
__declspec(dllexport) bool __cdecl b2EdgeAndCircleContact_IsTouching(b2EdgeAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2EdgeAndCircleContact_SetEnabled(b2EdgeAndCircleContactHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2EdgeAndCircleContact_IsEnabled(b2EdgeAndCircleContactHandle handle);
__declspec(dllexport) b2Contact* __cdecl b2EdgeAndCircleContact_GetNext(b2EdgeAndCircleContactHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2EdgeAndCircleContact_GetFixtureA(b2EdgeAndCircleContactHandle handle);
__declspec(dllexport) int __cdecl b2EdgeAndCircleContact_GetChildIndexA(b2EdgeAndCircleContactHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2EdgeAndCircleContact_GetFixtureB(b2EdgeAndCircleContactHandle handle);
__declspec(dllexport) int __cdecl b2EdgeAndCircleContact_GetChildIndexB(b2EdgeAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2EdgeAndCircleContact_SetFriction(b2EdgeAndCircleContactHandle handle, float friction);
__declspec(dllexport) float __cdecl b2EdgeAndCircleContact_GetFriction(b2EdgeAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2EdgeAndCircleContact_ResetFriction(b2EdgeAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2EdgeAndCircleContact_SetRestitution(b2EdgeAndCircleContactHandle handle, float restitution);
__declspec(dllexport) float __cdecl b2EdgeAndCircleContact_GetRestitution(b2EdgeAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2EdgeAndCircleContact_ResetRestitution(b2EdgeAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2EdgeAndCircleContact_SetTangentSpeed(b2EdgeAndCircleContactHandle handle, float speed);
__declspec(dllexport) float __cdecl b2EdgeAndCircleContact_GetTangentSpeed(b2EdgeAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2EdgeAndCircleContact_Evaluate(b2EdgeAndCircleContactHandle handle, b2Manifold* manifold, const b2Transform& xfA, const b2Transform& xfB);
__declspec(dllexport) b2Contact* __cdecl b2EdgeAndCircleContact_Create(b2EdgeAndCircleContactHandle handle, b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB, b2BlockAllocator* allocator);
__declspec(dllexport) void __cdecl b2EdgeAndCircleContact_Destroy(b2EdgeAndCircleContactHandle handle, b2Contact* contact, b2BlockAllocator* allocator);
// ------------------ class b2EdgeAndCircleContactWrapper ------------------


// ------------------ class b2EdgeAndPolygonContactWrapper ------------------
__declspec(dllexport) b2EdgeAndPolygonContactHandle __cdecl b2EdgeAndPolygonContact_b2EdgeAndPolygonContact_1(b2Fixture* fixtureA, b2Fixture* fixtureB);
__declspec(dllexport) void __cdecl b2EdgeAndPolygonContact_dtor(b2EdgeAndPolygonContactHandle handle);

__declspec(dllexport) b2Manifold* __cdecl b2EdgeAndPolygonContact_GetManifold(b2EdgeAndPolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2EdgeAndPolygonContact_GetWorldManifold(b2EdgeAndPolygonContactHandle handle, b2WorldManifold* worldManifold);
__declspec(dllexport) bool __cdecl b2EdgeAndPolygonContact_IsTouching(b2EdgeAndPolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2EdgeAndPolygonContact_SetEnabled(b2EdgeAndPolygonContactHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2EdgeAndPolygonContact_IsEnabled(b2EdgeAndPolygonContactHandle handle);
__declspec(dllexport) b2Contact* __cdecl b2EdgeAndPolygonContact_GetNext(b2EdgeAndPolygonContactHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2EdgeAndPolygonContact_GetFixtureA(b2EdgeAndPolygonContactHandle handle);
__declspec(dllexport) int __cdecl b2EdgeAndPolygonContact_GetChildIndexA(b2EdgeAndPolygonContactHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2EdgeAndPolygonContact_GetFixtureB(b2EdgeAndPolygonContactHandle handle);
__declspec(dllexport) int __cdecl b2EdgeAndPolygonContact_GetChildIndexB(b2EdgeAndPolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2EdgeAndPolygonContact_SetFriction(b2EdgeAndPolygonContactHandle handle, float friction);
__declspec(dllexport) float __cdecl b2EdgeAndPolygonContact_GetFriction(b2EdgeAndPolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2EdgeAndPolygonContact_ResetFriction(b2EdgeAndPolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2EdgeAndPolygonContact_SetRestitution(b2EdgeAndPolygonContactHandle handle, float restitution);
__declspec(dllexport) float __cdecl b2EdgeAndPolygonContact_GetRestitution(b2EdgeAndPolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2EdgeAndPolygonContact_ResetRestitution(b2EdgeAndPolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2EdgeAndPolygonContact_SetTangentSpeed(b2EdgeAndPolygonContactHandle handle, float speed);
__declspec(dllexport) float __cdecl b2EdgeAndPolygonContact_GetTangentSpeed(b2EdgeAndPolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2EdgeAndPolygonContact_Evaluate(b2EdgeAndPolygonContactHandle handle, b2Manifold* manifold, const b2Transform& xfA, const b2Transform& xfB);
__declspec(dllexport) b2Contact* __cdecl b2EdgeAndPolygonContact_Create(b2EdgeAndPolygonContactHandle handle, b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB, b2BlockAllocator* allocator);
__declspec(dllexport) void __cdecl b2EdgeAndPolygonContact_Destroy(b2EdgeAndPolygonContactHandle handle, b2Contact* contact, b2BlockAllocator* allocator);
// ------------------ class b2EdgeAndPolygonContactWrapper ------------------


// ------------------ class b2PolygonAndCircleContactWrapper ------------------
__declspec(dllexport) b2PolygonAndCircleContactHandle __cdecl b2PolygonAndCircleContact_b2PolygonAndCircleContact_1(b2Fixture* fixtureA, b2Fixture* fixtureB);
__declspec(dllexport) void __cdecl b2PolygonAndCircleContact_dtor(b2PolygonAndCircleContactHandle handle);

__declspec(dllexport) b2Manifold* __cdecl b2PolygonAndCircleContact_GetManifold(b2PolygonAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2PolygonAndCircleContact_GetWorldManifold(b2PolygonAndCircleContactHandle handle, b2WorldManifold* worldManifold);
__declspec(dllexport) bool __cdecl b2PolygonAndCircleContact_IsTouching(b2PolygonAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2PolygonAndCircleContact_SetEnabled(b2PolygonAndCircleContactHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2PolygonAndCircleContact_IsEnabled(b2PolygonAndCircleContactHandle handle);
__declspec(dllexport) b2Contact* __cdecl b2PolygonAndCircleContact_GetNext(b2PolygonAndCircleContactHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2PolygonAndCircleContact_GetFixtureA(b2PolygonAndCircleContactHandle handle);
__declspec(dllexport) int __cdecl b2PolygonAndCircleContact_GetChildIndexA(b2PolygonAndCircleContactHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2PolygonAndCircleContact_GetFixtureB(b2PolygonAndCircleContactHandle handle);
__declspec(dllexport) int __cdecl b2PolygonAndCircleContact_GetChildIndexB(b2PolygonAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2PolygonAndCircleContact_SetFriction(b2PolygonAndCircleContactHandle handle, float friction);
__declspec(dllexport) float __cdecl b2PolygonAndCircleContact_GetFriction(b2PolygonAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2PolygonAndCircleContact_ResetFriction(b2PolygonAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2PolygonAndCircleContact_SetRestitution(b2PolygonAndCircleContactHandle handle, float restitution);
__declspec(dllexport) float __cdecl b2PolygonAndCircleContact_GetRestitution(b2PolygonAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2PolygonAndCircleContact_ResetRestitution(b2PolygonAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2PolygonAndCircleContact_SetTangentSpeed(b2PolygonAndCircleContactHandle handle, float speed);
__declspec(dllexport) float __cdecl b2PolygonAndCircleContact_GetTangentSpeed(b2PolygonAndCircleContactHandle handle);
__declspec(dllexport) void __cdecl b2PolygonAndCircleContact_Evaluate(b2PolygonAndCircleContactHandle handle, b2Manifold* manifold, const b2Transform& xfA, const b2Transform& xfB);
__declspec(dllexport) b2Contact* __cdecl b2PolygonAndCircleContact_Create(b2PolygonAndCircleContactHandle handle, b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB, b2BlockAllocator* allocator);
__declspec(dllexport) void __cdecl b2PolygonAndCircleContact_Destroy(b2PolygonAndCircleContactHandle handle, b2Contact* contact, b2BlockAllocator* allocator);
// ------------------ class b2PolygonAndCircleContactWrapper ------------------


// ------------------ class b2PolygonContactWrapper ------------------
__declspec(dllexport) b2PolygonContactHandle __cdecl b2PolygonContact_b2PolygonContact_1(b2Fixture* fixtureA, b2Fixture* fixtureB);
__declspec(dllexport) void __cdecl b2PolygonContact_dtor(b2PolygonContactHandle handle);

__declspec(dllexport) b2Manifold* __cdecl b2PolygonContact_GetManifold(b2PolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2PolygonContact_GetWorldManifold(b2PolygonContactHandle handle, b2WorldManifold* worldManifold);
__declspec(dllexport) bool __cdecl b2PolygonContact_IsTouching(b2PolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2PolygonContact_SetEnabled(b2PolygonContactHandle handle, bool flag);
__declspec(dllexport) bool __cdecl b2PolygonContact_IsEnabled(b2PolygonContactHandle handle);
__declspec(dllexport) b2Contact* __cdecl b2PolygonContact_GetNext(b2PolygonContactHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2PolygonContact_GetFixtureA(b2PolygonContactHandle handle);
__declspec(dllexport) int __cdecl b2PolygonContact_GetChildIndexA(b2PolygonContactHandle handle);
__declspec(dllexport) b2Fixture* __cdecl b2PolygonContact_GetFixtureB(b2PolygonContactHandle handle);
__declspec(dllexport) int __cdecl b2PolygonContact_GetChildIndexB(b2PolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2PolygonContact_SetFriction(b2PolygonContactHandle handle, float friction);
__declspec(dllexport) float __cdecl b2PolygonContact_GetFriction(b2PolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2PolygonContact_ResetFriction(b2PolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2PolygonContact_SetRestitution(b2PolygonContactHandle handle, float restitution);
__declspec(dllexport) float __cdecl b2PolygonContact_GetRestitution(b2PolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2PolygonContact_ResetRestitution(b2PolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2PolygonContact_SetTangentSpeed(b2PolygonContactHandle handle, float speed);
__declspec(dllexport) float __cdecl b2PolygonContact_GetTangentSpeed(b2PolygonContactHandle handle);
__declspec(dllexport) void __cdecl b2PolygonContact_Evaluate(b2PolygonContactHandle handle, b2Manifold* manifold, const b2Transform& xfA, const b2Transform& xfB);
__declspec(dllexport) b2Contact* __cdecl b2PolygonContact_Create(b2PolygonContactHandle handle, b2Fixture* fixtureA, int indexA, b2Fixture* fixtureB, int indexB, b2BlockAllocator* allocator);
__declspec(dllexport) void __cdecl b2PolygonContact_Destroy(b2PolygonContactHandle handle, b2Contact* contact, b2BlockAllocator* allocator);
// ------------------ class b2PolygonContactWrapper ------------------


// ------------------ class b2Jacobian ------------------
__declspec(dllexport) b2Jacobian __cdecl b2Jacobian_b2Jacobian();
// ------------------ class b2Jacobian ------------------


// ------------------ class b2JointEdge ------------------
__declspec(dllexport) b2JointEdge __cdecl b2JointEdge_b2JointEdge();
// ------------------ class b2JointEdge ------------------


// ------------------ class b2JointDef ------------------
__declspec(dllexport) b2JointDef __cdecl b2JointDef_b2JointDef_1();
// ------------------ class b2JointDef ------------------


// ------------------ class b2JointWrapper ------------------

__declspec(dllexport) b2JointType __cdecl b2Joint_GetType(b2JointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2Joint_GetBodyA(b2JointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2Joint_GetBodyB(b2JointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2Joint_GetAnchorA(b2JointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2Joint_GetAnchorB(b2JointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2Joint_GetReactionForce(b2JointHandle handle, float inv_dt);
__declspec(dllexport) float __cdecl b2Joint_GetReactionTorque(b2JointHandle handle, float inv_dt);
__declspec(dllexport) b2Joint* __cdecl b2Joint_GetNext(b2JointHandle handle);
__declspec(dllexport) void* __cdecl b2Joint_GetUserData(b2JointHandle handle);
__declspec(dllexport) void __cdecl b2Joint_SetUserData(b2JointHandle handle, void* data);
__declspec(dllexport) bool __cdecl b2Joint_IsActive(b2JointHandle handle);
__declspec(dllexport) bool __cdecl b2Joint_GetCollideConnected(b2JointHandle handle);
__declspec(dllexport) void __cdecl b2Joint_Dump(b2JointHandle handle);
__declspec(dllexport) void __cdecl b2Joint_ShiftOrigin(b2JointHandle handle, const b2Vec2& newOrigin);
// ------------------ class b2JointWrapper ------------------


// ------------------ class b2DistanceJointDef ------------------
__declspec(dllexport) b2DistanceJointDef __cdecl b2DistanceJointDef_b2DistanceJointDef_1();
__declspec(dllexport) void __cdecl b2DistanceJointDef_Initialize(b2DistanceJointDefHandle handle, b2Body* bodyA, b2Body* bodyB, const b2Vec2& anchorA, const b2Vec2& anchorB);
// ------------------ class b2DistanceJointDef ------------------


// ------------------ class b2DistanceJointWrapper ------------------
__declspec(dllexport) void __cdecl b2DistanceJoint_dtor(b2DistanceJointHandle handle);

__declspec(dllexport) b2JointType __cdecl b2DistanceJoint_GetType(b2DistanceJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2DistanceJoint_GetBodyA(b2DistanceJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2DistanceJoint_GetBodyB(b2DistanceJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2DistanceJoint_GetAnchorA(b2DistanceJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2DistanceJoint_GetAnchorB(b2DistanceJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2DistanceJoint_GetReactionForce(b2DistanceJointHandle handle, float inv_dt);
__declspec(dllexport) float __cdecl b2DistanceJoint_GetReactionTorque(b2DistanceJointHandle handle, float inv_dt);
__declspec(dllexport) b2Joint* __cdecl b2DistanceJoint_GetNext(b2DistanceJointHandle handle);
__declspec(dllexport) void* __cdecl b2DistanceJoint_GetUserData(b2DistanceJointHandle handle);
__declspec(dllexport) void __cdecl b2DistanceJoint_SetUserData(b2DistanceJointHandle handle, void* data);
__declspec(dllexport) bool __cdecl b2DistanceJoint_IsActive(b2DistanceJointHandle handle);
__declspec(dllexport) bool __cdecl b2DistanceJoint_GetCollideConnected(b2DistanceJointHandle handle);
__declspec(dllexport) void __cdecl b2DistanceJoint_Dump(b2DistanceJointHandle handle);
__declspec(dllexport) void __cdecl b2DistanceJoint_ShiftOrigin(b2DistanceJointHandle handle, const b2Vec2& newOrigin);
__declspec(dllexport) const b2Vec2& __cdecl b2DistanceJoint_GetLocalAnchorA(b2DistanceJointHandle handle);
__declspec(dllexport) const b2Vec2& __cdecl b2DistanceJoint_GetLocalAnchorB(b2DistanceJointHandle handle);
__declspec(dllexport) void __cdecl b2DistanceJoint_SetLength(b2DistanceJointHandle handle, float length);
__declspec(dllexport) float __cdecl b2DistanceJoint_GetLength(b2DistanceJointHandle handle);
__declspec(dllexport) void __cdecl b2DistanceJoint_SetFrequency(b2DistanceJointHandle handle, float hz);
__declspec(dllexport) float __cdecl b2DistanceJoint_GetFrequency(b2DistanceJointHandle handle);
__declspec(dllexport) void __cdecl b2DistanceJoint_SetDampingRatio(b2DistanceJointHandle handle, float ratio);
__declspec(dllexport) float __cdecl b2DistanceJoint_GetDampingRatio(b2DistanceJointHandle handle);
// ------------------ class b2DistanceJointWrapper ------------------


// ------------------ class b2FrictionJointDef ------------------
__declspec(dllexport) b2FrictionJointDef __cdecl b2FrictionJointDef_b2FrictionJointDef_1();
__declspec(dllexport) void __cdecl b2FrictionJointDef_Initialize(b2FrictionJointDefHandle handle, b2Body* bodyA, b2Body* bodyB, const b2Vec2& anchor);
// ------------------ class b2FrictionJointDef ------------------


// ------------------ class b2FrictionJointWrapper ------------------
__declspec(dllexport) void __cdecl b2FrictionJoint_dtor(b2FrictionJointHandle handle);

__declspec(dllexport) b2JointType __cdecl b2FrictionJoint_GetType(b2FrictionJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2FrictionJoint_GetBodyA(b2FrictionJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2FrictionJoint_GetBodyB(b2FrictionJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2FrictionJoint_GetAnchorA(b2FrictionJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2FrictionJoint_GetAnchorB(b2FrictionJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2FrictionJoint_GetReactionForce(b2FrictionJointHandle handle, float inv_dt);
__declspec(dllexport) float __cdecl b2FrictionJoint_GetReactionTorque(b2FrictionJointHandle handle, float inv_dt);
__declspec(dllexport) b2Joint* __cdecl b2FrictionJoint_GetNext(b2FrictionJointHandle handle);
__declspec(dllexport) void* __cdecl b2FrictionJoint_GetUserData(b2FrictionJointHandle handle);
__declspec(dllexport) void __cdecl b2FrictionJoint_SetUserData(b2FrictionJointHandle handle, void* data);
__declspec(dllexport) bool __cdecl b2FrictionJoint_IsActive(b2FrictionJointHandle handle);
__declspec(dllexport) bool __cdecl b2FrictionJoint_GetCollideConnected(b2FrictionJointHandle handle);
__declspec(dllexport) void __cdecl b2FrictionJoint_Dump(b2FrictionJointHandle handle);
__declspec(dllexport) void __cdecl b2FrictionJoint_ShiftOrigin(b2FrictionJointHandle handle, const b2Vec2& newOrigin);
__declspec(dllexport) const b2Vec2& __cdecl b2FrictionJoint_GetLocalAnchorA(b2FrictionJointHandle handle);
__declspec(dllexport) const b2Vec2& __cdecl b2FrictionJoint_GetLocalAnchorB(b2FrictionJointHandle handle);
__declspec(dllexport) void __cdecl b2FrictionJoint_SetMaxForce(b2FrictionJointHandle handle, float force);
__declspec(dllexport) float __cdecl b2FrictionJoint_GetMaxForce(b2FrictionJointHandle handle);
__declspec(dllexport) void __cdecl b2FrictionJoint_SetMaxTorque(b2FrictionJointHandle handle, float torque);
__declspec(dllexport) float __cdecl b2FrictionJoint_GetMaxTorque(b2FrictionJointHandle handle);
// ------------------ class b2FrictionJointWrapper ------------------


// ------------------ class b2GearJointDef ------------------
__declspec(dllexport) b2GearJointDef __cdecl b2GearJointDef_b2GearJointDef_1();
// ------------------ class b2GearJointDef ------------------


// ------------------ class b2GearJointWrapper ------------------
__declspec(dllexport) void __cdecl b2GearJoint_dtor(b2GearJointHandle handle);

__declspec(dllexport) b2JointType __cdecl b2GearJoint_GetType(b2GearJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2GearJoint_GetBodyA(b2GearJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2GearJoint_GetBodyB(b2GearJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2GearJoint_GetAnchorA(b2GearJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2GearJoint_GetAnchorB(b2GearJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2GearJoint_GetReactionForce(b2GearJointHandle handle, float inv_dt);
__declspec(dllexport) float __cdecl b2GearJoint_GetReactionTorque(b2GearJointHandle handle, float inv_dt);
__declspec(dllexport) b2Joint* __cdecl b2GearJoint_GetNext(b2GearJointHandle handle);
__declspec(dllexport) void* __cdecl b2GearJoint_GetUserData(b2GearJointHandle handle);
__declspec(dllexport) void __cdecl b2GearJoint_SetUserData(b2GearJointHandle handle, void* data);
__declspec(dllexport) bool __cdecl b2GearJoint_IsActive(b2GearJointHandle handle);
__declspec(dllexport) bool __cdecl b2GearJoint_GetCollideConnected(b2GearJointHandle handle);
__declspec(dllexport) void __cdecl b2GearJoint_Dump(b2GearJointHandle handle);
__declspec(dllexport) void __cdecl b2GearJoint_ShiftOrigin(b2GearJointHandle handle, const b2Vec2& newOrigin);
__declspec(dllexport) b2Joint* __cdecl b2GearJoint_GetJoint1(b2GearJointHandle handle);
__declspec(dllexport) b2Joint* __cdecl b2GearJoint_GetJoint2(b2GearJointHandle handle);
__declspec(dllexport) void __cdecl b2GearJoint_SetRatio(b2GearJointHandle handle, float ratio);
__declspec(dllexport) float __cdecl b2GearJoint_GetRatio(b2GearJointHandle handle);
// ------------------ class b2GearJointWrapper ------------------


// ------------------ class b2MotorJointDef ------------------
__declspec(dllexport) b2MotorJointDef __cdecl b2MotorJointDef_b2MotorJointDef_1();
__declspec(dllexport) void __cdecl b2MotorJointDef_Initialize(b2MotorJointDefHandle handle, b2Body* bodyA, b2Body* bodyB);
// ------------------ class b2MotorJointDef ------------------


// ------------------ class b2MotorJointWrapper ------------------
__declspec(dllexport) void __cdecl b2MotorJoint_dtor(b2MotorJointHandle handle);

__declspec(dllexport) b2JointType __cdecl b2MotorJoint_GetType(b2MotorJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2MotorJoint_GetBodyA(b2MotorJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2MotorJoint_GetBodyB(b2MotorJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2MotorJoint_GetAnchorA(b2MotorJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2MotorJoint_GetAnchorB(b2MotorJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2MotorJoint_GetReactionForce(b2MotorJointHandle handle, float inv_dt);
__declspec(dllexport) float __cdecl b2MotorJoint_GetReactionTorque(b2MotorJointHandle handle, float inv_dt);
__declspec(dllexport) b2Joint* __cdecl b2MotorJoint_GetNext(b2MotorJointHandle handle);
__declspec(dllexport) void* __cdecl b2MotorJoint_GetUserData(b2MotorJointHandle handle);
__declspec(dllexport) void __cdecl b2MotorJoint_SetUserData(b2MotorJointHandle handle, void* data);
__declspec(dllexport) bool __cdecl b2MotorJoint_IsActive(b2MotorJointHandle handle);
__declspec(dllexport) bool __cdecl b2MotorJoint_GetCollideConnected(b2MotorJointHandle handle);
__declspec(dllexport) void __cdecl b2MotorJoint_Dump(b2MotorJointHandle handle);
__declspec(dllexport) void __cdecl b2MotorJoint_ShiftOrigin(b2MotorJointHandle handle, const b2Vec2& newOrigin);
__declspec(dllexport) void __cdecl b2MotorJoint_SetLinearOffset(b2MotorJointHandle handle, const b2Vec2& linearOffset);
__declspec(dllexport) const b2Vec2& __cdecl b2MotorJoint_GetLinearOffset(b2MotorJointHandle handle);
__declspec(dllexport) void __cdecl b2MotorJoint_SetAngularOffset(b2MotorJointHandle handle, float angularOffset);
__declspec(dllexport) float __cdecl b2MotorJoint_GetAngularOffset(b2MotorJointHandle handle);
__declspec(dllexport) void __cdecl b2MotorJoint_SetMaxForce(b2MotorJointHandle handle, float force);
__declspec(dllexport) float __cdecl b2MotorJoint_GetMaxForce(b2MotorJointHandle handle);
__declspec(dllexport) void __cdecl b2MotorJoint_SetMaxTorque(b2MotorJointHandle handle, float torque);
__declspec(dllexport) float __cdecl b2MotorJoint_GetMaxTorque(b2MotorJointHandle handle);
__declspec(dllexport) void __cdecl b2MotorJoint_SetCorrectionFactor(b2MotorJointHandle handle, float factor);
__declspec(dllexport) float __cdecl b2MotorJoint_GetCorrectionFactor(b2MotorJointHandle handle);
// ------------------ class b2MotorJointWrapper ------------------


// ------------------ class b2MouseJointDef ------------------
__declspec(dllexport) b2MouseJointDef __cdecl b2MouseJointDef_b2MouseJointDef_1();
// ------------------ class b2MouseJointDef ------------------


// ------------------ class b2MouseJointWrapper ------------------
__declspec(dllexport) void __cdecl b2MouseJoint_dtor(b2MouseJointHandle handle);

__declspec(dllexport) b2JointType __cdecl b2MouseJoint_GetType(b2MouseJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2MouseJoint_GetBodyA(b2MouseJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2MouseJoint_GetBodyB(b2MouseJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2MouseJoint_GetAnchorA(b2MouseJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2MouseJoint_GetAnchorB(b2MouseJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2MouseJoint_GetReactionForce(b2MouseJointHandle handle, float inv_dt);
__declspec(dllexport) float __cdecl b2MouseJoint_GetReactionTorque(b2MouseJointHandle handle, float inv_dt);
__declspec(dllexport) b2Joint* __cdecl b2MouseJoint_GetNext(b2MouseJointHandle handle);
__declspec(dllexport) void* __cdecl b2MouseJoint_GetUserData(b2MouseJointHandle handle);
__declspec(dllexport) void __cdecl b2MouseJoint_SetUserData(b2MouseJointHandle handle, void* data);
__declspec(dllexport) bool __cdecl b2MouseJoint_IsActive(b2MouseJointHandle handle);
__declspec(dllexport) bool __cdecl b2MouseJoint_GetCollideConnected(b2MouseJointHandle handle);
__declspec(dllexport) void __cdecl b2MouseJoint_Dump(b2MouseJointHandle handle);
__declspec(dllexport) void __cdecl b2MouseJoint_ShiftOrigin(b2MouseJointHandle handle, const b2Vec2& newOrigin);
__declspec(dllexport) void __cdecl b2MouseJoint_SetTarget(b2MouseJointHandle handle, const b2Vec2& target);
__declspec(dllexport) const b2Vec2& __cdecl b2MouseJoint_GetTarget(b2MouseJointHandle handle);
__declspec(dllexport) void __cdecl b2MouseJoint_SetMaxForce(b2MouseJointHandle handle, float force);
__declspec(dllexport) float __cdecl b2MouseJoint_GetMaxForce(b2MouseJointHandle handle);
__declspec(dllexport) void __cdecl b2MouseJoint_SetFrequency(b2MouseJointHandle handle, float hz);
__declspec(dllexport) float __cdecl b2MouseJoint_GetFrequency(b2MouseJointHandle handle);
__declspec(dllexport) void __cdecl b2MouseJoint_SetDampingRatio(b2MouseJointHandle handle, float ratio);
__declspec(dllexport) float __cdecl b2MouseJoint_GetDampingRatio(b2MouseJointHandle handle);
// ------------------ class b2MouseJointWrapper ------------------


// ------------------ class b2PrismaticJointDef ------------------
__declspec(dllexport) b2PrismaticJointDef __cdecl b2PrismaticJointDef_b2PrismaticJointDef_1();
__declspec(dllexport) void __cdecl b2PrismaticJointDef_Initialize(b2PrismaticJointDefHandle handle, b2Body* bodyA, b2Body* bodyB, const b2Vec2& anchor, const b2Vec2& axis);
// ------------------ class b2PrismaticJointDef ------------------


// ------------------ class b2PrismaticJointWrapper ------------------
__declspec(dllexport) void __cdecl b2PrismaticJoint_dtor(b2PrismaticJointHandle handle);

__declspec(dllexport) b2JointType __cdecl b2PrismaticJoint_GetType(b2PrismaticJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2PrismaticJoint_GetBodyA(b2PrismaticJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2PrismaticJoint_GetBodyB(b2PrismaticJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2PrismaticJoint_GetAnchorA(b2PrismaticJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2PrismaticJoint_GetAnchorB(b2PrismaticJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2PrismaticJoint_GetReactionForce(b2PrismaticJointHandle handle, float inv_dt);
__declspec(dllexport) float __cdecl b2PrismaticJoint_GetReactionTorque(b2PrismaticJointHandle handle, float inv_dt);
__declspec(dllexport) b2Joint* __cdecl b2PrismaticJoint_GetNext(b2PrismaticJointHandle handle);
__declspec(dllexport) void* __cdecl b2PrismaticJoint_GetUserData(b2PrismaticJointHandle handle);
__declspec(dllexport) void __cdecl b2PrismaticJoint_SetUserData(b2PrismaticJointHandle handle, void* data);
__declspec(dllexport) bool __cdecl b2PrismaticJoint_IsActive(b2PrismaticJointHandle handle);
__declspec(dllexport) bool __cdecl b2PrismaticJoint_GetCollideConnected(b2PrismaticJointHandle handle);
__declspec(dllexport) void __cdecl b2PrismaticJoint_Dump(b2PrismaticJointHandle handle);
__declspec(dllexport) void __cdecl b2PrismaticJoint_ShiftOrigin(b2PrismaticJointHandle handle, const b2Vec2& newOrigin);
__declspec(dllexport) const b2Vec2& __cdecl b2PrismaticJoint_GetLocalAnchorA(b2PrismaticJointHandle handle);
__declspec(dllexport) const b2Vec2& __cdecl b2PrismaticJoint_GetLocalAnchorB(b2PrismaticJointHandle handle);
__declspec(dllexport) const b2Vec2& __cdecl b2PrismaticJoint_GetLocalAxisA(b2PrismaticJointHandle handle);
__declspec(dllexport) float __cdecl b2PrismaticJoint_GetReferenceAngle(b2PrismaticJointHandle handle);
__declspec(dllexport) float __cdecl b2PrismaticJoint_GetJointTranslation(b2PrismaticJointHandle handle);
__declspec(dllexport) float __cdecl b2PrismaticJoint_GetJointSpeed(b2PrismaticJointHandle handle);
__declspec(dllexport) bool __cdecl b2PrismaticJoint_IsLimitEnabled(b2PrismaticJointHandle handle);
__declspec(dllexport) void __cdecl b2PrismaticJoint_EnableLimit(b2PrismaticJointHandle handle, bool flag);
__declspec(dllexport) float __cdecl b2PrismaticJoint_GetLowerLimit(b2PrismaticJointHandle handle);
__declspec(dllexport) float __cdecl b2PrismaticJoint_GetUpperLimit(b2PrismaticJointHandle handle);
__declspec(dllexport) void __cdecl b2PrismaticJoint_SetLimits(b2PrismaticJointHandle handle, float lower, float upper);
__declspec(dllexport) bool __cdecl b2PrismaticJoint_IsMotorEnabled(b2PrismaticJointHandle handle);
__declspec(dllexport) void __cdecl b2PrismaticJoint_EnableMotor(b2PrismaticJointHandle handle, bool flag);
__declspec(dllexport) void __cdecl b2PrismaticJoint_SetMotorSpeed(b2PrismaticJointHandle handle, float speed);
__declspec(dllexport) float __cdecl b2PrismaticJoint_GetMotorSpeed(b2PrismaticJointHandle handle);
__declspec(dllexport) void __cdecl b2PrismaticJoint_SetMaxMotorForce(b2PrismaticJointHandle handle, float force);
__declspec(dllexport) float __cdecl b2PrismaticJoint_GetMaxMotorForce(b2PrismaticJointHandle handle);
__declspec(dllexport) float __cdecl b2PrismaticJoint_GetMotorForce(b2PrismaticJointHandle handle, float inv_dt);
// ------------------ class b2PrismaticJointWrapper ------------------


// ------------------ class b2PulleyJointDef ------------------
__declspec(dllexport) b2PulleyJointDef __cdecl b2PulleyJointDef_b2PulleyJointDef_1();
__declspec(dllexport) void __cdecl b2PulleyJointDef_Initialize(b2PulleyJointDefHandle handle, b2Body* bodyA, b2Body* bodyB, const b2Vec2& groundAnchorA, const b2Vec2& groundAnchorB, const b2Vec2& anchorA, const b2Vec2& anchorB, float ratio);
// ------------------ class b2PulleyJointDef ------------------


// ------------------ class b2PulleyJointWrapper ------------------
__declspec(dllexport) void __cdecl b2PulleyJoint_dtor(b2PulleyJointHandle handle);

__declspec(dllexport) b2JointType __cdecl b2PulleyJoint_GetType(b2PulleyJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2PulleyJoint_GetBodyA(b2PulleyJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2PulleyJoint_GetBodyB(b2PulleyJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2PulleyJoint_GetAnchorA(b2PulleyJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2PulleyJoint_GetAnchorB(b2PulleyJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2PulleyJoint_GetReactionForce(b2PulleyJointHandle handle, float inv_dt);
__declspec(dllexport) float __cdecl b2PulleyJoint_GetReactionTorque(b2PulleyJointHandle handle, float inv_dt);
__declspec(dllexport) b2Joint* __cdecl b2PulleyJoint_GetNext(b2PulleyJointHandle handle);
__declspec(dllexport) void* __cdecl b2PulleyJoint_GetUserData(b2PulleyJointHandle handle);
__declspec(dllexport) void __cdecl b2PulleyJoint_SetUserData(b2PulleyJointHandle handle, void* data);
__declspec(dllexport) bool __cdecl b2PulleyJoint_IsActive(b2PulleyJointHandle handle);
__declspec(dllexport) bool __cdecl b2PulleyJoint_GetCollideConnected(b2PulleyJointHandle handle);
__declspec(dllexport) void __cdecl b2PulleyJoint_Dump(b2PulleyJointHandle handle);
__declspec(dllexport) void __cdecl b2PulleyJoint_ShiftOrigin(b2PulleyJointHandle handle, const b2Vec2& newOrigin);
__declspec(dllexport) b2Vec2 __cdecl b2PulleyJoint_GetGroundAnchorA(b2PulleyJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2PulleyJoint_GetGroundAnchorB(b2PulleyJointHandle handle);
__declspec(dllexport) float __cdecl b2PulleyJoint_GetLengthA(b2PulleyJointHandle handle);
__declspec(dllexport) float __cdecl b2PulleyJoint_GetLengthB(b2PulleyJointHandle handle);
__declspec(dllexport) float __cdecl b2PulleyJoint_GetRatio(b2PulleyJointHandle handle);
__declspec(dllexport) float __cdecl b2PulleyJoint_GetCurrentLengthA(b2PulleyJointHandle handle);
__declspec(dllexport) float __cdecl b2PulleyJoint_GetCurrentLengthB(b2PulleyJointHandle handle);
// ------------------ class b2PulleyJointWrapper ------------------


// ------------------ class b2RevoluteJointDef ------------------
__declspec(dllexport) b2RevoluteJointDef __cdecl b2RevoluteJointDef_b2RevoluteJointDef_1();
__declspec(dllexport) void __cdecl b2RevoluteJointDef_Initialize(b2RevoluteJointDefHandle handle, b2Body* bodyA, b2Body* bodyB, const b2Vec2& anchor);
// ------------------ class b2RevoluteJointDef ------------------


// ------------------ class b2RevoluteJointWrapper ------------------
__declspec(dllexport) void __cdecl b2RevoluteJoint_dtor(b2RevoluteJointHandle handle);

__declspec(dllexport) b2JointType __cdecl b2RevoluteJoint_GetType(b2RevoluteJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2RevoluteJoint_GetBodyA(b2RevoluteJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2RevoluteJoint_GetBodyB(b2RevoluteJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2RevoluteJoint_GetAnchorA(b2RevoluteJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2RevoluteJoint_GetAnchorB(b2RevoluteJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2RevoluteJoint_GetReactionForce(b2RevoluteJointHandle handle, float inv_dt);
__declspec(dllexport) float __cdecl b2RevoluteJoint_GetReactionTorque(b2RevoluteJointHandle handle, float inv_dt);
__declspec(dllexport) b2Joint* __cdecl b2RevoluteJoint_GetNext(b2RevoluteJointHandle handle);
__declspec(dllexport) void* __cdecl b2RevoluteJoint_GetUserData(b2RevoluteJointHandle handle);
__declspec(dllexport) void __cdecl b2RevoluteJoint_SetUserData(b2RevoluteJointHandle handle, void* data);
__declspec(dllexport) bool __cdecl b2RevoluteJoint_IsActive(b2RevoluteJointHandle handle);
__declspec(dllexport) bool __cdecl b2RevoluteJoint_GetCollideConnected(b2RevoluteJointHandle handle);
__declspec(dllexport) void __cdecl b2RevoluteJoint_Dump(b2RevoluteJointHandle handle);
__declspec(dllexport) void __cdecl b2RevoluteJoint_ShiftOrigin(b2RevoluteJointHandle handle, const b2Vec2& newOrigin);
__declspec(dllexport) const b2Vec2& __cdecl b2RevoluteJoint_GetLocalAnchorA(b2RevoluteJointHandle handle);
__declspec(dllexport) const b2Vec2& __cdecl b2RevoluteJoint_GetLocalAnchorB(b2RevoluteJointHandle handle);
__declspec(dllexport) float __cdecl b2RevoluteJoint_GetReferenceAngle(b2RevoluteJointHandle handle);
__declspec(dllexport) float __cdecl b2RevoluteJoint_GetJointAngle(b2RevoluteJointHandle handle);
__declspec(dllexport) float __cdecl b2RevoluteJoint_GetJointSpeed(b2RevoluteJointHandle handle);
__declspec(dllexport) bool __cdecl b2RevoluteJoint_IsLimitEnabled(b2RevoluteJointHandle handle);
__declspec(dllexport) void __cdecl b2RevoluteJoint_EnableLimit(b2RevoluteJointHandle handle, bool flag);
__declspec(dllexport) float __cdecl b2RevoluteJoint_GetLowerLimit(b2RevoluteJointHandle handle);
__declspec(dllexport) float __cdecl b2RevoluteJoint_GetUpperLimit(b2RevoluteJointHandle handle);
__declspec(dllexport) void __cdecl b2RevoluteJoint_SetLimits(b2RevoluteJointHandle handle, float lower, float upper);
__declspec(dllexport) bool __cdecl b2RevoluteJoint_IsMotorEnabled(b2RevoluteJointHandle handle);
__declspec(dllexport) void __cdecl b2RevoluteJoint_EnableMotor(b2RevoluteJointHandle handle, bool flag);
__declspec(dllexport) void __cdecl b2RevoluteJoint_SetMotorSpeed(b2RevoluteJointHandle handle, float speed);
__declspec(dllexport) float __cdecl b2RevoluteJoint_GetMotorSpeed(b2RevoluteJointHandle handle);
__declspec(dllexport) void __cdecl b2RevoluteJoint_SetMaxMotorTorque(b2RevoluteJointHandle handle, float torque);
__declspec(dllexport) float __cdecl b2RevoluteJoint_GetMaxMotorTorque(b2RevoluteJointHandle handle);
__declspec(dllexport) float __cdecl b2RevoluteJoint_GetMotorTorque(b2RevoluteJointHandle handle, float inv_dt);
// ------------------ class b2RevoluteJointWrapper ------------------


// ------------------ class b2RopeJointDef ------------------
__declspec(dllexport) b2RopeJointDef __cdecl b2RopeJointDef_b2RopeJointDef_1();
// ------------------ class b2RopeJointDef ------------------


// ------------------ class b2RopeJointWrapper ------------------
__declspec(dllexport) void __cdecl b2RopeJoint_dtor(b2RopeJointHandle handle);

__declspec(dllexport) b2JointType __cdecl b2RopeJoint_GetType(b2RopeJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2RopeJoint_GetBodyA(b2RopeJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2RopeJoint_GetBodyB(b2RopeJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2RopeJoint_GetAnchorA(b2RopeJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2RopeJoint_GetAnchorB(b2RopeJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2RopeJoint_GetReactionForce(b2RopeJointHandle handle, float inv_dt);
__declspec(dllexport) float __cdecl b2RopeJoint_GetReactionTorque(b2RopeJointHandle handle, float inv_dt);
__declspec(dllexport) b2Joint* __cdecl b2RopeJoint_GetNext(b2RopeJointHandle handle);
__declspec(dllexport) void* __cdecl b2RopeJoint_GetUserData(b2RopeJointHandle handle);
__declspec(dllexport) void __cdecl b2RopeJoint_SetUserData(b2RopeJointHandle handle, void* data);
__declspec(dllexport) bool __cdecl b2RopeJoint_IsActive(b2RopeJointHandle handle);
__declspec(dllexport) bool __cdecl b2RopeJoint_GetCollideConnected(b2RopeJointHandle handle);
__declspec(dllexport) void __cdecl b2RopeJoint_Dump(b2RopeJointHandle handle);
__declspec(dllexport) void __cdecl b2RopeJoint_ShiftOrigin(b2RopeJointHandle handle, const b2Vec2& newOrigin);
__declspec(dllexport) const b2Vec2& __cdecl b2RopeJoint_GetLocalAnchorA(b2RopeJointHandle handle);
__declspec(dllexport) const b2Vec2& __cdecl b2RopeJoint_GetLocalAnchorB(b2RopeJointHandle handle);
__declspec(dllexport) void __cdecl b2RopeJoint_SetMaxLength(b2RopeJointHandle handle, float length);
__declspec(dllexport) float __cdecl b2RopeJoint_GetMaxLength(b2RopeJointHandle handle);
__declspec(dllexport) b2LimitState __cdecl b2RopeJoint_GetLimitState(b2RopeJointHandle handle);
// ------------------ class b2RopeJointWrapper ------------------


// ------------------ class b2WeldJointDef ------------------
__declspec(dllexport) b2WeldJointDef __cdecl b2WeldJointDef_b2WeldJointDef_1();
__declspec(dllexport) void __cdecl b2WeldJointDef_Initialize(b2WeldJointDefHandle handle, b2Body* bodyA, b2Body* bodyB, const b2Vec2& anchor);
// ------------------ class b2WeldJointDef ------------------


// ------------------ class b2WeldJointWrapper ------------------
__declspec(dllexport) void __cdecl b2WeldJoint_dtor(b2WeldJointHandle handle);

__declspec(dllexport) b2JointType __cdecl b2WeldJoint_GetType(b2WeldJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2WeldJoint_GetBodyA(b2WeldJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2WeldJoint_GetBodyB(b2WeldJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2WeldJoint_GetAnchorA(b2WeldJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2WeldJoint_GetAnchorB(b2WeldJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2WeldJoint_GetReactionForce(b2WeldJointHandle handle, float inv_dt);
__declspec(dllexport) float __cdecl b2WeldJoint_GetReactionTorque(b2WeldJointHandle handle, float inv_dt);
__declspec(dllexport) b2Joint* __cdecl b2WeldJoint_GetNext(b2WeldJointHandle handle);
__declspec(dllexport) void* __cdecl b2WeldJoint_GetUserData(b2WeldJointHandle handle);
__declspec(dllexport) void __cdecl b2WeldJoint_SetUserData(b2WeldJointHandle handle, void* data);
__declspec(dllexport) bool __cdecl b2WeldJoint_IsActive(b2WeldJointHandle handle);
__declspec(dllexport) bool __cdecl b2WeldJoint_GetCollideConnected(b2WeldJointHandle handle);
__declspec(dllexport) void __cdecl b2WeldJoint_Dump(b2WeldJointHandle handle);
__declspec(dllexport) void __cdecl b2WeldJoint_ShiftOrigin(b2WeldJointHandle handle, const b2Vec2& newOrigin);
__declspec(dllexport) const b2Vec2& __cdecl b2WeldJoint_GetLocalAnchorA(b2WeldJointHandle handle);
__declspec(dllexport) const b2Vec2& __cdecl b2WeldJoint_GetLocalAnchorB(b2WeldJointHandle handle);
__declspec(dllexport) float __cdecl b2WeldJoint_GetReferenceAngle(b2WeldJointHandle handle);
__declspec(dllexport) void __cdecl b2WeldJoint_SetFrequency(b2WeldJointHandle handle, float hz);
__declspec(dllexport) float __cdecl b2WeldJoint_GetFrequency(b2WeldJointHandle handle);
__declspec(dllexport) void __cdecl b2WeldJoint_SetDampingRatio(b2WeldJointHandle handle, float ratio);
__declspec(dllexport) float __cdecl b2WeldJoint_GetDampingRatio(b2WeldJointHandle handle);
// ------------------ class b2WeldJointWrapper ------------------


// ------------------ class b2WheelJointDef ------------------
__declspec(dllexport) b2WheelJointDef __cdecl b2WheelJointDef_b2WheelJointDef_1();
__declspec(dllexport) void __cdecl b2WheelJointDef_Initialize(b2WheelJointDefHandle handle, b2Body* bodyA, b2Body* bodyB, const b2Vec2& anchor, const b2Vec2& axis);
// ------------------ class b2WheelJointDef ------------------


// ------------------ class b2WheelJointWrapper ------------------
__declspec(dllexport) void __cdecl b2WheelJoint_dtor(b2WheelJointHandle handle);

__declspec(dllexport) b2JointType __cdecl b2WheelJoint_GetType(b2WheelJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2WheelJoint_GetBodyA(b2WheelJointHandle handle);
__declspec(dllexport) b2Body* __cdecl b2WheelJoint_GetBodyB(b2WheelJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2WheelJoint_GetAnchorA(b2WheelJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2WheelJoint_GetAnchorB(b2WheelJointHandle handle);
__declspec(dllexport) b2Vec2 __cdecl b2WheelJoint_GetReactionForce(b2WheelJointHandle handle, float inv_dt);
__declspec(dllexport) float __cdecl b2WheelJoint_GetReactionTorque(b2WheelJointHandle handle, float inv_dt);
__declspec(dllexport) b2Joint* __cdecl b2WheelJoint_GetNext(b2WheelJointHandle handle);
__declspec(dllexport) void* __cdecl b2WheelJoint_GetUserData(b2WheelJointHandle handle);
__declspec(dllexport) void __cdecl b2WheelJoint_SetUserData(b2WheelJointHandle handle, void* data);
__declspec(dllexport) bool __cdecl b2WheelJoint_IsActive(b2WheelJointHandle handle);
__declspec(dllexport) bool __cdecl b2WheelJoint_GetCollideConnected(b2WheelJointHandle handle);
__declspec(dllexport) void __cdecl b2WheelJoint_Dump(b2WheelJointHandle handle);
__declspec(dllexport) void __cdecl b2WheelJoint_ShiftOrigin(b2WheelJointHandle handle, const b2Vec2& newOrigin);
__declspec(dllexport) const b2Vec2& __cdecl b2WheelJoint_GetLocalAnchorA(b2WheelJointHandle handle);
__declspec(dllexport) const b2Vec2& __cdecl b2WheelJoint_GetLocalAnchorB(b2WheelJointHandle handle);
__declspec(dllexport) const b2Vec2& __cdecl b2WheelJoint_GetLocalAxisA(b2WheelJointHandle handle);
__declspec(dllexport) float __cdecl b2WheelJoint_GetJointTranslation(b2WheelJointHandle handle);
__declspec(dllexport) float __cdecl b2WheelJoint_GetJointSpeed(b2WheelJointHandle handle);
__declspec(dllexport) bool __cdecl b2WheelJoint_IsMotorEnabled(b2WheelJointHandle handle);
__declspec(dllexport) void __cdecl b2WheelJoint_EnableMotor(b2WheelJointHandle handle, bool flag);
__declspec(dllexport) void __cdecl b2WheelJoint_SetMotorSpeed(b2WheelJointHandle handle, float speed);
__declspec(dllexport) float __cdecl b2WheelJoint_GetMotorSpeed(b2WheelJointHandle handle);
__declspec(dllexport) void __cdecl b2WheelJoint_SetMaxMotorTorque(b2WheelJointHandle handle, float torque);
__declspec(dllexport) float __cdecl b2WheelJoint_GetMaxMotorTorque(b2WheelJointHandle handle);
__declspec(dllexport) float __cdecl b2WheelJoint_GetMotorTorque(b2WheelJointHandle handle, float inv_dt);
__declspec(dllexport) void __cdecl b2WheelJoint_SetSpringFrequencyHz(b2WheelJointHandle handle, float hz);
__declspec(dllexport) float __cdecl b2WheelJoint_GetSpringFrequencyHz(b2WheelJointHandle handle);
__declspec(dllexport) void __cdecl b2WheelJoint_SetSpringDampingRatio(b2WheelJointHandle handle, float ratio);
__declspec(dllexport) float __cdecl b2WheelJoint_GetSpringDampingRatio(b2WheelJointHandle handle);
// ------------------ class b2WheelJointWrapper ------------------

__declspec(dllexport) float __cdecl Dynamics_b2MixFriction(float friction1, float friction2);
__declspec(dllexport) float __cdecl Dynamics_b2MixRestitution(float restitution1, float restitution2);


#if defined(__cplusplus)
};
#endif

#endif // DynamicsH
