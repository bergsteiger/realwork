unit vcmBaseEntitiesCollection;

// ћодуль: "w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseEntitiesCollection.pas"
// —тереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmBaseCollection
 , vcmExternalInterfaces
 , vcmBaseEntitiesCollectionItem
 , vcmBase
 , vcmBaseOperationsCollectionItem
 , vcmEntitiesDefList
 , Classes
 , vcmBaseCollectionItem
;

type
 //#UC START# *52A72E6B00B1ci*
 //#UC END# *52A72E6B00B1ci*
 //#UC START# *52A72E6B00B1cit*
 //#UC END# *52A72E6B00B1cit*
 TvcmBaseEntitiesCollection = class(TvcmBaseCollection, IvcmOperationsPublisher)
  protected
   procedure PublishEntity(const anEntity: TvcmString;
    aGetTarget: TvcmControlGetTargetEvent);
    {* опубликовать сущность. }
   function GetAttrCount: Integer; override;
   function GetAttr(Index: Integer): AnsiString; override;
   function GetItemAttr(Index: Integer;
    ItemIndex: Integer): AnsiString; override;
  public
   function PublishFormEntity(const anEntity: TvcmString;
    aGetTarget: TvcmGetTargetEvent): TvcmBaseEntitiesCollectionItem;
    {* опубликовать сущность }
   procedure GroupItemsInContextMenu(const anEntity: TvcmString);
   procedure ToolbarAtBottom(const anEntity: TvcmString);
   procedure ContextMenuWeight(const anEntity: TvcmString;
    aWeight: Integer); overload;
    {* установить вес сущности в контекстном меню }
   procedure ContextMenuWeight(const anEntity: TvcmString;
    const anOperation: TvcmString;
    aWeight: Integer;
    aNoPrefix: Boolean = False); overload;
    {* установить вес операции в контекстном меню }
   procedure PublishOpWithResult(const anEntity: TvcmString;
    const anOperation: TvcmString;
    anExecute: TvcmExecuteEvent;
    aTest: TvcmControlTestEvent;
    aGetState: TvcmControlGetStateEvent;
    aNoPrefix: Boolean = False);
    {* опубликовать операцию }
   function GetOperationByName(const anEntity: TvcmString;
    const anOperation: TvcmString;
    aNoPrefix: Boolean = False): TvcmBaseOperationsCollectionItem;
   procedure ShowInContextMenu(const anEntity: TvcmString;
    const anOperation: TvcmString;
    aValue: Boolean;
    aNoPrefix: Boolean = False);
   procedure ShowInToolbar(const anEntity: TvcmString;
    const anOperation: TvcmString;
    aValue: Boolean;
    aNoPrefix: Boolean = False);
   function CheckEntityForControl(const anEntity: TvcmString): TvcmBaseEntitiesCollectionItem;
   procedure GetEntitiesDef(aList: TvcmEntitiesDefList);
    {* возвращает список описателей сущностей }
   procedure LinkControl(aControl: TComponent);
   procedure UnlinkControl(aControl: TComponent);
   procedure RegisterInRep;
   function IsItemCaptionUnique(aItem: TvcmBaseCollectionItem): Boolean;
    {* поиск операции по названию }
   class function GetItemClass: TCollectionItemClass; override;
 //#UC START# *52A72E6B00B1publ*
  public
   procedure PublishOp(const anEntity: TvcmString;
    const anOperation: TvcmString;
    anExecute: TvcmControlExecuteEvent = nil;
    aTest: TvcmControlTestEvent = nil;
    aGetState: TvcmControlGetStateEvent = nil;
    aNoPrefix: Boolean = false);
     {* ќпубликовать операцию. aNoPrefix - костыль дл€ [$133891300] }
 //#UC END# *52A72E6B00B1publ*
 end;//TvcmBaseEntitiesCollection
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmInterfaces
 , vcmUserControls
 , vcmEntities
 , SysUtils
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TvcmBaseEntitiesCollection.PublishFormEntity(const anEntity: TvcmString;
 aGetTarget: TvcmGetTargetEvent): TvcmBaseEntitiesCollectionItem;
 {* опубликовать сущность }
//#UC START# *560A9E3700DF_52A72E6B00B1_var*
//#UC END# *560A9E3700DF_52A72E6B00B1_var*
begin
//#UC START# *560A9E3700DF_52A72E6B00B1_impl*
 Result := CheckEntityForControl(anEntity);
 if Assigned(aGetTarget) then
  Result.PublishFormEntity(aGetTarget);
//#UC END# *560A9E3700DF_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.PublishFormEntity

procedure TvcmBaseEntitiesCollection.GroupItemsInContextMenu(const anEntity: TvcmString);
//#UC START# *560A9E5C0285_52A72E6B00B1_var*
//#UC END# *560A9E5C0285_52A72E6B00B1_var*
begin
//#UC START# *560A9E5C0285_52A72E6B00B1_impl*
 with CheckEntityForControl(anEntity) do
  Options := Options + [vcm_enoGroupItemsInContextMenu];
//#UC END# *560A9E5C0285_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.GroupItemsInContextMenu

procedure TvcmBaseEntitiesCollection.ToolbarAtBottom(const anEntity: TvcmString);
//#UC START# *560A9E7F00B4_52A72E6B00B1_var*
//#UC END# *560A9E7F00B4_52A72E6B00B1_var*
begin
//#UC START# *560A9E7F00B4_52A72E6B00B1_impl*
 CheckEntityForControl(anEntity).ToolbarPos := vcm_tbpBottom;
//#UC END# *560A9E7F00B4_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.ToolbarAtBottom

procedure TvcmBaseEntitiesCollection.ContextMenuWeight(const anEntity: TvcmString;
 aWeight: Integer);
 {* установить вес сущности в контекстном меню }
//#UC START# *560A9E9E005D_52A72E6B00B1_var*
var
 l_EntitiesCollectionItem: TvcmBaseEntitiesCollectionItem;
//#UC END# *560A9E9E005D_52A72E6B00B1_var*
begin
//#UC START# *560A9E9E005D_52A72E6B00B1_impl*
 l_EntitiesCollectionItem := CheckEntityForControl(anEntity);
 if (l_EntitiesCollectionItem <> nil) then
  l_EntitiesCollectionItem.ContextMenuWeight := aWeight;
//#UC END# *560A9E9E005D_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.ContextMenuWeight

procedure TvcmBaseEntitiesCollection.ContextMenuWeight(const anEntity: TvcmString;
 const anOperation: TvcmString;
 aWeight: Integer;
 aNoPrefix: Boolean = False);
 {* установить вес операции в контекстном меню }
//#UC START# *560A9EC5026F_52A72E6B00B1_var*
var
 l_EntitiesCollectionItem: TvcmBaseEntitiesCollectionItem;
 l_OperationsCollectionItem: TvcmBaseOperationsCollectionItem;
//#UC END# *560A9EC5026F_52A72E6B00B1_var*
begin
//#UC START# *560A9EC5026F_52A72E6B00B1_impl*
 l_EntitiesCollectionItem := CheckEntityForControl(anEntity);
 if (l_EntitiesCollectionItem <> nil) then
 begin
  l_OperationsCollectionItem := GetOperationByName(anEntity, anOperation, aNoPrefix);
  if (l_OperationsCollectionItem <> nil) then
   l_OperationsCollectionItem.ContextMenuWeight := aWeight;
 end;
//#UC END# *560A9EC5026F_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.ContextMenuWeight

procedure TvcmBaseEntitiesCollection.PublishOpWithResult(const anEntity: TvcmString;
 const anOperation: TvcmString;
 anExecute: TvcmExecuteEvent;
 aTest: TvcmControlTestEvent;
 aGetState: TvcmControlGetStateEvent;
 aNoPrefix: Boolean = False);
 {* опубликовать операцию }
//#UC START# *560A9F53006F_52A72E6B00B1_var*
var
 l_Execute: TMethod absolute anExecute;
 l_Test: TMethod absolute aTest;
 l_Control: TComponent;
 l_Op: AnsiString;
 l_En: TvcmBaseEntitiesCollectionItem;
//#UC END# *560A9F53006F_52A72E6B00B1_var*
begin
//#UC START# *560A9F53006F_52A72E6B00B1_impl*
 l_Control := TComponent(l_Execute.Data);
 if (l_Control = nil) then
  l_Control := TComponent(l_Test.Data);
 l_En := CheckEntityForControl(anEntity);
 if (l_Control <> nil) then
 begin
  if aNoPrefix then
   l_Op := anOperation
  else
   l_Op := 'op' + anOperation;
  l_En.PublishOp(l_Control, l_Op, anExecute, aTest, aGetState);
 end;//l_Control <> nil
//#UC END# *560A9F53006F_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.PublishOpWithResult

function TvcmBaseEntitiesCollection.GetOperationByName(const anEntity: TvcmString;
 const anOperation: TvcmString;
 aNoPrefix: Boolean = False): TvcmBaseOperationsCollectionItem;
//#UC START# *560A9F87021C_52A72E6B00B1_var*
var
 l_Op: AnsiString;
//#UC END# *560A9F87021C_52A72E6B00B1_var*
begin
//#UC START# *560A9F87021C_52A72E6B00B1_impl*
 if aNoPrefix then
  l_Op := anOperation
 else
  l_Op := 'op' + anOperation;
 Result := CheckEntityForControl(anEntity).Operations.FindItemByName(l_Op) as TvcmBaseOperationsCollectionItem;
//#UC END# *560A9F87021C_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.GetOperationByName

procedure TvcmBaseEntitiesCollection.ShowInContextMenu(const anEntity: TvcmString;
 const anOperation: TvcmString;
 aValue: Boolean;
 aNoPrefix: Boolean = False);
//#UC START# *560A9FD5004C_52A72E6B00B1_var*
var
 l_Op : TvcmOperationOptions;  
//#UC END# *560A9FD5004C_52A72E6B00B1_var*
begin
//#UC START# *560A9FD5004C_52A72E6B00B1_impl*
 with GetOperationByName(anEntity, anOperation, aNoPrefix) do
 begin
  l_Op := Options;
  if aValue then
   Include(l_Op, vcm_ooShowInContextMenu)
  else
  begin
   Exclude(l_Op, vcm_ooShowInContextMenu);
   if (l_Op = []) then
    Include(l_Op, vcm_ooShowInChildMenu);
  end;//aValue
  Options := l_Op;
 end;//GetOperationByName(anEntity, anOperation, aNoPrefix)
//#UC END# *560A9FD5004C_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.ShowInContextMenu

procedure TvcmBaseEntitiesCollection.ShowInToolbar(const anEntity: TvcmString;
 const anOperation: TvcmString;
 aValue: Boolean;
 aNoPrefix: Boolean = False);
//#UC START# *560AA00103A8_52A72E6B00B1_var*
var
 l_Op : TvcmOperationOptions;  
//#UC END# *560AA00103A8_52A72E6B00B1_var*
begin
//#UC START# *560AA00103A8_52A72E6B00B1_impl*
 with GetOperationByName(anEntity, anOperation, aNoPrefix) do
 begin
  l_Op := Options;
  if aValue then
   Include(l_Op, vcm_ooShowInChildToolbar)
  else
  begin
   Exclude(l_Op, vcm_ooShowInChildToolbar);
   if (l_Op = []) then
    Include(l_Op, vcm_ooShowInChildMenu);
  end;//aValue
  Options := l_Op;
 end;//GetOperationByName(anEntity, anOperation, aNoPrefix)
//#UC END# *560AA00103A8_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.ShowInToolbar

function TvcmBaseEntitiesCollection.CheckEntityForControl(const anEntity: TvcmString): TvcmBaseEntitiesCollectionItem;
//#UC START# *560AA031026A_52A72E6B00B1_var*
var
 l_En: AnsiString;
//#UC END# *560AA031026A_52A72E6B00B1_var*
begin
//#UC START# *560AA031026A_52A72E6B00B1_impl*
 l_En := 'en' + anEntity;
 Result := FindItemByName(l_En) as TvcmBaseEntitiesCollectionItem;
 if (Result = nil) then
 begin
  Result := Add as TvcmBaseEntitiesCollectionItem;
  Result.Name := l_En;
 end;//l_EnI = nil
//#UC END# *560AA031026A_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.CheckEntityForControl

procedure TvcmBaseEntitiesCollection.GetEntitiesDef(aList: TvcmEntitiesDefList);
 {* возвращает список описателей сущностей }
//#UC START# *560AA05F01E7_52A72E6B00B1_var*
var
 l_Index: Integer;
//#UC END# *560AA05F01E7_52A72E6B00B1_var*
begin
//#UC START# *560AA05F01E7_52A72E6B00B1_impl*
 for l_Index := 0 to Pred(Count) do
  aList.Add(TvcmBaseEntitiesCollectionItem(Items[l_Index]).EntityDef);
//#UC END# *560AA05F01E7_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.GetEntitiesDef

procedure TvcmBaseEntitiesCollection.LinkControl(aControl: TComponent);
//#UC START# *560AA09401E0_52A72E6B00B1_var*
var
 l_Provider: IvcmOperationsProvider;
//#UC END# *560AA09401E0_52A72E6B00B1_var*
begin
//#UC START# *560AA09401E0_52A72E6B00B1_impl*
 if (aControl <> nil) then
 begin
  // «арегистрируем операции
  if Supports(aControl, IvcmOperationsProvider, l_Provider) then
  try
   l_Provider.ProvideOps(Self);
  finally
   l_Provider := nil;
  end;//try..finally
 end;//aControl <> nil
//#UC END# *560AA09401E0_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.LinkControl

procedure TvcmBaseEntitiesCollection.UnlinkControl(aControl: TComponent);
//#UC START# *560AA0B60313_52A72E6B00B1_var*
var
 l_Index: Integer;
 l_Item: TvcmBaseEntitiesCollectionItem;
//#UC END# *560AA0B60313_52A72E6B00B1_var*
begin
//#UC START# *560AA0B60313_52A72E6B00B1_impl*
 if (aControl <> nil) then
 begin
  for l_Index := 0 to Pred(Count) do
  begin
   l_Item := TvcmBaseEntitiesCollectionItem(Items[l_Index]);
   l_Item.SupportedBy[aControl] := False;
  end;//for l_Index
 end;//aControl <> nil
//#UC END# *560AA0B60313_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.UnlinkControl

procedure TvcmBaseEntitiesCollection.RegisterInRep;
//#UC START# *560AA0C50016_52A72E6B00B1_var*
var
 l_Index: Integer;
//#UC END# *560AA0C50016_52A72E6B00B1_var*
begin
//#UC START# *560AA0C50016_52A72E6B00B1_impl*
 for l_Index := 0 to Pred(Count) do
  TvcmBaseEntitiesCollectionItem(Items[l_Index]).RegisterInRep;
//#UC END# *560AA0C50016_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.RegisterInRep

function TvcmBaseEntitiesCollection.IsItemCaptionUnique(aItem: TvcmBaseCollectionItem): Boolean;
 {* поиск операции по названию }
//#UC START# *560AA0E20102_52A72E6B00B1_var*
var
 l_Index: Integer;
//#UC END# *560AA0E20102_52A72E6B00B1_var*
begin
//#UC START# *560AA0E20102_52A72E6B00B1_impl*
 Result := True;
 // “олько дл€ сущностей форм
 if Owner is TvcmEntities then
  for l_Index := 0 to Pred(Count) do
   with TvcmBaseEntitiesCollectionItem(Items[l_Index]) do
    if not IsItemCaptionUnique(aItem) then
    begin
     Result := False;
     Break;
    end;//if IsItemCaptionUnique(aCaption) then
//#UC END# *560AA0E20102_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.IsItemCaptionUnique

procedure TvcmBaseEntitiesCollection.PublishEntity(const anEntity: TvcmString;
 aGetTarget: TvcmControlGetTargetEvent);
 {* опубликовать сущность. }
//#UC START# *476954790060_52A72E6B00B1_var*
var
 l_M: TMethod absolute aGetTarget;
 l_Control: TComponent;
 l_En: TvcmBaseEntitiesCollectionItem;
//#UC END# *476954790060_52A72E6B00B1_var*
begin
//#UC START# *476954790060_52A72E6B00B1_impl*
 l_En := CheckEntityForControl(anEntity);
 l_Control := TComponent(l_M.Data);
 if (l_Control <> nil) then
  l_En.PublishEntity(l_Control, aGetTarget);
//#UC END# *476954790060_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.PublishEntity

class function TvcmBaseEntitiesCollection.GetItemClass: TCollectionItemClass;
//#UC START# *5607EE71032D_52A72E6B00B1_var*
//#UC END# *5607EE71032D_52A72E6B00B1_var*
begin
//#UC START# *5607EE71032D_52A72E6B00B1_impl*
 Result := TvcmBaseEntitiesCollectionItem;
//#UC END# *5607EE71032D_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.GetItemClass

function TvcmBaseEntitiesCollection.GetAttrCount: Integer;
//#UC START# *560A9DA80335_52A72E6B00B1_var*
//#UC END# *560A9DA80335_52A72E6B00B1_var*
begin
//#UC START# *560A9DA80335_52A72E6B00B1_impl*
 Result := inherited GetAttrCount + 2;
//#UC END# *560A9DA80335_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.GetAttrCount

function TvcmBaseEntitiesCollection.GetAttr(Index: Integer): AnsiString;
//#UC START# *560A9DCD009D_52A72E6B00B1_var*
var
 l_C: Integer;
//#UC END# *560A9DCD009D_52A72E6B00B1_var*
begin
//#UC START# *560A9DCD009D_52A72E6B00B1_impl*
 l_C := inherited GetAttrCount;
 if (Index >= l_C) then
 begin
  case Index - l_C of
   0 : Result := 'Caption';
   1 : Result := 'Name';
  end;//Case Index - l_C
 end//Index >= l_C
 else
  Result := inherited GetAttr(Index);
//#UC END# *560A9DCD009D_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.GetAttr

function TvcmBaseEntitiesCollection.GetItemAttr(Index: Integer;
 ItemIndex: Integer): AnsiString;
//#UC START# *560A9DEB0155_52A72E6B00B1_var*
var
 l_C: Integer;
//#UC END# *560A9DEB0155_52A72E6B00B1_var*
begin
//#UC START# *560A9DEB0155_52A72E6B00B1_impl*
 l_C := inherited GetAttrCount;
 if (Index > l_C) then
 begin
  case Index - l_C of
   1 : Result := TvcmBaseEntitiesCollectionItem(Items[ItemIndex]).Name;
  end;//Case Index - l_C
 end//Index > l_C
 else
  Result := inherited GetItemAttr(Index, ItemIndex);
//#UC END# *560A9DEB0155_52A72E6B00B1_impl*
end;//TvcmBaseEntitiesCollection.GetItemAttr

//#UC START# *52A72E6B00B1impl*
procedure TvcmBaseEntitiesCollection.PublishOp(const anEntity: TvcmString;
  const anOperation: TvcmString;
  anExecute: TvcmControlExecuteEvent = nil;
  aTest: TvcmControlTestEvent = nil;
  aGetState: TvcmControlGetStateEvent = nil;
  aNoPrefix: Boolean = false);
var
 l_Execute: TMethod absolute anExecute;
 l_Test: TMethod absolute aTest;
 l_GetState: TMethod absolute aGetState;
 l_Control: TComponent;
 l_Op: AnsiString;
 l_En: TvcmBaseEntitiesCollectionItem;
begin
 l_Control := TComponent(l_Execute.Data);
 if (l_Control = nil) then
  l_Control := TComponent(l_Test.Data);
 if (l_Control = nil) then
  l_Control := TComponent(l_GetState.Data);
 l_En := CheckEntityForControl(anEntity);
 if aNoPrefix then
  l_Op := anOperation
 else
  l_Op := 'op' + anOperation;
 l_En.PublishOp(l_Control, l_Op, anExecute, aTest, aGetState);
end;//TvcmBaseEntitiesCollection.PublishOp
//#UC END# *52A72E6B00B1impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmBaseEntitiesCollection);
 {* –егистраци€ TvcmBaseEntitiesCollection }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
