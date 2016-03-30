unit vcmBaseOperationsCollection;
 {* Коллекция операций }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseOperationsCollection.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmBaseOperationsCollection" MUID: (55D30E6601A8)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmBaseCollection
 , Classes
 , vcmExternalInterfaces
 , vcmUserControls
 , vcmInterfaces
 , vcmOperationDefList
 , vcmBase
;

type
 TvcmBaseOperationsCollection = class(TvcmBaseCollection)
  {* Коллекция операций }
  protected
   function GetAttrCount: Integer; override;
   function GetAttr(Index: Integer): AnsiString; override;
   function GetItemAttr(Index: Integer;
    ItemIndex: Integer): AnsiString; override;
  public
   function NeedToBeStored: Boolean;
   procedure Operation(aControl: TComponent;
    const aTarget: IUnknown;
    anOperationID: TvcmControlID;
    aMode: TvcmOperationMode;
    const aParams: IvcmParams);
    {* выполняет операцию сущности }
   procedure GetOperations(anOperations: TvcmOperationDefList);
    {* возвращает список описателей операций }
   procedure RegisterInRep;
   procedure PublishOp(aControl: TComponent;
    const anOperation: TvcmString;
    anExecute: TvcmControlExecuteEvent;
    aTest: TvcmControlTestEvent;
    aGetState: TvcmControlGetStateEvent);
    {* опубликовать операцию }
   procedure PublishOpWithResult(aControl: TComponent;
    const anOperation: TvcmString;
    anExecute: TvcmExecuteEvent;
    aTest: TvcmControlTestEvent;
    aGetState: TvcmControlGetStateEvent);
    {* опубликовать операцию }
   procedure UnlinkControl(aControl: TComponent);
    {* отвязать контрол }
   class function GetItemClass: TCollectionItemClass; override;
 end;//TvcmBaseOperationsCollection
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TypInfo
 , SysUtils
 , vcmBaseOperationsCollectionItem
 , vcmOperationsCollectionItem
 , vcmModule
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TvcmBaseOperationsCollection.NeedToBeStored: Boolean;
//#UC START# *56116D4D02C6_55D30E6601A8_var*
var
 l_Index: Integer;
//#UC END# *56116D4D02C6_55D30E6601A8_var*
begin
//#UC START# *56116D4D02C6_55D30E6601A8_impl*
 Result := False;
 for l_Index := 0 to Pred(Count) do
  with TvcmBaseOperationsCollectionItem(Items[l_Index]) do
   if not (Handled([vcm_htControl]) and not Handled([vcm_htGlobal, vcm_htContext])) or SomePropStored then
   begin
    Result := True;
    Break;
   end;//..HandledOnlyByControl..
//#UC END# *56116D4D02C6_55D30E6601A8_impl*
end;//TvcmBaseOperationsCollection.NeedToBeStored

procedure TvcmBaseOperationsCollection.Operation(aControl: TComponent;
 const aTarget: IUnknown;
 anOperationID: TvcmControlID;
 aMode: TvcmOperationMode;
 const aParams: IvcmParams);
 {* выполняет операцию сущности }
//#UC START# *56116D7B0216_55D30E6601A8_var*
var
 l_Item: TvcmBaseOperationsCollectionItem;
//#UC END# *56116D7B0216_55D30E6601A8_var*
begin
//#UC START# *56116D7B0216_55D30E6601A8_impl*
 l_Item := TvcmBaseOperationsCollectionItem(FindItemByID(anOperationID));
 if (l_Item <> nil) then
  l_Item.Operation(aControl, aTarget, aMode, aParams, False);
//#UC END# *56116D7B0216_55D30E6601A8_impl*
end;//TvcmBaseOperationsCollection.Operation

procedure TvcmBaseOperationsCollection.GetOperations(anOperations: TvcmOperationDefList);
 {* возвращает список описателей операций }
//#UC START# *56116DA502E0_55D30E6601A8_var*
var
 l_Index: Integer;
//#UC END# *56116DA502E0_55D30E6601A8_var*
begin
//#UC START# *56116DA502E0_55D30E6601A8_impl*
 if (anOperations <> nil) then
 begin
  for l_Index := 0 to Pred(Count) do
   anOperations.Add(TvcmBaseOperationsCollectionItem(Items[l_Index]).OperationDef);
 end;//anOperations <> nil
//#UC END# *56116DA502E0_55D30E6601A8_impl*
end;//TvcmBaseOperationsCollection.GetOperations

procedure TvcmBaseOperationsCollection.RegisterInRep;
//#UC START# *56116DBA001A_55D30E6601A8_var*
var
 l_Index: Integer;
 l_Item: TvcmBaseOperationsCollectionItem;
//#UC END# *56116DBA001A_55D30E6601A8_var*
begin
//#UC START# *56116DBA001A_55D30E6601A8_impl*
 for l_Index := 0 to Pred(Count) do
 begin
  l_Item := TvcmBaseOperationsCollectionItem(Items[l_Index]);
  if (l_Item is TvcmOperationsCollectionItem) then
   TvcmOperationsCollectionItem(l_Item).Register;
 end;//for l_Index
//#UC END# *56116DBA001A_55D30E6601A8_impl*
end;//TvcmBaseOperationsCollection.RegisterInRep

procedure TvcmBaseOperationsCollection.PublishOp(aControl: TComponent;
 const anOperation: TvcmString;
 anExecute: TvcmControlExecuteEvent;
 aTest: TvcmControlTestEvent;
 aGetState: TvcmControlGetStateEvent);
 {* опубликовать операцию }
//#UC START# *56116DD0036F_55D30E6601A8_var*
var
 l_Item: TvcmBaseOperationsCollectionItem;
//#UC END# *56116DD0036F_55D30E6601A8_var*
begin
//#UC START# *56116DD0036F_55D30E6601A8_impl*
 l_Item := FindItemByName(anOperation) as TvcmBaseOperationsCollectionItem;
 if (l_Item = nil) then
 begin
  l_Item := Add as TvcmBaseOperationsCollectionItem;
  l_Item.Name := anOperation;
  l_Item.Options := [vcm_ooShowInContextMenu];
  // - по-умолчанию показываем операции только в контекстном меню
  if (aControl is TvcmModule) then
   l_Item.Options := l_Item.Options + [vcm_ooShowInMainToolbar];
 end;//l_Item = nil
 l_Item.PublishOp(aControl, anExecute, aTest, aGetState);
//#UC END# *56116DD0036F_55D30E6601A8_impl*
end;//TvcmBaseOperationsCollection.PublishOp

procedure TvcmBaseOperationsCollection.PublishOpWithResult(aControl: TComponent;
 const anOperation: TvcmString;
 anExecute: TvcmExecuteEvent;
 aTest: TvcmControlTestEvent;
 aGetState: TvcmControlGetStateEvent);
 {* опубликовать операцию }
//#UC START# *56116E0A026F_55D30E6601A8_var*
var
 l_Item: TvcmBaseOperationsCollectionItem;
//#UC END# *56116E0A026F_55D30E6601A8_var*
begin
//#UC START# *56116E0A026F_55D30E6601A8_impl*
 l_Item := FindItemByName(anOperation) as TvcmBaseOperationsCollectionItem;
 if (l_Item = nil) then
 begin
  l_Item := Add as TvcmBaseOperationsCollectionItem;
  l_Item.Name := anOperation;
  l_Item.Options := [vcm_ooShowInContextMenu];
  // - по-умолчанию показываем операции только в контекстном меню
 end;//l_Item = nil
 l_Item.PublishOp(aControl, anExecute, aTest, aGetState);
//#UC END# *56116E0A026F_55D30E6601A8_impl*
end;//TvcmBaseOperationsCollection.PublishOpWithResult

procedure TvcmBaseOperationsCollection.UnlinkControl(aControl: TComponent);
 {* отвязать контрол }
//#UC START# *56116E2E0246_55D30E6601A8_var*
var
 l_Index: Integer;
//#UC END# *56116E2E0246_55D30E6601A8_var*
begin
//#UC START# *56116E2E0246_55D30E6601A8_impl*
 for l_Index := 0 to Pred(Count) do
  TvcmBaseOperationsCollectionItem(Items[l_Index]).UnlinkControl(aControl);
//#UC END# *56116E2E0246_55D30E6601A8_impl*
end;//TvcmBaseOperationsCollection.UnlinkControl

class function TvcmBaseOperationsCollection.GetItemClass: TCollectionItemClass;
//#UC START# *5607EE71032D_55D30E6601A8_var*
//#UC END# *5607EE71032D_55D30E6601A8_var*
begin
//#UC START# *5607EE71032D_55D30E6601A8_impl*
 Result := TvcmBaseOperationsCollectionItem;
//#UC END# *5607EE71032D_55D30E6601A8_impl*
end;//TvcmBaseOperationsCollection.GetItemClass

function TvcmBaseOperationsCollection.GetAttrCount: Integer;
//#UC START# *560A9DA80335_55D30E6601A8_var*
//#UC END# *560A9DA80335_55D30E6601A8_var*
begin
//#UC START# *560A9DA80335_55D30E6601A8_impl*
 Result := inherited GetAttrCount + 4;
//#UC END# *560A9DA80335_55D30E6601A8_impl*
end;//TvcmBaseOperationsCollection.GetAttrCount

function TvcmBaseOperationsCollection.GetAttr(Index: Integer): AnsiString;
//#UC START# *560A9DCD009D_55D30E6601A8_var*
var
 l_C: Integer;
//#UC END# *560A9DCD009D_55D30E6601A8_var*
begin
//#UC START# *560A9DCD009D_55D30E6601A8_impl*
 l_C := inherited GetAttrCount;
 if (Index >= l_C) then
 begin
  case Index - l_C of
   0 : Result := 'Caption';
   1 : Result := 'Type';
   2 : Result := 'Name';
   3 : Result := 'ShortCut';
  end;//case Index - l_C
 end//Index >= l_C
 else
  Result := inherited GetAttr(Index);
//#UC END# *560A9DCD009D_55D30E6601A8_impl*
end;//TvcmBaseOperationsCollection.GetAttr

function TvcmBaseOperationsCollection.GetItemAttr(Index: Integer;
 ItemIndex: Integer): AnsiString;
//#UC START# *560A9DEB0155_55D30E6601A8_var*
var
 l_C: Integer;
//#UC END# *560A9DEB0155_55D30E6601A8_var*
begin
//#UC START# *560A9DEB0155_55D30E6601A8_impl*
 l_C := inherited GetAttrCount;
 if (Index > l_C) then
 begin
  case Index - l_C of
   1 : Result := GetEnumName(TypeInfo(TvcmOperationType), Ord(TvcmBaseOperationsCollectionItem(Items[ItemIndex]).OperationType));
   2 : Result := TvcmBaseOperationsCollectionItem(Items[ItemIndex]).Name;
   3 : Result := ShortCutToText(TvcmBaseOperationsCollectionItem(Items[ItemIndex]).ShortCut);
  end;//case Index - l_C
 end//Index > l_C
 else
  Result := inherited GetItemAttr(Index, ItemIndex);
//#UC END# *560A9DEB0155_55D30E6601A8_impl*
end;//TvcmBaseOperationsCollection.GetItemAttr

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmBaseOperationsCollection);
 {* Регистрация TvcmBaseOperationsCollection }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
