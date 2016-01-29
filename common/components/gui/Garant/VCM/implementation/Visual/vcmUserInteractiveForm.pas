unit vcmUserInteractiveForm;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmUserInteractiveForm.pas"
// Начат: 22.06.2011 15:44
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Visual::TvcmUserInteractiveForm
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
  l3Forms,
  l3ProtoObject
  {$If not defined(NoVCL)}
  ,
  l3CloseFormHelper
  {$IfEnd} //not NoVCL
  ,
  vcmGUI,
  vcmExternalInterfaces
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  ,
  l3MessageID
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmCloseFormHelper = {final} class(Tl3ProtoObject {$If not defined(NoVCL)}, Il3CloseFormHelper{$IfEnd} //not NoVCL
 )
 public
 // realized methods
   {$If not defined(NoVCL)}
   function Close(aControl: TWinControl): Boolean;
   {$IfEnd} //not NoVCL
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TvcmCloseFormHelper;
    {- возвращает экземпляр синглетона. }
 end;//TvcmCloseFormHelper

 _vcmUserInteractiveForm_Parent_ = Tl3Form;
 {$Include ..\Visual\vcmUserInteractiveForm.imp.pas}
 TvcmUserInteractiveForm = class(_vcmUserInteractiveForm_)
 end;//TvcmUserInteractiveForm
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a},
  vcmForm
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmDialogs
  {$IfEnd} //not NoVCM AND not NoVGScene
  ,
  vcmMessagesSupport
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

{$Include ..\Visual\vcmUserInteractiveForm.imp.pas}


// start class TvcmCloseFormHelper

var g_TvcmCloseFormHelper : TvcmCloseFormHelper = nil;

procedure TvcmCloseFormHelperFree;
begin
 l3Free(g_TvcmCloseFormHelper);
end;

class function TvcmCloseFormHelper.Instance: TvcmCloseFormHelper;
begin
 if (g_TvcmCloseFormHelper = nil) then
 begin
  l3System.AddExitProc(TvcmCloseFormHelperFree);
  g_TvcmCloseFormHelper := Create;
 end;
 Result := g_TvcmCloseFormHelper;
end;


class function TvcmCloseFormHelper.Exists: Boolean;
 {-}
begin
 Result := g_TvcmCloseFormHelper <> nil;
end;//TvcmCloseFormHelper.Exists

{$If not defined(NoVCL)}
function TvcmCloseFormHelper.Close(aControl: TWinControl): Boolean;
//#UC START# *A1E64DB467E3_55015117004B_var*
//#UC END# *A1E64DB467E3_55015117004B_var*
begin
//#UC START# *A1E64DB467E3_55015117004B_impl*
 if (aControl Is TvcmInterfacedForm) then
 begin
  TvcmInterfacedForm(aControl).SafeClose;
  Result := true;
 end//aControl Is TvcmInterfacedForm
 else
  Result := false;
//#UC END# *A1E64DB467E3_55015117004B_impl*
end;//TvcmCloseFormHelper.Close
{$IfEnd} //not NoVCL

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoVCM)}
// Регистрация TvcmCloseFormHelper
 {$If not defined(NoVCL)}
 Tl3CloseFormHelper.Instance.Alien := TvcmCloseFormHelper.Instance;
 {$IfEnd} //not NoVCL

{$IfEnd} //not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация TvcmUserInteractiveForm
 TtfwClassRef.Register(TvcmUserInteractiveForm);
{$IfEnd} //not NoScripts AND not NoVCM

end.