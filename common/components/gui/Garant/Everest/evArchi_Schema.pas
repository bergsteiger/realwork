unit evArchi_Schema;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evArchi_Schema.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TagTable::Class>> Shared Delphi::Everest::Standard::evArchi
//
// Схема документа для Архивариуса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(Archi)}
uses
  Everest_Schema,
  l3Variant {a},
  k2Base {a},
  l3Interfaces {a},
  k2Interfaces {a},
  k2TypedSmallLeafTag {a}
  ;
{$IfEnd} //Archi

{$If defined(Archi)}

type
 ListTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "List" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ListTagClass

 ListTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ListTag

 TevArchiSchema = class(TEverestSchema)
 public
 // типы, определённые в данной схеме:
   t_List : ListTag;
 protected
 // определяем стандартные методы схемы
   procedure Cleanup; override;
 public
   constructor Create; override;
 end;//TevArchiSchema

{$IfEnd} //Archi

implementation

{$If defined(Archi)}
uses
  arList_Const,
  SysUtils {a},
  TypInfo {a},
  k2Const {a},
  k2Tags {a},
  k2BaseStruct {a},
  l3Types {a},
  l3String {a}
  {$If defined(Archi) AND defined(k2ForEditor)}
  ,
  evList_InterfaceFactory
  {$IfEnd} //Archi AND k2ForEditor
  ,
  k2Tag_Const,
  k2IUnknown_Const,
  TextPara_Const,
  k2List {a},
  k2NonOptimizeContext {a}
  ;
{$IfEnd} //Archi


{$If defined(Archi)}

// start class ListTag

function ListTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typList;
end;//ListTagClass.TagType

function ListTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('List'));
end;

function ListTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevArchiSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function ListTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ListTagClass.Make(Self);
end;

constructor TevArchiSchema.Create;
begin
 inherited;
 // List
 t_List := DefineType(k2_idList {16}, [t_Tag], '', ListTag) As ListTag;
 with t_List do
 begin
  AtomClass := ListTagClass;
  {$If defined(Archi) AND defined(k2ForEditor)}
  InterfaceFactoryType := TevListInterfaceFactory;
  {$IfEnd} //Archi AND k2ForEditor

  with DefineProperty(k2_attrObject, t_IUnknown, '') do
  begin
  end;//Object
 end;//List
 // TextStyle
 with t_TextStyle do
 begin
 end;//TextStyle
 // TextPara
 with t_TextPara do
 begin
  with Tk2CustomProperty(Prop[k2_attrPrintFontSize]) do
  begin
   DefaultValue := 12;
  end;//PrintFontSize
 end;//TextPara
 t_List.Recalc;
 t_TextStyle.Recalc;
 t_TextPara.Recalc;
end;

// определяем стандартные методы схемы


procedure TevArchiSchema.Cleanup;
begin
 t_List.InterfaceFactory := nil;
 FreeAndNil(t_List);
 inherited;
end;

{$IfEnd} //Archi


initialization
{$If defined(Archi)}
 TevArchiSchema.SetAsDefault;
{$IfEnd} //Archi


end.