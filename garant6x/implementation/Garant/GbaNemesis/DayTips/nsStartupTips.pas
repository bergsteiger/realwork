unit nsStartupTips;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DayTips"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/DayTips/nsStartupTips.pas"
// Начат: 2008/02/14 13:46:41
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Интерфейсные элементы::DayTips::DayTips::DayTips::TnsStartupTips
//
// Советик дня
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3TreeInterfaces,
  l3SimpleObject,
  DayTipsInterfaces,
  afwInterfaces,
  l3Interfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _afwApplicationDataUpdate_Parent_ = Tl3SimpleObject;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 TnsStartupTips = class(_afwApplicationDataUpdate_, InsStartupTips)
  {* Советик дня }
 private
 // private fields
   f_TipsTree : Il3SimpleTree;
   f_CurrentNode : Il3SimpleNode;
   f_DontShow : Boolean;
 protected
 // realized methods
   function pm_GetTipCaption: Il3CString;
   function pm_GetDontShow: Boolean;
   procedure pm_SetDontShow(aValue: Boolean);
   procedure Next;
   procedure Prev;
   procedure ShowDetails;
   procedure GotoWeb;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure FinishDataUpdate; override;
 public
 // public methods
   constructor Create; reintroduce;
   class function MakePrim: InsStartupTips; reintroduce;
   class function Make: InsStartupTips;
 end;//TnsStartupTips
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  DataAdapter,
  afwFacade,
  nsConst,
  DynamicTreeUnit,
  DocumentUnit,
  BaseTypesUnit,
  nsTreeStruct,
  SysUtils
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  deTips,
  nsINodeWrap,
  nsExternalObjectPrim,
  nsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

// start class TnsStartupTips

constructor TnsStartupTips.Create;
//#UC START# *49928A97027C_4992891800CF_var*
var
 l_Root: INodeBase;
 l_Path: INodeIndexPath;
 l_Temp: INodeBase;
//#UC END# *49928A97027C_4992891800CF_var*
begin
//#UC START# *49928A97027C_4992891800CF_impl*
 inherited Create;
 with defDataAdapter.NativeAdapter.MakeTipsManager do
 begin
  GetTipsTreeRoot(l_Root);
  GetCurrentTip(l_Path);
  Assert(Assigned(l_Path),'Undefined tips path');
 end;
 f_TipsTree := TnsTreeStruct.Make(l_Root, False);
 l_Root.GetNodeByPath(l_Path, l_Temp);
 if Assigned(l_Temp) then
  f_CurrentNode := TnsINodeWrap.Make(l_Temp);
 f_DontShow := afw.Settings.LoadBoolean(pi_DayTips_DontShowAtStart,
                                        dv_DayTips_DontShowAtStart);
//#UC END# *49928A97027C_4992891800CF_impl*
end;//TnsStartupTips.Create

class function TnsStartupTips.MakePrim: InsStartupTips;
var
 l_Inst : TnsStartupTips;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

class function TnsStartupTips.Make: InsStartupTips;
//#UC START# *4993F1F80032_4992891800CF_var*
//#UC END# *4993F1F80032_4992891800CF_var*
begin
//#UC START# *4993F1F80032_4992891800CF_impl*
 if defDataAdapter.NativeAdapter.MakeTipsManager.IsExist then
  Result := MakePrim
 else
  Result := nil; 
//#UC END# *4993F1F80032_4992891800CF_impl*
end;//TnsStartupTips.Make

function TnsStartupTips.pm_GetTipCaption: Il3CString;
//#UC START# *4991C74701F8_4992891800CFget_var*
//#UC END# *4991C74701F8_4992891800CFget_var*
begin
//#UC START# *4991C74701F8_4992891800CFget_impl*
 if Assigned(f_CurrentNode) then
  Result := nsCStr(f_CurrentNode.Text)
 else
  Result := nil;
//#UC END# *4991C74701F8_4992891800CFget_impl*
end;//TnsStartupTips.pm_GetTipCaption

function TnsStartupTips.pm_GetDontShow: Boolean;
//#UC START# *4991C75C00D5_4992891800CFget_var*
//#UC END# *4991C75C00D5_4992891800CFget_var*
begin
//#UC START# *4991C75C00D5_4992891800CFget_impl*
 Result := f_DontShow;
//#UC END# *4991C75C00D5_4992891800CFget_impl*
end;//TnsStartupTips.pm_GetDontShow

procedure TnsStartupTips.pm_SetDontShow(aValue: Boolean);
//#UC START# *4991C75C00D5_4992891800CFset_var*
//#UC END# *4991C75C00D5_4992891800CFset_var*
begin
//#UC START# *4991C75C00D5_4992891800CFset_impl*
 f_DontShow := aValue;
//#UC END# *4991C75C00D5_4992891800CFset_impl*
end;//TnsStartupTips.pm_SetDontShow

procedure TnsStartupTips.Next;
//#UC START# *4991C7680235_4992891800CF_var*
//#UC END# *4991C7680235_4992891800CF_var*
begin
//#UC START# *4991C7680235_4992891800CF_impl*
 if Assigned(f_CurrentNode) then
 begin
  if f_CurrentNode.IsLast then
   f_CurrentNode := f_TipsTree.RootNode.Child
  else
   f_CurrentNode := f_CurrentNode.Next;
 end;
//#UC END# *4991C7680235_4992891800CF_impl*
end;//TnsStartupTips.Next

procedure TnsStartupTips.Prev;
//#UC START# *4991C76E02ED_4992891800CF_var*
//#UC END# *4991C76E02ED_4992891800CF_var*
begin
//#UC START# *4991C76E02ED_4992891800CF_impl*
 if Assigned(f_CurrentNode) then
 begin
  if f_CurrentNode.IsFirst then
   while not f_CurrentNode.IsLast do
    f_CurrentNode := f_CurrentNode.Next
  else
   f_CurrentNode := f_CurrentNode.Prev;
 end;
//#UC END# *4991C76E02ED_4992891800CF_impl*
end;//TnsStartupTips.Prev

procedure TnsStartupTips.ShowDetails;
//#UC START# *4991C77601E9_4992891800CF_var*
var
 l_Node   : INodeBase;
 l_Entity : IEntityBase;
 l_Doc    : IDocument;
//#UC END# *4991C77601E9_4992891800CF_var*
begin
//#UC START# *4991C77601E9_4992891800CF_impl*
 if Supports(f_CurrentNode, INodeBase, l_Node) then
 Begin
  l_Node.GetEntity(l_Entity);
  if Supports(l_Entity, IDocument, l_Doc) then
   TdmStdRes.OpenDocument(TdeTips.Make(l_Doc), nil);
 end;
//#UC END# *4991C77601E9_4992891800CF_impl*
end;//TnsStartupTips.ShowDetails

procedure TnsStartupTips.GotoWeb;
//#UC START# *4991C78200E7_4992891800CF_var*
//#UC END# *4991C78200E7_4992891800CF_var*
begin
//#UC START# *4991C78200E7_4992891800CF_impl*
 nsDoShellExecute(nsCStr(ciitAdviceOfDay));
//#UC END# *4991C78200E7_4992891800CF_impl*
end;//TnsStartupTips.GotoWeb

procedure TnsStartupTips.Cleanup;
//#UC START# *479731C50290_4992891800CF_var*
//#UC END# *479731C50290_4992891800CF_var*
begin
//#UC START# *479731C50290_4992891800CF_impl*
 f_TipsTree := nil;
 f_CurrentNode := nil;
 if f_DontShow <> afw.Settings.LoadBoolean(pi_DayTips_DontShowAtStart,
                                           dv_DayTips_DontShowAtStart) then
  afw.Settings.SaveBoolean(pi_DayTips_DontShowAtStart, f_DontShow, dv_DayTips_DontShowAtStart);
 inherited;
//#UC END# *479731C50290_4992891800CF_impl*
end;//TnsStartupTips.Cleanup

procedure TnsStartupTips.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4992891800CF_var*
//#UC END# *47EA4E9002C6_4992891800CF_var*
begin
//#UC START# *47EA4E9002C6_4992891800CF_impl*
 f_CurrentNode := nil;
 inherited;
//#UC END# *47EA4E9002C6_4992891800CF_impl*
end;//TnsStartupTips.FinishDataUpdate

{$IfEnd} //not Admin AND not Monitorings

end.