{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{          File: manipulations.h                        }
{          Copyright (c) Microsoft Corporation          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Winapi.Manipulations;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

{$HPPEMIT ''}
{$HPPEMIT '#include "manipulations.h"'}
{$HPPEMIT ''}

interface

uses Winapi.Windows;

const
  CLSID_IInertiaProcessor: TGUID = (
    D1:$ABB27087; D2:$4CE0; D3:$4E58; D4:($A0,$CB,$E2,$4D,$F9,$68,$14,$BE));
  {$EXTERNALSYM CLSID_IInertiaProcessor}
  CLSID_IManipulationProcessor: TGUID = (
    D1:$597D4FB0; D2:$47FD; D3:$4AFF; D4:($89,$B9,$C6,$CF,$AE,$8C,$F0,$8E));
  {$EXTERNALSYM CLSID_IManipulationProcessor}

const
  SID__IManipulationEvents = '{4f62c8da-9c53-4b22-93df-927a862bbb03}';
  SID_IInertiaProcessor = '{18b00c6d-c5ee-41b1-90a9-9d4a929095ad}';
  SID_IManipulationProcessor = '{A22AC519-8300-48a0-BEF4-F1BE8737DBA4}';

  IID__IManipulationEvents: TGUID = SID__IManipulationEvents;
  {$EXTERNALSYM IID__IManipulationEvents}
  IID_IInertiaProcessor: TGUID = SID_IInertiaProcessor;
  {$EXTERNALSYM IID_IInertiaProcessor}
  IID_IManipulationProcessor: TGUID = SID_IInertiaProcessor;
  {$EXTERNALSYM IID_IManipulationProcessor}


type
  MANIPULATION_PROCESSOR_MANIPULATIONS = type Integer;
  {$EXTERNALSYM MANIPULATION_PROCESSOR_MANIPULATIONS}

const
  MANIPULATION_NONE        = 0;
  {$EXTERNALSYM MANIPULATION_NONE}
  MANIPULATION_TRANSLATE_X = $1;
  {$EXTERNALSYM MANIPULATION_TRANSLATE_X}
  MANIPULATION_TRANSLATE_Y = $2;
  {$EXTERNALSYM MANIPULATION_TRANSLATE_Y}
  MANIPULATION_SCALE       = $4;
  {$EXTERNALSYM MANIPULATION_SCALE}
  MANIPULATION_ROTATE      = $8;
  {$EXTERNALSYM MANIPULATION_ROTATE}
  MANIPULATION_ALL         = $F;
  {$EXTERNALSYM MANIPULATION_ALL}

type
  MANIPULATOR_ID = LongWord;
  {$EXTERNALSYM MANIPULATOR_ID}

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(_IManipulationEvents);'}
  _IManipulationEvents = interface(IUnknown)
    [SID__IManipulationEvents]
    function ManipulationStarted(x: Single; y: Single): HRESULT; stdcall;
    function ManipulationDelta(x: Single; y: Single; translationDeltaX: Single;
      translationDeltaY: Single; scaleDelta: Single; expansionDelta: Single;
      rotationDelta: Single; cumulativeTranslationX: Single;
      cumulativeTranslationY: Single; cumulativeScale: Single;
      cumulativeExpansion: Single; cumulativeRotation: Single): HRESULT; stdcall;
    function ManipulationCompleted(x: Single; y: Single;
      cumulativeTranslationX: Single; cumulativeTranslationY: Single;
      cumulativeScale: Single; cumulativeExpansion: Single;
      cumulativeRotation: Single): HRESULT; stdcall;
  end;
  {$EXTERNALSYM _IManipulationEvents}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IInertiaProcessor);'}
  IInertiaProcessor = interface(IUnknown)
    [SID_IInertiaProcessor]
    function get_InitialOriginX(var x: Single): HRESULT; stdcall;
    function put_InitialOriginX(x: Single): HRESULT; stdcall;
    function get_InitialOriginY(var y: Single): HRESULT; stdcall;
    function put_InitialOriginY(y: Single): HRESULT; stdcall;
    function get_InitialVelocityX(var x: Single): HRESULT; stdcall;
    function put_InitialVelocityX(x: Single): HRESULT; stdcall;
    function get_InitialVelocityY(var y: Single): HRESULT; stdcall;
    function put_InitialVelocityY(y: Single): HRESULT; stdcall;
    function get_InitialAngularVelocity(var velocity: Single): HRESULT; stdcall;
    function put_InitialAngularVelocity(velocity: Single): HRESULT; stdcall;
    function get_InitialExpansionVelocity(var velocity: Single): HRESULT; stdcall;
    function put_InitialExpansionVelocity(velocity: Single): HRESULT; stdcall;
    function get_InitialRadius(var radius: Single): HRESULT; stdcall;
    function put_InitialRadius(radius: Single): HRESULT; stdcall;
    function get_BoundaryLeft(var left: Single): HRESULT; stdcall;
    function put_BoundaryLeft(left: Single): HRESULT; stdcall;
    function get_BoundaryTop(var top: Single): HRESULT; stdcall;
    function put_BoundaryTop(top: Single): HRESULT; stdcall;
    function get_BoundaryRight(var right: Single): HRESULT; stdcall;
    function put_BoundaryRight(right: Single): HRESULT; stdcall;
    function get_BoundaryBottom(var bottom: Single): HRESULT; stdcall;
    function put_BoundaryBottom(bottom: Single): HRESULT; stdcall;
    function get_ElasticMarginLeft(var left: Single): HRESULT; stdcall;
    function put_ElasticMarginLeft(left: Single): HRESULT; stdcall;
    function get_ElasticMarginTop(var top: Single): HRESULT; stdcall;
    function put_ElasticMarginTop(top: Single): HRESULT; stdcall;
    function get_ElasticMarginRight(var right: Single): HRESULT; stdcall;
    function put_ElasticMarginRight(right: Single): HRESULT; stdcall;
    function get_ElasticMarginBottom(var bottom: Single): HRESULT; stdcall;
    function put_ElasticMarginBottom(bottom: Single): HRESULT; stdcall;
    function get_DesiredDisplacement(var displacement: Single): HRESULT; stdcall;
    function put_DesiredDisplacement(displacement: Single): HRESULT; stdcall;
    function get_DesiredRotation(var rotation: Single): HRESULT; stdcall;
    function put_DesiredRotation(rotation: Single): HRESULT; stdcall;
    function get_DesiredExpansion(var expansion: Single): HRESULT; stdcall;
    function put_DesiredExpansion(expansion: Single): HRESULT; stdcall;
    function get_DesiredDeceleration(var deceleration: Single): HRESULT; stdcall;
    function put_DesiredDeceleration(deceleration: Single): HRESULT; stdcall;
    function get_DesiredAngularDeceleration(var deceleration: Single): HRESULT; stdcall;
    function put_DesiredAngularDeceleration(deceleration: Single): HRESULT; stdcall;
    function get_DesiredExpansionDeceleration(var deceleration: Single): HRESULT; stdcall;
    function put_DesiredExpansionDeceleration(deceleration: Single): HRESULT; stdcall;
    function get_InitialTimestamp(var timestamp: DWORD): HRESULT; stdcall;
    function put_InitialTimestamp(timestamp: DWORD): HRESULT; stdcall;
    function Reset: HRESULT; stdcall;
    function Process(var completed: BOOL): HRESULT; stdcall;
    function ProcessTime(timestamp: DWORD; var completed: BOOL): HRESULT; stdcall;
    function Complete: HRESULT; stdcall;
    function CompleteTime(timestamp: DWORD): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IInertiaProcessor}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IManipulationProcessor);'}
  IManipulationProcessor = interface(IUnknown)
    [SID_IManipulationProcessor]
    function get_SupportedManipulations(
      var manipulations: MANIPULATION_PROCESSOR_MANIPULATIONS): HRESULT; stdcall;
    function put_SupportedManipulations(
      manipulations: MANIPULATION_PROCESSOR_MANIPULATIONS): HRESULT; stdcall;
    function get_PivotPointX(var pivotPointX: Single): HRESULT; stdcall;
    function put_PivotPointX(pivotPointX: Single): HRESULT; stdcall;
    function get_PivotPointY(var pivotPointY: Single): HRESULT; stdcall;
    function put_PivotPointY(pivotPointY: Single): HRESULT; stdcall;
    function get_PivotRadius(var pivotRadius: Single): HRESULT; stdcall;
    function put_PivotRadius(pivotRadius: Single): HRESULT; stdcall;
    function CompleteManipulation: HRESULT; stdcall;
    function ProcessDown(manipulatorId: MANIPULATOR_ID; x: Single;
      y: Single): HRESULT; stdcall;
    function ProcessMove(manipulatorId: MANIPULATOR_ID; x: Single;
      y: Single): HRESULT; stdcall;
    function ProcessUp(manipulatorId: MANIPULATOR_ID; x: Single;
      y: Single): HRESULT; stdcall;
    function ProcessDownWithTime(manipulatorId: MANIPULATOR_ID; x: Single;
      y: Single; timestamp: DWORD): HRESULT; stdcall;
    function ProcessMoveWithTime(manipulatorId: MANIPULATOR_ID; x: Single;
      y: Single; timestamp: DWORD): HRESULT; stdcall;
    function ProcessUpWithTime(manipulatorId: MANIPULATOR_ID; x: Single; y: Single;
      timestamp: DWORD): HRESULT; stdcall;
    function GetVelocityX(var velocityX: Single): HRESULT; stdcall;
    function GetVelocityY(var velocityY: Single): HRESULT; stdcall;
    function GetExpansionVelocity(var expansionVelocity: Single): HRESULT; stdcall;
    function GetAngularVelocity(var angularVelocity: Single): HRESULT; stdcall;
    function get_MinimumScaleRotateRadius(var minRadius: Single): HRESULT; stdcall;
    function put_MinimumScaleRotateRadius(minRadius: Single): HRESULT; stdcall;
  end;
  {$EXTERNALSYM IManipulationProcessor}

implementation

end.
