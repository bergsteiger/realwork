{$IfNDef nsUnknownComponentWithIvcmState_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Rem"
// Модуль: "w:/common/components/gui/Garant/VT/nsUnknownComponentWithIvcmState.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VT$Rem::NewReminders::nsUnknownComponentWithIvcmState
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nsUnknownComponentWithIvcmState_imp}
{$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}
 _nsUnknownComponent_Parent_ = _nsUnknownComponentWithIvcmState_Parent_;
 {$Include ..\VT\nsUnknownComponent.imp.pas}
 _nsUnknownComponentWithIvcmState_ = {mixin} class(_nsUnknownComponent_ {$If not defined(NoVCM)}, IvcmState{$IfEnd} //not NoVCM
 )
 protected
 // realized methods
   {$If not defined(NoVCM)}
   function SaveState(out theState: IUnknown;
    aStateType: TvcmStateType): Boolean;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function LoadState(const theState: IUnknown;
    aStateType: TvcmStateType): Boolean;
   {$IfEnd} //not NoVCM
 public
 // public methods
   function DoLoadState(const theState: IUnknown;
     aStateType: TvcmStateType): Boolean; virtual;
   function DoSaveState(out theState: IUnknown;
     aStateType: TvcmStateType): Boolean; virtual;
 end;//_nsUnknownComponentWithIvcmState_
{$Else}

 _nsUnknownComponent_Parent_ = _nsUnknownComponentWithIvcmState_Parent_;
 {$Include ..\VT\nsUnknownComponent.imp.pas}
 _nsUnknownComponentWithIvcmState_ = _nsUnknownComponent_;

{$IfEnd} //not DesignTimeLibrary AND not NoVGScene

{$Else nsUnknownComponentWithIvcmState_imp}

{$If not defined(DesignTimeLibrary) AND not defined(NoVGScene)}

{$Include ..\VT\nsUnknownComponent.imp.pas}

// start class _nsUnknownComponentWithIvcmState_

function _nsUnknownComponentWithIvcmState_.DoLoadState(const theState: IUnknown;
  aStateType: TvcmStateType): Boolean;
//#UC START# *4F9AB1780087_4F9A6F66035C_var*
//#UC END# *4F9AB1780087_4F9A6F66035C_var*
begin
//#UC START# *4F9AB1780087_4F9A6F66035C_impl*
 Result := False;
//#UC END# *4F9AB1780087_4F9A6F66035C_impl*
end;//_nsUnknownComponentWithIvcmState_.DoLoadState

function _nsUnknownComponentWithIvcmState_.DoSaveState(out theState: IUnknown;
  aStateType: TvcmStateType): Boolean;
//#UC START# *4F9AB19F020B_4F9A6F66035C_var*
//#UC END# *4F9AB19F020B_4F9A6F66035C_var*
begin
//#UC START# *4F9AB19F020B_4F9A6F66035C_impl*
 Result := False;
//#UC END# *4F9AB19F020B_4F9A6F66035C_impl*
end;//_nsUnknownComponentWithIvcmState_.DoSaveState

{$If not defined(NoVCM)}
function _nsUnknownComponentWithIvcmState_.SaveState(out theState: IUnknown;
  aStateType: TvcmStateType): Boolean;
//#UC START# *4683E75B01D8_4F9A6F66035C_var*
//#UC END# *4683E75B01D8_4F9A6F66035C_var*
begin
//#UC START# *4683E75B01D8_4F9A6F66035C_impl*
 Result := DoSaveState(theState, aStateType);
//#UC END# *4683E75B01D8_4F9A6F66035C_impl*
end;//_nsUnknownComponentWithIvcmState_.SaveState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function _nsUnknownComponentWithIvcmState_.LoadState(const theState: IUnknown;
  aStateType: TvcmStateType): Boolean;
//#UC START# *4683E79D0331_4F9A6F66035C_var*
//#UC END# *4683E79D0331_4F9A6F66035C_var*
begin
//#UC START# *4683E79D0331_4F9A6F66035C_impl*
 Result := DoLoadState(theState, aStateType);
//#UC END# *4683E79D0331_4F9A6F66035C_impl*
end;//_nsUnknownComponentWithIvcmState_.LoadState
{$IfEnd} //not NoVCM

{$IfEnd} //not DesignTimeLibrary AND not NoVGScene

{$EndIf nsUnknownComponentWithIvcmState_imp}
