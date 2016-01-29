unit ChromeLikeFormTabParamsList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChromeLikeControls"
// Модуль: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeFormTabParamsList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeTabSet::TChromeLikeFormTabParamsList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3ProtoObject,
  l3ProtoDataContainer,
  l3TabbedContainersDispatcher,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
type
 _ItemType_ = Il3FormTabParams;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TChromeLikeFormTabParamsList = class(_l3InterfaceRefList_)
 private
 // private methods
   function FindFormTabParams(aForm: TForm): Il3FormTabParams;
   function MakeParamsItem(aForm: TForm;
     const aParams: Il3TabParams): Il3FormTabParams;
 public
 // public methods
   procedure SetFormParams(aForm: TForm;
     const aParams: Il3TabParams);
   function GetFormParams(aForm: TForm): Il3TabParams;
   procedure DeleteFormParams(aForm: TForm);
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TChromeLikeFormTabParamsList;
    {- возвращает экземпляр синглетона. }
 end;//TChromeLikeFormTabParamsList
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3Base {a},
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}


// start class TChromeLikeFormTabParamsList

var g_TChromeLikeFormTabParamsList : TChromeLikeFormTabParamsList = nil;

procedure TChromeLikeFormTabParamsListFree;
begin
 l3Free(g_TChromeLikeFormTabParamsList);
end;

class function TChromeLikeFormTabParamsList.Instance: TChromeLikeFormTabParamsList;
begin
 if (g_TChromeLikeFormTabParamsList = nil) then
 begin
  l3System.AddExitProc(TChromeLikeFormTabParamsListFree);
  g_TChromeLikeFormTabParamsList := Create;
 end;
 Result := g_TChromeLikeFormTabParamsList;
end;


type _Instance_R_ = TChromeLikeFormTabParamsList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

type
  TChromeLikeFormTabParamsItem = class(Tl3ProtoObject, Il3FormTabParams)
  private
  // private fields
   f_Params : Il3TabParams;
   f_Form : TForm;
  protected
  // realized methods
   function pm_GetParams: Il3TabParams;
   function pm_GetForm: TForm;
   procedure Update(const aParams: Il3TabParams);
  protected
  // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
  public
  // public methods
   constructor Create(aForm: TForm;
      const aParams: Il3TabParams); reintroduce;
   class function Make(aForm: TForm;
      const aParams: Il3TabParams): Il3FormTabParams; reintroduce;
     {* Сигнатура фабрики TChromeLikeFormTabParamsItem.Make }
  end;//TChromeLikeFormTabParamsItem

// start class TChromeLikeFormTabParamsItem

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
end;

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
//#UC START# *479731C50290_55260AB7022B_var*
//#UC END# *479731C50290_55260AB7022B_var*
begin
//#UC START# *479731C50290_55260AB7022B_impl*
 f_Params := nil;
 f_Form := nil;
 inherited;
//#UC END# *479731C50290_55260AB7022B_impl*
end;//TChromeLikeFormTabParamsItem.Cleanup

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

class function TChromeLikeFormTabParamsList.Exists: Boolean;
 {-}
begin
 Result := g_TChromeLikeFormTabParamsList <> nil;
end;//TChromeLikeFormTabParamsList.Exists

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.