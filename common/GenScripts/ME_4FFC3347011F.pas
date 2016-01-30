unit vcmBaseCollectionItem;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\vcmBaseCollectionItem.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmPrimCollectionItem
 , Classes
;

type
 TvcmBaseCollectionItemPrim = class(TvcmPrimCollectionItem)
  private
   f_Name: AnsiString;
    {* Поле для свойства Name }
   f_Caption: AnsiString;
    {* Поле для свойства Caption }
  protected
   function pm_GetName: AnsiString;
   procedure pm_SetName(const aValue: AnsiString);
   function pm_GetCaption: AnsiString; virtual;
   procedure pm_SetCaption(const aValue: AnsiString); virtual;
   procedure SetCaptionFromName(const aName: AnsiString); virtual;
   procedure NameChanged; virtual;
   procedure DoSetCaption(const aName: AnsiString);
   procedure ChangeName(const anOld: AnsiString;
    const aNew: AnsiString); virtual;
   procedure ChangeCaption(const anOld: AnsiString;
    const aNew: AnsiString); virtual;
   procedure CaptionChanged; virtual;
   function GetCaptionStored: Boolean; virtual;
   function CaptionStored: Boolean;
    {* "Функция определяющая, что свойство Caption сохраняется" }
   procedure BeforeAddToCache; override;
    {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
   function GetDisplayName: String; override;
   function GetNamePath: String; override;
  public
   function MakeID(const aName: AnsiString): Integer; virtual;
   function GetID: Integer; virtual;
   procedure Assign(Source: TPersistent); override;
  public
   property Name: AnsiString
    read pm_GetName
    write pm_SetName;
   property Caption: AnsiString
    read pm_GetCaption
    write pm_SetCaption
    stored CaptionStored;
 end;//TvcmBaseCollectionItemPrim

 //#UC START# *4FFC3347011Fci*
 //#UC END# *4FFC3347011Fci*
 //#UC START# *4FFC3347011Fcit*
 //#UC END# *4FFC3347011Fcit*
 TvcmBaseCollectionItem = class(TvcmBaseCollectionItemPrim)
 //#UC START# *4FFC3347011Fpubl*
  published
   property Caption;
   property Name;
 //#UC END# *4FFC3347011Fpubl*
 end;//TvcmBaseCollectionItem
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmBaseCollection
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TvcmBaseCollectionItemPrim.pm_GetName: AnsiString;
//#UC START# *55CCB8960010_55D076150061get_var*
//#UC END# *55CCB8960010_55D076150061get_var*
begin
//#UC START# *55CCB8960010_55D076150061get_impl*
 Result := f_Name;
//#UC END# *55CCB8960010_55D076150061get_impl*
end;//TvcmBaseCollectionItemPrim.pm_GetName

procedure TvcmBaseCollectionItemPrim.pm_SetName(const aValue: AnsiString);
//#UC START# *55CCB8960010_55D076150061set_var*
//#UC END# *55CCB8960010_55D076150061set_var*
begin
//#UC START# *55CCB8960010_55D076150061set_impl*
 if (f_Name <> aValue) then
 begin
  {$IfDef DesignTimeLibrary}
  if (aName <> '') and not IsValidIdent(aValue) then
    raise EComponentError.CreateResFmt(@SInvalidName, [aValue]);
  {$EndIf DesignTimeLibrary}
  ChangeName(f_Name, aValue);
  SetCaptionFromName(aValue);
  f_Name := aValue;
  NameChanged;
 end;//f_Name <> aName
//#UC END# *55CCB8960010_55D076150061set_impl*
end;//TvcmBaseCollectionItemPrim.pm_SetName

function TvcmBaseCollectionItemPrim.pm_GetCaption: AnsiString;
//#UC START# *55CCB95D0197_55D076150061get_var*
//#UC END# *55CCB95D0197_55D076150061get_var*
begin
//#UC START# *55CCB95D0197_55D076150061get_impl*
 Result := f_Caption;
//#UC END# *55CCB95D0197_55D076150061get_impl*
end;//TvcmBaseCollectionItemPrim.pm_GetCaption

procedure TvcmBaseCollectionItemPrim.pm_SetCaption(const aValue: AnsiString);
//#UC START# *55CCB95D0197_55D076150061set_var*
//#UC END# *55CCB95D0197_55D076150061set_var*
begin
//#UC START# *55CCB95D0197_55D076150061set_impl*
 if (Caption <> aValue) then
  DoSetCaption(aValue);
//#UC END# *55CCB95D0197_55D076150061set_impl*
end;//TvcmBaseCollectionItemPrim.pm_SetCaption

procedure TvcmBaseCollectionItemPrim.SetCaptionFromName(const aName: AnsiString);
//#UC START# *55CCB9830041_55D076150061_var*
//#UC END# *55CCB9830041_55D076150061_var*
begin
//#UC START# *55CCB9830041_55D076150061_impl*
 if (Name = Caption) then
  Caption := aName;
//#UC END# *55CCB9830041_55D076150061_impl*
end;//TvcmBaseCollectionItemPrim.SetCaptionFromName

procedure TvcmBaseCollectionItemPrim.NameChanged;
//#UC START# *55CCBA65014E_55D076150061_var*
//#UC END# *55CCBA65014E_55D076150061_var*
begin
//#UC START# *55CCBA65014E_55D076150061_impl*
//#UC END# *55CCBA65014E_55D076150061_impl*
end;//TvcmBaseCollectionItemPrim.NameChanged

procedure TvcmBaseCollectionItemPrim.DoSetCaption(const aName: AnsiString);
//#UC START# *55CCB9A30160_55D076150061_var*
//#UC END# *55CCB9A30160_55D076150061_var*
begin
//#UC START# *55CCB9A30160_55D076150061_impl*
 ChangeCaption(Caption, aName);
 f_Caption := aName;
 CaptionChanged;
//#UC END# *55CCB9A30160_55D076150061_impl*
end;//TvcmBaseCollectionItemPrim.DoSetCaption

procedure TvcmBaseCollectionItemPrim.ChangeName(const anOld: AnsiString;
 const aNew: AnsiString);
//#UC START# *55CCBA3C0190_55D076150061_var*
//#UC END# *55CCBA3C0190_55D076150061_var*
begin
//#UC START# *55CCBA3C0190_55D076150061_impl*
//#UC END# *55CCBA3C0190_55D076150061_impl*
end;//TvcmBaseCollectionItemPrim.ChangeName

function TvcmBaseCollectionItemPrim.MakeID(const aName: AnsiString): Integer;
//#UC START# *55CCBAAB00F4_55D076150061_var*
//#UC END# *55CCBAAB00F4_55D076150061_var*
begin
//#UC START# *55CCBAAB00F4_55D076150061_impl*
 Assert(false, 'Данная коллекция не поддерживает поиска элемента по идентификатору');
 Result := -1;
//#UC END# *55CCBAAB00F4_55D076150061_impl*
end;//TvcmBaseCollectionItemPrim.MakeID

function TvcmBaseCollectionItemPrim.GetID: Integer;
//#UC START# *55CCBAC800F0_55D076150061_var*
//#UC END# *55CCBAC800F0_55D076150061_var*
begin
//#UC START# *55CCBAC800F0_55D076150061_impl*
 Assert(false, 'Данная коллекция не поддерживает поиска элемента по идентификатору');
 Result := -1;
//#UC END# *55CCBAC800F0_55D076150061_impl*
end;//TvcmBaseCollectionItemPrim.GetID

procedure TvcmBaseCollectionItemPrim.ChangeCaption(const anOld: AnsiString;
 const aNew: AnsiString);
//#UC START# *55CCBA8003C7_55D076150061_var*
//#UC END# *55CCBA8003C7_55D076150061_var*
begin
//#UC START# *55CCBA8003C7_55D076150061_impl*
//#UC END# *55CCBA8003C7_55D076150061_impl*
end;//TvcmBaseCollectionItemPrim.ChangeCaption

procedure TvcmBaseCollectionItemPrim.CaptionChanged;
//#UC START# *55CCBA910119_55D076150061_var*
//#UC END# *55CCBA910119_55D076150061_var*
begin
//#UC START# *55CCBA910119_55D076150061_impl*
 if Assigned(Collection) then
  TvcmBaseCollection(Collection).CaptionChanged(Self);
//#UC END# *55CCBA910119_55D076150061_impl*
end;//TvcmBaseCollectionItemPrim.CaptionChanged

function TvcmBaseCollectionItemPrim.GetCaptionStored: Boolean;
//#UC START# *55CCBA0103DE_55D076150061_var*
//#UC END# *55CCBA0103DE_55D076150061_var*
begin
//#UC START# *55CCBA0103DE_55D076150061_impl*
 Result := (Caption <> Name);
//#UC END# *55CCBA0103DE_55D076150061_impl*
end;//TvcmBaseCollectionItemPrim.GetCaptionStored

function TvcmBaseCollectionItemPrim.CaptionStored: Boolean;
 {* "Функция определяющая, что свойство Caption сохраняется" }
//#UC START# *BFBB04A0E452_55D076150061_var*
//#UC END# *BFBB04A0E452_55D076150061_var*
begin
//#UC START# *BFBB04A0E452_55D076150061_impl*
 Result := GetCaptionStored;
//#UC END# *BFBB04A0E452_55D076150061_impl*
end;//TvcmBaseCollectionItemPrim.CaptionStored

procedure TvcmBaseCollectionItemPrim.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_55D076150061_var*
//#UC END# *478CF34E02CE_55D076150061_var*
begin
//#UC START# *478CF34E02CE_55D076150061_impl*
 if (Source is TvcmBaseCollectionItem) then
 begin
  Name := TvcmBaseCollectionItem(Source).Name;
  Caption := TvcmBaseCollectionItem(Source).Caption;
 end//P is TvcmBaseCollectionItem
 else
  inherited;
//#UC END# *478CF34E02CE_55D076150061_impl*
end;//TvcmBaseCollectionItemPrim.Assign

procedure TvcmBaseCollectionItemPrim.BeforeAddToCache;
 {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
//#UC START# *479F2B3302C1_55D076150061_var*
//#UC END# *479F2B3302C1_55D076150061_var*
begin
//#UC START# *479F2B3302C1_55D076150061_impl*
 inherited;
 f_Name := '';
 f_Caption := '';
//#UC END# *479F2B3302C1_55D076150061_impl*
end;//TvcmBaseCollectionItemPrim.BeforeAddToCache

function TvcmBaseCollectionItemPrim.GetDisplayName: String;
//#UC START# *55CCBB5A01E5_55D076150061_var*
//#UC END# *55CCBB5A01E5_55D076150061_var*
begin
//#UC START# *55CCBB5A01E5_55D076150061_impl*
 Result := Caption;
//#UC END# *55CCBB5A01E5_55D076150061_impl*
end;//TvcmBaseCollectionItemPrim.GetDisplayName

function TvcmBaseCollectionItemPrim.GetNamePath: String;
//#UC START# *55CCBC12038F_55D076150061_var*
var
 l_Owner: TPersistent;
//#UC END# *55CCBC12038F_55D076150061_var*
begin
//#UC START# *55CCBC12038F_55D076150061_impl*
 if (Name = '') then
  Result := inherited GetNamePath
 else
 begin
  Result := Name;
  if (Collection <> nil) then
  begin
   l_Owner := Collection.Owner;
   if (l_Owner is TvcmBaseCollectionItem) then
    Result := TvcmBaseCollectionItem(l_Owner).Name + '.' + Result
   else
   if (l_Owner is TComponent) then
    Result := TComponent(l_Owner).Name + '.' + Result
   else
    Result := Collection.GetNamePath + '.' + Result;
  end;//Collection <> nil
 end;//Name = ''
//#UC END# *55CCBC12038F_55D076150061_impl*
end;//TvcmBaseCollectionItemPrim.GetNamePath

//#UC START# *4FFC3347011Fimpl*
//#UC END# *4FFC3347011Fimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmBaseCollectionItemPrim);
 {* Регистрация TvcmBaseCollectionItemPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmBaseCollectionItem);
 {* Регистрация TvcmBaseCollectionItem }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
