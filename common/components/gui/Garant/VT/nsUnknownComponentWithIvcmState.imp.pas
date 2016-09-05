{$IfNDef nsUnknownComponentWithIvcmState_imp}

// Модуль: "w:\common\components\gui\Garant\VT\nsUnknownComponentWithIvcmState.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nsUnknownComponentWithIvcmState" MUID: (4F9A6F66035C)
// Имя типа: "_nsUnknownComponentWithIvcmState_"

{$Define nsUnknownComponentWithIvcmState_imp}

{$If NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}
 _nsUnknownComponent_Parent_ = _nsUnknownComponentWithIvcmState_Parent_;
 {$Include w:\common\components\gui\Garant\VT\nsUnknownComponent.imp.pas}
 _nsUnknownComponentWithIvcmState_ = class(_nsUnknownComponent_{$If NOT Defined(NoVCM)}
 , IvcmState
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   {$If NOT Defined(NoVCM)}
   function SaveState(out theState: IUnknown;
    aStateType: TvcmStateType): Boolean;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function LoadState(const theState: IUnknown;
    aStateType: TvcmStateType;
    aClone: Boolean): Boolean;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function DoLoadState(const theState: IUnknown;
    aStateType: TvcmStateType): Boolean; virtual;
   function DoSaveState(out theState: IUnknown;
    aStateType: TvcmStateType): Boolean; virtual;
 end;//_nsUnknownComponentWithIvcmState_

{$Else NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}

_nsUnknownComponent_Parent_ = _nsUnknownComponentWithIvcmState_Parent_;
{$Include w:\common\components\gui\Garant\VT\nsUnknownComponent.imp.pas}
_nsUnknownComponentWithIvcmState_ = _nsUnknownComponent_;

{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)
{$Else nsUnknownComponentWithIvcmState_imp}

{$IfNDef nsUnknownComponentWithIvcmState_imp_impl}

{$Define nsUnknownComponentWithIvcmState_imp_impl}

{$If NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)}
{$Include w:\common\components\gui\Garant\VT\nsUnknownComponent.imp.pas}

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

{$If NOT Defined(NoVCM)}
function _nsUnknownComponentWithIvcmState_.SaveState(out theState: IUnknown;
 aStateType: TvcmStateType): Boolean;
//#UC START# *4683E75B01D8_4F9A6F66035C_var*
//#UC END# *4683E75B01D8_4F9A6F66035C_var*
begin
//#UC START# *4683E75B01D8_4F9A6F66035C_impl*
 Result := DoSaveState(theState, aStateType);
//#UC END# *4683E75B01D8_4F9A6F66035C_impl*
end;//_nsUnknownComponentWithIvcmState_.SaveState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function _nsUnknownComponentWithIvcmState_.LoadState(const theState: IUnknown;
 aStateType: TvcmStateType;
 aClone: Boolean): Boolean;
//#UC START# *4683E79D0331_4F9A6F66035C_var*
//#UC END# *4683E79D0331_4F9A6F66035C_var*
begin
//#UC START# *4683E79D0331_4F9A6F66035C_impl*
 Result := DoLoadState(theState, aStateType);
//#UC END# *4683E79D0331_4F9A6F66035C_impl*
end;//_nsUnknownComponentWithIvcmState_.LoadState
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(DesignTimeLibrary)
{$EndIf nsUnknownComponentWithIvcmState_imp_impl}

{$EndIf nsUnknownComponentWithIvcmState_imp}

