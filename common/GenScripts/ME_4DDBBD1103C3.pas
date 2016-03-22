unit vcmBaseEntitiesCollectionItem;
 {* Не дорисовал из-за ссылки на vcmForm
Потом надо как-то разрулить цикл }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseEntitiesCollectionItem.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmBaseEntitiesCollectionItem" MUID: (4DDBBD1103C3)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , Classes
 , vcmBaseCollectionItem
 , vcmBaseOperationsCollection
 , vcmUserControls
 , vcmTargetedControlsCollection
 , vcmInterfaces
 , vcmRepositoryEx
 , vcmBaseCollection
 , vcmExternalInterfaces
 , vcmBase
;

type
 TvcmGetTargetEvent = function(aControl: TComponent;
  aX: Integer;
  aY: Integer;
  out theTarget: IUnknown): Boolean of object;

 TvcmBaseEntitiesCollectionItemPrim = class(TvcmBaseCollectionItem)
  private
   f_Operations: TvcmBaseOperationsCollection;
    {* Поле для свойства Operations }
   f_ToolbarPos: TvcmToolBarPos;
    {* Поле для свойства ToolbarPos }
   f_Controls: TvcmTargetedControlsCollection;
    {* Поле для свойства Controls }
   f_OnGetTarget: TvcmGetTargetEvent;
    {* Поле для свойства OnGetTarget }
   f_EntityDef: IvcmEntityDef;
    {* Поле для свойства EntityDef }
   f_Options: TvcmEntityOperationsOptions;
    {* Поле для свойства Options }
   f_ContextMenuWeight: Integer;
    {* Поле для свойства ContextMenuWeight }
   f_EntityID: Integer;
    {* Поле для свойства EntityID }
  protected
   procedure pm_SetOperations(aValue: TvcmBaseOperationsCollection);
   procedure pm_SetControls(aValue: TvcmTargetedControlsCollection);
   function pm_GetEntityDef: IvcmEntityDef; virtual;
   function pm_GetSupportedBy(aControl: TComponent): Boolean;
   procedure pm_SetSupportedBy(aControl: TComponent;
    aValue: Boolean);
   function GetOperationsStored: Boolean; virtual;
   function IDRep: TvcmRep; virtual;
   class function GetOperationsCollectionClass: RvcmBaseCollection; virtual;
   function OperationsStored: Boolean;
    {* "Функция определяющая, что свойство Operations сохраняется" }
   function ControlsStored: Boolean;
    {* "Функция определяющая, что свойство Controls сохраняется" }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure BeforeAddToCache; override;
    {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
   procedure ClearFields; override;
   procedure ChangeName(const anOld: AnsiString;
    const aNew: AnsiString); override;
   procedure ChangeCaption(const anOld: AnsiString;
    const aNew: AnsiString); override;
  public
   function GetEntityForControl(aControl: TComponent;
    aX: Integer;
    aY: Integer): IvcmEntity;
   procedure Operation(aControl: TComponent;
    const aTarget: IUnknown;
    anOperationID: TvcmControlID;
    aMode: TvcmOperationMode;
    const aParams: IvcmParams);
   function IsFormItem: Boolean;
   function SupportedExBy(aControl: TComponent): Integer;
   {$If Defined(DesignTimeLibrary)}
   function HasInternalOperations: Boolean;
   {$IfEnd} // Defined(DesignTimeLibrary)
   {$If Defined(DesignTimeLibrary)}
   function HasOnlyInternalOperations: Boolean;
   {$IfEnd} // Defined(DesignTimeLibrary)
   procedure RegisterInRep;
   procedure PublishEntity(aControl: TComponent;
    aGetTarget: TvcmControlGetTargetEvent);
   procedure PublishFormEntity(aGetTarget: TvcmGetTargetEvent);
   procedure PublishOp(aControl: TComponent;
    const anOperation: TvcmString;
    anExecute: TvcmControlExecuteEvent;
    aTest: TvcmControlTestEvent;
    aGetState: TvcmControlGetStateEvent); overload;
   procedure PublishOp(aControl: TComponent;
    const anOperation: TvcmString;
    anExecute: TvcmExecuteEvent;
    aTest: TvcmControlTestEvent;
    aGetState: TvcmControlGetStateEvent); overload;
   function IsItemCaptionUnique(aItem: TvcmBaseCollectionItem): Boolean;
   procedure Assign(Source: TPersistent); override;
   constructor Create(aCollection: TCollection); override;
   function MakeID(const aName: AnsiString): Integer; override;
   function GetID: Integer; override;
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; override;
  public
   property Operations: TvcmBaseOperationsCollection
    read f_Operations
    write pm_SetOperations
    stored OperationsStored;
   property ToolbarPos: TvcmToolBarPos
    read f_ToolbarPos
    write f_ToolbarPos;
   property Controls: TvcmTargetedControlsCollection
    read f_Controls
    write pm_SetControls
    stored ControlsStored;
   property OnGetTarget: TvcmGetTargetEvent
    read f_OnGetTarget
    write f_OnGetTarget;
   property EntityDef: IvcmEntityDef
    read pm_GetEntityDef;
   property Options: TvcmEntityOperationsOptions
    read f_Options
    write f_Options;
   property ContextMenuWeight: Integer
    read f_ContextMenuWeight
    write f_ContextMenuWeight;
   property EntityID: Integer
    read f_EntityID;
   property SupportedBy[aControl: TComponent]: Boolean
    read pm_GetSupportedBy
    write pm_SetSupportedBy;
 end;//TvcmBaseEntitiesCollectionItemPrim

 //#UC START# *4DDBBD1103C3ci*
 //#UC END# *4DDBBD1103C3ci*
 //#UC START# *4DDBBD1103C3cit*
 //#UC END# *4DDBBD1103C3cit*
 TvcmBaseEntitiesCollectionItem = class(TvcmBaseEntitiesCollectionItemPrim)
  {* Не дорисовал из-за ссылки на vcmForm
Потом надо как-то разрулить цикл }
 //#UC START# *4DDBBD1103C3publ*
  published
   property Operations;
   property ToolbarPos default vcm_tbpTop;
 //#UC END# *4DDBBD1103C3publ*
 end;//TvcmBaseEntitiesCollectionItem
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmEntitiesCollectionItemEntity
 , vcmControlsCollectionItem
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmBaseEntityDef
 , vcmOperationableIdentifiedUserFriendly
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TvcmBaseEntitiesCollectionItemPrim.pm_SetOperations(aValue: TvcmBaseOperationsCollection);
//#UC START# *55D30E8A0376_55D30D410267set_var*
//#UC END# *55D30E8A0376_55D30D410267set_var*
begin
//#UC START# *55D30E8A0376_55D30D410267set_impl*
 f_Operations.Assign(aValue);
//#UC END# *55D30E8A0376_55D30D410267set_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.pm_SetOperations

procedure TvcmBaseEntitiesCollectionItemPrim.pm_SetControls(aValue: TvcmTargetedControlsCollection);
//#UC START# *55D30FB2030A_55D30D410267set_var*
//#UC END# *55D30FB2030A_55D30D410267set_var*
begin
//#UC START# *55D30FB2030A_55D30D410267set_impl*
 f_Controls.Assign(aValue);
//#UC END# *55D30FB2030A_55D30D410267set_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.pm_SetControls

function TvcmBaseEntitiesCollectionItemPrim.pm_GetEntityDef: IvcmEntityDef;
//#UC START# *55D3104B0336_55D30D410267get_var*
//#UC END# *55D3104B0336_55D30D410267get_var*
begin
//#UC START# *55D3104B0336_55D30D410267get_impl*
 if (f_EntityDef = nil) then
  f_EntityDef := TvcmBaseEntityDef.Make(Self);
 Result := f_EntityDef;
//#UC END# *55D3104B0336_55D30D410267get_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.pm_GetEntityDef

function TvcmBaseEntitiesCollectionItemPrim.pm_GetSupportedBy(aControl: TComponent): Boolean;
//#UC START# *55D3127F038A_55D30D410267get_var*
//#UC END# *55D3127F038A_55D30D410267get_var*
begin
//#UC START# *55D3127F038A_55D30D410267get_impl*
 with Controls do //зачем тут with?
  if (Controls.Count = 0) and (aControl = nil) then
   Result := True
  else
   Result := (SupportedExBy(aControl) >= 0);
//#UC END# *55D3127F038A_55D30D410267get_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.pm_GetSupportedBy

procedure TvcmBaseEntitiesCollectionItemPrim.pm_SetSupportedBy(aControl: TComponent;
 aValue: Boolean);
//#UC START# *55D3127F038A_55D30D410267set_var*
var
 l_Index: Integer;
//#UC END# *55D3127F038A_55D30D410267set_var*
begin
//#UC START# *55D3127F038A_55D30D410267set_impl*
 l_Index := SupportedExBy(aControl);
 if (aValue) then
 begin
  if (l_Index < 0) then
   TvcmControlsCollectionItem(Controls.Add).Control := aControl;
 end//aValue
 else
 begin
  if (Operations <> nil) then
   Operations.UnlinkControl(aControl);
  if (l_Index >= 0) then
   Controls.Delete(l_Index);
 end;//aValue
//#UC END# *55D3127F038A_55D30D410267set_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.pm_SetSupportedBy

function TvcmBaseEntitiesCollectionItemPrim.GetOperationsStored: Boolean;
//#UC START# *55D30ECE00AD_55D30D410267_var*
//#UC END# *55D30ECE00AD_55D30D410267_var*
begin
//#UC START# *55D30ECE00AD_55D30D410267_impl*
 Result := (Operations <> nil) and (Operations.Count > 0);
//#UC END# *55D30ECE00AD_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.GetOperationsStored

function TvcmBaseEntitiesCollectionItemPrim.IDRep: TvcmRep;
//#UC START# *55D3156703C9_55D30D410267_var*
//#UC END# *55D3156703C9_55D30D410267_var*
begin
//#UC START# *55D3156703C9_55D30D410267_impl*
 Result := vcm_repEntity;
//#UC END# *55D3156703C9_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.IDRep

class function TvcmBaseEntitiesCollectionItemPrim.GetOperationsCollectionClass: RvcmBaseCollection;
//#UC START# *55D3158D0030_55D30D410267_var*
//#UC END# *55D3158D0030_55D30D410267_var*
begin
//#UC START# *55D3158D0030_55D30D410267_impl*
 Result := TvcmBaseOperationsCollection;
//#UC END# *55D3158D0030_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.GetOperationsCollectionClass

function TvcmBaseEntitiesCollectionItemPrim.GetEntityForControl(aControl: TComponent;
 aX: Integer;
 aY: Integer): IvcmEntity;
//#UC START# *55D315AF00FF_55D30D410267_var*
var
 l_Target: IUnknown;

 function _MakeEntity: IvcmEntity;
 var
  l_Entity: TvcmEntitiesCollectionItemEntity;
 begin//_MakeEntity
  if (l_Target = nil)
   then l_Entity := TvcmEntitiesCollectionItemEntity.Create(aControl, Self)
   else l_Entity := TvcmEntitiesCollectionItemTargetedEntity.Create(aControl, Self, l_Target);
  try
   Result := l_Entity;
  finally
   vcmFree(l_Entity);
  end;//try..finally
 end;//_MakeEntity
//#UC END# *55D315AF00FF_55D30D410267_var*
begin
//#UC START# *55D315AF00FF_55D30D410267_impl*
 Result := nil;
 if SupportedBy[aControl] then
 begin
  if ((aX <> High(aX)) or (aY <> High(aY))) then
  begin
   if (Controls <> nil) and
      Controls.GetTargetForControl(aControl, Point(aX, aY), l_Target) then
   begin
    if (l_Target <> nil) then
     Result := _MakeEntity;
    Exit;
   end else   
   if Assigned(f_OnGetTarget) then
   begin
    if f_OnGetTarget(aControl, aX, aY, l_Target) then
    begin
     if (l_Target <> nil) then
      Result := _MakeEntity;
     Exit;
    end;//f_OnGetTarget
   end;//Assigned(f_OnGetTarget)
  end;//aX <> High(aX)
  Result := _MakeEntity;
 end;//SupportedBy(aControl)
//#UC END# *55D315AF00FF_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.GetEntityForControl

procedure TvcmBaseEntitiesCollectionItemPrim.Operation(aControl: TComponent;
 const aTarget: IUnknown;
 anOperationID: TvcmControlID;
 aMode: TvcmOperationMode;
 const aParams: IvcmParams);
//#UC START# *55D315DD021A_55D30D410267_var*
//#UC END# *55D315DD021A_55D30D410267_var*
begin
//#UC START# *55D315DD021A_55D30D410267_impl*
 if (Operations <> nil) then
  Operations.Operation(aControl, aTarget, anOperationID, aMode, aParams); 
//#UC END# *55D315DD021A_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.Operation

function TvcmBaseEntitiesCollectionItemPrim.IsFormItem: Boolean;
//#UC START# *55D3160A0358_55D30D410267_var*
//#UC END# *55D3160A0358_55D30D410267_var*
begin
//#UC START# *55D3160A0358_55D30D410267_impl*
 Result := Controls.LinkedToForm;
//#UC END# *55D3160A0358_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.IsFormItem

function TvcmBaseEntitiesCollectionItemPrim.SupportedExBy(aControl: TComponent): Integer;
//#UC START# *55D3166700B9_55D30D410267_var*
var
 l_Index: Integer;
//#UC END# *55D3166700B9_55D30D410267_var*
begin
//#UC START# *55D3166700B9_55D30D410267_impl*
 Result := -1;
 with Controls do
  for l_Index := 0 to Pred(Count) do
   with TvcmControlsCollectionItem(Items[l_Index]) do
    if (Control = aControl) then
    begin
     Result := l_Index;
     Break;
    end;//Control = aControl
//#UC END# *55D3166700B9_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.SupportedExBy

{$If Defined(DesignTimeLibrary)}
function TvcmBaseEntitiesCollectionItemPrim.HasInternalOperations: Boolean;
//#UC START# *55D31692032D_55D30D410267_var*
var
 l_Index: Integer;
//#UC END# *55D31692032D_55D30D410267_var*
begin
//#UC START# *55D31692032D_55D30D410267_impl*
 Result := False;
 if (Operations <> nil) then
  for l_Index := 0 to Pred(Operations.Count) do
   if (TvcmBaseOperationsCollectionItem(Operations.Items[l_Index]).OperationType in vcm_InternalOperations) then
   begin
    Result := True;
    Break;
   end;//..vcm_InternalOperations..
//#UC END# *55D31692032D_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.HasInternalOperations
{$IfEnd} // Defined(DesignTimeLibrary)

{$If Defined(DesignTimeLibrary)}
function TvcmBaseEntitiesCollectionItemPrim.HasOnlyInternalOperations: Boolean;
//#UC START# *55D316B201E7_55D30D410267_var*
var
 l_Index: Integer;
//#UC END# *55D316B201E7_55D30D410267_var*
begin
//#UC START# *55D316B201E7_55D30D410267_impl*
 Result := True;
 if (Operations <> nil) then
  for l_Index := 0 to Pred(Operations.Count) do
   if not (TvcmBaseOperationsCollectionItem(Operations.Items[l_Index]).OperationType in vcm_InternalOperations) then
   begin
    Result := False;
    Break;
   end;//..vcm_InternalOperations..
//#UC END# *55D316B201E7_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.HasOnlyInternalOperations
{$IfEnd} // Defined(DesignTimeLibrary)

procedure TvcmBaseEntitiesCollectionItemPrim.RegisterInRep;
//#UC START# *55D316CE0191_55D30D410267_var*
//#UC END# *55D316CE0191_55D30D410267_var*
begin
//#UC START# *55D316CE0191_55D30D410267_impl*
 if (Operations <> nil) then
  Operations.RegisterInRep;
//#UC END# *55D316CE0191_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.RegisterInRep

procedure TvcmBaseEntitiesCollectionItemPrim.PublishEntity(aControl: TComponent;
 aGetTarget: TvcmControlGetTargetEvent);
//#UC START# *55D316E10142_55D30D410267_var*
//#UC END# *55D316E10142_55D30D410267_var*
begin
//#UC START# *55D316E10142_55D30D410267_impl*
 SupportedBy[aControl] := True;
 Controls.PublishEntity(aControl, aGetTarget);
//#UC END# *55D316E10142_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.PublishEntity

procedure TvcmBaseEntitiesCollectionItemPrim.PublishFormEntity(aGetTarget: TvcmGetTargetEvent);
//#UC START# *55D317030302_55D30D410267_var*
//#UC END# *55D317030302_55D30D410267_var*
begin
//#UC START# *55D317030302_55D30D410267_impl*
 OnGetTarget := aGetTarget;
//#UC END# *55D317030302_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.PublishFormEntity

procedure TvcmBaseEntitiesCollectionItemPrim.PublishOp(aControl: TComponent;
 const anOperation: TvcmString;
 anExecute: TvcmControlExecuteEvent;
 aTest: TvcmControlTestEvent;
 aGetState: TvcmControlGetStateEvent);
//#UC START# *55D317480019_55D30D410267_var*
//#UC END# *55D317480019_55D30D410267_var*
begin
//#UC START# *55D317480019_55D30D410267_impl*
 if (aControl <> nil) then
  if not (aControl is TForm) then
   SupportedBy[aControl] := True;
 f_Operations.PublishOp(aControl, anOperation, anExecute, aTest, aGetState);
//#UC END# *55D317480019_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.PublishOp

procedure TvcmBaseEntitiesCollectionItemPrim.PublishOp(aControl: TComponent;
 const anOperation: TvcmString;
 anExecute: TvcmExecuteEvent;
 aTest: TvcmControlTestEvent;
 aGetState: TvcmControlGetStateEvent);
//#UC START# *55D317760220_55D30D410267_var*
//#UC END# *55D317760220_55D30D410267_var*
begin
//#UC START# *55D317760220_55D30D410267_impl*
 if not (aControl is TForm) then
  SupportedBy[aControl] := True;
 f_Operations.PublishOpWithResult(aControl, anOperation, anExecute, aTest, aGetState);
//#UC END# *55D317760220_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.PublishOp

function TvcmBaseEntitiesCollectionItemPrim.IsItemCaptionUnique(aItem: TvcmBaseCollectionItem): Boolean;
//#UC START# *55D317B50256_55D30D410267_var*
var
 l_Index: Integer;
//#UC END# *55D317B50256_55D30D410267_var*
begin
//#UC START# *55D317B50256_55D30D410267_impl*
 Result := True;
 for l_Index := 0 to Pred(f_Operations.Count) do
  if (aItem <> f_Operations.Items[l_Index]) and (f_Operations.Items[l_Index].Caption = aItem.Caption) then
  begin
   Result := False;
   Break;
  end;//if f_Operations.Items[l_Index].
//#UC END# *55D317B50256_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.IsItemCaptionUnique

function TvcmBaseEntitiesCollectionItemPrim.OperationsStored: Boolean;
 {* "Функция определяющая, что свойство Operations сохраняется" }
//#UC START# *78B8116FEB76_55D30D410267_var*
//#UC END# *78B8116FEB76_55D30D410267_var*
begin
//#UC START# *78B8116FEB76_55D30D410267_impl*
 Result := GetOperationsStored;
//#UC END# *78B8116FEB76_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.OperationsStored

function TvcmBaseEntitiesCollectionItemPrim.ControlsStored: Boolean;
 {* "Функция определяющая, что свойство Controls сохраняется" }
//#UC START# *EC3EC97ADA92_55D30D410267_var*
//#UC END# *EC3EC97ADA92_55D30D410267_var*
begin
//#UC START# *EC3EC97ADA92_55D30D410267_impl*
 Result := (f_Controls <> nil) and (f_Controls.Count > 0);
//#UC END# *EC3EC97ADA92_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.ControlsStored

procedure TvcmBaseEntitiesCollectionItemPrim.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_55D30D410267_var*
//#UC END# *478CF34E02CE_55D30D410267_var*
begin
//#UC START# *478CF34E02CE_55D30D410267_impl*
 inherited;
 if (Source is TvcmBaseEntitiesCollectionItemPrim) then
 begin
  Operations := TvcmBaseEntitiesCollectionItemPrim(Source).Operations;
  Controls := TvcmBaseEntitiesCollectionItemPrim(Source).Controls;
 end;//Source is TvcmBaseEntitiesCollectionItem
//#UC END# *478CF34E02CE_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.Assign

procedure TvcmBaseEntitiesCollectionItemPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55D30D410267_var*
var
 l_OpHolder: IvcmOperationsHolder;
//#UC END# *479731C50290_55D30D410267_var*
begin
//#UC START# *479731C50290_55D30D410267_impl*
 f_Options := [];
 if Supports(f_EntityDef, IvcmOperationsHolder, l_OpHolder) then
  try
   l_OpHolder.ClearOps;
  finally
   l_OpHolder := nil;
  end;//try..finally
 f_EntityDef := nil;
 FreeAndNil(f_Operations);
 FreeAndNil(f_Controls);
 // - это надо ПОЗЖЕ операций !!!
 inherited;
//#UC END# *479731C50290_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.Cleanup

procedure TvcmBaseEntitiesCollectionItemPrim.BeforeAddToCache;
 {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
//#UC START# *479F2B3302C1_55D30D410267_var*
//#UC END# *479F2B3302C1_55D30D410267_var*
begin
//#UC START# *479F2B3302C1_55D30D410267_impl*
 inherited;
 f_EntityID := 0;
 f_OnGetTarget := nil;
//#UC END# *479F2B3302C1_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.BeforeAddToCache

constructor TvcmBaseEntitiesCollectionItemPrim.Create(aCollection: TCollection);
//#UC START# *4D555CF50027_55D30D410267_var*
//#UC END# *4D555CF50027_55D30D410267_var*
begin
//#UC START# *4D555CF50027_55D30D410267_impl*
 inherited;
 f_ContextMenuWeight := 0;
 f_Operations := TvcmBaseOperationsCollection(GetOperationsCollectionClass.Create(Self));
 f_Controls := TvcmTargetedControlsCollection.Create(Self);
 f_ToolbarPos := vcm_tbpTop;
//#UC END# *4D555CF50027_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.Create

procedure TvcmBaseEntitiesCollectionItemPrim.ClearFields;
begin
 f_EntityDef := nil;
 inherited;
end;//TvcmBaseEntitiesCollectionItemPrim.ClearFields

procedure TvcmBaseEntitiesCollectionItemPrim.ChangeName(const anOld: AnsiString;
 const aNew: AnsiString);
//#UC START# *55CCBA3C0190_55D30D410267_var*
//#UC END# *55CCBA3C0190_55D30D410267_var*
begin
//#UC START# *55CCBA3C0190_55D30D410267_impl*
 inherited;
 f_EntityID := MakeID(aNew);
//#UC END# *55CCBA3C0190_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.ChangeName

procedure TvcmBaseEntitiesCollectionItemPrim.ChangeCaption(const anOld: AnsiString;
 const aNew: AnsiString);
//#UC START# *55CCBA8003C7_55D30D410267_var*
//#UC END# *55CCBA8003C7_55D30D410267_var*
begin
//#UC START# *55CCBA8003C7_55D30D410267_impl*
 inherited;
 {$IfDef DesignTimeLibrary}
 vcmGetID(vcm_repEntityCaption, aNew);
 {$EndIf DesignTimeLibrary}
//#UC END# *55CCBA8003C7_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.ChangeCaption

function TvcmBaseEntitiesCollectionItemPrim.MakeID(const aName: AnsiString): Integer;
//#UC START# *55CCBAAB00F4_55D30D410267_var*
//#UC END# *55CCBAAB00F4_55D30D410267_var*
begin
//#UC START# *55CCBAAB00F4_55D30D410267_impl*
 Result := vcmGetID(IDRep, aName);
//#UC END# *55CCBAAB00F4_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.MakeID

function TvcmBaseEntitiesCollectionItemPrim.GetID: Integer;
//#UC START# *55CCBAC800F0_55D30D410267_var*
//#UC END# *55CCBAC800F0_55D30D410267_var*
begin
//#UC START# *55CCBAC800F0_55D30D410267_impl*
 Result := EntityID;
//#UC END# *55CCBAC800F0_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.GetID

function TvcmBaseEntitiesCollectionItemPrim.QueryInterface(const IID: TGUID;
 out Obj): HResult;
//#UC START# *561145D802BB_55D30D410267_var*
//#UC END# *561145D802BB_55D30D410267_var*
begin
//#UC START# *561145D802BB_55D30D410267_impl*
 if IsEqualGUID(IID, IvcmUserFriendlyControl) then
 begin
  Result := S_Ok;
  IvcmUserFriendlyControl(Obj) := EntityDef;
 end
 else
 if IsEqualGUID(IID, IvcmIdentifiedUserFriendlyControl) then
 begin
  Result := S_Ok;
  IvcmIdentifiedUserFriendlyControl(Obj) := EntityDef;
 end
 else
 if IsEqualGUID(IID, IvcmEntityDef) then
 begin
  Result := S_Ok;
  IvcmEntityDef(Obj) := EntityDef;
 end
 else
  Result := inherited QueryInterface(IID, Obj);
//#UC END# *561145D802BB_55D30D410267_impl*
end;//TvcmBaseEntitiesCollectionItemPrim.QueryInterface

//#UC START# *4DDBBD1103C3impl*
//#UC END# *4DDBBD1103C3impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmBaseEntitiesCollectionItemPrim);
 {* Регистрация TvcmBaseEntitiesCollectionItemPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmBaseEntitiesCollectionItem);
 {* Регистрация TvcmBaseEntitiesCollectionItem }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
