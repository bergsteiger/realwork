unit vcmBaseEntities;
 {* Компонент для определения списка сущностей }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseEntities.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmBaseEntities" MUID: (52A1EA2A0184)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmComponent
 , vcmBaseEntitiesCollection
 , vcmBaseCollection
 , vcmBaseEntitiesCollectionItem
 , vcmEntitiesDefList
 , vcmBaseOperationsCollectionItem
 , vcmExternalInterfaces
 , Classes
;

type
 TvcmBaseEntities = class(TvcmComponent)
  {* Компонент для определения списка сущностей }
  private
   f_Linked: Boolean;
   f_Entities: TvcmBaseEntitiesCollection;
    {* Поле для свойства Entities }
  protected
   function pm_GetEntities: TvcmBaseEntitiesCollection;
   procedure pm_SetEntities(aValue: TvcmBaseEntitiesCollection);
   function EntitiesStored: Boolean;
    {* "Функция определяющая, что свойство Entities сохраняется" }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Notification(AComponent: TComponent;
    Operation: TOperation); override;
  public
   class function GetEntitiesCollectionClass: RvcmBaseCollection; virtual;
   function GetItemByName(const aName: AnsiString): TvcmBaseEntitiesCollectionItem;
   procedure LinkControls;
   procedure UnlinkControls;
   procedure GetEntitiesDef(aList: TvcmEntitiesDefList);
   function GetOperationByName(const anEntity: TvcmString;
    const anOperation: TvcmString): TvcmBaseOperationsCollectionItem;
   procedure SetTargetGetter(const anEntity: TvcmString;
    anEvent: TvcmGetTargetEvent);
   procedure MakeSupportedByControl(const anEntity: TvcmString;
    aControl: TComponent);
   constructor Create(AOwner: TComponent); override;
  public
   property Entities: TvcmBaseEntitiesCollection
    read pm_GetEntities
    write pm_SetEntities
    stored EntitiesStored;
 end;//TvcmBaseEntities
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
;

function TvcmBaseEntities.pm_GetEntities: TvcmBaseEntitiesCollection;
//#UC START# *560815340395_52A1EA2A0184get_var*
//#UC END# *560815340395_52A1EA2A0184get_var*
begin
//#UC START# *560815340395_52A1EA2A0184get_impl*
 Result := f_Entities;
//#UC END# *560815340395_52A1EA2A0184get_impl*
end;//TvcmBaseEntities.pm_GetEntities

procedure TvcmBaseEntities.pm_SetEntities(aValue: TvcmBaseEntitiesCollection);
//#UC START# *560815340395_52A1EA2A0184set_var*
//#UC END# *560815340395_52A1EA2A0184set_var*
begin
//#UC START# *560815340395_52A1EA2A0184set_impl*
 f_Entities.Assign(aValue);
//#UC END# *560815340395_52A1EA2A0184set_impl*
end;//TvcmBaseEntities.pm_SetEntities

class function TvcmBaseEntities.GetEntitiesCollectionClass: RvcmBaseCollection;
//#UC START# *52A1ED12039D_52A1EA2A0184_var*
//#UC END# *52A1ED12039D_52A1EA2A0184_var*
begin
//#UC START# *52A1ED12039D_52A1EA2A0184_impl*
 Result := TvcmBaseEntitiesCollection;
//#UC END# *52A1ED12039D_52A1EA2A0184_impl*
end;//TvcmBaseEntities.GetEntitiesCollectionClass

function TvcmBaseEntities.GetItemByName(const aName: AnsiString): TvcmBaseEntitiesCollectionItem;
//#UC START# *560815920320_52A1EA2A0184_var*
//#UC END# *560815920320_52A1EA2A0184_var*
begin
//#UC START# *560815920320_52A1EA2A0184_impl*
 Result := Entities.FindItemByName(aName) as TvcmBaseEntitiesCollectionItem;
//#UC END# *560815920320_52A1EA2A0184_impl*
end;//TvcmBaseEntities.GetItemByName

procedure TvcmBaseEntities.LinkControls;
//#UC START# *560815A70133_52A1EA2A0184_var*
var
 l_Index: Integer;
//#UC END# *560815A70133_52A1EA2A0184_var*
begin
//#UC START# *560815A70133_52A1EA2A0184_impl*
 if not f_Linked and (Owner <> nil) then
 begin
  {$IfNDef vcmExportHelp}
  if not (Owner is TCustomForm) or (Owner.Owner <> nil) or (csDesigning in ComponentState) then
  {$EndIf  vcmExportHelp}
  begin
   f_Linked := true;
   for l_Index := 0 to Pred(Owner.ComponentCount) do
    f_Entities.LinkControl(Owner.Components[l_Index]);
  end;//not (Owner is TCustomForm)..
 end;//not f_Linked
//#UC END# *560815A70133_52A1EA2A0184_impl*
end;//TvcmBaseEntities.LinkControls

procedure TvcmBaseEntities.UnlinkControls;
//#UC START# *560815B2001B_52A1EA2A0184_var*
var
 l_Index: Integer;
//#UC END# *560815B2001B_52A1EA2A0184_var*
begin
//#UC START# *560815B2001B_52A1EA2A0184_impl*
 if f_Linked and (Owner <> nil) then
 begin
  if not (Owner is TCustomForm) or (Owner.Owner <> nil) or (csDesigning in ComponentState) then
  begin
   f_Linked := false;
   for l_Index := 0 to Pred(Owner.ComponentCount) do
    f_Entities.UnlinkControl(Owner.Components[l_Index]);
  end;//not (Owner is TCustomForm)..
 end;//not f_Linked
//#UC END# *560815B2001B_52A1EA2A0184_impl*
end;//TvcmBaseEntities.UnlinkControls

procedure TvcmBaseEntities.GetEntitiesDef(aList: TvcmEntitiesDefList);
//#UC START# *560815BD02F4_52A1EA2A0184_var*
//#UC END# *560815BD02F4_52A1EA2A0184_var*
begin
//#UC START# *560815BD02F4_52A1EA2A0184_impl*
 LinkControls;
 Entities.GetEntitiesDef(aList);
//#UC END# *560815BD02F4_52A1EA2A0184_impl*
end;//TvcmBaseEntities.GetEntitiesDef

function TvcmBaseEntities.GetOperationByName(const anEntity: TvcmString;
 const anOperation: TvcmString): TvcmBaseOperationsCollectionItem;
//#UC START# *560815DA00A6_52A1EA2A0184_var*
//#UC END# *560815DA00A6_52A1EA2A0184_var*
begin
//#UC START# *560815DA00A6_52A1EA2A0184_impl*
 Result := Entities.GetOperationByName(anEntity, anOperation);
//#UC END# *560815DA00A6_52A1EA2A0184_impl*
end;//TvcmBaseEntities.GetOperationByName

procedure TvcmBaseEntities.SetTargetGetter(const anEntity: TvcmString;
 anEvent: TvcmGetTargetEvent);
//#UC START# *560815F40305_52A1EA2A0184_var*
//#UC END# *560815F40305_52A1EA2A0184_var*
begin
//#UC START# *560815F40305_52A1EA2A0184_impl*
 Entities.CheckEntityForControl(anEntity).OnGetTarget := anEvent;
//#UC END# *560815F40305_52A1EA2A0184_impl*
end;//TvcmBaseEntities.SetTargetGetter

procedure TvcmBaseEntities.MakeSupportedByControl(const anEntity: TvcmString;
 aControl: TComponent);
//#UC START# *5608160F00E1_52A1EA2A0184_var*
//#UC END# *5608160F00E1_52A1EA2A0184_var*
begin
//#UC START# *5608160F00E1_52A1EA2A0184_impl*
 Entities.CheckEntityForControl(anEntity).SupportedBy[aControl] := true;
//#UC END# *5608160F00E1_52A1EA2A0184_impl*
end;//TvcmBaseEntities.MakeSupportedByControl

function TvcmBaseEntities.EntitiesStored: Boolean;
 {* "Функция определяющая, что свойство Entities сохраняется" }
//#UC START# *56A6B7F8E5B9_52A1EA2A0184_var*
//#UC END# *56A6B7F8E5B9_52A1EA2A0184_var*
begin
//#UC START# *56A6B7F8E5B9_52A1EA2A0184_impl*
 Result := (f_Entities <> nil) and (f_Entities.Count > 0);
//#UC END# *56A6B7F8E5B9_52A1EA2A0184_impl*
end;//TvcmBaseEntities.EntitiesStored

procedure TvcmBaseEntities.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52A1EA2A0184_var*
//#UC END# *479731C50290_52A1EA2A0184_var*
begin
//#UC START# *479731C50290_52A1EA2A0184_impl*
 f_Linked := false;
 FreeAndNil(f_Entities);
 inherited;
//#UC END# *479731C50290_52A1EA2A0184_impl*
end;//TvcmBaseEntities.Cleanup

constructor TvcmBaseEntities.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_52A1EA2A0184_var*
//#UC END# *47D1602000C6_52A1EA2A0184_var*
begin
//#UC START# *47D1602000C6_52A1EA2A0184_impl*
 inherited;
 f_Entities := TvcmBaseEntitiesCollection(GetEntitiesCollectionClass.Create(Self));
//#UC END# *47D1602000C6_52A1EA2A0184_impl*
end;//TvcmBaseEntities.Create

procedure TvcmBaseEntities.Notification(AComponent: TComponent;
 Operation: TOperation);
//#UC START# *4F884378016A_52A1EA2A0184_var*
//#UC END# *4F884378016A_52A1EA2A0184_var*
begin
//#UC START# *4F884378016A_52A1EA2A0184_impl*
 if not (csDestroying in ComponentState) then
 begin
  if (f_Entities <> nil) and f_Linked then
  begin
   if (Operation = opRemove) then
     f_Entities.UnlinkControl(aComponent)
   else
   if (Operation = opInsert) and (aComponent.Owner = Owner) then
     f_Entities.LinkControl(aComponent);
  end;//f_Entities
 end;//not (csDestroying in ComponentState)
 inherited;
//#UC END# *4F884378016A_52A1EA2A0184_impl*
end;//TvcmBaseEntities.Notification
{$IfEnd} // NOT Defined(NoVCM)

end.
