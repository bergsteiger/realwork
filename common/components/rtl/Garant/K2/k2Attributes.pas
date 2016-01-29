unit k2Attributes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2Attributes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::TagAttributes::Tk2Attributes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Tags,
  l3ProtoDataContainer,
  l3Memory,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Except,
  Classes
  ;

type
 Tk2Attribute = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   rName : AnsiString;
   rID : Integer;
   rIsAlias : Boolean;
 public
    function Compare(const anOther: Tk2Attribute): Integer;
 end;//Tk2Attribute

 _ItemType_ = Tk2Attribute;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 Tk2Attributes = class(_l3RecordListPrim_)
 private
 // private fields
   f_IDDelta : Integer;
 protected
 // overridden protected methods
   procedure InitFields; override;
 public
 // public methods
   function IDByName(const aName: AnsiString): Integer;
   function NameByID(anID: Integer): AnsiString;
   function CheckIDByName(const aName: AnsiString): Integer;
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: Tk2Attributes;
    {- возвращает экземпляр синглетона. }
 end;//Tk2Attributes

function Tk2Attribute_C(aTagID: Tk2TagID): Tk2Attribute; overload;
function Tk2Attribute_C(aTagID: Tk2TagID;
     const anAlias: AnsiString): Tk2Attribute; overload;
function Tk2Attribute_ForFind(const aName: AnsiString): Tk2Attribute;
function Tk2Attribute_New(anID: Integer;
     const aName: AnsiString): Tk2Attribute;

implementation

uses
  l3Base {a},
  TypInfo,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;


// start class Tk2Attributes

var g_Tk2Attributes : Tk2Attributes = nil;

procedure Tk2AttributesFree;
begin
 l3Free(g_Tk2Attributes);
end;

class function Tk2Attributes.Instance: Tk2Attributes;
begin
 if (g_Tk2Attributes = nil) then
 begin
  l3System.AddExitProc(Tk2AttributesFree);
  g_Tk2Attributes := Create;
 end;
 Result := g_Tk2Attributes;
end;


{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_53A963F700CD_var*
//#UC END# *47B07CF403D0_53A963F700CD_var*
begin
//#UC START# *47B07CF403D0_53A963F700CD_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_53A963F700CD_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_53A963F700CD_var*
//#UC END# *47B2C42A0163_53A963F700CD_var*
begin
//#UC START# *47B2C42A0163_53A963F700CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_53A963F700CD_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_53A963F700CD_var*
//#UC END# *47B99D4503A2_53A963F700CD_var*
begin
//#UC START# *47B99D4503A2_53A963F700CD_impl*
 Result := CI.rA^.Compare(CI.rB^);
//#UC END# *47B99D4503A2_53A963F700CD_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2Attributes;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

// start class Tk2Attributes

function Tk2Attributes.IDByName(const aName: AnsiString): Integer;
//#UC START# *53A9843302D9_53A963F700CD_var*
var
 l_Index : Integer;
//#UC END# *53A9843302D9_53A963F700CD_var*
begin
//#UC START# *53A9843302D9_53A963F700CD_impl*
 if FindData(Tk2Attribute_ForFind(aName), l_Index) then
  Result := Items[l_Index].rID
 else
  Result := -1;
//#UC END# *53A9843302D9_53A963F700CD_impl*
end;//Tk2Attributes.IDByName

function Tk2Attributes.NameByID(anID: Integer): AnsiString;
//#UC START# *53A9847000CA_53A963F700CD_var*
var
 l_Index : Integer;
 l_Item : Tk2Attribute;
//#UC END# *53A9847000CA_53A963F700CD_var*
begin
//#UC START# *53A9847000CA_53A963F700CD_impl*
 Result := '';
 for l_Index := 0 to Pred(Count) do
 begin
  l_Item := Items[l_Index];
  if not l_Item.rIsAlias AND (l_Item.rID = anID) then
  begin
   Result := l_Item.rName;
   break;
  end;//l_Item.rID = anID
 end;//for l_Index
//#UC END# *53A9847000CA_53A963F700CD_impl*
end;//Tk2Attributes.NameByID

function Tk2Attributes.CheckIDByName(const aName: AnsiString): Integer;
//#UC START# *53A991E60226_53A963F700CD_var*
//#UC END# *53A991E60226_53A963F700CD_var*
begin
//#UC START# *53A991E60226_53A963F700CD_impl*
 Result := IDByName(aName);
 if (Result < 0) then
 begin
  Inc(f_IDDelta);
  Result := f_IDDelta + Ord(High(Tk2TagID));
  Self.Add(Tk2Attribute_New(Result, aName));
 end;//Result < 0
//#UC END# *53A991E60226_53A963F700CD_impl*
end;//Tk2Attributes.CheckIDByName
// start class Tk2Attribute

function Tk2Attribute.Compare(const anOther: Tk2Attribute): Integer;
//#UC START# *53A965100324_53A9648F013C_var*
//#UC END# *53A965100324_53A9648F013C_var*
begin
//#UC START# *53A965100324_53A9648F013C_impl*
 Result := ANSICompareText(rName, anOther.rName);
//#UC END# *53A965100324_53A9648F013C_impl*
end;//Tk2Attribute.Compare

function Tk2Attribute_C(aTagID: Tk2TagID): Tk2Attribute;
//#UC START# *53A9654E0056_53A9648F013C_var*
var
 l_Name : AnsiString;
//#UC END# *53A9654E0056_53A9648F013C_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *53A9654E0056_53A9648F013C_impl*
 l_Name := GetEnumName(TypeInfo(Tk2TagID), Ord(aTagID));
 l_Name := Copy(l_Name, 7, Length(l_Name)-6);
 Result := Tk2Attribute_C(aTagID, l_Name);
 Result.rIsAlias := false;
//#UC END# *53A9654E0056_53A9648F013C_impl*
end;//Tk2Attribute.C


function Tk2Attribute_C(aTagID: Tk2TagID;
        const anAlias: AnsiString): Tk2Attribute;
//#UC START# *53A96C5502B0_53A9648F013C_var*
//#UC END# *53A96C5502B0_53A9648F013C_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *53A96C5502B0_53A9648F013C_impl*
 Result.rID := Ord(aTagID);
 Result.rName := anAlias;
 Result.rIsAlias := true;
//#UC END# *53A96C5502B0_53A9648F013C_impl*
end;//Tk2Attribute.C


function Tk2Attribute_ForFind(const aName: AnsiString): Tk2Attribute;
//#UC START# *53A988CC00D2_53A9648F013C_var*
//#UC END# *53A988CC00D2_53A9648F013C_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *53A988CC00D2_53A9648F013C_impl*
 Result.rID := -1;
 Result.rName := aName;
//#UC END# *53A988CC00D2_53A9648F013C_impl*
end;//Tk2Attribute.ForFind


function Tk2Attribute_New(anID: Integer;
        const aName: AnsiString): Tk2Attribute;
//#UC START# *53A99219013B_53A9648F013C_var*
//#UC END# *53A99219013B_53A9648F013C_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *53A99219013B_53A9648F013C_impl*
 Result.rID := anID;
 REsult.rName := aName;
//#UC END# *53A99219013B_53A9648F013C_impl*
end;//Tk2Attribute.New

// start class Tk2Attributes

class function Tk2Attributes.Exists: Boolean;
 {-}
begin
 Result := g_Tk2Attributes <> nil;
end;//Tk2Attributes.Exists

procedure Tk2Attributes.InitFields;
//#UC START# *47A042E100E2_53A963F700CD_var*
var
 l_Index : Tk2TagID;
//#UC END# *47A042E100E2_53A963F700CD_var*
begin
//#UC START# *47A042E100E2_53A963F700CD_impl*
 inherited;
 Sorted := true;
 for l_Index := Low(Tk2TagID) to High(Tk2TagID) do
  Self.Add(Tk2Attribute_C(l_Index));
 Self.Add(Tk2Attribute_C(_k2_tiChecks, 'Checked'));
 Self.Add(Tk2Attribute_C(_k2_tiHeaders, 'Header'));
 Self.Add(Tk2Attribute_C(_k2_tiFooters, 'Footer'));
 Self.Add(Tk2Attribute_C(_k2_tiCollapsed, 'Collapsable'));
 Self.Add(Tk2Attribute_C(_k2_tiContentsLevel6, 'ContentsLevel'));
 Self.Add(Tk2Attribute_C(_k2_tiBitmap, 'Data'));
//#UC END# *47A042E100E2_53A963F700CD_impl*
end;//Tk2Attributes.InitFields

end.