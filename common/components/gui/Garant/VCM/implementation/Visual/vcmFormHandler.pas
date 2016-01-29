unit vcmFormHandler;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmFormHandler.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Visual::TvcmFormHandler
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces,
  Classes,
  vcmEntityForm,
  l3ProtoObject
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmFormHandler = class(Tl3ProtoObject, IvcmFormHandler)
 private
 // private fields
   f_Hint : IvcmCString;
   f_Form : TvcmEntityForm;
   f_Handler : TNotifyEvent;
 protected
 // realized methods
   function Get_Handler: TNotifyEvent;
   function Get_Hint: IvcmCString;
   function Get_Form: TCustomForm;
   function CanHaveCloseButtonInNavigator: Boolean;
   function CanHaveOwnCloseButtonInNavigator: Boolean;
 public
 // public methods
   constructor Create(aForm: TvcmEntityForm;
    aHandler: TNotifyEvent;
    const aHint: IvcmCString); reintroduce;
   class function Make(aForm: TvcmEntityForm;
    aHandler: TNotifyEvent;
    const aHint: IvcmCString): IvcmFormHandler; reintroduce; virtual;
 end;//TvcmFormHandler
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}

// start class TvcmFormHandler

constructor TvcmFormHandler.Create(aForm: TvcmEntityForm;
  aHandler: TNotifyEvent;
  const aHint: IvcmCString);
//#UC START# *47D0E6DC0152_47D0E1C9021A_var*
//#UC END# *47D0E6DC0152_47D0E1C9021A_var*
begin
//#UC START# *47D0E6DC0152_47D0E1C9021A_impl*
 Assert(aForm <> nil);
 Assert(Assigned(aHandler));
 inherited Create;
 f_Form := aForm;
 f_Handler := aHandler;
 f_Hint := aHint;
//#UC END# *47D0E6DC0152_47D0E1C9021A_impl*
end;//TvcmFormHandler.Create

class function TvcmFormHandler.Make(aForm: TvcmEntityForm;
  aHandler: TNotifyEvent;
  const aHint: IvcmCString): IvcmFormHandler;
var
 l_Inst : TvcmFormHandler;
begin
 l_Inst := Create(aForm, aHandler, aHint);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TvcmFormHandler.Get_Handler: TNotifyEvent;
//#UC START# *47D0DE680250_47D0E1C9021Aget_var*
//#UC END# *47D0DE680250_47D0E1C9021Aget_var*
begin
//#UC START# *47D0DE680250_47D0E1C9021Aget_impl*
 Result := f_Handler;
//#UC END# *47D0DE680250_47D0E1C9021Aget_impl*
end;//TvcmFormHandler.Get_Handler

function TvcmFormHandler.Get_Hint: IvcmCString;
//#UC START# *47D0DE7E02BB_47D0E1C9021Aget_var*
//#UC END# *47D0DE7E02BB_47D0E1C9021Aget_var*
begin
//#UC START# *47D0DE7E02BB_47D0E1C9021Aget_impl*
 Result := f_Hint;
//#UC END# *47D0DE7E02BB_47D0E1C9021Aget_impl*
end;//TvcmFormHandler.Get_Hint

function TvcmFormHandler.Get_Form: TCustomForm;
//#UC START# *47D0DE9902DE_47D0E1C9021Aget_var*
//#UC END# *47D0DE9902DE_47D0E1C9021Aget_var*
begin
//#UC START# *47D0DE9902DE_47D0E1C9021Aget_impl*
 Result := f_Form;
//#UC END# *47D0DE9902DE_47D0E1C9021Aget_impl*
end;//TvcmFormHandler.Get_Form

function TvcmFormHandler.CanHaveCloseButtonInNavigator: Boolean;
//#UC START# *4F619C980151_47D0E1C9021A_var*
//#UC END# *4F619C980151_47D0E1C9021A_var*
begin
//#UC START# *4F619C980151_47D0E1C9021A_impl*
 Result := f_Form.CanHaveCloseButtonInNavigator;
//#UC END# *4F619C980151_47D0E1C9021A_impl*
end;//TvcmFormHandler.CanHaveCloseButtonInNavigator

function TvcmFormHandler.CanHaveOwnCloseButtonInNavigator: Boolean;
//#UC START# *4F6A0EA503A9_47D0E1C9021A_var*
//#UC END# *4F6A0EA503A9_47D0E1C9021A_var*
begin
//#UC START# *4F6A0EA503A9_47D0E1C9021A_impl*
 Result := f_Form.CanHaveOwnCloseButtonInNavigator;
//#UC END# *4F6A0EA503A9_47D0E1C9021A_impl*
end;//TvcmFormHandler.CanHaveOwnCloseButtonInNavigator

{$IfEnd} //not NoVCM

end.