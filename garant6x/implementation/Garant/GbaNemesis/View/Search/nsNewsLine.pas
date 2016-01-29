unit nsNewsLine;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/nsNewsLine.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Пользовательские сервисы::Autoreferat::View::Search::TnsNewsLine
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
  DynamicTreeUnit
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3SimpleDataContainer,
  PrimeInterfaces,
  l3ProtoObject,
  nsNotificationManager,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes,
  afwInterfaces,
  l3TreeInterfaces,
  DocumentUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _ItemType_ = InsNewsLineNotifier;
 _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TnsNewsLineSubscribersList = class(_l3InterfacePtrList_)
 end;//TnsNewsLineSubscribersList

 _afwApplicationDataUpdate_Parent_ = Tl3ProtoObject;
{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 TnsNewsLinePrim = class(_afwApplicationDataUpdate_, InsNewsLine, InsNotificationListener)
 private
 // private fields
   f_Root : INodeBase;
   f_CurrentThemeIndex : Integer;
   f_ThemeCount : Integer;
   f_ThemeList : IvcmStrings;
   f_Subscribers : TnsNewsLineSubscribersList;
   f_CurrentThemeNode : INodeBase;
    {* Поле для свойства CurrentThemeNode}
 private
 // private methods
   procedure LoadThemeList;
     {* Сигнатура метода LoadThemeList }
   procedure SetCurrentThemeIndex(anIndex: Integer);
   procedure NotifySubscribers;
     {* Сигнатура метода NotifySubscribers }
   procedure DoDataUpdate(aSaveCurrentTheme: Boolean);
 protected
 // property methods
   function pm_GetCurrentThemeNode: INodeBase;
 protected
 // realized methods
   procedure SaveThemeToSettings;
   procedure LoadThemeFromSettings;
   procedure Subscribe(const aNotifier: InsNewsLineNotifier);
   procedure UnSubscribe(const aNotifier: InsNewsLineNotifier);
   function pm_GetThemeList: IafwStrings;
   function pm_GetCurrentTheme: Il3CString;
   procedure pm_SetCurrentTheme(const aValue: Il3CString);
   function MakeCurrentThemeTreeStruct: Il3SimpleTree;
     {* Создать TreeStruct для текущей ленты }
   function ExtractAutoreferat(const aNode: Il3SimpleNode): IDocument;
   procedure NsNotification(aType: TnsNotificationType);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure FinishDataUpdate; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create; reintroduce;
     {* Сигнатура метода Create }
   class function Make: InsNewsLine; reintroduce;
     {* Сигнатура фабрики TnsNewsLinePrim.Make }
 private
 // private properties
   property CurrentThemeNode: INodeBase
     read pm_GetCurrentThemeNode;
 end;//TnsNewsLinePrim

 TnsNewsLine = {final} class(TnsNewsLinePrim)
 public
 // public methods
   class function Make: InsNewsLine; reintroduce;
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsNewsLine
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  l3MinMax,
  RTLConsts,
  SysUtils,
  afwFacade,
  IOUnit,
  BaseTypesUnit,
  nsTypes,
  DataAdapter
  {$If not defined(NoVCM)}
  ,
  vcmStringList
  {$IfEnd} //not NoVCM
  ,
  nsTreeStruct,
  nsConst
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TnsNewsLineSubscribersList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

// start class TnsNewsLinePrim

procedure TnsNewsLinePrim.LoadThemeList;
//#UC START# *524D3FAC00F2_524D3E260036_var*
var
 I: Integer;
 l_Theme: INodeBase;
 l_Name: IString;
//#UC END# *524D3FAC00F2_524D3E260036_var*
begin
//#UC START# *524D3FAC00F2_524D3E260036_impl*
 if (f_Root = nil) and defDataAdapter.Monitoring.IsExist then
  defDataAdapter.Monitoring.GetNewsLineRoot(f_Root);

 if Assigned(f_Root) then
 begin
  f_ThemeCount := f_Root.GetChildCount;
  if (f_ThemeCount > 0) then
   f_CurrentThemeIndex := 0;
   for I := 0 to Pred(f_ThemeCount) do
   begin
    try
     f_Root.GetByVisibleIndex(I + 1, l_Theme);
    except
     on EStorageLocked do
     // http://mdp.garant.ru/pages/viewpage.action?pageId=294597335
     begin
      f_ThemeCount := 0;
      f_ThemeList.Clear;
      Exit;
     end;//EStorageLocked
    end;//try..except
    try
     l_Theme.GetCaption(l_Name);
     try
      f_ThemeList.Add(nsCStr(l_Name));
     finally
      l_Name := nil;
     end;//try..finally
    finally
     l_Theme := nil;
    end;//try..finally
   end;//for I
 end;//f_Root <> nil
//#UC END# *524D3FAC00F2_524D3E260036_impl*
end;//TnsNewsLinePrim.LoadThemeList

procedure TnsNewsLinePrim.SetCurrentThemeIndex(anIndex: Integer);
//#UC START# *524D3FC101AA_524D3E260036_var*
//#UC END# *524D3FC101AA_524D3E260036_var*
begin
//#UC START# *524D3FC101AA_524D3E260036_impl*
 if (anIndex >= 0) and
    (f_CurrentThemeIndex <> anIndex) then
 begin
  f_CurrentThemeIndex := anIndex;
  if f_CurrentThemeNode <> nil then
   f_CurrentThemeNode.SetFlag(FM_OPEN, False);
  f_CurrentThemeNode := nil;
 end;//anIndex >= 0
//#UC END# *524D3FC101AA_524D3E260036_impl*
end;//TnsNewsLinePrim.SetCurrentThemeIndex

procedure TnsNewsLinePrim.NotifySubscribers;
//#UC START# *524D590B0136_524D3E260036_var*
var
 l_IDX: Integer;
//#UC END# *524D590B0136_524D3E260036_var*
begin
//#UC START# *524D590B0136_524D3E260036_impl*
 if Assigned(f_Subscribers) then
  for l_IDX := 0 to f_Subscribers.Count - 1 do
   f_Subscribers.Items[l_IDX].DataChanged;
//#UC END# *524D590B0136_524D3E260036_impl*
end;//TnsNewsLinePrim.NotifySubscribers

procedure TnsNewsLinePrim.DoDataUpdate(aSaveCurrentTheme: Boolean);
//#UC START# *54366C58003B_524D3E260036_var*
var
 l_SavedTheme: Il3CString;
//#UC END# *54366C58003B_524D3E260036_var*
begin
//#UC START# *54366C58003B_524D3E260036_impl*
 if aSaveCurrentTheme then
  l_SavedTheme := pm_GetCurrentTheme;

 f_Root := nil;
 f_CurrentThemeNode := nil;
 f_CurrentThemeIndex := -1;
 f_ThemeList := nil;
// if Assigned(f_ThemeList) then
// begin
//  f_ThemeList.Clear;
//  LoadThemeList;
// end
// else
  pm_GetThemeList;

 if aSaveCurrentTheme then
  pm_SetCurrentTheme(l_SavedTheme);
  
 NotifySubscribers;
//#UC END# *54366C58003B_524D3E260036_impl*
end;//TnsNewsLinePrim.DoDataUpdate

constructor TnsNewsLinePrim.Create;
//#UC START# *524D3EAE02E1_524D3E260036_var*
//#UC END# *524D3EAE02E1_524D3E260036_var*
begin
//#UC START# *524D3EAE02E1_524D3E260036_impl*
 inherited Create;
 f_CurrentThemeIndex := -1;
//#UC END# *524D3EAE02E1_524D3E260036_impl*
end;//TnsNewsLinePrim.Create

class function TnsNewsLinePrim.Make: InsNewsLine;
var
 l_Inst : TnsNewsLinePrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsNewsLinePrim.pm_GetCurrentThemeNode: INodeBase;
//#UC START# *524D3F740063_524D3E260036get_var*
//#UC END# *524D3F740063_524D3E260036get_var*
begin
//#UC START# *524D3F740063_524D3E260036get_impl*
 Assert(Assigned(f_Root));
 if (f_CurrentThemeNode = nil) and
    (f_CurrentThemeIndex >= 0) then
 begin
  try
   f_Root.GetByVisibleIndex(f_CurrentThemeIndex + 1, f_CurrentThemeNode);
  except
   on EStorageLocked do
   // http://mdp.garant.ru/pages/viewpage.action?pageId=294597335
   begin
    f_CurrentThemeNode := nil;
    Result := nil;
    Exit;
   end;//EStorageLocked
  end;//try..except 
  f_CurrentThemeNode.SetFlag(FM_OPEN, True);
 end;//f_CurrentThemeNode = nil
 Result := f_CurrentThemeNode;
//#UC END# *524D3F740063_524D3E260036get_impl*
end;//TnsNewsLinePrim.pm_GetCurrentThemeNode

procedure TnsNewsLinePrim.SaveThemeToSettings;
//#UC START# *49918CE0025D_524D3E260036_var*
//#UC END# *49918CE0025D_524D3E260036_var*
begin
//#UC START# *49918CE0025D_524D3E260036_impl*
 if (f_Root <> nil) and (CurrentThemeNode <> nil) then
  CurrentThemeNode.SaveInSetting(nsAStr(pi_Monitorings_Active_Theme));
//#UC END# *49918CE0025D_524D3E260036_impl*
end;//TnsNewsLinePrim.SaveThemeToSettings

procedure TnsNewsLinePrim.LoadThemeFromSettings;
//#UC START# *49918CE900C9_524D3E260036_var*
var
 l_Setting: ISettingEntity;
 l_Theme: INodeBase;
 l_Index: LongInt;
//#UC END# *49918CE900C9_524D3E260036_var*
begin
//#UC START# *49918CE900C9_524D3E260036_impl*
 if (f_Root <> nil) then
 begin
  try
   f_Root.LoadFromSetting(nsAStr(pi_Monitorings_Active_Theme), l_Setting);
  except
   on EStorageLocked do
   // http://mdp.garant.ru/pages/viewpage.action?pageId=294597335
   begin
    f_Root := nil;
    Exit;
   end;//try..except
  end;//try..except
  if Supports(l_Setting, INodeBase, l_Theme) and
     (l_Theme.GetLevel = 1) then
  begin
   try
    l_Index := l_Theme.GetIndexFromParent;
   except
    on ENotFound do
     l_Index := -1; // Ничего не нашли, вернем -1
   end;//try..except
   if (l_Index > 0) then
   begin
    SetCurrentThemeIndex(l_Index - 1);
    Exit;
   end;//l_Index > 0
  end;//Supports(l_Setting, INodeBase, l_Theme)

  if f_Root.GetChildCount > 0 then
   // как минимум есть тематика "Все мониторинги"
   SetCurrentThemeIndex(0)
  else
   SetCurrentThemeIndex(-1);
 end;//f_Root <> nil
//#UC END# *49918CE900C9_524D3E260036_impl*
end;//TnsNewsLinePrim.LoadThemeFromSettings

procedure TnsNewsLinePrim.Subscribe(const aNotifier: InsNewsLineNotifier);
//#UC START# *49918CFD0326_524D3E260036_var*
//#UC END# *49918CFD0326_524D3E260036_var*
begin
//#UC START# *49918CFD0326_524D3E260036_impl*
 if f_Subscribers = nil then
  f_Subscribers := TnsNewsLineSubscribersList.Make;
 if (f_Subscribers.IndexOf(aNotifier) = -1) then
  f_Subscribers.Add(aNotifier);
//#UC END# *49918CFD0326_524D3E260036_impl*
end;//TnsNewsLinePrim.Subscribe

procedure TnsNewsLinePrim.UnSubscribe(const aNotifier: InsNewsLineNotifier);
//#UC START# *49918D0B03A3_524D3E260036_var*
//#UC END# *49918D0B03A3_524D3E260036_var*
begin
//#UC START# *49918D0B03A3_524D3E260036_impl*
 //Assert(Assigned(f_Subscribers));
 if (f_Subscribers <> nil) then
  f_Subscribers.Remove(aNotifier);
//#UC END# *49918D0B03A3_524D3E260036_impl*
end;//TnsNewsLinePrim.UnSubscribe

function TnsNewsLinePrim.pm_GetThemeList: IafwStrings;
//#UC START# *49918D340382_524D3E260036get_var*
//#UC END# *49918D340382_524D3E260036get_var*
begin
//#UC START# *49918D340382_524D3E260036get_impl*
 if not Assigned(f_ThemeList) then
 begin
  f_ThemeList := TvcmStringList.Make;
  LoadThemeList;
 end;
 Result := f_ThemeList;
//#UC END# *49918D340382_524D3E260036get_impl*
end;//TnsNewsLinePrim.pm_GetThemeList

function TnsNewsLinePrim.pm_GetCurrentTheme: Il3CString;
//#UC START# *49918D570335_524D3E260036get_var*
//#UC END# *49918D570335_524D3E260036get_var*
begin
//#UC START# *49918D570335_524D3E260036get_impl*
 if not Assigned(f_ThemeList) then
  pm_GetThemeList;
 if (f_CurrentThemeIndex >= 0) and
    (f_CurrentThemeIndex < f_ThemeList.Count) then
  Result := f_ThemeList.ItemC[f_CurrentThemeIndex]
 else
  Result := nil;
//#UC END# *49918D570335_524D3E260036get_impl*
end;//TnsNewsLinePrim.pm_GetCurrentTheme

procedure TnsNewsLinePrim.pm_SetCurrentTheme(const aValue: Il3CString);
//#UC START# *49918D570335_524D3E260036set_var*
//#UC END# *49918D570335_524D3E260036set_var*
begin
//#UC START# *49918D570335_524D3E260036set_impl*
 SetCurrentThemeIndex(f_ThemeList.IndexOf(aValue));
//#UC END# *49918D570335_524D3E260036set_impl*
end;//TnsNewsLinePrim.pm_SetCurrentTheme

function TnsNewsLinePrim.MakeCurrentThemeTreeStruct: Il3SimpleTree;
//#UC START# *49F7028D024F_524D3E260036_var*
//#UC END# *49F7028D024F_524D3E260036_var*
begin
//#UC START# *49F7028D024F_524D3E260036_impl*
 if TnsNewsLine.Make.ThemeList.Count > 0 then
  Result := TnsTreeStruct.Make(CurrentThemeNode, False, True)
 else
  Result := nil;
//#UC END# *49F7028D024F_524D3E260036_impl*
end;//TnsNewsLinePrim.MakeCurrentThemeTreeStruct

function TnsNewsLinePrim.ExtractAutoreferat(const aNode: Il3SimpleNode): IDocument;
//#UC START# *49F7F4E603A4_524D3E260036_var*
var
 l_Node: INodeBase;
 l_Entity: IEntityBase;
//#UC END# *49F7F4E603A4_524D3E260036_var*
begin
//#UC START# *49F7F4E603A4_524D3E260036_impl*
 Result := nil;
 if Supports(aNode, INodeBase, l_Node) then
 begin
  l_Node.GetEntity(l_Entity);
  Supports(l_Entity, IDocument, Result);
 end;
//#UC END# *49F7F4E603A4_524D3E260036_impl*
end;//TnsNewsLinePrim.ExtractAutoreferat

procedure TnsNewsLinePrim.NsNotification(aType: TnsNotificationType);
//#UC START# *542BF11D00B6_524D3E260036_var*
//#UC END# *542BF11D00B6_524D3E260036_var*
begin
//#UC START# *542BF11D00B6_524D3E260036_impl*
 if aType = ntMonitoringUpdate then
  DoDataUpdate(True);
//#UC END# *542BF11D00B6_524D3E260036_impl*
end;//TnsNewsLinePrim.NsNotification

procedure TnsNewsLinePrim.Cleanup;
//#UC START# *479731C50290_524D3E260036_var*
//#UC END# *479731C50290_524D3E260036_var*
begin
//#UC START# *479731C50290_524D3E260036_impl*
 TnsNotificationManager.RemoveListener(Self);
 f_Root := nil;
 f_CurrentThemeNode := nil;
 f_ThemeList := nil;
 f_CurrentThemeIndex := -1;
 FreeAndNil(f_Subscribers);
 inherited;
//#UC END# *479731C50290_524D3E260036_impl*
end;//TnsNewsLinePrim.Cleanup

procedure TnsNewsLinePrim.InitFields;
//#UC START# *47A042E100E2_524D3E260036_var*
//#UC END# *47A042E100E2_524D3E260036_var*
begin
//#UC START# *47A042E100E2_524D3E260036_impl*
 inherited;
 TnsNotificationManager.AddListener(Self);
//#UC END# *47A042E100E2_524D3E260036_impl*
end;//TnsNewsLinePrim.InitFields

procedure TnsNewsLinePrim.FinishDataUpdate;
//#UC START# *47EA4E9002C6_524D3E260036_var*
//#UC END# *47EA4E9002C6_524D3E260036_var*
begin
//#UC START# *47EA4E9002C6_524D3E260036_impl*
 DoDataUpdate(False);
//#UC END# *47EA4E9002C6_524D3E260036_impl*
end;//TnsNewsLinePrim.FinishDataUpdate

procedure TnsNewsLinePrim.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_CurrentThemeNode := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsNewsLinePrim.ClearFields

var g_TnsNewsLine : Pointer = nil;

procedure TnsNewsLineFree;
begin
 IUnknown(g_TnsNewsLine) := nil;
end;


class function TnsNewsLine.Make: InsNewsLine;
begin
 if (g_TnsNewsLine = nil) then
 begin
  l3System.AddExitProc(TnsNewsLineFree);
  InsNewsLine(g_TnsNewsLine) := inherited Make;
 end;
 Result := InsNewsLine(g_TnsNewsLine);
end;

class function TnsNewsLine.Exists: Boolean;
 {-}
begin
 Result := g_TnsNewsLine <> nil;
end;//TnsNewsLine.Exists

{$IfEnd} //not Admin AND not Monitorings

end.