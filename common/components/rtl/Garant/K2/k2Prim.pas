unit k2Prim;

// Модуль: "w:\common\components\rtl\Garant\K2\k2Prim.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "k2Prim" MUID: (4A4DE48C0344)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Classes
 , l3Variant
 , l3Interfaces
 , l3Types
 , TypInfo
 , l3ProtoIntegerList
 , k2PropertyArray
;

type
 Tk2TypeTablePrim = {abstract} class(Tl3ProtoObject)
  public
   class procedure AddCreatedListener(aListener: TNotifyEvent); virtual;
 end;//Tk2TypeTablePrim

 Tk2TypePrim = class;

 Tk2CustomPropertyPrim = class;

 Tk2Base = {abstract} class(Tl3VariantDef)
  protected
   function pm_GetTagType: Tk2TypePrim; virtual; abstract;
   function pm_GetAsProp: Tk2CustomPropertyPrim; virtual;
  public
   property TagType: Tk2TypePrim
    read pm_GetTagType;
   property AsProp: Tk2CustomPropertyPrim
    read pm_GetAsProp;
 end;//Tk2Base

 Tk2TypePrimPrim = class;

 Tk2CustomPropertyPrim = {abstract} class(Tk2Base)
  {* Базовое описание свойств }
  private
   f_TagIndex: Integer;
   f_AtomType: Tk2TypePrimPrim;
   f_NeedMarkModified: Boolean;
   f_Shared: Boolean;
   f_AtomIndex: Integer;
   f_ParentType: Tk2TypePrimPrim;
  protected
   f_tmpName: AnsiString;
  protected
   procedure pm_SetAtomType(aValue: Tk2TypePrimPrim);
   function pm_GetEmptyMapping: Integer; virtual; abstract;
   function pm_GetReadOnly: Boolean; virtual; abstract;
   function pm_GetMappingTarget: Integer; virtual; abstract;
   function pm_GetDefaultValue: Integer; virtual; abstract;
   function pm_GetTagType: Tk2TypePrim; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetAsPCharLen: Tl3WString; override;
   function GetOwner: TPersistent; override;
   function GetIsProp: Boolean; override;
   function pm_GetAsProp: Tk2CustomPropertyPrim; override;
   procedure pm_SetIDw(aValue: Integer); override;
   function DoDoMakeTag(aRef: Integer): Il3TagRef; override;
  public
   constructor Create(anOwner: Tk2TypePrim); reintroduce;
   function IsThisArray(out theProp: Tl3VariantDef): Boolean; virtual;
  public
   property TagIndex: Integer
    read f_TagIndex;
   property AtomType: Tk2TypePrimPrim
    read f_AtomType
    write pm_SetAtomType;
   property EmptyMapping: Integer
    read pm_GetEmptyMapping;
   property ReadOnly: Boolean
    read pm_GetReadOnly;
   property MappingTarget: Integer
    read pm_GetMappingTarget;
   property NeedMarkModified: Boolean
    read f_NeedMarkModified
    write f_NeedMarkModified;
   property DefaultValue: Integer
    read pm_GetDefaultValue;
   property Shared: Boolean
    read f_Shared
    write f_Shared;
   property AtomIndex: Integer
    read f_AtomIndex
    write f_AtomIndex;
   property ParentType: Tk2TypePrimPrim
    read f_ParentType;
 end;//Tk2CustomPropertyPrim

 Tk2TypeIDPrim = Byte;

 Tk2TypeIDSet = set of Tk2TypeIDPrim;

 Tk2TypeIDs = class(Tl3ProtoIntegerList)
  private
   f_Small: Tk2TypeIDSet;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   function Has(aTypeID: Integer): Boolean;
   procedure Include(aTypeID: Integer);
   procedure Assign(anOther: Tk2TypeIDs);
 end;//Tk2TypeIDs

 Tk2TypePrimPrim = {abstract} class(Tk2Base)
  private
   f_IsParents: Tk2TypeIDs;
   f_IsNotParents: Tk2TypeIDs;
   f_ID: Integer;
   f_AtomType: PTypeInfo;
   f_DisabledChildTypeIDs: Tk2TypeIDs;
    {* Типы запрещённых детей }
   f_FormatInfoFactory: TClass;
    {* Фабрика для изотовления информации о форматировании }
   f_TypeTable: Tk2TypeTablePrim;
  protected
   f_IsOrd: Tl3Bool;
  protected
   procedure pm_SetAtomType(aValue: PTypeInfo);
   procedure pm_SetDisabledChildTypeIDs(aValue: Tk2TypeIDs);
   function pm_GetTagType: Tk2TypePrim; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetIsOrd: Boolean; override;
   function GetIsKindOfPrim(aType: Tl3VariantDef): Boolean; override;
  public
   function IsDisabledChildTypeID(anID: Integer): Boolean;
    {* Проверяет, что тип ребёнка является запрещённым }
   procedure AddDisabledChildTypeID(anID: Integer);
    {* Добавляет тип запрещённого ребёнка }
   function DefaultChildTypeID: Tk2TypePrim;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; virtual;
   procedure InheritsFrom;
  protected
   property DisabledChildTypeIDs: Tk2TypeIDs
    read f_DisabledChildTypeIDs
    write pm_SetDisabledChildTypeIDs;
    {* Типы запрещённых детей }
  public
   property ID: Integer
    read f_ID;
   property AtomType: PTypeInfo
    read f_AtomType
    write pm_SetAtomType;
   property FormatInfoFactory: TClass
    read f_FormatInfoFactory
    write f_FormatInfoFactory;
    {* Фабрика для изотовления информации о форматировании }
   property TypeTable: Tk2TypeTablePrim
    read f_TypeTable
    write f_TypeTable;
 end;//Tk2TypePrimPrim

 Ik2Op = Il3OpPack;
  {* Пачка операций. }

 Tk2PropertyArray = k2PropertyArray.Tk2PropertyArray;

 Tk2TypePrim = {abstract} class(Tk2TypePrimPrim)
  {* Базовое описание типа }
  protected
   f_Tags: Tk2PropertyArray;
  protected
   function pm_GetProp(TagIndex: Integer): Tk2CustomPropertyPrim;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   function GetAsPCharLen: Tl3WString; override;
   procedure pm_SetIDw(aValue: Integer); override;
  public
   property Prop[TagIndex: Integer]: Tk2CustomPropertyPrim
    read pm_GetProp;
    {* Свойства тега }
 end;//Tk2TypePrim

 Tk2ArrayPropertyPrim = Tk2CustomPropertyPrim;

 Ik2Processor = l3Variant.Ik2Processor;

 Il3OpPackMode = l3Variant.Il3OpPackMode;

 Il3OpPack = l3Variant.Il3OpPack;

implementation

uses
 l3ImplUses
 , k2TypeTableCreatedListeners
 , SysUtils
 , l3String
 , k2Attributes
 , k2Tags
 , k2Empty_Const
 , k2BaseHack
;

type
 Pk2CustomPropertyPrim = ^Tk2CustomPropertyPrim;

class procedure Tk2TypeTablePrim.AddCreatedListener(aListener: TNotifyEvent);
//#UC START# *53C7DA31003C_4A4E1F7A029F_var*
//#UC END# *53C7DA31003C_4A4E1F7A029F_var*
begin
//#UC START# *53C7DA31003C_4A4E1F7A029F_impl*
 Tk2TypeTableCreatedListeners.Instance.AddListener(aListener);
//#UC END# *53C7DA31003C_4A4E1F7A029F_impl*
end;//Tk2TypeTablePrim.AddCreatedListener

function Tk2Base.pm_GetAsProp: Tk2CustomPropertyPrim;
//#UC START# *4A4DE5AF036A_4A4DE0BF039Eget_var*
//#UC END# *4A4DE5AF036A_4A4DE0BF039Eget_var*
begin
//#UC START# *4A4DE5AF036A_4A4DE0BF039Eget_impl*
 Result := nil;
//#UC END# *4A4DE5AF036A_4A4DE0BF039Eget_impl*
end;//Tk2Base.pm_GetAsProp

procedure Tk2CustomPropertyPrim.pm_SetAtomType(aValue: Tk2TypePrimPrim);
//#UC START# *4A4DEE580305_4A4DE5850182set_var*
//#UC END# *4A4DEE580305_4A4DE5850182set_var*
begin
//#UC START# *4A4DEE580305_4A4DE5850182set_impl*
 if (f_AtomType <> aValue) then
 begin
(*  if (f_AtomType <> f_ParentType) then
   FreeAndNil(f_AtomType);*)
  f_AtomType := aValue;
(*  if (f_AtomType <> f_ParentType) then
   f_AtomType.Use;*)
 end;//f_AtomType <> aValue
//#UC END# *4A4DEE580305_4A4DE5850182set_impl*
end;//Tk2CustomPropertyPrim.pm_SetAtomType

constructor Tk2CustomPropertyPrim.Create(anOwner: Tk2TypePrim);
//#UC START# *4B85667B0066_4A4DE5850182_var*
//#UC END# *4B85667B0066_4A4DE5850182_var*
begin
//#UC START# *4B85667B0066_4A4DE5850182_impl*
 inherited Create;
 f_ParentType := anOwner;
//#UC END# *4B85667B0066_4A4DE5850182_impl*
end;//Tk2CustomPropertyPrim.Create

function Tk2CustomPropertyPrim.IsThisArray(out theProp: Tl3VariantDef): Boolean;
//#UC START# *5357A18303D6_4A4DE5850182_var*
//#UC END# *5357A18303D6_4A4DE5850182_var*
begin
//#UC START# *5357A18303D6_4A4DE5850182_impl*
 Result := false;
 theProp := nil;
//#UC END# *5357A18303D6_4A4DE5850182_impl*
end;//Tk2CustomPropertyPrim.IsThisArray

function Tk2CustomPropertyPrim.pm_GetTagType: Tk2TypePrim;
//#UC START# *4A4DE5340236_4A4DE5850182get_var*
//#UC END# *4A4DE5340236_4A4DE5850182get_var*
begin
//#UC START# *4A4DE5340236_4A4DE5850182get_impl*
 Result := Tk2TypePrim(AtomType);
//#UC END# *4A4DE5340236_4A4DE5850182get_impl*
end;//Tk2CustomPropertyPrim.pm_GetTagType

procedure Tk2CustomPropertyPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A4DE5850182_var*
//#UC END# *479731C50290_4A4DE5850182_var*
begin
//#UC START# *479731C50290_4A4DE5850182_impl*
 pm_SetAtomType(nil);
 inherited;
//#UC END# *479731C50290_4A4DE5850182_impl*
end;//Tk2CustomPropertyPrim.Cleanup

function Tk2CustomPropertyPrim.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_4A4DE5850182_var*
//#UC END# *47A869BB02DE_4A4DE5850182_var*
begin
//#UC START# *47A869BB02DE_4A4DE5850182_impl*
 if (f_tmpName = '') then
 begin
  f_tmpName := Tk2Attributes.Instance.NameByID(TagIndex);
(*  f_tmpName := GetEnumName(TypeInfo(_Tk2TagID), TagIndex);
  f_tmpName := Copy(f_tmpName, 7, Length(f_tmpName)-6);*)
 end;{f_tmpName = ''}
 Result := l3PCharLen(f_TmpName);
//#UC END# *47A869BB02DE_4A4DE5850182_impl*
end;//Tk2CustomPropertyPrim.GetAsPCharLen

function Tk2CustomPropertyPrim.GetOwner: TPersistent;
//#UC START# *480DD1890221_4A4DE5850182_var*
//#UC END# *480DD1890221_4A4DE5850182_var*
begin
//#UC START# *480DD1890221_4A4DE5850182_impl*
 Result := f_ParentType;
//#UC END# *480DD1890221_4A4DE5850182_impl*
end;//Tk2CustomPropertyPrim.GetOwner

function Tk2CustomPropertyPrim.GetIsProp: Boolean;
//#UC START# *4A4DE1FE035C_4A4DE5850182_var*
//#UC END# *4A4DE1FE035C_4A4DE5850182_var*
begin
//#UC START# *4A4DE1FE035C_4A4DE5850182_impl*
 Result := true;
//#UC END# *4A4DE1FE035C_4A4DE5850182_impl*
end;//Tk2CustomPropertyPrim.GetIsProp

function Tk2CustomPropertyPrim.pm_GetAsProp: Tk2CustomPropertyPrim;
//#UC START# *4A4DE5AF036A_4A4DE5850182get_var*
//#UC END# *4A4DE5AF036A_4A4DE5850182get_var*
begin
//#UC START# *4A4DE5AF036A_4A4DE5850182get_impl*
 Result := Self;
//#UC END# *4A4DE5AF036A_4A4DE5850182get_impl*
end;//Tk2CustomPropertyPrim.pm_GetAsProp

procedure Tk2CustomPropertyPrim.pm_SetIDw(aValue: Integer);
//#UC START# *5331A12D0103_4A4DE5850182set_var*
//#UC END# *5331A12D0103_4A4DE5850182set_var*
begin
//#UC START# *5331A12D0103_4A4DE5850182set_impl*
 f_TagIndex := aValue;
//#UC END# *5331A12D0103_4A4DE5850182set_impl*
end;//Tk2CustomPropertyPrim.pm_SetIDw

function Tk2CustomPropertyPrim.DoDoMakeTag(aRef: Integer): Il3TagRef;
//#UC START# *5356910A0042_4A4DE5850182_var*
//#UC END# *5356910A0042_4A4DE5850182_var*
begin
//#UC START# *5356910A0042_4A4DE5850182_impl*
 Result := AtomType.MakeTag(aRef);
//#UC END# *5356910A0042_4A4DE5850182_impl*
end;//Tk2CustomPropertyPrim.DoDoMakeTag

function Tk2TypeIDs.Has(aTypeID: Integer): Boolean;
//#UC START# *54785FC20224_4A4E1D7C01DB_var*
var
 l_Index : Integer;
//#UC END# *54785FC20224_4A4E1D7C01DB_var*
begin
//#UC START# *54785FC20224_4A4E1D7C01DB_impl*
 if (Self = nil) then
  Result := false
 else
 begin
  Assert(aTypeID >= Ord(Low(Tk2TypeIDPrim)) + 1);
  if (aTypeID <= Ord(High(Tk2TypeIDPrim))) then
   Result := Tk2TypeIDPrim(aTypeID) in f_Small
  else
   Result := FindData(aTypeID, l_Index);
 end;//Self = nil
//#UC END# *54785FC20224_4A4E1D7C01DB_impl*
end;//Tk2TypeIDs.Has

procedure Tk2TypeIDs.Include(aTypeID: Integer);
//#UC START# *54785FF603C6_4A4E1D7C01DB_var*
//#UC END# *54785FF603C6_4A4E1D7C01DB_var*
begin
//#UC START# *54785FF603C6_4A4E1D7C01DB_impl*
 Assert(Self <> nil);
 Assert(aTypeID >= Ord(Low(Tk2TypeIDPrim)) + 1);
 if (aTypeID <= Ord(High(Tk2TypeIDPrim))) then
  f_Small := f_Small + [Tk2TypeIDPrim(aTypeID)]
 else
  Add(aTypeID);
//#UC END# *54785FF603C6_4A4E1D7C01DB_impl*
end;//Tk2TypeIDs.Include

procedure Tk2TypeIDs.Assign(anOther: Tk2TypeIDs);
//#UC START# *547863510376_4A4E1D7C01DB_var*
//#UC END# *547863510376_4A4E1D7C01DB_var*
begin
//#UC START# *547863510376_4A4E1D7C01DB_impl*
 Assert(Self <> nil);
 if (anOther = nil) then
 begin
  Clear;
  f_Small := [];
 end//anOther = nil
 else
 begin
  inherited Assign(anOther);
  f_Small := anOther.f_Small;
 end;//anOther = nil
//#UC END# *547863510376_4A4E1D7C01DB_impl*
end;//Tk2TypeIDs.Assign

procedure Tk2TypeIDs.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A4E1D7C01DB_var*
//#UC END# *479731C50290_4A4E1D7C01DB_var*
begin
//#UC START# *479731C50290_4A4E1D7C01DB_impl*
 inherited;
//#UC END# *479731C50290_4A4E1D7C01DB_impl*
end;//Tk2TypeIDs.Cleanup

procedure Tk2TypeIDs.InitFields;
//#UC START# *47A042E100E2_4A4E1D7C01DB_var*
//#UC END# *47A042E100E2_4A4E1D7C01DB_var*
begin
//#UC START# *47A042E100E2_4A4E1D7C01DB_impl*
 inherited;
//#UC END# *47A042E100E2_4A4E1D7C01DB_impl*
end;//Tk2TypeIDs.InitFields

procedure Tk2TypePrimPrim.pm_SetAtomType(aValue: PTypeInfo);
//#UC START# *4A533DF0031C_4FFEF43201C7set_var*
//#UC END# *4A533DF0031C_4FFEF43201C7set_var*
begin
//#UC START# *4A533DF0031C_4FFEF43201C7set_impl*
 if (f_AtomType <> nil) AND (aValue <> nil) then
 begin
  if (f_AtomType.Kind <> aValue.Kind) then
  begin
   if not (f_AtomType.Kind in [tkInteger, tkChar, tkEnumeration, tkSet]) OR
      not (aValue.Kind in [tkInteger, tkChar, tkEnumeration, tkSet]) then
    raise Exception.Create('При наследовании типов тегов нельзя смешивать атомарные и структурированные типы');  
  end;//f_AtomType.Kind <> aValue.Kind
 end;//f_AtomType <> nil
 f_AtomType := aValue;
//#UC END# *4A533DF0031C_4FFEF43201C7set_impl*
end;//Tk2TypePrimPrim.pm_SetAtomType

procedure Tk2TypePrimPrim.pm_SetDisabledChildTypeIDs(aValue: Tk2TypeIDs);
//#UC START# *4C177F23037E_4FFEF43201C7set_var*
//#UC END# *4C177F23037E_4FFEF43201C7set_var*
begin
//#UC START# *4C177F23037E_4FFEF43201C7set_impl*
 if (aValue = nil) then
 begin
  if (f_DisabledChildTypeIDs <> nil) then
   f_DisabledChildTypeIDs.Assign(aValue);
 end//aValue = nil
 else
 begin
  if (f_DisabledChildTypeIDs = nil) then
   f_DisabledChildTypeIDs := Tk2TypeIDs.Create;
  f_DisabledChildTypeIDs.Assign(aValue);
 end;//aValue = nil
//#UC END# *4C177F23037E_4FFEF43201C7set_impl*
end;//Tk2TypePrimPrim.pm_SetDisabledChildTypeIDs

function Tk2TypePrimPrim.IsDisabledChildTypeID(anID: Integer): Boolean;
 {* Проверяет, что тип ребёнка является запрещённым }
//#UC START# *4C177E9D0375_4FFEF43201C7_var*
//#UC END# *4C177E9D0375_4FFEF43201C7_var*
begin
//#UC START# *4C177E9D0375_4FFEF43201C7_impl*
 Result := f_DisabledChildTypeIDs.Has(anID);
//#UC END# *4C177E9D0375_4FFEF43201C7_impl*
end;//Tk2TypePrimPrim.IsDisabledChildTypeID

procedure Tk2TypePrimPrim.AddDisabledChildTypeID(anID: Integer);
 {* Добавляет тип запрещённого ребёнка }
//#UC START# *4C177E4700AB_4FFEF43201C7_var*
//#UC END# *4C177E4700AB_4FFEF43201C7_var*
begin
//#UC START# *4C177E4700AB_4FFEF43201C7_impl*
 if (f_DisabledChildTypeIDs = nil) then
  f_DisabledChildTypeIDs := Tk2TypeIDs.Create;
 f_DisabledChildTypeIDs.Include(anID);
//#UC END# *4C177E4700AB_4FFEF43201C7_impl*
end;//Tk2TypePrimPrim.AddDisabledChildTypeID

function Tk2TypePrimPrim.DefaultChildTypeID: Tk2TypePrim;
//#UC START# *4A534133014D_4FFEF43201C7_var*
var
 l_Prop : Tk2ChildrenProperty;
//#UC END# *4A534133014D_4FFEF43201C7_var*
begin
//#UC START# *4A534133014D_4FFEF43201C7_impl*
 l_Prop := Tk2ChildrenProperty(Tk2TypePrim(Self).Prop[k2_tiChildren]);
 if (l_Prop = nil) then
  Result := k2_typEmpty
 else
  Result := l_Prop.DefaultChildType; 
//#UC END# *4A534133014D_4FFEF43201C7_impl*
end;//Tk2TypePrimPrim.DefaultChildTypeID

function Tk2TypePrimPrim.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
//#UC START# *4A4E01DA0396_4FFEF43201C7_var*
//#UC END# *4A4E01DA0396_4FFEF43201C7_var*
begin
//#UC START# *4A4E01DA0396_4FFEF43201C7_impl*
 Result := (Self = anAtomType);
//#UC END# *4A4E01DA0396_4FFEF43201C7_impl*
end;//Tk2TypePrimPrim.GetIsKindOf

procedure Tk2TypePrimPrim.InheritsFrom;
//#UC START# *52615ECC03BD_4FFEF43201C7_var*
//#UC END# *52615ECC03BD_4FFEF43201C7_var*
begin
//#UC START# *52615ECC03BD_4FFEF43201C7_impl*
 Assert(false);
//#UC END# *52615ECC03BD_4FFEF43201C7_impl*
end;//Tk2TypePrimPrim.InheritsFrom

function Tk2TypePrimPrim.pm_GetTagType: Tk2TypePrim;
//#UC START# *4A4DE5340236_4FFEF43201C7get_var*
//#UC END# *4A4DE5340236_4FFEF43201C7get_var*
begin
//#UC START# *4A4DE5340236_4FFEF43201C7get_impl*
 Result := Tk2TypePrim(Self);
//#UC END# *4A4DE5340236_4FFEF43201C7get_impl*
end;//Tk2TypePrimPrim.pm_GetTagType

procedure Tk2TypePrimPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4FFEF43201C7_var*
//#UC END# *479731C50290_4FFEF43201C7_var*
begin
//#UC START# *479731C50290_4FFEF43201C7_impl*
 FreeAndNil(f_IsParents);
 FreeAndNil(f_IsNotParents);
 FreeAndNil(f_DisabledChildTypeIDs);
 inherited;
//#UC END# *479731C50290_4FFEF43201C7_impl*
end;//Tk2TypePrimPrim.Cleanup

function Tk2TypePrimPrim.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_4FFEF43201C7_var*
//#UC END# *532AE8F2009A_4FFEF43201C7_var*
begin
//#UC START# *532AE8F2009A_4FFEF43201C7_impl*
 assert(Self <> nil);
 Case f_IsOrd of
  l3_bUnknown:
  begin
   if (AtomType = nil) then
    Result := (Tk2TypePrim(Self).f_Tags.Count = 0)
   else
    Result := AtomType.Kind in [tkInteger, tkChar, tkEnumeration, tkSet];
   if Result then
    f_IsOrd := l3_bTrue
   else
    f_IsOrd := l3_bFalse;
  end;//l3_bUnknown
  l3_bFalse:
   Result := false;
  l3_bTrue:
   Result := true;
  else
  begin
   Result := false;
   Assert(false);
  end;//else
 end;//Case f_IsOrd
//#UC END# *532AE8F2009A_4FFEF43201C7_impl*
end;//Tk2TypePrimPrim.GetIsOrd

function Tk2TypePrimPrim.GetIsKindOfPrim(aType: Tl3VariantDef): Boolean;
//#UC START# *533129DC037C_4FFEF43201C7_var*
//#UC END# *533129DC037C_4FFEF43201C7_var*
begin
//#UC START# *533129DC037C_4FFEF43201C7_impl*
 if (Self = nil) then
  Result := (aType = nil)
 else
 if (Self = aType) then
  Result := true
 else
 begin
  if (aType = nil) then
  begin
   Result := false;
   Exit;
  end;//anID = nil
  Assert(aType <> nil);
  if true(*((Tk2TypePrimPrim(aType).ID >= Ord(Low(Tk2TypeIDPrim))) AND
      (Tk2TypePrimPrim(aType).ID <= Ord(High(Tk2TypeIDPrim))))*) then
  begin
   if f_IsParents.Has(Tk2TypePrimPrim(aType).ID) then
    Result := true
   else
   if f_IsNotParents.Has(Tk2TypePrimPrim(aType).ID) then
    Result := false
   else
   begin
    Result := GetIsKindOf(Tk2TypePrim(aType));
    if Result then
    begin
     if (f_IsParents = nil) then
      f_IsParents := Tk2TypeIDs.Create;
     f_IsParents.Include(Tk2TypePrimPrim(aType).ID)
    end//Result
    else
    begin
     if (f_IsNotParents = nil) then
      f_IsNotParents := Tk2TypeIDs.Create;
     f_IsNotParents.Include(Tk2TypePrimPrim(aType).ID)
    end;//Result
   end;//anID in f_IsNotParent
  end//(anID >= Ord(Low(Tk2TypeIDPrim))..
  else
   Result := GetIsKindOf(Tk2TypePrim(aType));
 end;//ID = anID
//#UC END# *533129DC037C_4FFEF43201C7_impl*
end;//Tk2TypePrimPrim.GetIsKindOfPrim

function Tk2TypePrim.pm_GetProp(TagIndex: Integer): Tk2CustomPropertyPrim;
//#UC START# *4A4DEAE0006B_4A4DE5000202get_var*
//#UC END# *4A4DEAE0006B_4A4DE5000202get_var*
begin
//#UC START# *4A4DEAE0006B_4A4DE5000202get_impl*
(* if (f_LastProperty.rID = TagIndex) then
 begin
  Result := f_LastProperty.rProp;
 end
 else*)
 begin
(*  if (TagIndex > k2_tiLast) then
   Result := nil
  else*)
  begin
   Assert(Self <> nil);
   Assert(f_Tags <> nil);
   Result := Tk2CustomPropertyPrim(f_Tags.Items[TagIndex]);
(*   if (Result <> nil) then
   begin
    //Result := Pk2CustomPropertyPrim(Result)^;
    f_LastProperty.rID := TagIndex;
    f_LastProperty.rProp := Result;
   end;//Result <> nil*)
  end;//TagIndex > k2_tiLast
 end;//f_LastProperty.rID <> -1
//#UC END# *4A4DEAE0006B_4A4DE5000202get_impl*
end;//Tk2TypePrim.pm_GetProp

procedure Tk2TypePrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A4DE5000202_var*
//#UC END# *479731C50290_4A4DE5000202_var*
begin
//#UC START# *479731C50290_4A4DE5000202_impl*
 f_IsOrd := l3_bUnknown;
 inherited; 
//#UC END# *479731C50290_4A4DE5000202_impl*
end;//Tk2TypePrim.Cleanup

procedure Tk2TypePrim.InitFields;
//#UC START# *47A042E100E2_4A4DE5000202_var*
//#UC END# *47A042E100E2_4A4DE5000202_var*
begin
//#UC START# *47A042E100E2_4A4DE5000202_impl*
 inherited;
(* f_LastProperty.rID := -1;
 f_LastProperty.rProp := nil;*)
//#UC END# *47A042E100E2_4A4DE5000202_impl*
end;//Tk2TypePrim.InitFields

function Tk2TypePrim.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_4A4DE5000202_var*
//#UC END# *47A869BB02DE_4A4DE5000202_var*
begin
//#UC START# *47A869BB02DE_4A4DE5000202_impl*
 l3AssignNil(Result);
 Assert(false, 'Метод ' + ClassName + '.GetAsPCharLen должен быть переопределён в потомке');
//#UC END# *47A869BB02DE_4A4DE5000202_impl*
end;//Tk2TypePrim.GetAsPCharLen

procedure Tk2TypePrim.pm_SetIDw(aValue: Integer);
//#UC START# *5331A12D0103_4A4DE5000202set_var*
//#UC END# *5331A12D0103_4A4DE5000202set_var*
begin
//#UC START# *5331A12D0103_4A4DE5000202set_impl*
 f_ID := aValue;
//#UC END# *5331A12D0103_4A4DE5000202set_impl*
end;//Tk2TypePrim.pm_SetIDw

end.
