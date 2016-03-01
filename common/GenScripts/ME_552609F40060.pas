unit ChromeLikeFormTabParamsList;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeFormTabParamsList.pas"
// Стереотип: "SimpleClass"

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3TabbedContainersDispatcher
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Il3FormTabParams;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TChromeLikeFormTabParamsList = class(_l3InterfaceRefList_)
  private
   function FindFormTabParams(aForm: TForm): Il3FormTabParams;
   function MakeParamsItem(aForm: TForm;
    const aParams: Il3TabParams): Il3FormTabParams;
  public
   procedure SetFormParams(aForm: TForm;
    const aParams: Il3TabParams);
   function GetFormParams(aForm: TForm): Il3TabParams;
   procedure DeleteFormParams(aForm: TForm);
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TChromeLikeFormTabParamsList;
    {* Метод получения экземпляра синглетона TChromeLikeFormTabParamsList }
 end;//TChromeLikeFormTabParamsList
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , l3ProtoObject
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type
 TChromeLikeFormTabParamsItem = class(Tl3ProtoObject, Il3FormTabParams)
  private
   f_Params: Il3TabParams;
   f_Form: TForm;
  protected
   function pm_GetParams: Il3TabParams;
   function pm_GetForm: TForm;
   procedure Update(const aParams: Il3TabParams);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aForm: TForm;
    const aParams: Il3TabParams); reintroduce;
   class function Make(aForm: TForm;
    const aParams: Il3TabParams): Il3FormTabParams; reintroduce;
 end;//TChromeLikeFormTabParamsItem

var g_TChromeLikeFormTabParamsList: TChromeLikeFormTabParamsList = nil;
 {* Экземпляр синглетона TChromeLikeFormTabParamsList }

procedure TChromeLikeFormTabParamsListFree;
 {* Метод освобождения экземпляра синглетона TChromeLikeFormTabParamsList }
begin
 l3Free(g_TChromeLikeFormTabParamsList);
end;//TChromeLikeFormTabParamsListFree

constructor TChromeLikeFormTabParamsItem.Create(aForm: TForm;
 const aParams: Il3TabParams);
//#UC START# *55260B8B0071_55260AB7022B_var*
//#UC END# *55260B8B0071_55260AB7022B_var*
begin
//#UC START# *55260B8B0071_55260AB7022B_impl*
 Assert(aForm <> nil);
 Assert(aParams <> nil);
 inherited Create;
 f_Form := aForm;
 f_Params := aParams;
//#UC END# *55260B8B0071_55260AB7022B_impl*
end;//TChromeLikeFormTabParamsItem.Create

class function TChromeLikeFormTabParamsItem.Make(aForm: TForm;
 const aParams: Il3TabParams): Il3FormTabParams;
var
 l_Inst : TChromeLikeFormTabParamsItem;
begin
 l_Inst := Create(aForm, aParams);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TChromeLikeFormTabParamsItem.Make

function TChromeLikeFormTabParamsItem.pm_GetParams: Il3TabParams;
//#UC START# *55260C7502E1_55260AB7022Bget_var*
//#UC END# *55260C7502E1_55260AB7022Bget_var*
begin
//#UC START# *55260C7502E1_55260AB7022Bget_impl*
 Result := f_Params;
 Assert(Result <> nil);
//#UC END# *55260C7502E1_55260AB7022Bget_impl*
end;//TChromeLikeFormTabParamsItem.pm_GetParams

function TChromeLikeFormTabParamsItem.pm_GetForm: TForm;
//#UC START# *55260C8102CA_55260AB7022Bget_var*
//#UC END# *55260C8102CA_55260AB7022Bget_var*
begin
//#UC START# *55260C8102CA_55260AB7022Bget_impl*
 Result := f_Form;
 Assert(Result <> nil);
//#UC END# *55260C8102CA_55260AB7022Bget_impl*
end;//TChromeLikeFormTabParamsItem.pm_GetForm

procedure TChromeLikeFormTabParamsItem.Update(const aParams: Il3TabParams);
//#UC START# *55261F0F00EB_55260AB7022B_var*
//#UC END# *55261F0F00EB_55260AB7022B_var*
begin
//#UC START# *55261F0F00EB_55260AB7022B_impl*
 f_Params := aParams;
//#UC END# *55261F0F00EB_55260AB7022B_impl*
end;//TChromeLikeFormTabParamsItem.Update

procedure TChromeLikeFormTabParamsItem.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55260AB7022B_var*
//#UC END# *479731C50290_55260AB7022B_var*
begin
//#UC START# *479731C50290_55260AB7022B_impl*
 f_Params := nil;
 f_Form := nil;
 inherited;
//#UC END# *479731C50290_55260AB7022B_impl*
end;//TChromeLikeFormTabParamsItem.Cleanup

type _Instance_R_ = TChromeLikeFormTabParamsList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

procedure TChromeLikeFormTabParamsList.SetFormParams(aForm: TForm;
 const aParams: Il3TabParams);
//#UC START# *55260D5602B1_552609F40060_var*
var
 l_Params: Il3FormTabParams;
//#UC END# *55260D5602B1_552609F40060_var*
begin
//#UC START# *55260D5602B1_552609F40060_impl*
 Assert(aForm <> nil);
 Assert(aParams <> nil);
 l_Params := FindFormTabParams(aForm);
 if (l_Params = nil) then
  l_Params := MakeParamsItem(aForm, aParams)
 else
  l_Params.Update(aParams);
//#UC END# *55260D5602B1_552609F40060_impl*
end;//TChromeLikeFormTabParamsList.SetFormParams

function TChromeLikeFormTabParamsList.GetFormParams(aForm: TForm): Il3TabParams;
//#UC START# *55260D6C0245_552609F40060_var*
var
 l_FormParams: Il3FormTabParams;
//#UC END# *55260D6C0245_552609F40060_var*
begin
//#UC START# *55260D6C0245_552609F40060_impl*
 Assert(aForm <> nil);
 Result := nil;
 l_FormParams := FindFormTabParams(aForm);
 if (l_FormParams <> nil) then
  Result := l_FormParams.Params;
//#UC END# *55260D6C0245_552609F40060_impl*
end;//TChromeLikeFormTabParamsList.GetFormParams

procedure TChromeLikeFormTabParamsList.DeleteFormParams(aForm: TForm);
//#UC START# *55260DC5010D_552609F40060_var*
var
 l_Index: Integer;
//#UC END# *55260DC5010D_552609F40060_var*
begin
//#UC START# *55260DC5010D_552609F40060_impl*
 for l_Index := 0 to Pred(Count) do
  if (Items[l_Index].Form = aForm) then
  begin
   Delete(l_Index);
   Break;
  end;
//#UC END# *55260DC5010D_552609F40060_impl*
end;//TChromeLikeFormTabParamsList.DeleteFormParams

function TChromeLikeFormTabParamsList.FindFormTabParams(aForm: TForm): Il3FormTabParams;
//#UC START# *55260E100131_552609F40060_var*
var
 l_FormParams: Il3FormTabParams;

 function lp_DoFindFormTab(anItem: Pointer; anIndex: Integer): Boolean;
 var
  l_Item: Il3FormTabParams;
 begin
  l_Item := Il3FormTabParams(anItem^);
  if (l_Item.Form = aForm) then
  begin
   l_FormParams := l_Item;
   Result := False;
  end
  else
   Result := True;
 end;

//#UC END# *55260E100131_552609F40060_var*
begin
//#UC START# *55260E100131_552609F40060_impl*
 Assert(aForm <> nil);
 l_FormParams := nil;
 IterateAllF(l3L2IA(@lp_DoFindFormTab));
 Result := l_FormParams;
//#UC END# *55260E100131_552609F40060_impl*
end;//TChromeLikeFormTabParamsList.FindFormTabParams

function TChromeLikeFormTabParamsList.MakeParamsItem(aForm: TForm;
 const aParams: Il3TabParams): Il3FormTabParams;
//#UC START# *55260E320249_552609F40060_var*
//#UC END# *55260E320249_552609F40060_var*
begin
//#UC START# *55260E320249_552609F40060_impl*
 Assert(aForm <> nil);
 Assert(aParams <> nil);
 Result := TChromeLikeFormTabParamsItem.Make(aForm, aParams);
//#UC END# *55260E320249_552609F40060_impl*
end;//TChromeLikeFormTabParamsList.MakeParamsItem

class function TChromeLikeFormTabParamsList.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TChromeLikeFormTabParamsList <> nil;
end;//TChromeLikeFormTabParamsList.Exists

class function TChromeLikeFormTabParamsList.Instance: TChromeLikeFormTabParamsList;
 {* Метод получения экземпляра синглетона TChromeLikeFormTabParamsList }
begin
 if (g_TChromeLikeFormTabParamsList = nil) then
 begin
  l3System.AddExitProc(TChromeLikeFormTabParamsListFree);
  g_TChromeLikeFormTabParamsList := Create;
 end;
 Result := g_TChromeLikeFormTabParamsList;
end;//TChromeLikeFormTabParamsList.Instance
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
