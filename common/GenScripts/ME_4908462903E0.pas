unit nscContextFilterState;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscContextFilterState.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3CacheableBase
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3TreeInterfaces
 , nscNewInterfaces
 , l3Interfaces
;

type
 TnscContextFilterState = class(Tl3CacheableBase{$If NOT Defined(NoVCM)}
 , IvcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , Il3ContextFilterNotifier, InscContextFilterState)
  private
   f_Active: Boolean;
   f_CaretPos: Integer;
   f_NeedRefilterTree: Boolean;
   f_Context: Il3CString;
   f_NotificationSource: Il3ContextFilterNotifySource;
  protected
   procedure RequestReapply;
    {* Желательно переприменить фильтр. }
   procedure RequestClearAndTurnOff;
    {* Дерево выключило на себе фильтр. }
   procedure RequestCheckValid;
    {* Дерево поменялось - нужно проверить валидность фильтра. }
   function pm_GetActive: Boolean;
   function pm_GetContext: Il3CString;
   function pm_GetActiveContext: Il3CString;
   function pm_GetCaretPos: Integer;
   function NeedRefilterTree: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(IsActive: Boolean;
    const aContext: Il3CString;
    aPos: Integer;
    aNeedRefilterTree: Boolean;
    const aContextFilterTarget: Il3ContextFilterTarget); reintroduce;
   class function Make(IsActive: Boolean;
    const aContext: Il3CString;
    aPos: Integer;
    aNeedRefilterTree: Boolean = False;
    const aContextFilterTarget: Il3ContextFilterTarget = nil): InscContextFilterState; reintroduce;
 end;//TnscContextFilterState
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
;

constructor TnscContextFilterState.Create(IsActive: Boolean;
 const aContext: Il3CString;
 aPos: Integer;
 aNeedRefilterTree: Boolean;
 const aContextFilterTarget: Il3ContextFilterTarget);
//#UC START# *4908477B00BE_4908462903E0_var*

 function lp_ExtractNotifySource(const aSource: Il3ContextFilterTarget): Il3ContextFilterNotifySource;
 var
  l_Container: Il3ContextFilterTargetContainer;
  l_ContextTarget: Il3ContextFilterTarget;
 begin
  if Supports(aSource, Il3ContextFilterTargetContainer, l_Container) then
   l_ContextTarget := l_COntainer.Unfold
  else
   l_ContextTarget := aSource;
  Supports(l_ContextTarget, Il3ContextFilterNotifySource, Result);
 end;

//#UC END# *4908477B00BE_4908462903E0_var*
begin
//#UC START# *4908477B00BE_4908462903E0_impl*
 inherited Create;
 f_Active := IsActive;
 f_Context := aContext;
 f_CaretPos := aPos;
 f_NotificationSource := lp_ExtractNotifySource(aContextFilterTarget);
 if Assigned(f_NotificationSource) then
  f_NotificationSource.SubscribeToContextFilter(Self);
 f_NeedRefilterTree := aNeedRefilterTree; 
//#UC END# *4908477B00BE_4908462903E0_impl*
end;//TnscContextFilterState.Create

class function TnscContextFilterState.Make(IsActive: Boolean;
 const aContext: Il3CString;
 aPos: Integer;
 aNeedRefilterTree: Boolean = False;
 const aContextFilterTarget: Il3ContextFilterTarget = nil): InscContextFilterState;
var
 l_Inst : TnscContextFilterState;
begin
 l_Inst := Create(IsActive, aContext, aPos, aNeedRefilterTree, aContextFilterTarget);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnscContextFilterState.Make

procedure TnscContextFilterState.RequestReapply;
 {* Желательно переприменить фильтр. }
//#UC START# *477250FC0040_4908462903E0_var*
//#UC END# *477250FC0040_4908462903E0_var*
begin
//#UC START# *477250FC0040_4908462903E0_impl*
 // DoNothing
//#UC END# *477250FC0040_4908462903E0_impl*
end;//TnscContextFilterState.RequestReapply

procedure TnscContextFilterState.RequestClearAndTurnOff;
 {* Дерево выключило на себе фильтр. }
//#UC START# *4772510D0043_4908462903E0_var*
//#UC END# *4772510D0043_4908462903E0_var*
begin
//#UC START# *4772510D0043_4908462903E0_impl*
 f_Active := False;
 f_Context := nil;
//#UC END# *4772510D0043_4908462903E0_impl*
end;//TnscContextFilterState.RequestClearAndTurnOff

procedure TnscContextFilterState.RequestCheckValid;
 {* Дерево поменялось - нужно проверить валидность фильтра. }
//#UC START# *4772511D0316_4908462903E0_var*
//#UC END# *4772511D0316_4908462903E0_var*
begin
//#UC START# *4772511D0316_4908462903E0_impl*
 // DoNothing
//#UC END# *4772511D0316_4908462903E0_impl*
end;//TnscContextFilterState.RequestCheckValid

function TnscContextFilterState.pm_GetActive: Boolean;
//#UC START# *4908394101EB_4908462903E0get_var*
//#UC END# *4908394101EB_4908462903E0get_var*
begin
//#UC START# *4908394101EB_4908462903E0get_impl*
 Result := f_Active;
//#UC END# *4908394101EB_4908462903E0get_impl*
end;//TnscContextFilterState.pm_GetActive

function TnscContextFilterState.pm_GetContext: Il3CString;
//#UC START# *4908395B027E_4908462903E0get_var*
//#UC END# *4908395B027E_4908462903E0get_var*
begin
//#UC START# *4908395B027E_4908462903E0get_impl*
 Result := f_Context;
//#UC END# *4908395B027E_4908462903E0get_impl*
end;//TnscContextFilterState.pm_GetContext

function TnscContextFilterState.pm_GetActiveContext: Il3CString;
//#UC START# *4908396C014C_4908462903E0get_var*
//#UC END# *4908396C014C_4908462903E0get_var*
begin
//#UC START# *4908396C014C_4908462903E0get_impl*
 if f_Active then
  Result := f_Context
 else
  Result := nil;
//#UC END# *4908396C014C_4908462903E0get_impl*
end;//TnscContextFilterState.pm_GetActiveContext

function TnscContextFilterState.pm_GetCaretPos: Integer;
//#UC START# *4908397A033F_4908462903E0get_var*
//#UC END# *4908397A033F_4908462903E0get_var*
begin
//#UC START# *4908397A033F_4908462903E0get_impl*
 Result := f_CaretPos;
//#UC END# *4908397A033F_4908462903E0get_impl*
end;//TnscContextFilterState.pm_GetCaretPos

function TnscContextFilterState.NeedRefilterTree: Boolean;
//#UC START# *490839F50038_4908462903E0_var*
//#UC END# *490839F50038_4908462903E0_var*
begin
//#UC START# *490839F50038_4908462903E0_impl*
 Result := f_NeedRefilterTree;
//#UC END# *490839F50038_4908462903E0_impl*
end;//TnscContextFilterState.NeedRefilterTree

procedure TnscContextFilterState.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4908462903E0_var*
//#UC END# *479731C50290_4908462903E0_var*
begin
//#UC START# *479731C50290_4908462903E0_impl*
 if Assigned(f_NotificationSource) then
  f_NotificationSource.UnSubscribeFromContextFilter(Self);
 f_NotificationSource := nil; 
 f_Context := nil;
 inherited;
//#UC END# *479731C50290_4908462903E0_impl*
end;//TnscContextFilterState.Cleanup
{$IfEnd} // Defined(Nemesis)

end.
