unit nscTasksPanelGroupsIterator;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscTasksPanelGroupsIterator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnscTasksPanelGroupsIterator" MUID: (4D3430A7028D)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmTaskPanelInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , nscTasksPanelGroupDescList
;

type
 TnscTasksPanelGroupsIterator = class(Tl3ProtoObject{$If NOT Defined(NoVCM)}
 , IvcmCustOpsGroupsIterator
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_Groups: TnscTasksPanelGroupDescList;
   f_Current: Integer;
  protected
   {$If NOT Defined(NoVCM)}
   function Next: IvcmCustOpsGroup;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aGroups: TnscTasksPanelGroupDescList); reintroduce;
   class function Make(aGroups: TnscTasksPanelGroupDescList): IvcmCustOpsGroupsIterator; reintroduce;
 end;//TnscTasksPanelGroupsIterator
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , nscTasksPanelGroup
 , SysUtils
 , l3Base
;

constructor TnscTasksPanelGroupsIterator.Create(aGroups: TnscTasksPanelGroupDescList);
//#UC START# *4D343C3502B5_4D3430A7028D_var*
//#UC END# *4D343C3502B5_4D3430A7028D_var*
begin
//#UC START# *4D343C3502B5_4D3430A7028D_impl*
 inherited Create;
 f_Current := -1;
 l3Set(f_Groups, aGroups);
//#UC END# *4D343C3502B5_4D3430A7028D_impl*
end;//TnscTasksPanelGroupsIterator.Create

class function TnscTasksPanelGroupsIterator.Make(aGroups: TnscTasksPanelGroupDescList): IvcmCustOpsGroupsIterator;
var
 l_Inst : TnscTasksPanelGroupsIterator;
begin
 l_Inst := Create(aGroups);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnscTasksPanelGroupsIterator.Make

{$If NOT Defined(NoVCM)}
function TnscTasksPanelGroupsIterator.Next: IvcmCustOpsGroup;
//#UC START# *4992FE89024F_4D3430A7028D_var*
//#UC END# *4992FE89024F_4D3430A7028D_var*
begin
//#UC START# *4992FE89024F_4D3430A7028D_impl*
 while true do
 begin
  Inc(f_Current);
  if (f_Current < f_Groups.Count) then
  begin
   if f_Groups[f_Current].rControl.Visible then
   begin
    Result := TnscTasksPanelGroup.Make(f_Current, f_Groups[f_Current]);
    break;
   end//f_Groups[f_Current].rControl.Visible
   else
    continue;
  end//f_Current < f_Groups.Count
  else
  begin
   Result := nil;
   break;
  end;//f_Current < f_Groups.Count
 end;//while true
//#UC END# *4992FE89024F_4D3430A7028D_impl*
end;//TnscTasksPanelGroupsIterator.Next
{$IfEnd} // NOT Defined(NoVCM)

procedure TnscTasksPanelGroupsIterator.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4D3430A7028D_var*
//#UC END# *479731C50290_4D3430A7028D_var*
begin
//#UC START# *479731C50290_4D3430A7028D_impl*
 FreeAndNil(f_Groups);
 inherited;
//#UC END# *479731C50290_4D3430A7028D_impl*
end;//TnscTasksPanelGroupsIterator.Cleanup
{$IfEnd} // Defined(Nemesis)

end.
