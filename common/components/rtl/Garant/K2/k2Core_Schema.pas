unit k2Core_Schema;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2Core_Schema.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TagTable::Class>> Shared Delphi::K2::CoreTypes::k2Core
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3Variant {a},
  k2Base {a},
  l3Interfaces {a},
  k2Interfaces {a},
  k2TypedAtomicTag {a}
  ;

type
 ObjectAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ObjectAtom

 SomeDataContainerAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//SomeDataContainerAtom

 StringTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//StringTag

 EmptyAtom = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//EmptyAtom

 l3BaseAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//l3BaseAtom

 OListTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//OListTag

 LongAtomClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Long" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//LongAtomClass

 LongAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//LongAtom

 EnumAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//EnumAtom

 BoolAtomClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Bool" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//BoolAtomClass

 BoolAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//BoolAtom

 FontNameTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//FontNameTag

 IUnknownAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//IUnknownAtom

 SetOfAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//SetOfAtom

 Tk2CoreSchema = class(Tk2TypeTable)
 public
 // типы, определённые в данной схеме:
   t_Object : ObjectAtom;
   t_SomeDataContainer : SomeDataContainerAtom;
   t_String : StringTag;
   t_Empty : EmptyAtom;
   t_l3Base : l3BaseAtom;
   t_OList : OListTag;
   t_Long : LongAtom;
   t_Enum : EnumAtom;
   t_Bool : BoolAtom;
   t_FontName : FontNameTag;
   t_IUnknown : IUnknownAtom;
   t_SetOf : SetOfAtom;
 protected
 // определяем стандартные методы схемы
   procedure Cleanup; override;
 public
   constructor Create; override;
 end;//Tk2CoreSchema

implementation

uses
  l3FontManager,
  k2String,
  k2Object_Const,
  k2SomeDataContainer_Const,
  k2String_Const,
  k2Empty_Const,
  k2l3Base_Const,
  k2OList_Const,
  k2Long_Const,
  k2Enum_Const,
  k2Bool_Const,
  k2FontName_Const,
  k2IUnknown_Const,
  k2SetOf_Const,
  SysUtils {a},
  TypInfo {a},
  k2Const {a},
  k2Tags {a},
  k2BaseStruct {a},
  l3Types {a},
  l3String {a},
  Object_Wrap,
  l3String_Wrap,
  l3List_Wrap,
  Long_Wrap,
  Enumeration_Wrap,
  Bool_Wrap,
  evFontName_Wrap,
  SetOf_Wrap,
  k2List,
  k2FontName,
  k2NonOptimizeContext {a}
  ;


// start class ObjectAtom

function ObjectAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Object'));
end;

function ObjectAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег Object');
end;

function SomeDataContainerAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('SomeDataContainer'));
end;

function SomeDataContainerAtom.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           Tk2CoreSchema(TypeTable).t_Object.IsKindOf(anAtomType);
end;

function SomeDataContainerAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег SomeDataContainer');
end;

function StringTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('String'));
end;

function StringTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           Tk2CoreSchema(TypeTable).t_SomeDataContainer.IsKindOf(anAtomType);
end;

function StringTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Tk2String.Make(Self);
end;

function EmptyAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Empty'));
end;

function EmptyAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег Empty');
end;

function l3BaseAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('l3Base'));
end;

function l3BaseAtom.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           Tk2CoreSchema(TypeTable).t_Object.IsKindOf(anAtomType);
end;

function l3BaseAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег l3Base');
end;

function OListTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('OList'));
end;

function OListTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           Tk2CoreSchema(TypeTable).t_SomeDataContainer.IsKindOf(anAtomType);
end;

function OListTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег OList');
end;

function LongAtomClass.GetTagType: Tl3Type;
begin
 Result := k2_typLong;
end;//LongAtomClass.TagType

function LongAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Long'));
end;

function LongAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, LongAtomClass);
end;

function EnumAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Enum'));
end;

function EnumAtom.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           Tk2CoreSchema(TypeTable).t_Long.IsKindOf(anAtomType);
end;

function EnumAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег Enum');
end;

function BoolAtomClass.GetTagType: Tl3Type;
begin
 Result := k2_typBool;
end;//BoolAtomClass.TagType

function BoolAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Bool'));
end;

function BoolAtom.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           Tk2CoreSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function BoolAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, BoolAtomClass);
end;

function FontNameTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('FontName'));
end;

function FontNameTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           Tk2CoreSchema(TypeTable).t_String.IsKindOf(anAtomType);
end;

function FontNameTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег FontName');
end;

function IUnknownAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('IUnknown'));
end;

function IUnknownAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег IUnknown');
end;

function SetOfAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('SetOf'));
end;

function SetOfAtom.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           Tk2CoreSchema(TypeTable).t_Long.IsKindOf(anAtomType);
end;

function SetOfAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег SetOf');
end;

constructor Tk2CoreSchema.Create;
begin
 inherited;
 // Object
 t_Object := DefineAutoType([], 'Базовый класс', ObjectAtom) As ObjectAtom;
 with t_Object do
 begin
  AtomClass := nil;
  WrapperType := WObject;
 end;//Object
 // SomeDataContainer
 t_SomeDataContainer := DefineAutoType([t_Object], '', SomeDataContainerAtom) As SomeDataContainerAtom;
 with t_SomeDataContainer do
 begin
  AtomClass := nil;
 end;//SomeDataContainer
 // String
 t_String := DefineAutoType([t_SomeDataContainer], 'Строка', StringTag) As StringTag;
 with t_String do
 begin
  AtomClass := Tk2String;
  WrapperType := Wl3String;
  with DefineProperty(k2_attrValue, t_String, 'Собственно строка.') do
  begin
  end;//Value
 end;//String
 // Empty
 t_Empty := DefineType(k2_idEmpty {0}, [], 'Запрещённое значение', EmptyAtom) As EmptyAtom;
 with t_Empty do
 begin
 end;//Empty
 // l3Base
 t_l3Base := DefineAutoType([t_Object], 'Базовый класс с подсчетом ссылок', l3BaseAtom) As l3BaseAtom;
 with t_l3Base do
 begin
 end;//l3Base
 // OList
 t_OList := DefineAutoType([t_SomeDataContainer], 'Список объектов', OListTag) As OListTag;
 with t_OList do
 begin
  AtomClass := Tk2List;
  WrapperType := Wl3List;
  with DefineChildren(t_l3Base) do
  begin
   ReadOnly := true;
  end;//
 end;//OList
 // Long
 t_Long := DefineAutoType([], 'Целое число', LongAtom) As LongAtom;
 with t_Long do
 begin
  AtomType := TypeInfo(Integer);
  WrapperType := WLong;
 end;//Long
 // Enum
 t_Enum := DefineAutoType([t_Long], 'Перечислимый тип', EnumAtom) As EnumAtom;
 with t_Enum do
 begin
  WrapperType := WEnumeration;
 end;//Enum
 // Bool
 t_Bool := DefineAutoType([t_Enum], 'Логическое значение', BoolAtom) As BoolAtom;
 with t_Bool do
 begin
  AtomType := TypeInfo(Boolean);
  WrapperType := WBool;
 end;//Bool
 // FontName
 t_FontName := DefineAutoType([t_String], 'Гарнитура шрифта', FontNameTag) As FontNameTag;
 with t_FontName do
 begin
  AtomClass := Tk2FontName;
  WrapperType := WevFontName;
  IDIndex := k2_attrSelfID;
//#UC START# *484CE9CE0107atom1*
//#UC END# *484CE9CE0107atom1*
//#UC START# *484CE9CE0107atom*
  //ValueTable := l3FontManager.Fonts;
//#UC END# *484CE9CE0107atom*
 end;//FontName
 // IUnknown
 t_IUnknown := DefineAutoType([], 'Интерфейс', IUnknownAtom) As IUnknownAtom;
 with t_IUnknown do
 begin
  AtomType := TypeInfo(IUnknown);
 end;//IUnknown
 // SetOf
 t_SetOf := DefineAutoType([t_Long], 'Множество', SetOfAtom) As SetOfAtom;
 with t_SetOf do
 begin
  WrapperType := WSetOf;
 end;//SetOf
 t_Object.Recalc;
 t_SomeDataContainer.Recalc;
 t_String.Recalc;
 t_Empty.Recalc;
 t_l3Base.Recalc;
 t_OList.Recalc;
 t_Long.Recalc;
 t_Enum.Recalc;
 t_Bool.Recalc;
 t_FontName.Recalc;
 t_IUnknown.Recalc;
 t_SetOf.Recalc;
end;

// определяем стандартные методы схемы


procedure Tk2CoreSchema.Cleanup;
begin
 t_Object.InterfaceFactory := nil;
 t_SomeDataContainer.InterfaceFactory := nil;
 t_String.InterfaceFactory := nil;
 t_Empty.InterfaceFactory := nil;
 t_l3Base.InterfaceFactory := nil;
 t_OList.InterfaceFactory := nil;
 t_Long.InterfaceFactory := nil;
 t_Enum.InterfaceFactory := nil;
 t_Bool.InterfaceFactory := nil;
 t_FontName.InterfaceFactory := nil;
 t_IUnknown.InterfaceFactory := nil;
 t_SetOf.InterfaceFactory := nil;
 FreeAndNil(t_Object);
 FreeAndNil(t_SomeDataContainer);
 FreeAndNil(t_String);
 FreeAndNil(t_Empty);
 FreeAndNil(t_l3Base);
 FreeAndNil(t_OList);
 FreeAndNil(t_Long);
 FreeAndNil(t_Enum);
 FreeAndNil(t_Bool);
 FreeAndNil(t_FontName);
 FreeAndNil(t_IUnknown);
 FreeAndNil(t_SetOf);
 inherited;
end;


initialization
 Tk2CoreSchema.SetAsDefault;

end.