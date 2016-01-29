unit Meta_Schema;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "Meta_Schema.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: TagTable::Class Shared Delphi Sand Box::SandBox::Meta::Meta
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbDefine.inc}

interface

uses
  l3Variant {a},
  k2Base {a},
  l3Interfaces {a},
  k2Interfaces {a},
  k2TypedAtomicTag {a}
  ;

type
  Visibility = (
    public
  , private
  , protected
  );//Visibility
  Abstract = (
    regular
  , abstract
  , final
  );//Abstract
 InnerTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//InnerTag

 ElementTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ElementTag

 Element_Visisbility_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Element_Visisbility" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//Element_Visisbility_TagClass

 Element_Visisbility_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Element_Visisbility_Tag

 Element_Abstract_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Element_Abstract" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//Element_Abstract_TagClass

 Element_Abstract_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Element_Abstract_Tag

 dependencyTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//dependencyTag

 ClassTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ClassTag

 Class_Extends_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Class_Extends_Tag

 Class_Children_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Class_Children_Tag

 operationTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//operationTag

 attributeTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//attributeTag

 TMetaSchema = class(Tk2TypeTable)
 public
 // типы, определённые в данной схеме:
   t_Inner : InnerTag;
   t_Element : ElementTag;
   t_Element_Visisbility : Element_Visisbility_Tag;
   t_Element_Abstract : Element_Abstract_Tag;
   t_dependency : dependencyTag;
   t_Class : ClassTag;
   t_Class_Extends : Class_Extends_Tag;
   t_Class_Children : Class_Children_Tag;
   t_operation : operationTag;
   t_attribute : attributeTag;
 protected
 // определяем стандартные методы схемы
   procedure Cleanup; override;
 public
   constructor Create; override;
 end;//TMetaSchema

implementation

uses
  Inner_Const,
  Element_Const,
  dependency_Const,
  Class_Const,
  operation_Const,
  attribute_Const,
  SysUtils {a},
  TypInfo {a},
  k2Const {a},
  k2Tags {a},
  k2BaseStruct {a},
  l3Types {a},
  l3String {a},
  k2List {a},
  k2NonOptimizeContext {a}
  ;


// start class InnerTag

function InnerTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Inner'));
end;

function InnerTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег Inner');
end;

function Element_Visisbility_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Element_Visisbility'));
end;

function Element_Visisbility_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TMetaSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function Element_Visisbility_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typElement_Visisbility;
end;//VisisbilityClass.TagType

function Element_Visisbility_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, Element_Visisbility_TagClass);
end;

function Element_Abstract_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Element_Abstract'));
end;

function Element_Abstract_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TMetaSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function Element_Abstract_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typElement_Abstract;
end;//AbstractClass.TagType

function Element_Abstract_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, Element_Abstract_TagClass);
end;

function ElementTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Element'));
end;

function ElementTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TMetaSchema(TypeTable).t_Inner.IsKindOf(anAtomType);
end;

function ElementTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег Element');
end;

function dependencyTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('dependency'));
end;

function dependencyTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TMetaSchema(TypeTable).t_Inner.IsKindOf(anAtomType);
end;

function dependencyTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := .Make(Self);
end;

function Class_Extends_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Class_Extends'));
end;

function Class_Extends_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TMetaSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Class_Extends_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Class_Children_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Class_Children'));
end;

function Class_Children_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TMetaSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Class_Children_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function ClassTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Class'));
end;

function ClassTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TMetaSchema(TypeTable).t_Element.IsKindOf(anAtomType);
end;

function ClassTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := .Make(Self);
end;

function operationTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('operation'));
end;

function operationTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TMetaSchema(TypeTable).t_Element.IsKindOf(anAtomType);
end;

function operationTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := .Make(Self);
end;

function attributeTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('attribute'));
end;

function attributeTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TMetaSchema(TypeTable).t_Element.IsKindOf(anAtomType);
end;

function attributeTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := .Make(Self);
end;

constructor TMetaSchema.Create;
begin
 inherited;
 // Inner
 t_Inner := DefineAutoType([], '', InnerTag) As InnerTag;
 with t_Inner do
 begin
  with DefineProperty(k2_attrStereotype, AnsiString, '') do
  begin
   Shared := true;
  end;//Stereotype
 end;//Inner
 // Element
 t_Element := DefineAutoType([t_Inner], '', ElementTag) As ElementTag;
 with t_Element do
 begin
  with DefineProperty(k2_attrName, AnsiString, '') do
  begin
   Shared := true;
  end;//Name
  t_Element_Visisbility := DefineAutoType([t_Enum], 'Element Visisbility', Element_Visisbility_Tag) As Element_Visisbility_Tag;
  try
   t_Element_Visisbility.AtomType := TypeInfo(Visibility);
   DefineProperty(k2_attrVisisbility, t_Element_Visisbility, '');
   t_Element_Visisbility.Recalc;
  except
   FreeAndNil(t_Element_Visisbility);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrVisisbility]) do
  begin
  end;//Visisbility
  t_Element_Abstract := DefineAutoType([t_Enum], 'Element Abstract', Element_Abstract_Tag) As Element_Abstract_Tag;
  try
   t_Element_Abstract.AtomType := TypeInfo(Abstract);
   DefineProperty(k2_attrAbstract, t_Element_Abstract, '');
   t_Element_Abstract.Recalc;
  except
   FreeAndNil(t_Element_Abstract);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrAbstract]) do
  begin
  end;//Abstract
 end;//Element
 // dependency
 t_dependency := DefineAutoType([t_Inner], '', dependencyTag) As dependencyTag;
 with t_dependency do
 begin
 end;//dependency
 // Class
 t_Class := DefineAutoType([t_Element], '', ClassTag) As ClassTag;
 with t_Class do
 begin
  t_Class_Extends := DefineAutoType([t_OList], 'Class Extends', Class_Extends_Tag) As Class_Extends_Tag;
  try
   t_Class_Extends.DefineChildren(t_Class);
   DefineProperty(k2_attrExtends, t_Class_Extends, '');
   t_Class_Extends.Recalc;
  except
   FreeAndNil(t_Class_Extends);
  end;//try..except
  with t_Class_Extends.ArrayProp[k2_tiChildren] do
  begin
  end;//Extends
  with DefineProperty(k2_attrImplements, t_Class, '') do
  begin
  end;//Implements
  t_Class_Children := DefineAutoType([t_OList], 'Class ', Class_Children_Tag) As Class_Children_Tag;
  try
   t_Class_Children.DefineChildren(t_Inner);
   DefineChildren(t_Inner, t_Class_Children);
   t_Class_Children.Recalc;
  except
   FreeAndNil(t_Class_Children);
  end;//try..except
  with ArrayProp[k2_tiChildren] do
  begin
  end;//
 end;//Class
 // operation
 t_operation := DefineAutoType([t_Element], '', operationTag) As operationTag;
 with t_operation do
 begin
 end;//operation
 // attribute
 t_attribute := DefineAutoType([t_Element], '', attributeTag) As attributeTag;
 with t_attribute do
 begin
 end;//attribute
 t_Inner.Recalc;
 t_Element.Recalc;
 t_dependency.Recalc;
 t_Class.Recalc;
 t_operation.Recalc;
 t_attribute.Recalc;
end;

// определяем стандартные методы схемы


procedure TMetaSchema.Cleanup;
begin
 t_Inner.InterfaceFactory := nil;
 t_Element.InterfaceFactory := nil;
 t_Element_Visisbility.InterfaceFactory := nil;
 t_Element_Abstract.InterfaceFactory := nil;
 t_dependency.InterfaceFactory := nil;
 t_Class.InterfaceFactory := nil;
 t_Class_Extends.InterfaceFactory := nil;
 t_Class_Children.InterfaceFactory := nil;
 t_operation.InterfaceFactory := nil;
 t_attribute.InterfaceFactory := nil;
 FreeAndNil(t_Inner);
 FreeAndNil(t_Element);
 FreeAndNil(t_Element_Visisbility);
 FreeAndNil(t_Element_Abstract);
 FreeAndNil(t_dependency);
 FreeAndNil(t_Class);
 FreeAndNil(t_Class_Extends);
 FreeAndNil(t_Class_Children);
 FreeAndNil(t_operation);
 FreeAndNil(t_attribute);
 inherited;
end;


initialization
 TMetaSchema.SetAsDefault;

end.