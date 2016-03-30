unit vgRemindersLineManager;

// Модуль: "w:\common\components\gui\Garant\VT\vgRemindersLineManager.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvgRemindersLineManager" MUID: (533EABAE0351)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , l3ProtoObject
 , vgRemindersLine
;

type
 TvgRemindersLineManager = class(Tl3ProtoObject)
  public
   class procedure AddLine(aLine: TvgRemindersLine);
   class procedure RemoveLine(aLine: TvgRemindersLine);
   class procedure ClosePopupForms;
   class procedure CheckZOrder;
   class procedure LockActivateProcessing;
   class procedure UnlockActivateProcessing;
   class procedure UpdateRemindersActions;
 end;//TvgRemindersLineManager
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 , vgRemindersLineList
 , NewRemindersInterfaces
;

class procedure TvgRemindersLineManager.AddLine(aLine: TvgRemindersLine);
//#UC START# *533EACEE02DC_533EABAE0351_var*
//#UC END# *533EACEE02DC_533EABAE0351_var*
begin
//#UC START# *533EACEE02DC_533EABAE0351_impl*
 TvgRemindersLineList.Instance.Add(aLine);
//#UC END# *533EACEE02DC_533EABAE0351_impl*
end;//TvgRemindersLineManager.AddLine

class procedure TvgRemindersLineManager.RemoveLine(aLine: TvgRemindersLine);
//#UC START# *533EAD3F0303_533EABAE0351_var*
//#UC END# *533EAD3F0303_533EABAE0351_var*
begin
//#UC START# *533EAD3F0303_533EABAE0351_impl*
 if TvgRemindersLineList.Exists then
  TvgRemindersLineList.Instance.Remove(aLine);
//#UC END# *533EAD3F0303_533EABAE0351_impl*
end;//TvgRemindersLineManager.RemoveLine

class procedure TvgRemindersLineManager.ClosePopupForms;
//#UC START# *533EAD7C0130_533EABAE0351_var*
var
 I: Integer;
//#UC END# *533EAD7C0130_533EABAE0351_var*
begin
//#UC START# *533EAD7C0130_533EABAE0351_impl*
 if TvgRemindersLineList.Exists then
  for I := 0 to TvgRemindersLineList.Instance.Count - 1 do
   TvgRemindersLineList.Instance[I].ClosePopupForm;
//#UC END# *533EAD7C0130_533EABAE0351_impl*
end;//TvgRemindersLineManager.ClosePopupForms

class procedure TvgRemindersLineManager.CheckZOrder;
//#UC START# *537489FC01AE_533EABAE0351_var*
var
 I: Integer;
//#UC END# *537489FC01AE_533EABAE0351_var*
begin
//#UC START# *537489FC01AE_533EABAE0351_impl*
 if TvgRemindersLineList.Exists then
  for I := 0 to TvgRemindersLineList.Instance.Count - 1 do
   TvgRemindersLineList.Instance[I].CheckZOrder;
//#UC END# *537489FC01AE_533EABAE0351_impl*
end;//TvgRemindersLineManager.CheckZOrder

class procedure TvgRemindersLineManager.LockActivateProcessing;
//#UC START# *5410105B0256_533EABAE0351_var*
var
 I: Integer;
//#UC END# *5410105B0256_533EABAE0351_var*
begin
//#UC START# *5410105B0256_533EABAE0351_impl*
 if TvgRemindersLineList.Exists then
  for I := 0 to TvgRemindersLineList.Instance.Count - 1 do
   TvgRemindersLineList.Instance[I].LockActivateProcessing;
//#UC END# *5410105B0256_533EABAE0351_impl*
end;//TvgRemindersLineManager.LockActivateProcessing

class procedure TvgRemindersLineManager.UnlockActivateProcessing;
//#UC START# *54101F390084_533EABAE0351_var*
var
 I: Integer;
//#UC END# *54101F390084_533EABAE0351_var*
begin
//#UC START# *54101F390084_533EABAE0351_impl*
 if TvgRemindersLineList.Exists then
  for I := 0 to TvgRemindersLineList.Instance.Count - 1 do
   TvgRemindersLineList.Instance[I].UnlockActivateProcessing;
//#UC END# *54101F390084_533EABAE0351_impl*
end;//TvgRemindersLineManager.UnlockActivateProcessing

class procedure TvgRemindersLineManager.UpdateRemindersActions;
//#UC START# *54ED7069021A_533EABAE0351_var*
var
 I: Integer;
//#UC END# *54ED7069021A_533EABAE0351_var*
begin
//#UC START# *54ED7069021A_533EABAE0351_impl*
 if TvgRemindersLineList.Exists then
  for I := 0 to Pred(TvgRemindersLineList.Instance.Count - 1) do
   IvgRemindersLine(TvgRemindersLineList.Instance[I]).UpdateActions;
//#UC END# *54ED7069021A_533EABAE0351_impl*
end;//TvgRemindersLineManager.UpdateRemindersActions
{$IfEnd} // NOT Defined(NoVGScene)

end.
