unit vcmMainMenuAction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmMainMenuAction.pas"
// Начат: 24.03.2008 11:24
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Actions::TvcmMainMenuAction
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
  vcmInterfaces,
  Classes,
  vcmAction
  {$If not defined(NoVCL)}
  ,
  Menus
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmMainMenuAction = class(TvcmAction)
 private
 // private fields
   f_OnTest : TvcmTestEvent;
    {* Поле для свойства OnTest}
 protected
 // overridden protected methods
   procedure DoUpdate; override;
 public
 // public methods
   constructor Create(anOwner: TComponent;
    aTest: TvcmTestEvent); reintroduce;
   class function MakeForMenu(anItem: TMenuItem;
    aTest: TvcmTestEvent): TvcmMainMenuAction;
 public
 // public properties
   property OnTest: TvcmTestEvent
     read f_OnTest
     write f_OnTest;
 end;//TvcmMainMenuAction
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TvcmMainMenuAction

constructor TvcmMainMenuAction.Create(anOwner: TComponent;
  aTest: TvcmTestEvent);
//#UC START# *47E7670B000F_47E7652402FF_var*
//#UC END# *47E7670B000F_47E7652402FF_var*
begin
//#UC START# *47E7670B000F_47E7652402FF_impl*
 inherited Create(anOwner);
 Assert(Assigned(aTest));
 OnTest := aTest;
//#UC END# *47E7670B000F_47E7652402FF_impl*
end;//TvcmMainMenuAction.Create

class function TvcmMainMenuAction.MakeForMenu(anItem: TMenuItem;
  aTest: TvcmTestEvent): TvcmMainMenuAction;
//#UC START# *47E7AC17020C_47E7652402FF_var*
//#UC END# *47E7AC17020C_47E7652402FF_var*
begin
//#UC START# *47E7AC17020C_47E7652402FF_impl*
 if (anItem = nil) then
  Result := nil
 else 
 if Assigned(aTest) then
 begin
  Result := Create(anItem, aTest);
  Result.Caption := l3CStr(anItem.Caption);
  anItem.Action := Result;
 end//Assigned(aTest)
 else
  Result := nil;
//#UC END# *47E7AC17020C_47E7652402FF_impl*
end;//TvcmMainMenuAction.MakeForMenu

procedure TvcmMainMenuAction.DoUpdate;
//#UC START# *47E766E10053_47E7652402FF_var*
var
 l_Params : IvcmTestParams;
//#UC END# *47E766E10053_47E7652402FF_var*
begin
//#UC START# *47E766E10053_47E7652402FF_impl*
 l_Params := MakeTestParams;
 OnTest(l_Params);
 SetParams(l_Params);
//#UC END# *47E766E10053_47E7652402FF_impl*
end;//TvcmMainMenuAction.DoUpdate

{$IfEnd} //not NoVCM

end.