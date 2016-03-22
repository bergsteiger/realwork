unit k2Native_Schema;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2Native_Schema.pas"
// Начат: 17.07.1998 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TagTable::Class>> Shared Delphi Low Level::K2::Standard::k2Native
//
// Стандартная таблица тегов.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3Interfaces,
  k2Core_Schema,
  l3Variant {a},
  k2Base {a},
  k2Interfaces {a},
  k2TypedAtomicTag {a},
  k2TypedSmallLeafTag {a}
  ;

type
 TagAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TagAtom

 HandleAtomClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Handle" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//HandleAtomClass

 HandleAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//HandleAtom

 InchAtomClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Inch" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//InchAtomClass

 InchAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//InchAtom

 ColorAtomClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Color" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ColorAtomClass

 ColorAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ColorAtom

 RawDataAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//RawDataAtom

 Int64TagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "Int64" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//Int64TagClass

 Int64Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//Int64Tag

 Tk2NativeSchema = class(Tk2CoreSchema)
 public
 // типы, определённые в данной схеме:
   t_Tag : TagAtom;
   t_Handle : HandleAtom;
   t_Inch : InchAtom;
   t_Color : ColorAtom;
   t_RawData : RawDataAtom;
   t_Int64 : Int64Tag;
 protected
 // определяем стандартные методы схемы
   procedure Cleanup; override;
 public
   constructor Create; override;
 end;//Tk2NativeSchema

implementation

uses
  k2Tag_Const,
  k2Handle_Const,
  k2Inch_Const,
  k2Color_Const,
  k2RawData_Const,
  k2Int64_Const,
  SysUtils {a},
  TypInfo {a},
  k2Const {a},
  k2Tags {a},
  k2BaseStruct {a},
  l3Types {a},
  l3String {a},
  k2Tag_Wrap,
  Color_Wrap,
  k2RawData_Wrap,
  k2SizedMemoryPool,
  k2Long_Const,
  k2SomeDataContainer_Const,
  k2List {a},
  k2NonOptimizeContext {a}
  ;


// start class TagAtom

function TagAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Tag'));
end;

function TagAtom.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           Tk2NativeSchema(TypeTable).t_SomeDataContainer.IsKindOf(anAtomType);
end;

function TagAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег Tag');
end;

function HandleAtomClass.GetTagType: Tl3Type;
begin
 Result := k2_typHandle;
end;//HandleAtomClass.TagType

function HandleAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Handle'));
end;

function HandleAtom.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           Tk2NativeSchema(TypeTable).t_Long.IsKindOf(anAtomType);
end;

function HandleAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, HandleAtomClass);
end;

function InchAtomClass.GetTagType: Tl3Type;
begin
 Result := k2_typInch;
end;//InchAtomClass.TagType

function InchAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Inch'));
end;

function InchAtom.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           Tk2NativeSchema(TypeTable).t_Long.IsKindOf(anAtomType);
end;

function InchAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, InchAtomClass);
end;

function ColorAtomClass.GetTagType: Tl3Type;
begin
 Result := k2_typColor;
end;//ColorAtomClass.TagType

function ColorAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Color'));
end;

function ColorAtom.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           Tk2NativeSchema(TypeTable).t_Long.IsKindOf(anAtomType);
end;

function ColorAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, ColorAtomClass);
end;

function RawDataAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('RawData'));
end;

function RawDataAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Tk2RawData.Make(Self);
end;

function Int64TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typInt64;
end;//Int64TagClass.TagType

function Int64Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Int64'));
end;

function Int64Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           Tk2NativeSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function Int64Tag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Int64TagClass.Make(Self);
end;

constructor Tk2NativeSchema.Create;
begin
 inherited;
 // Tag
 t_Tag := DefineAutoType([t_SomeDataContainer], 'Класс с переменным набором свойств', TagAtom) As TagAtom;
 with t_Tag do
 begin
  WrapperType := Wk2Tag;
 end;//Tag
 // Handle
 t_Handle := DefineAutoType([t_Long], 'Целочисленный идентификатор объекта', HandleAtom) As HandleAtom;
 with t_Handle do
 begin
 end;//Handle
 // Inch
 t_Inch := DefineAutoType([t_Long], 'Дюйм', InchAtom) As InchAtom;
 with t_Inch do
 begin
 end;//Inch
 // Color
 t_Color := DefineAutoType([t_Long], 'Цвет', ColorAtom) As ColorAtom;
 with t_Color do
 begin
  AtomType := TypeInfo(Tl3Color);
  WrapperType := WColor;
 end;//Color
 // RawData
 t_RawData := DefineAutoType([], '"Сырые" данные', RawDataAtom) As RawDataAtom;
 with t_RawData do
 begin
  AtomClass := Tk2RawData;
  WrapperType := Wk2RawData;
 end;//RawData
 // Int64
 t_Int64 := DefineAutoType([t_Tag], '', Int64Tag) As Int64Tag;
 with t_Int64 do
 begin
  AtomClass := Int64TagClass;
  with DefineProperty(k2_attrDocID, t_Long, '') do
  begin
  end;//DocID
  with DefineProperty(k2_attrSubID, t_Long, '') do
  begin
  end;//SubID
 end;//Int64
 t_Tag.Recalc;
 t_Handle.Recalc;
 t_Inch.Recalc;
 t_Color.Recalc;
 t_RawData.Recalc;
 t_Int64.Recalc;
end;

// определяем стандартные методы схемы


procedure Tk2NativeSchema.Cleanup;
begin
 t_Tag.InterfaceFactory := nil;
 t_Handle.InterfaceFactory := nil;
 t_Inch.InterfaceFactory := nil;
 t_Color.InterfaceFactory := nil;
 t_RawData.InterfaceFactory := nil;
 t_Int64.InterfaceFactory := nil;
 FreeAndNil(t_Tag);
 FreeAndNil(t_Handle);
 FreeAndNil(t_Inch);
 FreeAndNil(t_Color);
 FreeAndNil(t_RawData);
 FreeAndNil(t_Int64);
 inherited;
end;


initialization
 Tk2NativeSchema.SetAsDefault;

end.