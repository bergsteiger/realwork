unit nscTasksPanelGroupsIterator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscTasksPanelGroupsIterator.pas"
// Начат: 17.01.2011 15:06
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Nemesis::TasksPanel::TnscTasksPanelGroupsIterator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmTaskPanelInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObject,
  nscTasksPanelGroupDescList
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TnscTasksPanelGroupsIterator = class(Tl3ProtoObject {$If not defined(NoVCM)}, IvcmCustOpsGroupsIterator{$IfEnd} //not NoVCM
 )
 private
 // private fields
   f_Groups : TnscTasksPanelGroupDescList;
   f_Current : Integer;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   function Next: IvcmCustOpsGroup;
   {$IfEnd} //not NoVCM
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aGroups: TnscTasksPanelGroupDescList); reintroduce;
   class function Make(aGroups: TnscTasksPanelGroupDescList): IvcmCustOpsGroupsIterator; reintroduce;
     {* Сигнатура фабрики TnscTasksPanelGroupsIterator.Make }
 end;//TnscTasksPanelGroupsIterator
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  nscTasksPanelGroup,
  SysUtils,
  l3Base
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

// start class TnscTasksPanelGroupsIterator

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
end;

{$If not defined(NoVCM)}
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
{$IfEnd} //not NoVCM

procedure TnscTasksPanelGroupsIterator.Cleanup;
//#UC START# *479731C50290_4D3430A7028D_var*
//#UC END# *479731C50290_4D3430A7028D_var*
begin
//#UC START# *479731C50290_4D3430A7028D_impl*
 FreeAndNil(f_Groups);
 inherited;
//#UC END# *479731C50290_4D3430A7028D_impl*
end;//TnscTasksPanelGroupsIterator.Cleanup

{$IfEnd} //Nemesis

end.