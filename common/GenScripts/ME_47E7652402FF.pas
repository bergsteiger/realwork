unit vcmMainMenuAction;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMainMenuAction.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmMainMenuAction" MUID: (47E7652402FF)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmAction
 , vcmInterfaces
 , Classes
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TvcmMainMenuAction = class(TvcmAction)
  private
   f_OnTest: TvcmTestEvent;
  protected
   procedure DoUpdate; override;
  public
   constructor Create(anOwner: TComponent;
    aTest: TvcmTestEvent); reintroduce;
   class function MakeForMenu(anItem: TMenuItem;
    aTest: TvcmTestEvent): TvcmMainMenuAction;
  public
   property OnTest: TvcmTestEvent
    read f_OnTest
    write f_OnTest;
 end;//TvcmMainMenuAction
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
;

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
{$IfEnd} // NOT Defined(NoVCM)

end.
