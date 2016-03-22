unit evNative_Schema;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evNative_Schema.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TagTable::Class>> Shared Delphi::Everest::Standard::evNative
//
// Родная схема EVD-документов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Interfaces,
  evdTypes,
  evdStyles,
  evQueryCardInt,
  evdNative_Schema,
  evBitmapParaBitmapContainer,
  l3Variant {a},
  k2Base {a},
  k2Interfaces {a},
  k2ParentedTypedSmallLeafTag {a},
  k2ParentedTypedHugeLeafTag {a},
  k2TypedAtomicTag {a},
  k2ParentedTypedSmallListTag {a},
  k2TypedSmallLeafTag {a},
  k2OwnedTypedHugeListTag {a},
  k2ParentedTypedHugeListTag {a}
  ;

type
 StyledLeafParaTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "StyledLeafPara" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//StyledLeafParaTagClass

 StyledLeafParaTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//StyledLeafParaTag

 TextParaTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "TextPara" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TextParaTagClass

 TextParaTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TextParaTag

 TextPara_Segments_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//TextPara_Segments_Tag

 TextPara_TabStops_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//TextPara_TabStops_Tag

 DecorTextParaTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "DecorTextPara" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//DecorTextParaTagClass

 DecorTextParaTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DecorTextParaTag

 ControlParaTagClass = class(Tk2ParentedTypedHugeLeafTag)
  {* Класс реализации тега "ControlPara" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ControlParaTagClass

 ControlParaTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ControlParaTag

 ControlPara_Type_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "ControlPara_Type" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//ControlPara_Type_TagClass

 ControlPara_Type_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//ControlPara_Type_Tag

 FormulaTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "Formula" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//FormulaTagClass

 FormulaTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//FormulaTag

 ParaListTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "ParaList" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ParaListTagClass

 ParaListTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ParaListTag

 ParaList_Orientation_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "ParaList_Orientation" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//ParaList_Orientation_TagClass

 ParaList_Orientation_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//ParaList_Orientation_Tag

 HFParentTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "HFParent" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//HFParentTagClass

 HFParentTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//HFParentTag

 HFParent_Type_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "HFParent_Type" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//HFParent_Type_TagClass

 HFParent_Type_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//HFParent_Type_Tag

 HeaderTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "Header" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//HeaderTagClass

 HeaderTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//HeaderTag

 FooterTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "Footer" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//FooterTagClass

 FooterTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//FooterTag

 DivisionTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "Division" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//DivisionTagClass

 DivisionTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DivisionTag

 Division_Headers_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Division_Headers_Tag

 Division_Footers_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Division_Footers_Tag

 ContentsElementTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "ContentsElement" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ContentsElementTagClass

 ContentsElementTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ContentsElementTag

 ContentsElement_InContents_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "ContentsElement_InContents" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//ContentsElement_InContents_TagClass

 ContentsElement_InContents_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//ContentsElement_InContents_Tag

 ParticipantTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "Participant" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ParticipantTagClass

 ParticipantTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ParticipantTag

 BlockTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "Block" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//BlockTagClass

 BlockTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//BlockTag

 Block_LayerID_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Block_LayerID" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//Block_LayerID_TagClass

 Block_LayerID_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Block_LayerID_Tag

 Block_ViewKind_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Block_ViewKind" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//Block_ViewKind_TagClass

 Block_ViewKind_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Block_ViewKind_Tag

 VersionTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//VersionTag

 DictEntryBlockTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "DictEntryBlock" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//DictEntryBlockTagClass

 DictEntryBlockTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DictEntryBlockTag

 EditablePartTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "EditablePart" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//EditablePartTagClass

 EditablePartTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//EditablePartTag

 DocumentTagClass = class(Tk2OwnedTypedHugeListTag)
  {* Класс реализации тега "Document" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//DocumentTagClass

 DocumentTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DocumentTag

 Document_Subs_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_Subs_Tag

 Document_Groups_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_Groups_Tag

 Document_AccGroups_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_AccGroups_Tag

 Document_Sources_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_Sources_Tag

 Document_Warnings_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_Warnings_Tag

 Document_NumANDDates_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_NumANDDates_Tag

 Document_LogRecords_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_LogRecords_Tag

 Document_SysLogRecords_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_SysLogRecords_Tag

 Document_Versions_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_Versions_Tag

 Document_Stages_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_Stages_Tag

 Document_Checks_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_Checks_Tag

 Document_PublishedIn_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_PublishedIn_Tag

 Document_Territory_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_Territory_Tag

 Document_Norm_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_Norm_Tag

 Document_ActiveIntervals_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_ActiveIntervals_Tag

 Document_Alarms_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_Alarms_Tag

 Document_AnnoClasses_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_AnnoClasses_Tag

 Document_LinkedDocuments_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_LinkedDocuments_Tag

 Document_CaseDocParticipants_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_CaseDocParticipants_Tag

 Document_EditableParts_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Document_EditableParts_Tag

 SimpleDocumentTextParaTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "SimpleDocumentTextPara" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//SimpleDocumentTextParaTagClass

 SimpleDocumentTextParaTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//SimpleDocumentTextParaTag

 QueryCardTagClass = class(Tk2OwnedTypedHugeListTag)
  {* Класс реализации тега "QueryCard" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//QueryCardTagClass

 QueryCardTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//QueryCardTag

 QueryCard_CardType_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "QueryCard_CardType" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//QueryCard_CardType_TagClass

 QueryCard_CardType_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//QueryCard_CardType_Tag

 TableTextParaTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "TableTextPara" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TableTextParaTagClass

 TableTextParaTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TableTextParaTag

 TableCellTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "TableCell" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TableCellTagClass

 TableCellTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TableCellTag

 TableCell_MergeStatus_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "TableCell_MergeStatus" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//TableCell_MergeStatus_TagClass

 TableCell_MergeStatus_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//TableCell_MergeStatus_Tag

 TableCell_VerticalAligment_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "TableCell_VerticalAligment" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//TableCell_VerticalAligment_TagClass

 TableCell_VerticalAligment_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//TableCell_VerticalAligment_Tag

 SBSCellTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "SBSCell" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//SBSCellTagClass

 SBSCellTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//SBSCellTag

 TableRowTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "TableRow" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TableRowTagClass

 TableRowTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TableRowTag

 SBSRowTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "SBSRow" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//SBSRowTagClass

 SBSRowTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//SBSRowTag

 TableTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "Table" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TableTagClass

 TableTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TableTag

 ReqCellTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "ReqCell" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ReqCellTagClass

 ReqCellTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ReqCellTag

 ReqRowTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "ReqRow" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ReqRowTagClass

 ReqRowTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ReqRowTag

 ReqRow_ReqKind_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "ReqRow_ReqKind" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//ReqRow_ReqKind_TagClass

 ReqRow_ReqKind_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//ReqRow_ReqKind_Tag

 ControlsBlockTagClass = class(Tk2ParentedTypedHugeListTag)
  {* Класс реализации тега "ControlsBlock" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ControlsBlockTagClass

 ControlsBlockTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ControlsBlockTag

 BitmapParaTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "BitmapPara" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//BitmapParaTagClass

 BitmapParaTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//BitmapParaTag

 BitmapPara_Object_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//BitmapPara_Object_Tag

 XMLTagTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "XMLTag" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//XMLTagTagClass

 XMLTagTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//XMLTagTag

 XMLTagClass = class(Tk2OwnedTypedHugeListTag)
  {* Класс реализации тега "XML" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//XMLTagClass

 XMLTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//XMLTag

 ExtDataParaTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "ExtDataPara" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ExtDataParaTagClass

 ExtDataParaTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ExtDataParaTag

 AttrValueTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "AttrValue" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AttrValueTagClass

 AttrValueTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AttrValueTag

 AttrNameTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "AttrName" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AttrNameTagClass

 AttrNameTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AttrNameTag

 AttrTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "Attr" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AttrTagClass

 AttrTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AttrTag

 TagNameTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "TagName" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TagNameTagClass

 TagNameTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TagNameTag

 TagBodyTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "TagBody" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TagBodyTagClass

 TagBodyTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TagBodyTag

 ImageListBitmapTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "ImageListBitmap" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ImageListBitmapTagClass

 ImageListBitmapTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ImageListBitmapTag

 SimpleDocumentTagClass = class(Tk2OwnedTypedHugeListTag)
  {* Класс реализации тега "SimpleDocument" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//SimpleDocumentTagClass

 SimpleDocumentTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//SimpleDocumentTag

 CommentParaTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "CommentPara" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//CommentParaTagClass

 CommentParaTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//CommentParaTag

 SBSTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "SBS" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//SBSTagClass

 SBSTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//SBSTag

 TinyDocumentTagClass = class(Tk2OwnedTypedHugeListTag)
  {* Класс реализации тега "TinyDocument" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TinyDocumentTagClass

 TinyDocumentTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TinyDocumentTag

 LeafParaDecorationsHolderTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "LeafParaDecorationsHolder" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//LeafParaDecorationsHolderTagClass

 LeafParaDecorationsHolderTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//LeafParaDecorationsHolderTag

 ReqGroupTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "ReqGroup" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ReqGroupTagClass

 ReqGroupTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ReqGroupTag

 AutoreferatDocumentTagClass = class(Tk2OwnedTypedHugeListTag)
  {* Класс реализации тега "AutoreferatDocument" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AutoreferatDocumentTagClass

 AutoreferatDocumentTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AutoreferatDocumentTag

 DictEntryTagClass = class(Tk2OwnedTypedHugeListTag)
  {* Класс реализации тега "DictEntry" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//DictEntryTagClass

 DictEntryTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DictEntryTag

 DictEntry_ShortName_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//DictEntry_ShortName_Tag

 CloakTagClass = class(Tk2ParentedTypedHugeListTag)
  {* Класс реализации тега "Cloak" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//CloakTagClass

 CloakTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//CloakTag

 NodeGroupTagClass = class(Tk2ParentedTypedHugeListTag)
  {* Класс реализации тега "NodeGroup" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//NodeGroupTagClass

 NodeGroupTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//NodeGroupTag

 DocumentQueryTagClass = class(Tk2OwnedTypedHugeListTag)
  {* Класс реализации тега "DocumentQuery" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//DocumentQueryTagClass

 DocumentQueryTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DocumentQueryTag

 AnnoTopicTagClass = class(Tk2OwnedTypedHugeListTag)
  {* Класс реализации тега "AnnoTopic" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AnnoTopicTagClass

 AnnoTopicTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AnnoTopicTag

 DocumentContainerAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DocumentContainerAtom

 TevNativeSchema = class(TevdNativeSchema)
 public
 // типы, определённые в данной схеме:
   t_StyledLeafPara : StyledLeafParaTag;
   t_TextPara : TextParaTag;
   t_TextPara_Segments : TextPara_Segments_Tag;
   t_TextPara_TabStops : TextPara_TabStops_Tag;
   t_DecorTextPara : DecorTextParaTag;
   t_ControlPara : ControlParaTag;
   t_ControlPara_Type : ControlPara_Type_Tag;
   t_Formula : FormulaTag;
   t_ParaList : ParaListTag;
   t_ParaList_Orientation : ParaList_Orientation_Tag;
   t_HFParent : HFParentTag;
   t_HFParent_Type : HFParent_Type_Tag;
   t_Header : HeaderTag;
   t_Footer : FooterTag;
   t_Division : DivisionTag;
   t_Division_Headers : Division_Headers_Tag;
   t_Division_Footers : Division_Footers_Tag;
   t_ContentsElement : ContentsElementTag;
   t_ContentsElement_InContents : ContentsElement_InContents_Tag;
   t_Participant : ParticipantTag;
   t_Block : BlockTag;
   t_Block_LayerID : Block_LayerID_Tag;
   t_Block_ViewKind : Block_ViewKind_Tag;
   t_Version : VersionTag;
   t_DictEntryBlock : DictEntryBlockTag;
   t_EditablePart : EditablePartTag;
   t_Document : DocumentTag;
   t_Document_Subs : Document_Subs_Tag;
   t_Document_Groups : Document_Groups_Tag;
   t_Document_AccGroups : Document_AccGroups_Tag;
   t_Document_Sources : Document_Sources_Tag;
   t_Document_Warnings : Document_Warnings_Tag;
   t_Document_NumANDDates : Document_NumANDDates_Tag;
   t_Document_LogRecords : Document_LogRecords_Tag;
   t_Document_SysLogRecords : Document_SysLogRecords_Tag;
   t_Document_Versions : Document_Versions_Tag;
   t_Document_Stages : Document_Stages_Tag;
   t_Document_Checks : Document_Checks_Tag;
   t_Document_PublishedIn : Document_PublishedIn_Tag;
   t_Document_Territory : Document_Territory_Tag;
   t_Document_Norm : Document_Norm_Tag;
   t_Document_ActiveIntervals : Document_ActiveIntervals_Tag;
   t_Document_Alarms : Document_Alarms_Tag;
   t_Document_AnnoClasses : Document_AnnoClasses_Tag;
   t_Document_LinkedDocuments : Document_LinkedDocuments_Tag;
   t_Document_CaseDocParticipants : Document_CaseDocParticipants_Tag;
   t_Document_EditableParts : Document_EditableParts_Tag;
   t_SimpleDocumentTextPara : SimpleDocumentTextParaTag;
   t_QueryCard : QueryCardTag;
   t_QueryCard_CardType : QueryCard_CardType_Tag;
   t_TableTextPara : TableTextParaTag;
   t_TableCell : TableCellTag;
   t_TableCell_MergeStatus : TableCell_MergeStatus_Tag;
   t_TableCell_VerticalAligment : TableCell_VerticalAligment_Tag;
   t_SBSCell : SBSCellTag;
   t_TableRow : TableRowTag;
   t_SBSRow : SBSRowTag;
   t_Table : TableTag;
   t_ReqCell : ReqCellTag;
   t_ReqRow : ReqRowTag;
   t_ReqRow_ReqKind : ReqRow_ReqKind_Tag;
   t_ControlsBlock : ControlsBlockTag;
   t_BitmapPara : BitmapParaTag;
   t_BitmapPara_Object : BitmapPara_Object_Tag;
   t_XMLTag : XMLTagTag;
   t_XML : XMLTag;
   t_ExtDataPara : ExtDataParaTag;
   t_AttrValue : AttrValueTag;
   t_AttrName : AttrNameTag;
   t_Attr : AttrTag;
   t_TagName : TagNameTag;
   t_TagBody : TagBodyTag;
   t_ImageListBitmap : ImageListBitmapTag;
   t_SimpleDocument : SimpleDocumentTag;
   t_CommentPara : CommentParaTag;
   t_SBS : SBSTag;
   t_TinyDocument : TinyDocumentTag;
   t_LeafParaDecorationsHolder : LeafParaDecorationsHolderTag;
   t_ReqGroup : ReqGroupTag;
   t_AutoreferatDocument : AutoreferatDocumentTag;
   t_DictEntry : DictEntryTag;
   t_DictEntry_ShortName : DictEntry_ShortName_Tag;
   t_Cloak : CloakTag;
   t_NodeGroup : NodeGroupTag;
   t_DocumentQuery : DocumentQueryTag;
   t_AnnoTopic : AnnoTopicTag;
   t_DocumentContainer : DocumentContainerAtom;
 protected
 // определяем стандартные методы схемы
   procedure Cleanup; override;
 public
   constructor Create; override;
 end;//TevNativeSchema

//#UC START# *484CD009023Dttintf*
{$IfDef DesignTimeLibrary}
 {$R evttStd.Unicode.res evttStd.Unicode.rc}
{$Else DesignTimeLibrary}
 {$IfDef evMyEditor}
  {$R evttStd.My.res evttStd.My.rc}
 {$Else}
  {$IfDef nsTest}
   {$R NemesisStyles.res NemesisStyles.rc}
   //{$R evttStd.Unicode.res evttStd.Unicode.rc}
  {$Else  nsTest}
   {$IfDef Nemesis}
    {$R NemesisStyles.res NemesisStyles.rc}
   {$Else}
    {$R evttStd.Unicode.res evttStd.Unicode.rc}
   {$EndIf}
  {$EndIf nsTest}
 {$EndIf evMyEditor}
{$EndIf DesignTimeLibrary}
//#UC END# *484CD009023Dttintf*

implementation

uses
  nevTools,
  evStyleInterfaceEx,
  l3Stream,
  Classes,
  Graphics,
  nevBase,
  l3Base,
  Bullet_Const
  {$If defined(k2ForEditor)}
  ,
  evDocumentPart
  {$IfEnd} //k2ForEditor
  ,
  l3Defaults,
  k2DictItem,
  l3Const,
  evControlsBlockConst,
  evDef,
  nevFacade,
  l3Units,
  Bookmark_Const,
  Mark_Const
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  evNative_AttrValues,
  StyledLeafPara_Const,
  TextPara_Const,
  DecorTextPara_Const,
  ControlPara_Const,
  Formula_Const,
  ParaList_Const,
  HFParent_Const,
  Header_Const,
  Footer_Const,
  Division_Const,
  ContentsElement_Const,
  Participant_Const,
  Block_Const,
  Version_Const,
  DictEntryBlock_Const,
  EditablePart_Const,
  Document_Const,
  SimpleDocumentTextPara_Const,
  QueryCard_Const,
  TableTextPara_Const,
  TableCell_Const,
  SBSCell_Const,
  TableRow_Const,
  SBSRow_Const,
  Table_Const,
  ReqCell_Const,
  ReqRow_Const,
  ControlsBlock_Const,
  BitmapPara_Const,
  XMLTag_Const,
  XML_Const,
  ExtDataPara_Const,
  AttrValue_Const,
  AttrName_Const,
  Attr_Const,
  TagName_Const,
  TagBody_Const,
  ImageListBitmap_Const,
  SimpleDocument_Const,
  CommentPara_Const,
  SBS_Const,
  TinyDocument_Const,
  LeafParaDecorationsHolder_Const,
  ReqGroup_Const,
  AutoreferatDocument_Const,
  DictEntry_Const,
  Cloak_Const,
  evTextStyle_Const,
  NodeGroup_Const,
  DocumentQuery_Const,
  AnnoTopic_Const,
  DocumentContainer_Const,
  SysUtils {a},
  TypInfo {a},
  k2Const {a},
  k2Tags {a},
  k2BaseStruct {a},
  l3Types {a},
  l3String {a},
  evTextPara_Wrap
  {$If defined(k2ForEditor)}
  ,
  evControlPara_Wrap
  {$IfEnd} //k2ForEditor
  ,
  evFormula_Wrap,
  evDocument_Wrap,
  evReqRow_Wrap,
  evBitmapPara_Wrap,
  evCommentPara_Wrap,
  evReqGroup_Wrap
  {$If defined(k2ForEditor)}
  ,
  evTextPara_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evControlPara_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evFormula_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evParaList_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evBlock_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evDocument_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evQueryCard_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evTableCell_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evSBSCell_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evTableRow_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evSBSRow_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evTable_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evReqCell_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evReqRow_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evControlsBlock_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evBitmapPara_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evCommentPara_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evSBS_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evReqGroup_InterfaceFactory
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  evAutoreferatDocument_InterfaceFactory
  {$IfEnd} //k2ForEditor
  ,
  k2Tag_Const,
  k2IUnknown_Const,
  k2Long_Const,
  k2Handle_Const,
  k2Inch_Const,
  k2Bool_Const,
  k2Color_Const,
  k2String_Const,
  k2RawData_Const,
  Justification_Const,
  Date_Const,
  Type_Const,
  Address_Const,
  ObjectWithHandle_Const,
  Font_Const,
  evdFrame_Const,
  evdTextStyle_Const,
  DictItem_Const,
  Sub_Const,
  DocSubLayer_Const,
  Para_Const,
  ActiveInterval_Const,
  Alarm_Const,
  LogRecord_Const,
  Stage_Const,
  NumANDDate_Const,
  Check_Const,
  PIRec_Const,
  SegmentsLayer_Const,
  TabStop_Const,
  HyperLink_Const,
  ObjectSegment_Const,
  PageProperties_Const,
  LeafPara_Const,
  k2Int64_Const,
  k2List {a},
  k2NonOptimizeContext {a}
  ;

//#UC START# *484CD009023Dtt*

procedure CreateStandardTextStyles(StyleType: Tk2Type);
var
 SI : TevStyleInterfaceEx;
 S  : TStream;
begin
 SI := TevStyleInterfaceEx.Create;
 try
  SI.TagType := StyleType;
  S := Tl3ResourceStream.Create(hInstance,
   {$IfDef evMyEditor}
   'MYSTANDARDTEXTSTYLETABLE'
   {$Else  evMyEditor}
   'EVSTANDARDTEXTSTYLETABLE'
   {$EndIf evMyEditor}
  );
  try
   g_InCreateDocumentSchema := true;
   try
    SI.Load(S);
   finally
    g_InCreateDocumentSchema := false;
   end;//try..finally
  finally
   FreeAndNil(S);
  end;//try..finally
 finally
  FreeAndNil(SI);
 end;//try..finally
end;

procedure BlockHeaderUpdate(const V       : Tk2Values;
                            const aProp   : Tk2Prop;
                            const Context : Ik2Op);
var
 l_NShape : InevObject;
begin
 if V.rTag.IsValid then
 begin
  if (Context = nil) then
  begin
   if V.rTag.QT(InevObject, l_NShape, nil) then
    try
     l_NShape.Invalidate([]);
    finally
     l_NShape := nil;
    end;//try..finally
  end//Context = nil
  else
  begin
   if not Context.InIOProcess then
    if V.rTag.QT(InevObject, l_NShape, Context.Processor) then
     try
      l_NShape.Invalidate([]);
     finally
      l_NShape := nil;
     end;//try..finally
  end;//Context = nil
 end;//V.rTag.IsValid
end;

procedure SubLayerChildType(aParent : Tl3Variant;
                            var theType   : Tk2Type);
begin
 Case aParent.IntA[k2_tiHandle] of
  Ord(ev_sbtBookmark):
   theType := k2_typBookmark;
  Ord(ev_sbtMark):
   theType := k2_typMark;
 end;//Case aParent.IntA[k2_tiHandle]
end;

procedure SBSRowValidateChild(aParent : Tl3Variant;
                              var aChild    : Tl3Variant;
                              var aValid    : Boolean);
var
 l_C : Tl3Variant;
begin
 if not aValid then
 begin
  aValid := aChild.IsKindOf(k2_typTableCell);
  if aValid then
  begin
   l_C := k2_typSBSCell.MakeTag.AsObject;
   l_C.AsObject.AssignTag(aChild);
   l_C.SetRef(aChild);
  end;//aValid
 end;//not aValid
end;

procedure SBSValidateChild(aParent : Tl3Variant;
                           var aChild    : Tl3Variant;
                           var aValid    : Bool);
var
 l_C : Tl3Variant;
begin
 if not aValid then
 begin
  aValid := aChild.IsKindOf(k2_typTableRow);
  if aValid then
  begin
   l_C := k2_typSBSRow.MakeTag.AsObject;
   l_C.AsObject.AssignTag(aChild);
   l_C.SetRef(aChild);
  end;//aValid
 end;//not aValid
end;

//#UC END# *484CD009023Dtt*


// unit methods

procedure StyledLeafParaStyleAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *48567D5F0064var_AfterChange*
var
 l_Para : InevObject;
//#UC END# *48567D5F0064var_AfterChange*
begin
//#UC START# *48567D5F0064AfterChange*
 if (aContext <> nil) AND not aContext.InIOProcess AND V.rTag.IsValid then
  if V.rTag.QT(InevObject, l_Para, aContext.Processor) then
  begin
   if not l_Para.IsKindOf(k2_typFormula) then
    l_Para.BoolW[k2_attrCollapsed, aContext] := False;
   l_Para.Invalidate([nev_spExtent]);
  end;
//#UC END# *48567D5F0064AfterChange*
end;

procedure StyledLeafParaJustificationAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *485680D50229var_AfterChange*
var
 l_Para : InevObject;
//#UC END# *485680D50229var_AfterChange*
begin
//#UC START# *485680D50229AfterChange*
 if (aContext <> nil) AND not aContext.InIOProcess AND V.rTag.IsValid then
  if V.rTag.QT(InevObject, l_Para, aContext.Processor) then
   l_Para.Invalidate([]);
//#UC END# *485680D50229AfterChange*
end;

procedure StyledLeafParaWidthAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *48568328038Fvar_AfterChange*
//#UC END# *48568328038Fvar_AfterChange*
begin
//#UC START# *48568328038FAfterChange*
 StyledLeafParaJustificationAfterChange(V, aProp, aContext);
//#UC END# *48568328038FAfterChange*
end;

procedure StyledLeafParaLeftIndentAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4856834700B0var_AfterChange*
//#UC END# *4856834700B0var_AfterChange*
begin
//#UC START# *4856834700B0AfterChange*
 StyledLeafParaJustificationAfterChange(V, aProp, aContext);
//#UC END# *4856834700B0AfterChange*
end;

procedure StyledLeafParaRightIndentAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4856835E0282var_AfterChange*
//#UC END# *4856835E0282var_AfterChange*
begin
//#UC START# *4856835E0282AfterChange*
 StyledLeafParaJustificationAfterChange(V, aProp, aContext);
//#UC END# *4856835E0282AfterChange*
end;

function StyledLeafParaTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typStyledLeafPara;
end;//StyledLeafParaTagClass.TagType

function StyledLeafParaTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('StyledLeafPara'));
end;

function StyledLeafParaTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_LeafPara.IsKindOf(anAtomType);
end;

function StyledLeafParaTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег StyledLeafPara');
end;

procedure TextParaFontAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *485784AF0369var_AfterChange*
{$WriteableConst On}
const
 g_WasSize : Boolean = false;
 g_Para    : InevObject = nil;
{$WriteableConst Off}
var
 l_Para : InevObject;
//#UC END# *485784AF0369var_AfterChange*
begin
//#UC START# *485784AF0369AfterChange*
 if (aContext <> nil) AND not aContext.InIOProcess AND V.rTag.IsValid then
  if V.rTag.IsKindOf(k2_typFont) then
   begin
    if g_Para <> nil then
     g_Para.Invalidate([nev_spExtent])
    else
     g_WasSize := True;
    g_Para := nil;
   end
   else
    if V.rTag.QT(InevObject, l_Para, aContext.Processor) then
     if g_WasSize then
     begin
      l_Para.Invalidate([nev_spExtent]);
      g_WasSize := False;
     end
     else
      g_Para := l_Para;
//#UC END# *485784AF0369AfterChange*
end;

function TextPara_Segments_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TextPara_Segments'));
end;

function TextPara_Segments_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function TextPara_Segments_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function TextParaSegmentsChildStored(aParent : Tl3Variant;
 aChild   : Tl3Variant;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op): Boolean;
//#UC START# *485787650374var_childstored*
var
 H : Integer;
//#UC END# *485787650374var_childstored*
begin
//#UC START# *485787650374childstored*
 if (aChild.ChildrenCount > 0) then
 begin
  H := aChild.IntA[k2_tiHandle];
  Result := (H > Ord(ev_slSuperposition)) AND (H <> Ord(ev_slFound)) AND
            (H <> Ord(ev_slFoundWords)) AND (H <> Ord(ev_slMistakes));
 end//aChild.ChildrenCount > 0
 else
  Result := false; 
//#UC END# *485787650374childstored*
end;

function TextPara_TabStops_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TextPara_TabStops'));
end;

function TextPara_TabStops_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function TextPara_TabStops_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function TextParaTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTextPara;
end;//TextParaTagClass.TagType

function TextParaTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TextPara'));
end;

function TextParaTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_StyledLeafPara.IsKindOf(anAtomType);
end;

function TextParaTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TextParaTagClass.Make(Self);
end;

function DecorTextParaTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typDecorTextPara;
end;//DecorTextParaTagClass.TagType

function DecorTextParaTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DecorTextPara'));
end;

function DecorTextParaTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_TextPara.IsKindOf(anAtomType);
end;

function DecorTextParaTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := DecorTextParaTagClass.Make(Self);
end;

function ControlPara_Type_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ControlPara_Type'));
end;

function ControlPara_Type_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function ControlPara_Type_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typControlPara_Type;
end;//TypeClass.TagType

function ControlPara_Type_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, ControlPara_Type_TagClass);
end;

procedure ControlParaCollapsedAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4858022A024Dvar_AfterChange*
var
 l_P : InevObject;
//#UC END# *4858022A024Dvar_AfterChange*
begin
//#UC START# *4858022A024DAfterChange*
 if (aContext = nil) OR not aContext.InIOProcess then
 begin
  if not V.rTag.QT(InevObject, l_P) then
   Assert(false);
  l_P.Invalidate([nev_spExtent, nev_spSegments]);
 end;//aContext = nil..
//#UC END# *4858022A024DAfterChange*
end;

procedure ControlParaValidAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *485803DA0295var_AfterChange*
//#UC END# *485803DA0295var_AfterChange*
begin
//#UC START# *485803DA0295AfterChange*
 BlockHeaderUpdate(V, aProp, aContext);
//#UC END# *485803DA0295AfterChange*
end;

procedure ControlParaVisibleAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4858041B00D6var_AfterChange*
//#UC END# *4858041B00D6var_AfterChange*
begin
//#UC START# *4858041B00D6AfterChange*
 BlockHeaderUpdate(V, aProp, aContext);
//#UC END# *4858041B00D6AfterChange*
end;

procedure ControlParaStateIndexAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4858042A01B7var_AfterChange*
//#UC END# *4858042A01B7var_AfterChange*
begin
//#UC START# *4858042A01B7AfterChange*
 BlockHeaderUpdate(V, aProp, aContext);
//#UC END# *4858042A01B7AfterChange*
end;

procedure ControlParaCheckedAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4858047602E3var_AfterChange*
//#UC END# *4858047602E3var_AfterChange*
begin
//#UC START# *4858047602E3AfterChange*
 BlockHeaderUpdate(V, aProp, aContext);
//#UC END# *4858047602E3AfterChange*
end;

function ControlParaEnabledStored(aTag : Tl3Variant;
 aValue   : Tl3Variant;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op): Boolean;
//#UC START# *485804B3009Evar_stored*
var
 l_ReqGroup : Tl3Variant;
//#UC END# *485804B3009Evar_stored*
begin
//#UC START# *485804B3009Estored*
 if evInPara(aTag, k2_typReqGroup, l_ReqGroup) then
  Result := l_ReqGroup.BoolA[k2_tiChecked]
 else
  Result := true; 
//#UC END# *485804B3009Estored*
end;

procedure ControlParaEnabledAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *485804B3009Evar_AfterChange*
//#UC END# *485804B3009Evar_AfterChange*
begin
//#UC START# *485804B3009EAfterChange*
 BlockHeaderUpdate(V, aProp, aContext);
//#UC END# *485804B3009EAfterChange*
end;

procedure ControlParaUpperAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *485804D403A4var_AfterChange*
//#UC END# *485804D403A4var_AfterChange*
begin
//#UC START# *485804D403A4AfterChange*
 BlockHeaderUpdate(V, aProp, aContext);
//#UC END# *485804D403A4AfterChange*
end;

procedure ControlParaFlatAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *485804F501E9var_AfterChange*
//#UC END# *485804F501E9var_AfterChange*
begin
//#UC START# *485804F501E9AfterChange*
 BlockHeaderUpdate(V, aProp, aContext);
//#UC END# *485804F501E9AfterChange*
end;

function ControlParaTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typControlPara;
end;//ControlParaTagClass.TagType

function ControlParaTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ControlPara'));
end;

function ControlParaTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_TextPara.IsKindOf(anAtomType);
end;

function ControlParaTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ControlParaTagClass.Make(Self);
end;

procedure FormulaTextAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4857964E013Cvar_AfterChange*
var
 l_P : InevObject;
//#UC END# *4857964E013Cvar_AfterChange*
begin
//#UC START# *4857964E013CAfterChange*
 if (aContext = nil) OR not aContext.InIOProcess then
 begin
  if (aContext <> nil) then
   aContext.MarkModified(V.rTag);
  if not V.rTag.QT(InevObject, l_P) then
   Assert(false);
  l_P.Invalidate([nev_spExtent]);
 end;//Context = nil..
//#UC END# *4857964E013CAfterChange*
end;

function FormulaTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typFormula;
end;//FormulaTagClass.TagType

function FormulaTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Formula'));
end;

function FormulaTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_TextPara.IsKindOf(anAtomType);
end;

function FormulaTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := FormulaTagClass.Make(Self);
end;

function ParaListWidthStored(aTag : Tl3Variant;
 aValue   : Tl3Variant;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op): Boolean;
//#UC START# *48579FA203ADvar_stored*
//#UC END# *48579FA203ADvar_stored*
begin
//#UC START# *48579FA203ADstored*
 Result := aTag.BoolA[k2_tiFixedWidth];
//#UC END# *48579FA203ADstored*
end;

function ParaList_Orientation_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ParaList_Orientation'));
end;

function ParaList_Orientation_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function ParaList_Orientation_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typParaList_Orientation;
end;//OrientationClass.TagType

function ParaList_Orientation_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, ParaList_Orientation_TagClass);
end;

function ParaListTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typParaList;
end;//ParaListTagClass.TagType

function ParaListTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ParaList'));
end;

function ParaListTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Para.IsKindOf(anAtomType);
end;

function ParaListTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег ParaList');
end;

function HFParent_Type_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('HFParent_Type'));
end;

function HFParent_Type_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function HFParent_Type_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typHFParent_Type;
end;//TypeClass.TagType

function HFParent_Type_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, HFParent_Type_TagClass);
end;

function HFParentTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typHFParent;
end;//HFParentTagClass.TagType

function HFParentTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('HFParent'));
end;

function HFParentTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_ParaList.IsKindOf(anAtomType);
end;

function HFParentTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег HFParent');
end;

function HeaderTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typHeader;
end;//HeaderTagClass.TagType

function HeaderTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Header'));
end;

function HeaderTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_HFParent.IsKindOf(anAtomType);
end;

function HeaderTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := HeaderTagClass.Make(Self);
end;

function FooterTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typFooter;
end;//FooterTagClass.TagType

function FooterTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Footer'));
end;

function FooterTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_HFParent.IsKindOf(anAtomType);
end;

function FooterTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := FooterTagClass.Make(Self);
end;

function Division_Headers_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Division_Headers'));
end;

function Division_Headers_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Division_Headers_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Division_Footers_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Division_Footers'));
end;

function Division_Footers_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Division_Footers_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function DivisionTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typDivision;
end;//DivisionTagClass.TagType

function DivisionTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Division'));
end;

function DivisionTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_ParaList.IsKindOf(anAtomType);
end;

function DivisionTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := DivisionTagClass.Make(Self);
end;

function ContentsElement_InContents_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ContentsElement_InContents'));
end;

function ContentsElement_InContents_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function ContentsElement_InContents_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typContentsElement_InContents;
end;//InContentsClass.TagType

function ContentsElement_InContents_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, ContentsElement_InContents_TagClass);
end;

function ContentsElementTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typContentsElement;
end;//ContentsElementTagClass.TagType

function ContentsElementTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ContentsElement'));
end;

function ContentsElementTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_ParaList.IsKindOf(anAtomType)
           OR
           TevNativeSchema(TypeTable).t_ObjectWithHandle.IsKindOf(anAtomType);
end;

function ContentsElementTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ContentsElementTagClass.Make(Self);
end;

function ParticipantTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typParticipant;
end;//ParticipantTagClass.TagType

function ParticipantTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Participant'));
end;

function ParticipantTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function ParticipantTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ParticipantTagClass.Make(Self);
end;

function BlockCollapsedStored(aTag : Tl3Variant;
 aValue   : Tl3Variant;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op): Boolean;
//#UC START# *4857B0230374var_stored*
//#UC END# *4857B0230374var_stored*
begin
//#UC START# *4857B0230374stored*
 Result := aTag.Attr[k2_tiStyle].BoolA[k2_attrCollapsable];
//#UC END# *4857B0230374stored*
end;

procedure BlockCollapsedAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4857B0230374var_AfterChange*
var
 l_SubCache : IevSubCache;
 l_Para     : InevPara;
//#UC END# *4857B0230374var_AfterChange*
begin
//#UC START# *4857B0230374AfterChange*
 if (aContext = nil) OR not aContext.InIOProcess then
 begin
  if (aContext = nil) then
  begin
   if V.rTag.QT(InevPara, l_Para, nil) then
    try
     l_Para.Invalidate([nev_spExtent]);
    finally
     l_Para := nil;
    end;//try..finally
  end//aContext = nil
  else
  begin
   if V.rTag.QT(InevPara, l_Para, aContext.Processor) then
    try
     l_Para.Invalidate([nev_spExtent]);
    finally
     l_Para := nil;
    end;//try..finally
  end;//aContext = nil
  if Supports(aContext, IevSubCache, l_SubCache) then
   try
    l_SubCache.ClearSubs;
   finally
    l_SubCache := nil;
   end;//try..finally
 end;{aContext <> nil..}
//#UC END# *4857B0230374AfterChange*
end;

function Block_LayerID_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Block_LayerID'));
end;

function Block_LayerID_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function Block_LayerID_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typBlock_LayerID;
end;//LayerIDClass.TagType

function Block_LayerID_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, Block_LayerID_TagClass);
end;

procedure BlockStyleAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4FBB8CF301A4var_AfterChange*
var
 l_Para : InevObject;
//#UC END# *4FBB8CF301A4var_AfterChange*
begin
//#UC START# *4FBB8CF301A4AfterChange*
 if (aContext <> nil) AND not aContext.InIOProcess AND V.rTag.IsValid then
  if V.rTag.QT(InevObject, l_Para, aContext.Processor) then
   l_Para.Invalidate([nev_spExtent]);
//#UC END# *4FBB8CF301A4AfterChange*
end;

function Block_ViewKind_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Block_ViewKind'));
end;

function Block_ViewKind_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function Block_ViewKind_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typBlock_ViewKind;
end;//ViewKindClass.TagType

function Block_ViewKind_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, Block_ViewKind_TagClass);
end;

function BlockTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typBlock;
end;//BlockTagClass.TagType

function BlockTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Block'));
end;

function BlockTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_ParaList.IsKindOf(anAtomType)
           OR
           TevNativeSchema(TypeTable).t_Sub.IsKindOf(anAtomType) OR 
           TevNativeSchema(TypeTable).t_ContentsElement.IsKindOf(anAtomType);
end;

function BlockTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := BlockTagClass.Make(Self);
end;

function VersionTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Version'));
end;

function VersionTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_DictItem.IsKindOf(anAtomType);
end;

function VersionTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Tk2DictItem.Make(Self);
end;

function DictEntryBlockTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typDictEntryBlock;
end;//DictEntryBlockTagClass.TagType

function DictEntryBlockTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DictEntryBlock'));
end;

function DictEntryBlockTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Block.IsKindOf(anAtomType);
end;

function DictEntryBlockTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := DictEntryBlockTagClass.Make(Self);
end;

function EditablePartTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typEditablePart;
end;//EditablePartTagClass.TagType

function EditablePartTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('EditablePart'));
end;

function EditablePartTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Tag.IsKindOf(anAtomType)
           OR
           TevNativeSchema(TypeTable).t_ObjectWithHandle.IsKindOf(anAtomType);
end;

function EditablePartTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := EditablePartTagClass.Make(Self);
end;

procedure DocumentSpaceAfterAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4857BB4B00D0var_AfterChange*
//#UC END# *4857BB4B00D0var_AfterChange*
begin
//#UC START# *4857BB4B00D0AfterChange*
 if (aContext <> nil) AND not aContext.InIOProcess then
 begin
  if aContext.SaveUndo then
   aContext.MarkModified(V.rTag);
 end;//Context <> nil..
//#UC END# *4857BB4B00D0AfterChange*
end;

procedure DocumentLeftIndentAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4857BC220259var_AfterChange*
//#UC END# *4857BC220259var_AfterChange*
begin
//#UC START# *4857BC220259AfterChange*
 DocumentSpaceAfterAfterChange(V, aProp, aContext);
//#UC END# *4857BC220259AfterChange*
end;

procedure DocumentRightIndentAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4857BCC3024Avar_AfterChange*
//#UC END# *4857BCC3024Avar_AfterChange*
begin
//#UC START# *4857BCC3024AAfterChange*
 DocumentSpaceAfterAfterChange(V, aProp, aContext);
//#UC END# *4857BCC3024AAfterChange*
end;

procedure DocumentWidthAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4857BDF9035Avar_AfterChange*
//#UC END# *4857BDF9035Avar_AfterChange*
begin
//#UC START# *4857BDF9035AAfterChange*
 DocumentSpaceAfterAfterChange(V, aProp, aContext);
//#UC END# *4857BDF9035AAfterChange*
end;

function Document_Subs_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_Subs'));
end;

function Document_Subs_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_Subs_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function DocumentSubsChildStored(aParent : Tl3Variant;
 aChild   : Tl3Variant;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op): Boolean;
//#UC START# *4857B957011Dvar_childstored*
var
 H : Integer;
//#UC END# *4857B957011Dvar_childstored*
begin
//#UC START# *4857B957011Dchildstored*
 if (aChild.ChildrenCount > 0) then
 begin
  H := aChild.IntA[k2_tiHandle];
  Result := (H = Ord(ev_sbtSub))
            {$IfDef Nemesis}
            OR (H = Ord(ev_sbtBookmark))
            OR (H = Ord(ev_sbtMark))
            {$EndIf Nemesis}
            ;
 end else
  Result := false;
//#UC END# *4857B957011Dchildstored*
end;

function Document_Groups_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_Groups'));
end;

function Document_Groups_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_Groups_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_AccGroups_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_AccGroups'));
end;

function Document_AccGroups_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_AccGroups_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_Sources_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_Sources'));
end;

function Document_Sources_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_Sources_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_Warnings_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_Warnings'));
end;

function Document_Warnings_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_Warnings_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_NumANDDates_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_NumANDDates'));
end;

function Document_NumANDDates_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_NumANDDates_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_LogRecords_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_LogRecords'));
end;

function Document_LogRecords_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_LogRecords_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_SysLogRecords_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_SysLogRecords'));
end;

function Document_SysLogRecords_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_SysLogRecords_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_Versions_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_Versions'));
end;

function Document_Versions_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_Versions_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_Stages_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_Stages'));
end;

function Document_Stages_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_Stages_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_Checks_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_Checks'));
end;

function Document_Checks_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_Checks_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_PublishedIn_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_PublishedIn'));
end;

function Document_PublishedIn_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_PublishedIn_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_Territory_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_Territory'));
end;

function Document_Territory_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_Territory_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_Norm_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_Norm'));
end;

function Document_Norm_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_Norm_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_ActiveIntervals_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_ActiveIntervals'));
end;

function Document_ActiveIntervals_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_ActiveIntervals_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_Alarms_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_Alarms'));
end;

function Document_Alarms_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_Alarms_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_AnnoClasses_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_AnnoClasses'));
end;

function Document_AnnoClasses_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_AnnoClasses_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_LinkedDocuments_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_LinkedDocuments'));
end;

function Document_LinkedDocuments_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_LinkedDocuments_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_CaseDocParticipants_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_CaseDocParticipants'));
end;

function Document_CaseDocParticipants_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_CaseDocParticipants_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Document_EditableParts_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document_EditableParts'));
end;

function Document_EditableParts_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Document_EditableParts_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function DocumentTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typDocument;
end;//DocumentTagClass.TagType

function DocumentTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Document'));
end;

function DocumentTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Block.IsKindOf(anAtomType);
end;

function DocumentTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := DocumentTagClass.Make(Self);
end;

function SimpleDocumentTextParaTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typSimpleDocumentTextPara;
end;//SimpleDocumentTextParaTagClass.TagType

function SimpleDocumentTextParaTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('SimpleDocumentTextPara'));
end;

function SimpleDocumentTextParaTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_TextPara.IsKindOf(anAtomType);
end;

function SimpleDocumentTextParaTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := SimpleDocumentTextParaTagClass.Make(Self);
end;

function QueryCard_CardType_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('QueryCard_CardType'));
end;

function QueryCard_CardType_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function QueryCard_CardType_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typQueryCard_CardType;
end;//CardTypeClass.TagType

function QueryCard_CardType_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, QueryCard_CardType_TagClass);
end;

function QueryCardTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typQueryCard;
end;//QueryCardTagClass.TagType

function QueryCardTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('QueryCard'));
end;

function QueryCardTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Document.IsKindOf(anAtomType);
end;

function QueryCardTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := QueryCardTagClass.Make(Self);
end;

function TableTextParaTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTableTextPara;
end;//TableTextParaTagClass.TagType

function TableTextParaTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TableTextPara'));
end;

function TableTextParaTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_TextPara.IsKindOf(anAtomType);
end;

function TableTextParaTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TableTextParaTagClass.Make(Self);
end;

procedure TableCellWidthAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4857CE0D022Evar_AfterChange*
var
 l_Para : InevObject;
//#UC END# *4857CE0D022Evar_AfterChange*
begin
//#UC START# *4857CE0D022EAfterChange*
 DocumentSpaceAfterAfterChange(V, aProp, aContext);
 if (aContext <> nil) AND not aContext.InIOProcess AND V.rTag.IsValid then
  if V.rTag.QT(InevObject, l_Para, aContext.Processor) then
   l_Para.Invalidate([nev_spExtent]);
//#UC END# *4857CE0D022EAfterChange*
end;

procedure TableCellLeftIndentAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4857CEC601BBvar_AfterChange*
//#UC END# *4857CEC601BBvar_AfterChange*
begin
//#UC START# *4857CEC601BBAfterChange*
 DocumentSpaceAfterAfterChange(V, aProp, aContext);
//#UC END# *4857CEC601BBAfterChange*
end;

procedure TableCellRightIndentAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4857CEED02A3var_AfterChange*
//#UC END# *4857CEED02A3var_AfterChange*
begin
//#UC START# *4857CEED02A3AfterChange*
 DocumentSpaceAfterAfterChange(V, aProp, aContext);
//#UC END# *4857CEED02A3AfterChange*
end;

function TableCell_MergeStatus_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TableCell_MergeStatus'));
end;

function TableCell_MergeStatus_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function TableCell_MergeStatus_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTableCell_MergeStatus;
end;//MergeStatusClass.TagType

function TableCell_MergeStatus_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, TableCell_MergeStatus_TagClass);
end;

procedure TableCellMergeStatusAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4857CF8C0050var_AfterChange*
var
 l_ParaList : InevParaList;
//#UC END# *4857CF8C0050var_AfterChange*
begin
//#UC START# *4857CF8C0050AfterChange*
 if (aContext <> nil) AND not aContext.InIOProcess AND V.rTag.IsValid then
  if V.rTag.QT(InevParaList, l_ParaList, aContext.Processor) then
   l_ParaList.Invalidate([nev_spCellExtent]);
//#UC END# *4857CF8C0050AfterChange*
end;

function TableCell_VerticalAligment_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TableCell_VerticalAligment'));
end;

function TableCell_VerticalAligment_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function TableCell_VerticalAligment_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTableCell_VerticalAligment;
end;//VerticalAligmentClass.TagType

function TableCell_VerticalAligment_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, TableCell_VerticalAligment_TagClass);
end;

procedure TableCellVerticalAligmentAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4857D0750068var_AfterChange*
var
 l_ParaList : InevParaList;
//#UC END# *4857D0750068var_AfterChange*
begin
//#UC START# *4857D0750068AfterChange*
 if (aContext <> nil) AND not aContext.InIOProcess AND V.rTag.IsValid then
  if V.rTag.QT(InevParaList, l_ParaList, aContext.Processor) then
   l_ParaList.Invalidate([]);
//#UC END# *4857D0750068AfterChange*
end;

function TableCellTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTableCell;
end;//TableCellTagClass.TagType

function TableCellTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TableCell'));
end;

function TableCellTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_ParaList.IsKindOf(anAtomType);
end;

function TableCellTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TableCellTagClass.Make(Self);
end;

function SBSCellTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typSBSCell;
end;//SBSCellTagClass.TagType

function SBSCellTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('SBSCell'));
end;

function SBSCellTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_TableCell.IsKindOf(anAtomType);
end;

function SBSCellTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := SBSCellTagClass.Make(Self);
end;

function TableRowTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTableRow;
end;//TableRowTagClass.TagType

function TableRowTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TableRow'));
end;

function TableRowTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_ParaList.IsKindOf(anAtomType);
end;

function TableRowTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TableRowTagClass.Make(Self);
end;

function SBSRowTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typSBSRow;
end;//SBSRowTagClass.TagType

function SBSRowTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('SBSRow'));
end;

function SBSRowTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_TableRow.IsKindOf(anAtomType);
end;

function SBSRowTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := SBSRowTagClass.Make(Self);
end;

procedure TableStyleAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *52B12C2D003Dvar_AfterChange*
var
 l_Para : InevObject;
//#UC END# *52B12C2D003Dvar_AfterChange*
begin
//#UC START# *52B12C2D003DAfterChange*
 if (aContext <> nil) AND not aContext.InIOProcess AND V.rTag.IsValid then
  if V.rTag.QT(InevObject, l_Para, aContext.Processor) then
   l_Para.Invalidate([]);
//#UC END# *52B12C2D003DAfterChange*
end;

function TableTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTable;
end;//TableTagClass.TagType

function TableTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Table'));
end;

function TableTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_ParaList.IsKindOf(anAtomType);
end;

function TableTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TableTagClass.Make(Self);
end;

function ReqCellTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typReqCell;
end;//ReqCellTagClass.TagType

function ReqCellTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ReqCell'));
end;

function ReqCellTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_TableCell.IsKindOf(anAtomType);
end;

function ReqCellTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ReqCellTagClass.Make(Self);
end;

function ReqRow_ReqKind_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ReqRow_ReqKind'));
end;

function ReqRow_ReqKind_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function ReqRow_ReqKind_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typReqRow_ReqKind;
end;//ReqKindClass.TagType

function ReqRow_ReqKind_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, ReqRow_ReqKind_TagClass);
end;

procedure ReqRowStateIndexAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4CD0018201EBvar_AfterChange*
var
 l_Req      : IevReq;
 l_Button   : IevEditorControlButton;
 l_StateBtn : IevEditorStateButton;
//#UC END# *4CD0018201EBvar_AfterChange*
begin
//#UC START# *4CD0018201EBAfterChange*
 if V.rTag.IsValid then
  if V.rTag.QT(IevReq, l_Req) then
   try
    l_Button := l_Req.FirstField.FindButton(ev_btLogical);
    if Supports(l_Button, IevEditorStateButton, l_StateBtn) then
     l_StateBtn.CurrentIndex := l_StateBtn.ImageIndex + V.rNew.AsLong;
   finally
    l_Req := nil;
   end;//try..finally
//#UC END# *4CD0018201EBAfterChange*
end;

function ReqRowTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typReqRow;
end;//ReqRowTagClass.TagType

function ReqRowTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ReqRow'));
end;

function ReqRowTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_TableRow.IsKindOf(anAtomType);
end;

function ReqRowTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ReqRowTagClass.Make(Self);
end;

procedure ControlsBlockEnabledAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *485810AE033Cvar_AfterChange*
//#UC END# *485810AE033Cvar_AfterChange*
begin
//#UC START# *485810AE033CAfterChange*
 BlockHeaderUpdate(V, aProp, aContext);
//#UC END# *485810AE033CAfterChange*
end;

procedure ControlsBlockUpperAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *485810C80074var_AfterChange*
//#UC END# *485810C80074var_AfterChange*
begin
//#UC START# *485810C80074AfterChange*
 BlockHeaderUpdate(V, aProp, aContext);
//#UC END# *485810C80074AfterChange*
end;

procedure ControlsBlockFlatAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *485811030276var_AfterChange*
//#UC END# *485811030276var_AfterChange*
begin
//#UC START# *485811030276AfterChange*
 BlockHeaderUpdate(V, aProp, aContext);
//#UC END# *485811030276AfterChange*
end;

function ControlsBlockTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typControlsBlock;
end;//ControlsBlockTagClass.TagType

function ControlsBlockTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ControlsBlock'));
end;

function ControlsBlockTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Block.IsKindOf(anAtomType);
end;

function ControlsBlockTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ControlsBlockTagClass.Make(Self);
end;

procedure BitmapParaLeftIndentAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *4858158D0254var_AfterChange*
var
 l_Para : InevObject;
//#UC END# *4858158D0254var_AfterChange*
begin
//#UC START# *4858158D0254AfterChange*
 if (aContext <> nil) AND not aContext.InIOProcess AND V.rTag.IsValid then
  if V.rTag.QT(InevObject, l_Para, aContext.Processor) then
   l_Para.Invalidate([]);
//#UC END# *4858158D0254AfterChange*
end;

procedure BitmapParaHeightAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *486D23B00263var_AfterChange*
//#UC END# *486D23B00263var_AfterChange*
begin
//#UC START# *486D23B00263AfterChange*
 StyledLeafParaJustificationAfterChange(V, aProp, aContext);
//#UC END# *486D23B00263AfterChange*
end;

function BitmapPara_Object_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('BitmapPara_Object'));
end;

function BitmapPara_Object_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_l3Base.IsKindOf(anAtomType);
end;

function BitmapPara_Object_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег BitmapPara_Object');
end;

function BitmapParaTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typBitmapPara;
end;//BitmapParaTagClass.TagType

function BitmapParaTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('BitmapPara'));
end;

function BitmapParaTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_StyledLeafPara.IsKindOf(anAtomType);
end;

function BitmapParaTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := BitmapParaTagClass.Make(Self);
end;

function XMLTagTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typXMLTag;
end;//XMLTagTagClass.TagType

function XMLTagTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('XMLTag'));
end;

function XMLTagTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Block.IsKindOf(anAtomType);
end;

function XMLTagTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := XMLTagTagClass.Make(Self);
end;

function XMLTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typXML;
end;//XMLTagClass.TagType

function XMLTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('XML'));
end;

function XMLTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Document.IsKindOf(anAtomType);
end;

function XMLTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := XMLTagClass.Make(Self);
end;

function ExtDataParaTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typExtDataPara;
end;//ExtDataParaTagClass.TagType

function ExtDataParaTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ExtDataPara'));
end;

function ExtDataParaTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_LeafPara.IsKindOf(anAtomType);
end;

function ExtDataParaTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ExtDataParaTagClass.Make(Self);
end;

function AttrValueTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAttrValue;
end;//AttrValueTagClass.TagType

function AttrValueTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AttrValue'));
end;

function AttrValueTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_TextPara.IsKindOf(anAtomType);
end;

function AttrValueTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AttrValueTagClass.Make(Self);
end;

function AttrNameTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAttrName;
end;//AttrNameTagClass.TagType

function AttrNameTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AttrName'));
end;

function AttrNameTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_TextPara.IsKindOf(anAtomType);
end;

function AttrNameTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AttrNameTagClass.Make(Self);
end;

function AttrTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAttr;
end;//AttrTagClass.TagType

function AttrTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Attr'));
end;

function AttrTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Block.IsKindOf(anAtomType);
end;

function AttrTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AttrTagClass.Make(Self);
end;

function TagNameTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTagName;
end;//TagNameTagClass.TagType

function TagNameTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TagName'));
end;

function TagNameTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_TextPara.IsKindOf(anAtomType);
end;

function TagNameTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TagNameTagClass.Make(Self);
end;

function TagBodyTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTagBody;
end;//TagBodyTagClass.TagType

function TagBodyTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TagBody'));
end;

function TagBodyTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_TextPara.IsKindOf(anAtomType);
end;

function TagBodyTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TagBodyTagClass.Make(Self);
end;

function ImageListBitmapTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typImageListBitmap;
end;//ImageListBitmapTagClass.TagType

function ImageListBitmapTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ImageListBitmap'));
end;

function ImageListBitmapTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_BitmapPara.IsKindOf(anAtomType);
end;

function ImageListBitmapTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ImageListBitmapTagClass.Make(Self);
end;

procedure PagePropertiesOrientationAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *49A403F203B7var_AfterChange*

 procedure UnformatDocument(const aTagFromDocument: Tl3Variant;
   const anOpPack: InevOp);
 var
  l_TagOwner : Tl3Variant;
  l_Para     : InevPara;
 begin//UnformatDocument
  anOpPack.MarkModified(aTagFromDocument.AsObject);
  l_TagOwner := aTagFromDocument;
  while l_TagOwner.IsValid do
  begin
   if l_TagOwner.IsKindOf(k2_typDocument) then
   begin
    if l_TagOwner.QT(InevPara, l_Para) then 
     l_Para.Invalidate([nev_spExtent]);
    Break;
   end//l_TagOwner.IsKindOf(k2_typDocument)
   else
    l_TagOwner := l_TagOwner.Owner;
  end;//l_TagOwner.IsValid
 end;//UnformatDocument

//#UC END# *49A403F203B7var_AfterChange*
begin
//#UC START# *49A403F203B7AfterChange*
 if (aContext <> nil) AND not aContext.InIOProcess then
  UnformatDocument(V.rTag.Owner, aContext);
//#UC END# *49A403F203B7AfterChange*
end;



procedure PagePropertiesWidthAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *49A4040D0395var_AfterChange*
//#UC END# *49A4040D0395var_AfterChange*
begin
//#UC START# *49A4040D0395AfterChange*
 PagePropertiesOrientationAfterChange(V, aProp, aContext);
//#UC END# *49A4040D0395AfterChange*
end;

function SimpleDocumentTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typSimpleDocument;
end;//SimpleDocumentTagClass.TagType

function SimpleDocumentTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('SimpleDocument'));
end;

function SimpleDocumentTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Document.IsKindOf(anAtomType);
end;

function SimpleDocumentTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := SimpleDocumentTagClass.Make(Self);
end;

function CommentParaTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typCommentPara;
end;//CommentParaTagClass.TagType

function CommentParaTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('CommentPara'));
end;

function CommentParaTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Block.IsKindOf(anAtomType);
end;

function CommentParaTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := CommentParaTagClass.Make(Self);
end;

function SBSTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typSBS;
end;//SBSTagClass.TagType

function SBSTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('SBS'));
end;

function SBSTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Table.IsKindOf(anAtomType);
end;

function SBSTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := SBSTagClass.Make(Self);
end;

function TinyDocumentTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTinyDocument;
end;//TinyDocumentTagClass.TagType

function TinyDocumentTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TinyDocument'));
end;

function TinyDocumentTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_SimpleDocument.IsKindOf(anAtomType);
end;

function TinyDocumentTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TinyDocumentTagClass.Make(Self);
end;

function LeafParaDecorationsHolderTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typLeafParaDecorationsHolder;
end;//LeafParaDecorationsHolderTagClass.TagType

function LeafParaDecorationsHolderTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('LeafParaDecorationsHolder'));
end;

function LeafParaDecorationsHolderTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_ParaList.IsKindOf(anAtomType);
end;

function LeafParaDecorationsHolderTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := LeafParaDecorationsHolderTagClass.Make(Self);
end;

function ReqGroupTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typReqGroup;
end;//ReqGroupTagClass.TagType

function ReqGroupTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ReqGroup'));
end;

function ReqGroupTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Table.IsKindOf(anAtomType);
end;

function ReqGroupTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ReqGroupTagClass.Make(Self);
end;

function AutoreferatDocumentTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAutoreferatDocument;
end;//AutoreferatDocumentTagClass.TagType

function AutoreferatDocumentTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoreferatDocument'));
end;

function AutoreferatDocumentTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Document.IsKindOf(anAtomType);
end;

function AutoreferatDocumentTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AutoreferatDocumentTagClass.Make(Self);
end;

function DictEntry_ShortName_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DictEntry_ShortName'));
end;

function DictEntry_ShortName_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function DictEntry_ShortName_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function DictEntryTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typDictEntry;
end;//DictEntryTagClass.TagType

function DictEntryTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DictEntry'));
end;

function DictEntryTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Document.IsKindOf(anAtomType);
end;

function DictEntryTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := DictEntryTagClass.Make(Self);
end;

function CloakTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typCloak;
end;//CloakTagClass.TagType

function CloakTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Cloak'));
end;

function CloakTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_ControlsBlock.IsKindOf(anAtomType);
end;

function CloakTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := CloakTagClass.Make(Self);
end;

function NodeGroupTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typNodeGroup;
end;//NodeGroupTagClass.TagType

function NodeGroupTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('NodeGroup'));
end;

function NodeGroupTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_ControlsBlock.IsKindOf(anAtomType);
end;

function NodeGroupTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := NodeGroupTagClass.Make(Self);
end;

function DocumentQueryTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typDocumentQuery;
end;//DocumentQueryTagClass.TagType

function DocumentQueryTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DocumentQuery'));
end;

function DocumentQueryTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Document.IsKindOf(anAtomType);
end;

function DocumentQueryTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := DocumentQueryTagClass.Make(Self);
end;

function AnnoTopicTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAnnoTopic;
end;//AnnoTopicTagClass.TagType

function AnnoTopicTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AnnoTopic'));
end;

function AnnoTopicTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevNativeSchema(TypeTable).t_Document.IsKindOf(anAtomType);
end;

function AnnoTopicTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AnnoTopicTagClass.Make(Self);
end;

function DocumentContainerAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DocumentContainer'));
end;

function DocumentContainerAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег DocumentContainer');
end;

constructor TevNativeSchema.Create;
var
 l_ChangesInfo_Header_HeaderC : Tl3Variant;
 l_HeaderC_Segments_Hyperlinks : Tl3Variant;
 l_Segments_Hyperlinks_Hyperlink : Tl3Variant;
 l_HeaderC_Segments_Objects : Tl3Variant;
 l_Segments_Objects_Collapser : Tl3Variant;
 l_Objects_Collapser_Bitmap : Tl3Variant;
 l_ChangesInfo_Footer_FooterC : Tl3Variant;
 l_FooterC_Segments_Hyperlinks : Tl3Variant;
 l_Hyperlinks_Hyperlink_Address : Tl3Variant;
 l_LinkToPublication_Header_FooterC : Tl3Variant;
 l_ExpandedText_Header_HeaderC : Tl3Variant;
begin
 inherited;
//#UC START# *484CD009023Dttimpl*
//#UC END# *484CD009023Dttimpl*
 // StyledLeafPara
 t_StyledLeafPara := DefineAutoType([t_LeafPara], '"Листьевой" параграф с оформлением', StyledLeafParaTag) As StyledLeafParaTag;
 with t_StyledLeafPara do
 begin
  AtomClass := StyledLeafParaTagClass;
//#UC START# *48567D1900F6atom1*
//#UC END# *48567D1900F6atom1*
  with DefineProperty(k2_attrStyle, t_TextStyle, 'Стиль') do
  begin
   Shared := true;
   AfterChange := StyledLeafParaStyleAfterChange;
  end;//Style
  with Tk2CustomProperty(Prop[k2_attrVisible]) do
  begin
   EmptyMapping := k2_attrStyle;
  end;//Visible
  with Tk2CustomProperty(Prop[k2_attrSpaceBefore]) do
  begin
   EmptyMapping := k2_attrStyle;
  end;//SpaceBefore
  with Tk2CustomProperty(Prop[k2_attrSpaceAfter]) do
  begin
   EmptyMapping := k2_attrStyle;
  end;//SpaceAfter
  with DefineProperty(k2_attrJustification, t_Justification, 'Выравнивание текста') do
  begin
   EmptyMapping := k2_attrStyle;
   AfterChange := StyledLeafParaJustificationAfterChange;
  end;//Justification
  with DefineProperty(k2_attrHandle, t_Handle, 'Идентификатор') do
  begin
   DefaultValue := 0;
  end;//Handle
  with Tk2CustomProperty(Prop[k2_attrWidth]) do
  begin
   AfterChange := StyledLeafParaWidthAfterChange;
  end;//Width
  with Tk2CustomProperty(Prop[k2_attrLeftIndent]) do
  begin
   EmptyMapping := k2_attrStyle;
   AfterChange := StyledLeafParaLeftIndentAfterChange;
  end;//LeftIndent
  with Tk2CustomProperty(Prop[k2_attrRightIndent]) do
  begin
   EmptyMapping := k2_attrStyle;
   AfterChange := StyledLeafParaRightIndentAfterChange;
  end;//RightIndent
  with DefineProperty(k2_attrLineSpacing, t_Long, 'Интерлиньяж') do
  begin
   EmptyMapping := k2_attrStyle;
  end;//LineSpacing
//#UC START# *48567D1900F6atom*
  DefineChildrenPath(t_Sub, [k2_tiSubs, k2_tiChildren,
                             k2_tiHandle, Ord(ev_sbtSub)]);
  DefineChildrenPath(t_Bookmark, [k2_tiSubs, k2_tiChildren,
                                  k2_tiHandle, Ord(ev_sbtBookmark)]);
  DefineChildrenPath(t_Mark, [k2_tiSubs, k2_tiChildren,
                              k2_tiHandle, Ord(ev_sbtMark)]);
//#UC END# *48567D1900F6atom*
 end;//StyledLeafPara
 // TextPara
 t_TextPara := DefineType(k2_idTextPara {22}, [t_StyledLeafPara], 'Текстовый параграф', TextParaTag) As TextParaTag;
 with t_TextPara do
 begin
  AtomClass := TextParaTagClass;
  WrapperType := WevTextPara;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevTextParaInterfaceFactory;
  {$IfEnd} //k2ForEditor

//#UC START# *485683750360atom1*
//#UC END# *485683750360atom1*
  with Tk2CustomProperty(Prop[k2_attrWidth]) do
  begin
   DefaultValue := 0;
   EmptyMapping := k2_attrMask;
   Stored := false;
  end;//Width
  with Tk2CustomProperty(Prop[k2_attrLeftIndent]) do
  begin
   AfterChange := nil;
  end;//LeftIndent
  with Tk2CustomProperty(Prop[k2_attrRightIndent]) do
  begin
   AfterChange := nil;
  end;//RightIndent
  with DefineProperty(k2_attrAllowHyphen, t_Bool, 'Разрешены переносы') do
  begin
   DefaultValue := Ord(false);
   EmptyMapping := k2_attrStyle;
  end;//AllowHyphen
  with DefineProperty(k2_attrFirstIndent, t_Inch, 'Отступ красной строки') do
  begin
   EmptyMapping := k2_attrStyle;
  end;//FirstIndent
  with DefineProperty(k2_attrFirstLineIndent, t_Inch, 'Отступ красной строки относительно левого отступа (пока не используется)') do
  begin
   EmptyMapping := k2_attrStyle;
  end;//FirstLineIndent
  with DefineProperty(k2_attrBullet, t_Bullet, 'Тип маркера') do
  begin
   DefaultValue := 0;
  end;//Bullet
  with DefineProperty(k2_attrPrintFontSize, t_Long, 'Размер шрифта при печати') do
  begin
   DefaultValue := 11;
  end;//PrintFontSize
  with DefineProperty(k2_attrCollapsed, t_Bool, '') do
  begin
   DefaultValue := Ord(false);
  end;//Collapsed
  with DefineProperty(k2_attrText, t_String, 'Текст') do
  begin
  end;//Text
  with DefineProperty(k2_attrFont, t_Font, '') do
  begin
   EmptyMapping := k2_attrStyle;
   AfterChange := TextParaFontAfterChange;
//#UC START# *485784AF0369attr*
   Tk2Prop(Tk2TypePrim(AtomType).Prop[k2_tiSize]).AfterChange := TextParaFontAfterChange;
//#UC END# *485784AF0369attr*
  end;//Font
  with Tk2CustomProperty(Prop[k2_attrBackColor]) do
  begin
   ReadOnly := true;
   EmptyMapping := k2_attrFont;
   AtomType := t_Color;
  end;//BackColor
  t_TextPara_Segments := DefineAutoType([t_OList], 'Текстовый параграф Segments', TextPara_Segments_Tag) As TextPara_Segments_Tag;
  try
   t_TextPara_Segments.DefineChildren(t_SegmentsLayer);
   DefineProperty(k2_attrSegments, t_TextPara_Segments, '');
   t_TextPara_Segments.Recalc;
  except
   FreeAndNil(t_TextPara_Segments);
  end;//try..except
  with t_TextPara_Segments.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrHandle;
   StoredChildProc := TextParaSegmentsChildStored;
  end;//Segments
  t_TextPara_TabStops := DefineAutoType([t_OList], 'Текстовый параграф Позиции табуляции', TextPara_TabStops_Tag) As TextPara_TabStops_Tag;
  try
   t_TextPara_TabStops.DefineChildren(t_TabStop);
   DefineProperty(k2_attrTabStops, t_TextPara_TabStops, 'Позиции табуляции');
   t_TextPara_TabStops.Recalc;
  except
   FreeAndNil(t_TextPara_TabStops);
  end;//try..except
  with t_TextPara_TabStops.ArrayProp[k2_tiChildren] do
  begin
  end;//TabStops
  with Tk2CustomProperty(Prop[k2_attrFrame]) do
  begin
   EmptyMapping := k2_attrStyle;
   AtomType := t_Frame;
  end;//Frame
//#UC START# *485683750360atom*
  ParamsForClone := l3LongArray([k2_tiStyle,
                                 k2_tiFont,
                                 k2_tiFirstIndent,
                                 k2_tiFirstLineIndent,
                                 k2_tiLeftIndent,
                                 k2_tiRightIndent,
                                 k2_tiSpaceBefore,
                                 k2_tiSpaceAfter,
                                 k2_tiJustification,
                                 k2_tiVisible,
                                 k2_tiFrame,
                                 k2_tiBullet,
                                 k2_tiTabStops,
                                 k2_tiPrintFontSize]);

  t_TextPara_Segments.DefineChildrenPath(t_Hyperlink,
                     [k2_tiChildren,
                      k2_tiHandle, Ord(ev_slHyperlinks)]);
  t_TextPara_Segments.DefineChildrenPath(t_ObjectSegment,
                     [k2_tiChildren,
                      k2_tiHandle, Ord(ev_slObjects)]);
  t_TextPara_Segments.DefineChildrenPath(t_TextSegment,
                     [k2_tiChildren,
                      k2_tiHandle, Ord(ev_slView)]);

  DefineChildrenPath(t_Hyperlink,
                     [k2_tiSegments, k2_tiChildren,
                      k2_tiHandle, Ord(ev_slHyperlinks)]);
  DefineChildrenPath(t_ObjectSegment,
                     [k2_tiSegments, k2_tiChildren,
                      k2_tiHandle, Ord(ev_slObjects)]);
  DefineChildrenPath(t_TextSegment,
                     [k2_tiSegments, k2_tiChildren,
                      k2_tiHandle, Ord(ev_slView)]);
  SetNeedMarkModified([k2_tiLeftIndent,
                       k2_tiRightIndent,
                       k2_tiFirstIndent,
                       k2_tiFirstLineIndent]);
  t_TextPara.Recalc;                     
//#UC END# *485683750360atom*
 end;//TextPara
 // DecorTextPara
 t_DecorTextPara := DefineType(k2_idDecorTextPara {72}, [t_TextPara], 'Текстовый параграф - оформление, не редактируется, не участвует в поиске', DecorTextParaTag) As DecorTextParaTag;
 with t_DecorTextPara do
 begin
  AtomClass := DecorTextParaTagClass;
 end;//DecorTextPara
 // ControlPara
 t_ControlPara := DefineType(k2_idControlPara {119}, [t_TextPara], 'Параграф представляющий собой контрол ввода', ControlParaTag) As ControlParaTag;
 with t_ControlPara do
 begin
  AtomClass := ControlParaTagClass;
  {$If defined(k2ForEditor)}
  WrapperType := WevControlPara;
  {$IfEnd} //k2ForEditor

  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevControlParaInterfaceFactory;
  {$IfEnd} //k2ForEditor

//#UC START# *4857923F0186atom1*
//#UC END# *4857923F0186atom1*
  with DefineProperty(k2_attrName, t_String, 'Имя контрола') do
  begin
  end;//Name
  with DefineProperty(k2_attrShortName, t_String, 'Подсказка контрола') do
  begin
  end;//ShortName
  with DefineProperty(k2_attrAlternateText, t_TextPara, 'Альтернативный текст (с оформлением)') do
  begin
  end;//AlternateText
  with DefineProperty(k2_attrMaxTextLength, t_Long, 'Максимальная длина текста для контрола') do
  begin
   DefaultValue := Pred(High(Integer));
  end;//MaxTextLength
  t_ControlPara_Type := DefineAutoType([t_Enum], 'Параграф представляющий собой контрол ввода Тип контрола', ControlPara_Type_Tag) As ControlPara_Type_Tag;
  try
   t_ControlPara_Type.AtomType := TypeInfo(TevControlType);
   DefineProperty(k2_attrType, t_ControlPara_Type, 'Тип контрола');
   t_ControlPara_Type.Recalc;
  except
   FreeAndNil(t_ControlPara_Type);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrType]) do
  begin
   DefaultValue := Ord(ev_ctLabel);
  end;//Type
  with Tk2CustomProperty(Prop[k2_attrCollapsed]) do
  begin
   DefaultValue := Ord(false);
   Stored := false;
   AfterChange := ControlParaCollapsedAfterChange;
   AtomType := t_Bool;
  end;//Collapsed
  with DefineProperty(k2_attrValid, t_Bool, 'Корректность данных') do
  begin
   DefaultValue := Ord(true);
   AfterChange := ControlParaValidAfterChange;
  end;//Valid
  with Tk2CustomProperty(Prop[k2_attrVisible]) do
  begin
   AfterChange := ControlParaVisibleAfterChange;
  end;//Visible
  with DefineProperty(k2_attrStateIndex, t_Long, 'Текущее состояние') do
  begin
   DefaultValue := -1;
   AfterChange := ControlParaStateIndexAfterChange;
  end;//StateIndex
  with DefineProperty(k2_attrStateCount, t_Long, 'Количество состояний') do
  begin
   DefaultValue := 2;
  end;//StateCount
  with DefineProperty(k2_attrImageIndex, t_Long, 'Индекс картинки') do
  begin
   DefaultValue := -1;
  end;//ImageIndex
  with DefineProperty(k2_attrChecked, t_Bool, 'Кнопка нажата/отпущена') do
  begin
   DefaultValue := Ord(false);
   AfterChange := ControlParaCheckedAfterChange;
  end;//Checked
  with DefineProperty(k2_attrEnabled, t_Bool, 'Доступность контрола') do
  begin
   DefaultValue := Ord(true);
   AfterChange := ControlParaEnabledAfterChange;
   StoredProc := ControlParaEnabledStored;
  end;//Enabled
  with DefineProperty(k2_attrUpper, t_Bool, 'Мышь над кнопкой') do
  begin
   DefaultValue := Ord(false);
   AfterChange := ControlParaUpperAfterChange;
  end;//Upper
  with DefineProperty(k2_attrFlat, t_Bool, 'Режим Flat') do
  begin
   DefaultValue := Ord(false);
   AfterChange := ControlParaFlatAfterChange;
  end;//Flat
  with DefineProperty(k2_attrScript, t_String, 'Скрипт') do
  begin
  end;//Script
  with DefineProperty(k2_attrObject, t_IUnknown, 'Данные для контрола') do
  begin
   Stored := false;
  end;//Object
  with DefineProperty(k2_attrModelControl, t_Long, 'Ссылка на контрол модели') do
  begin
   Stored := false;
  end;//ModelControl
  with DefineProperty(k2_attrNodeVisibleIndex, t_Long, 'VisibleIndex для выбранного в дереве узла - гнусный хак') do
  begin
   DefaultValue := -1;
   Stored := false;
  end;//NodeVisibleIndex
  with Tk2CustomProperty(Prop[k2_attrSpaceBefore]) do
  begin
   ReadOnly := true;
  end;//SpaceBefore
  with Tk2CustomProperty(Prop[k2_attrSpaceAfter]) do
  begin
   ReadOnly := true;
  end;//SpaceAfter
  with Tk2CustomProperty(Prop[k2_attrRightIndent]) do
  begin
   ReadOnly := true;
  end;//RightIndent
  with Tk2CustomProperty(Prop[k2_attrLeftIndent]) do
  begin
   ReadOnly := true;
  end;//LeftIndent
  with Tk2CustomProperty(Prop[k2_attrFirstIndent]) do
  begin
   ReadOnly := true;
  end;//FirstIndent
  with Tk2CustomProperty(Prop[k2_attrFirstLineIndent]) do
  begin
   ReadOnly := true;
  end;//FirstLineIndent
//#UC START# *4857923F0186atom*
  UndefineProperties([k2_tiPrintFontSize]);
  Recalc;
  ParamsForClone := l3CatLongArray(ParamsForClone, [k2_tiType, k2_tiChecked, k2_tiUpper]);
//#UC END# *4857923F0186atom*
 end;//ControlPara
 // Formula
 t_Formula := DefineType(k2_idFormula {110}, [t_TextPara], 'Формула', FormulaTag) As FormulaTag;
 with t_Formula do
 begin
  AtomClass := FormulaTagClass;
  WrapperType := WevFormula;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevFormulaInterfaceFactory;
  {$IfEnd} //k2ForEditor

//#UC START# *4857926501CBatom1*
//#UC END# *4857926501CBatom1*
  with Tk2CustomProperty(Prop[k2_attrCollapsed]) do
  begin
   DefaultValue := Ord(true);
   AtomType := t_Bool;
  end;//Collapsed
  with Tk2CustomProperty(Prop[k2_attrText]) do
  begin
   AfterChange := FormulaTextAfterChange;
  end;//Text
//#UC START# *4857926501CBatom*
  UndefineProperties([k2_tiHeight, k2_tiWidth]);
  Recalc;
//#UC END# *4857926501CBatom*
 end;//Formula
 // ParaList
 t_ParaList := DefineAutoType([t_Para], 'Список параграфов', ParaListTag) As ParaListTag;
 with t_ParaList do
 begin
  AtomClass := ParaListTagClass;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevParaListInterfaceFactory;
  {$IfEnd} //k2ForEditor

  with Tk2CustomProperty(Prop[k2_attrWidth]) do
  begin
   DefaultValue := 0;
   StoredProc := ParaListWidthStored;
  end;//Width
  with Tk2CustomProperty(Prop[k2_attrLeftIndent]) do
  begin
   DefaultValue := 0;
  end;//LeftIndent
  t_ParaList_Orientation := DefineAutoType([t_Enum], 'Список параграфов Ориентация', ParaList_Orientation_Tag) As ParaList_Orientation_Tag;
  try
   t_ParaList_Orientation.AtomType := TypeInfo(Tl3Orientation);
   DefineProperty(k2_attrOrientation, t_ParaList_Orientation, 'Ориентация');
   t_ParaList_Orientation.Recalc;
  except
   FreeAndNil(t_ParaList_Orientation);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrOrientation]) do
  begin
   ReadOnly := true;
   DefaultValue := Ord(ev_orVertical);
  end;//Orientation
  with DefineProperty(k2_attrAllChildrenCount, t_Long, 'Общее число детей') do
  begin
   DefaultValue := 0;
   Stored := false;
  end;//AllChildrenCount
  with DefineProperty(k2_attrFixedWidth, t_Bool, 'Фиксированная ширина') do
  begin
   ReadOnly := true;
   DefaultValue := Ord(false);
  end;//FixedWidth
  with DefineProperty(k2_attrLineSpacing, t_Long, '') do
  begin
   DefaultValue := Pred(High(Integer));
  end;//LineSpacing
  with DefineChildren(t_Para) do
  begin
  end;//
  ArrayProp[k2_tiChildren].DefaultChildType := t_TextPara;
 end;//ParaList
 // HFParent
 t_HFParent := DefineAutoType([t_ParaList], '', HFParentTag) As HFParentTag;
 with t_HFParent do
 begin
  AtomClass := HFParentTagClass;
  with Tk2CustomProperty(Prop[k2_attrOrientation]) do
  begin
   ReadOnly := true;
  end;//Orientation
  t_HFParent_Type := DefineAutoType([t_Enum], 'HFParent Type', HFParent_Type_Tag) As HFParent_Type_Tag;
  try
   t_HFParent_Type.AtomType := TypeInfo(TevHFType);
   DefineProperty(k2_attrType, t_HFParent_Type, '');
   t_HFParent_Type.Recalc;
  except
   FreeAndNil(t_HFParent_Type);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrType]) do
  begin
   DefaultValue := Ord(evd_hftOrdinal);
  end;//Type
 end;//HFParent
 // Header
 t_Header := DefineType(k2_idHeader {100}, [t_HFParent], 'Верхний колонтитул', HeaderTag) As HeaderTag;
 with t_Header do
 begin
  AtomClass := HeaderTagClass;
 end;//Header
 // Footer
 t_Footer := DefineType(k2_idFooter {101}, [t_HFParent], 'Нижний колонтитул', FooterTag) As FooterTag;
 with t_Footer do
 begin
  AtomClass := FooterTagClass;
 end;//Footer
 // Division
 t_Division := DefineType(k2_idDivision {102}, [t_ParaList], 'Раздел документа (не используется)', DivisionTag) As DivisionTag;
 with t_Division do
 begin
  AtomClass := DivisionTagClass;
  with Tk2CustomProperty(Prop[k2_attrOrientation]) do
  begin
   ReadOnly := true;
  end;//Orientation
  t_Division_Headers := DefineAutoType([t_OList], 'Раздел документа (не используется) Верхние колонтитулы', Division_Headers_Tag) As Division_Headers_Tag;
  try
   t_Division_Headers.DefineChildren(t_Header);
   DefineProperty(k2_attrHeaders, t_Division_Headers, 'Верхние колонтитулы');
   t_Division_Headers.Recalc;
  except
   FreeAndNil(t_Division_Headers);
  end;//try..except
  with t_Division_Headers.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrType;
  end;//Headers
  t_Division_Footers := DefineAutoType([t_OList], 'Раздел документа (не используется) Нижние колонтитулы', Division_Footers_Tag) As Division_Footers_Tag;
  try
   t_Division_Footers.DefineChildren(t_Footer);
   DefineProperty(k2_attrFooters, t_Division_Footers, 'Нижние колонтитулы');
   t_Division_Footers.Recalc;
  except
   FreeAndNil(t_Division_Footers);
  end;//try..except
  with t_Division_Footers.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrType;
  end;//Footers
 end;//Division
 // ContentsElement
 t_ContentsElement := DefineType(k2_idContentsElement {133}, [t_ParaList, t_ObjectWithHandle], 'элемент структуры документа', ContentsElementTag) As ContentsElementTag;
 with t_ContentsElement do
 begin
  AtomClass := ContentsElementTagClass;
  t_ContentsElement_InContents := DefineAutoType([t_Enum], 'элемент структуры документа InContents', ContentsElement_InContents_Tag) As ContentsElement_InContents_Tag;
  try
   t_ContentsElement_InContents.AtomType := TypeInfo(TevSubPlace);
   DefineProperty(k2_attrInContents, t_ContentsElement_InContents, '');
   t_ContentsElement_InContents.Recalc;
  except
   FreeAndNil(t_ContentsElement_InContents);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrInContents]) do
  begin
   DefaultValue := Ord(ev_spNoWhere);
  end;//InContents
  with Tk2CustomProperty(Prop[k2_attrRubber]) do
  begin
   DefaultValue := Ord(true);
  end;//Rubber
  with DefineProperty(k2_attrName, t_String, 'Имя') do
  begin
  end;//Name
  with DefineProperty(k2_attrShortName, t_String, 'Короткое имя') do
  begin
  end;//ShortName
 end;//ContentsElement
 // Participant
 t_Participant := DefineType(k2_idParticipant {90}, [t_Tag], 'Участник', ParticipantTag) As ParticipantTag;
 with t_Participant do
 begin
  AtomClass := ParticipantTagClass;
  with DefineProperty(k2_attrType, t_Long, '') do
  begin
  end;//Type
  with DefineProperty(k2_attrName, t_String, '') do
  begin
  end;//Name
 end;//Participant
 // Block
 t_Block := DefineType(k2_idBlock {50}, [t_ParaList, t_Sub, t_ContentsElement], 'Элемент структуры документа', BlockTag) As BlockTag;
 with t_Block do
 begin
  AtomClass := BlockTagClass;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevBlockInterfaceFactory;
  {$IfEnd} //k2ForEditor

  with Tk2CustomProperty(Prop[k2_attrSpaceBefore]) do
  begin
   DefaultValue := 0;
   EmptyMapping := k2_attrStyle;
   Stored := false;
  end;//SpaceBefore
  with Tk2CustomProperty(Prop[k2_attrSpaceAfter]) do
  begin
   DefaultValue := 0;
   EmptyMapping := k2_attrStyle;
   Stored := false;
  end;//SpaceAfter
  with Tk2CustomProperty(Prop[k2_attrLeftIndent]) do
  begin
   DefaultValue := 0;
   EmptyMapping := k2_attrStyle;
   Stored := false;
  end;//LeftIndent
  with Tk2CustomProperty(Prop[k2_attrRightIndent]) do
  begin
   DefaultValue := 0;
   EmptyMapping := k2_attrStyle;
   Stored := false;
  end;//RightIndent
  with Tk2CustomProperty(Prop[k2_attrFixedWidth]) do
  begin
   DefaultValue := Ord(false);
  end;//FixedWidth
  with Tk2CustomProperty(Prop[k2_attrWidth]) do
  begin
   ReadOnly := true;
  end;//Width
  with DefineProperty(k2_attrExternalHandle, t_Handle, 'Идентификатор внешнего объекта') do
  begin
   NeedMarkModified := true;
  end;//ExternalHandle
  with DefineProperty(k2_attrType, t_Long, 'Тип внешнего объекта') do
  begin
   DefaultValue := 0;
   NeedMarkModified := true;
  end;//Type
  with DefineProperty(k2_attrCollapsed, t_Bool, 'Раскрыт') do
  begin
   DefaultValue := Ord(false);
   AfterChange := BlockCollapsedAfterChange;
   StoredProc := BlockCollapsedStored;
  end;//Collapsed
  with DefineProperty(k2_attrContentsLevel, t_Long, 'Уровень оглавления') do
  begin
   DefaultValue := Pred(High(Integer));
  end;//ContentsLevel
  with DefineProperty(k2_attrContentsLevel5, t_Long, 'Уровень оглавления для 5.х') do
  begin
   DefaultValue := 0;
  end;//ContentsLevel5
  t_Block_LayerID := DefineAutoType([t_Enum], 'Элемент структуры документа Слой блока', Block_LayerID_Tag) As Block_LayerID_Tag;
  try
   t_Block_LayerID.AtomType := TypeInfo(TevSubHandle);
   DefineProperty(k2_attrLayerID, t_Block_LayerID, 'Слой блока');
   t_Block_LayerID.Recalc;
  except
   FreeAndNil(t_Block_LayerID);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrLayerID]) do
  begin
   ReadOnly := true;
   DefaultValue := Ord(ev_sbtSub);
  end;//LayerID
  with DefineProperty(k2_attrStyle, t_TextStyle, '') do
  begin
   DefaultValue := k2_TransparentValue;
   NeedMarkModified := true;
   AfterChange := BlockStyleAfterChange;
  end;//Style
  with Tk2CustomProperty(Prop[k2_attrFrame]) do
  begin
   EmptyMapping := k2_attrStyle;
  end;//Frame
  with Tk2CustomProperty(Prop[k2_attrBackColor]) do
  begin
   ReadOnly := false;
   DefaultValue := k2_TransparentValue;
   EmptyMapping := k2_attrFont;
  end;//BackColor
  with DefineProperty(k2_attrCompareContentsLevel, t_Long, 'http://mdp.garant.ru/pages/viewpage.action?pageId=332563400') do
  begin
  end;//CompareContentsLevel
  with DefineProperty(k2_attrFont, t_Font, '') do
  begin
   EmptyMapping := k2_attrStyle;
  end;//Font
  t_Block_ViewKind := DefineAutoType([t_Enum], 'Элемент структуры документа http://mdp.garant.ru/pages/viewpage.action?pageId=360022952', Block_ViewKind_Tag) As Block_ViewKind_Tag;
  try
   t_Block_ViewKind.AtomType := TypeInfo(TevBlockViewKind);
   DefineProperty(k2_attrViewKind, t_Block_ViewKind, 'http://mdp.garant.ru/pages/viewpage.action?pageId=360022952');
   t_Block_ViewKind.Recalc;
  except
   FreeAndNil(t_Block_ViewKind);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrViewKind]) do
  begin
  end;//ViewKind
 end;//Block
 // Version
 t_Version := DefineType(k2_idVersion {136}, [t_DictItem], 'Версия', VersionTag) As VersionTag;
 with t_Version do
 begin
  with DefineProperty(k2_attrIsActive, t_Bool, 'http://mdp.garant.ru/pages/viewpage.action?pageId=269083814') do
  begin
  end;//IsActive
  with DefineProperty(k2_attrType, t_Long, 'http://mdp.garant.ru/pages/viewpage.action?pageId=269083814') do
  begin
  end;//Type
 end;//Version
 // DictEntryBlock
 t_DictEntryBlock := DefineType(k2_idDictEntryBlock {48}, [t_Block], 'Элемент словарной статьи', DictEntryBlockTag) As DictEntryBlockTag;
 with t_DictEntryBlock do
 begin
  AtomClass := DictEntryBlockTagClass;
 end;//DictEntryBlock
 // EditablePart
 t_EditablePart := DefineType(k2_idEditablePart {139}, [t_Tag, t_ObjectWithHandle], 'http://mdp.garant.ru/pages/viewpage.action?pageId=280859697', EditablePartTag) As EditablePartTag;
 with t_EditablePart do
 begin
  AtomClass := EditablePartTagClass;
  with DefineProperty(k2_attrModified, t_Bool, 'Указывает, что данная часть - модифицирована') do
  begin
  end;//Modified
 end;//EditablePart
 // Document
 t_Document := DefineType(k2_idDocument {20}, [t_Block], 'Документ', DocumentTag) As DocumentTag;
 with t_Document do
 begin
  AtomClass := DocumentTagClass;
  WrapperType := WevDocument;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevDocumentInterfaceFactory;
  {$IfEnd} //k2ForEditor

//#UC START# *4857B5260267atom1*
  UndefineProperties([k2_tiSubs, k2_tiType]);
//#UC END# *4857B5260267atom1*
  with Tk2CustomProperty(Prop[k2_attrOrientation]) do
  begin
   ReadOnly := true;
  end;//Orientation
  with Tk2CustomProperty(Prop[k2_attrCollapsed]) do
  begin
   ReadOnly := true;
  end;//Collapsed
  with Tk2CustomProperty(Prop[k2_attrSpaceAfter]) do
  begin
   DefaultValue := 0;
   Stored := true;
   AfterChange := DocumentSpaceAfterAfterChange;
  end;//SpaceAfter
  with Tk2CustomProperty(Prop[k2_attrLeftIndent]) do
  begin
   Stored := true;
   AfterChange := DocumentLeftIndentAfterChange;
//#UC START# *4857BC220259attr*
   {$IfDef Nemesis}
   DefaultValue := l3NilLong;
   {$Else  Nemesis}
   DefaultValue := def_inchPaperLeft;
   {$EndIf Nemesis}
//#UC END# *4857BC220259attr*
  end;//LeftIndent
  with Tk2CustomProperty(Prop[k2_attrRightIndent]) do
  begin
   Stored := true;
   AfterChange := DocumentRightIndentAfterChange;
//#UC START# *4857BCC3024Aattr*
   {$IfDef Nemesis}
   DefaultValue := l3NilLong;
   {$Else  Nemesis}
   DefaultValue := def_inchPaperRight;
   {$EndIf Nemesis}
//#UC END# *4857BCC3024Aattr*
  end;//RightIndent
  with DefineProperty(k2_attrHeight, t_Inch, '') do
  begin
   DefaultValue := 0;
  end;//Height
  with Tk2CustomProperty(Prop[k2_attrWidth]) do
  begin
   ReadOnly := false;
   DefaultValue := def_inchPaperWidth;
   EmptyMapping := k2_attrParas;
   AfterChange := DocumentWidthAfterChange;
  end;//Width
  with Tk2CustomProperty(Prop[k2_attrHandle]) do
  begin
   ReadOnly := true;
   DefaultValue := 0;
  end;//Handle
  with DefineProperty(k2_attrType, t_Type, 'Тип') do
  begin
  end;//Type
  with DefineProperty(k2_attrUserType, t_Type, 'Пользовательский тип') do
  begin
  end;//UserType
  with DefineProperty(k2_attrInternalHandle, t_Handle, 'Внутренний номер') do
  begin
  end;//InternalHandle
  with DefineProperty(k2_attrSortDate, t_Date, 'Дата сортировки') do
  begin
  end;//SortDate
  with DefineProperty(k2_attrRelExternalHandle, t_Handle, 'Внешний номер справки') do
  begin
  end;//RelExternalHandle
  with DefineProperty(k2_attrRelInternalHandle, t_Handle, 'Внутренний номер справки') do
  begin
  end;//RelInternalHandle
  with DefineProperty(k2_attrPriority, t_Long, 'Приоритет') do
  begin
  end;//Priority
  with DefineProperty(k2_attrExternalPath, t_String, '') do
  begin
  end;//ExternalPath
  with DefineProperty(k2_attrPriceLevel, t_Long, '') do
  begin
  end;//PriceLevel
  with DefineProperty(k2_attrComment, t_String, 'Комментарий') do
  begin
  end;//Comment
  with DefineProperty(k2_attrInternalVerLink, t_Handle, 'Предыдущая версия') do
  begin
  end;//InternalVerLink
  with DefineProperty(k2_attrExternalVerLink, t_Handle, 'Предыдущая версия') do
  begin
  end;//ExternalVerLink
  with DefineProperty(k2_attrMaxHyperlinkHandle, t_Long, 'Максимальное значение идентификатора ссылки') do
  begin
   DefaultValue := 0;
   Stored := false;
  end;//MaxHyperlinkHandle
  with DefineProperty(k2_attrInternalNextVerLink, t_Handle, '') do
  begin
  end;//InternalNextVerLink
  with DefineProperty(k2_attrExternalNextVerLink, t_Handle, '') do
  begin
  end;//ExternalNextVerLink
  with DefineProperty(k2_attrUrgency, t_Long, 'Срочность') do
  begin
  end;//Urgency
  with DefineProperty(k2_attrLanguage, t_Long, 'Язык. Подробности  - [$135594063]') do
  begin
   DefaultValue := 1049;
  end;//Language
  with Tk2CustomProperty(Prop[k2_attrLineSpacing]) do
  begin
   EmptyMapping := k2_attrStyle;
  end;//LineSpacing
  with DefineProperty(k2_attrParas, t_PageProperties, 'Параметры страницы') do
  begin
  end;//Paras
  t_Document_Subs := DefineAutoType([t_OList], 'Документ Метки документа', Document_Subs_Tag) As Document_Subs_Tag;
  try
   t_Document_Subs.DefineChildren(t_DocSubLayer);
   DefineProperty(k2_attrSubs, t_Document_Subs, 'Метки документа');
   t_Document_Subs.Recalc;
  except
   FreeAndNil(t_Document_Subs);
  end;//try..except
  with t_Document_Subs.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrHandle;
   StoredChildProc := DocumentSubsChildStored;
   Duplicates := l3_dupAssign;
//#UC START# *4857B957011Dattr*
   {$IfNDef evStoreSubsIndex}
   Stored := false;
   {$EndIf  evStoreSubsIndex}
//#UC END# *4857B957011Dattr*
  end;//Subs
  t_Document_Groups := DefineAutoType([t_OList], 'Документ Группы', Document_Groups_Tag) As Document_Groups_Tag;
  try
   t_Document_Groups.DefineChildren(t_DictItem);
   DefineProperty(k2_attrGroups, t_Document_Groups, 'Группы');
   t_Document_Groups.Recalc;
  except
   FreeAndNil(t_Document_Groups);
  end;//try..except
  with t_Document_Groups.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrName;
   Duplicates := l3_dupAccept;
  end;//Groups
  t_Document_AccGroups := DefineAutoType([t_OList], 'Документ Группы доступа', Document_AccGroups_Tag) As Document_AccGroups_Tag;
  try
   t_Document_AccGroups.DefineChildren(t_DictItem);
   DefineProperty(k2_attrAccGroups, t_Document_AccGroups, 'Группы доступа');
   t_Document_AccGroups.Recalc;
  except
   FreeAndNil(t_Document_AccGroups);
  end;//try..except
  with t_Document_AccGroups.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrName;
   Duplicates := l3_dupAccept;
   MaxChildrenCount := 1;
  end;//AccGroups
  t_Document_Sources := DefineAutoType([t_OList], 'Документ Источники', Document_Sources_Tag) As Document_Sources_Tag;
  try
   t_Document_Sources.DefineChildren(t_DictItem);
   DefineProperty(k2_attrSources, t_Document_Sources, 'Источники');
   t_Document_Sources.Recalc;
  except
   FreeAndNil(t_Document_Sources);
  end;//try..except
  with t_Document_Sources.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrName;
   Duplicates := l3_dupAccept;
  end;//Sources
  t_Document_Warnings := DefineAutoType([t_OList], 'Документ Предупреждения', Document_Warnings_Tag) As Document_Warnings_Tag;
  try
   t_Document_Warnings.DefineChildren(t_DictItem);
   DefineProperty(k2_attrWarnings, t_Document_Warnings, 'Предупреждения');
   t_Document_Warnings.Recalc;
  except
   FreeAndNil(t_Document_Warnings);
  end;//try..except
  with t_Document_Warnings.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrName;
   Duplicates := l3_dupAccept;
   MaxChildrenCount := 1;
  end;//Warnings
  t_Document_NumANDDates := DefineAutoType([t_OList], 'Документ Даты/номера', Document_NumANDDates_Tag) As Document_NumANDDates_Tag;
  try
   t_Document_NumANDDates.DefineChildren(t_NumANDDate);
   DefineProperty(k2_attrNumANDDates, t_Document_NumANDDates, 'Даты/номера');
   t_Document_NumANDDates.Recalc;
  except
   FreeAndNil(t_Document_NumANDDates);
  end;//try..except
  with t_Document_NumANDDates.ArrayProp[k2_tiChildren] do
  begin
   SetSortTags([k2_tiType, k2_tiStart, k2_tiNumber]);
   Duplicates := l3_dupAccept;
  end;//NumANDDates
  t_Document_LogRecords := DefineAutoType([t_OList], 'Документ Юридические изменения', Document_LogRecords_Tag) As Document_LogRecords_Tag;
  try
   t_Document_LogRecords.DefineChildren(t_LogRecord);
   DefineProperty(k2_attrLogRecords, t_Document_LogRecords, 'Юридические изменения');
   t_Document_LogRecords.Recalc;
  except
   FreeAndNil(t_Document_LogRecords);
  end;//try..except
  with t_Document_LogRecords.ArrayProp[k2_tiChildren] do
  begin
   SetSortTags([-k2_tiStart, -k2_tiTime, k2_tiType]);
  end;//LogRecords
  t_Document_SysLogRecords := DefineAutoType([t_OList], 'Документ Системные изменения', Document_SysLogRecords_Tag) As Document_SysLogRecords_Tag;
  try
   t_Document_SysLogRecords.DefineChildren(t_LogRecord);
   DefineProperty(k2_attrSysLogRecords, t_Document_SysLogRecords, 'Системные изменения');
   t_Document_SysLogRecords.Recalc;
  except
   FreeAndNil(t_Document_SysLogRecords);
  end;//try..except
  with t_Document_SysLogRecords.ArrayProp[k2_tiChildren] do
  begin
   SetSortTags([-k2_tiStart, -k2_tiTime, k2_tiType]);
  end;//SysLogRecords
  t_Document_Versions := DefineAutoType([t_OList], 'Документ Versions', Document_Versions_Tag) As Document_Versions_Tag;
  try
   t_Document_Versions.DefineChildren(t_Version);
   DefineProperty(k2_attrVersions, t_Document_Versions, '');
   t_Document_Versions.Recalc;
  except
   FreeAndNil(t_Document_Versions);
  end;//try..except
  with t_Document_Versions.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrName;
   Duplicates := l3_dupAccept;
  end;//Versions
  t_Document_Stages := DefineAutoType([t_OList], 'Документ Этапы', Document_Stages_Tag) As Document_Stages_Tag;
  try
   t_Document_Stages.DefineChildren(t_Stage);
   DefineProperty(k2_attrStages, t_Document_Stages, 'Этапы');
   t_Document_Stages.Recalc;
  except
   FreeAndNil(t_Document_Stages);
  end;//try..except
  with t_Document_Stages.ArrayProp[k2_tiChildren] do
  begin
   SetSortTags([k2_tiType, -k2_tiFinish]);
   Duplicates := l3_dupAccept;
  end;//Stages
  t_Document_Checks := DefineAutoType([t_OList], 'Документ Вычитка', Document_Checks_Tag) As Document_Checks_Tag;
  try
   t_Document_Checks.DefineChildren(t_Check);
   DefineProperty(k2_attrChecks, t_Document_Checks, 'Вычитка');
   t_Document_Checks.Recalc;
  except
   FreeAndNil(t_Document_Checks);
  end;//try..except
  with t_Document_Checks.ArrayProp[k2_tiChildren] do
  begin
   SetSortTags([k2_tiStart, k2_tiUser]);
   Duplicates := l3_dupAccept;
  end;//Checks
  t_Document_PublishedIn := DefineAutoType([t_OList], 'Документ Источники опубликования', Document_PublishedIn_Tag) As Document_PublishedIn_Tag;
  try
   t_Document_PublishedIn.DefineChildren(t_PIRec);
   DefineProperty(k2_attrPublishedIn, t_Document_PublishedIn, 'Источники опубликования');
   t_Document_PublishedIn.Recalc;
  except
   FreeAndNil(t_Document_PublishedIn);
  end;//try..except
  with t_Document_PublishedIn.ArrayProp[k2_tiChildren] do
  begin
   SetSortTags([k2_tiSource, k2_tiStart, k2_tiNumber]);
   Duplicates := l3_dupAccept;
  end;//PublishedIn
  t_Document_Territory := DefineAutoType([t_OList], 'Документ Территории', Document_Territory_Tag) As Document_Territory_Tag;
  try
   t_Document_Territory.DefineChildren(t_DictItem);
   DefineProperty(k2_attrTerritory, t_Document_Territory, 'Территории');
   t_Document_Territory.Recalc;
  except
   FreeAndNil(t_Document_Territory);
  end;//try..except
  with t_Document_Territory.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrName;
   Duplicates := l3_dupAccept;
  end;//Territory
  t_Document_Norm := DefineAutoType([t_OList], 'Документ Нормы права', Document_Norm_Tag) As Document_Norm_Tag;
  try
   t_Document_Norm.DefineChildren(t_DictItem);
   DefineProperty(k2_attrNorm, t_Document_Norm, 'Нормы права');
   t_Document_Norm.Recalc;
  except
   FreeAndNil(t_Document_Norm);
  end;//try..except
  with t_Document_Norm.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrName;
   Duplicates := l3_dupAccept;
   MaxChildrenCount := 1;
  end;//Norm
  t_Document_ActiveIntervals := DefineAutoType([t_OList], 'Документ Интервалы активности', Document_ActiveIntervals_Tag) As Document_ActiveIntervals_Tag;
  try
   t_Document_ActiveIntervals.DefineChildren(t_ActiveInterval);
   DefineProperty(k2_attrActiveIntervals, t_Document_ActiveIntervals, 'Интервалы активности');
   t_Document_ActiveIntervals.Recalc;
  except
   FreeAndNil(t_Document_ActiveIntervals);
  end;//try..except
  with t_Document_ActiveIntervals.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrStart;
   NeedMarkModified := true;
   SetSortTags([k2_tiStart, k2_tiType]);
   Duplicates := l3_dupAccept;
  end;//ActiveIntervals
  t_Document_Alarms := DefineAutoType([t_OList], 'Документ Звонки', Document_Alarms_Tag) As Document_Alarms_Tag;
  try
   t_Document_Alarms.DefineChildren(t_Alarm);
   DefineProperty(k2_attrAlarms, t_Document_Alarms, 'Звонки');
   t_Document_Alarms.Recalc;
  except
   FreeAndNil(t_Document_Alarms);
  end;//try..except
  with t_Document_Alarms.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrStart;
   NeedMarkModified := true;
   Duplicates := l3_dupAccept;
  end;//Alarms
  t_Document_AnnoClasses := DefineAutoType([t_OList], 'Документ Классы', Document_AnnoClasses_Tag) As Document_AnnoClasses_Tag;
  try
   t_Document_AnnoClasses.DefineChildren(t_DictItem);
   DefineProperty(k2_attrAnnoClasses, t_Document_AnnoClasses, 'Классы');
   t_Document_AnnoClasses.Recalc;
  except
   FreeAndNil(t_Document_AnnoClasses);
  end;//try..except
  with t_Document_AnnoClasses.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrName;
   Duplicates := l3_dupAccept;
  end;//AnnoClasses
  t_Document_LinkedDocuments := DefineAutoType([t_OList], 'Документ Связанные документы', Document_LinkedDocuments_Tag) As Document_LinkedDocuments_Tag;
  try
   t_Document_LinkedDocuments.DefineChildren(t_Address);
   DefineProperty(k2_attrLinkedDocuments, t_Document_LinkedDocuments, 'Связанные документы');
   t_Document_LinkedDocuments.Recalc;
  except
   FreeAndNil(t_Document_LinkedDocuments);
  end;//try..except
  with t_Document_LinkedDocuments.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrType;
   Duplicates := l3_dupAccept;
  end;//LinkedDocuments
  with DefineProperty(k2_attrNameComment, t_String, 'Комментарий. [$140286072]') do
  begin
  end;//NameComment
  t_Document_CaseDocParticipants := DefineAutoType([t_OList], 'Документ Участники судебного дела. [$145097085]', Document_CaseDocParticipants_Tag) As Document_CaseDocParticipants_Tag;
  try
   t_Document_CaseDocParticipants.DefineChildren(t_Participant);
   DefineProperty(k2_attrCaseDocParticipants, t_Document_CaseDocParticipants, 'Участники судебного дела. [$145097085]');
   t_Document_CaseDocParticipants.Recalc;
  except
   FreeAndNil(t_Document_CaseDocParticipants);
  end;//try..except
  with t_Document_CaseDocParticipants.ArrayProp[k2_tiChildren] do
  begin
  end;//CaseDocParticipants
  with DefineProperty(k2_attrNoCompare, t_Bool, 'Документ не участвует в стравнении редакций') do
  begin
  end;//NoCompare
  with DefineProperty(k2_attrMDPPageID, t_Int64, '{RequestLink:275780190}.') do
  begin
  end;//MDPPageID
  with DefineProperty(k2_attrHasAnno, t_Bool, 'Показывает наличие аннотации у документа') do
  begin
  end;//HasAnno
  with DefineProperty(k2_attrMaxSubID, t_Long, '') do
  begin
   Stored := false;
  end;//MaxSubID
  with DefineProperty(k2_attrData, t_RawData, 'http://mdp.garant.ru/pages/viewpage.action?pageId=356073879') do
  begin
  end;//Data
  t_Document_EditableParts := DefineAutoType([t_OList], 'Документ http://mdp.garant.ru/pages/viewpage.action?pageId=280859697 http://mdp.garant.ru/pages/viewpage.action?pageId=280859713', Document_EditableParts_Tag) As Document_EditableParts_Tag;
  try
   t_Document_EditableParts.DefineChildren(t_EditablePart);
   DefineProperty(k2_attrEditableParts, t_Document_EditableParts, 'http://mdp.garant.ru/pages/viewpage.action?pageId=280859697 http://mdp.garant.ru/pages/viewpage.action?pageId=280859713');
   t_Document_EditableParts.Recalc;
  except
   FreeAndNil(t_Document_EditableParts);
  end;//try..except
  with t_Document_EditableParts.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrHandle;
   Duplicates := l3_dupError;
  end;//EditableParts
//#UC START# *4857B5260267atom*
  {$IfDef Nemesis}
  Tk2Prop(Prop[k2_tiSpaceBefore]).DefaultValue := l3Inch div 16;
  {$EndIf Nemesis}
  SetNeedMarkModified([k2_tiExternalHandle,
                       k2_tiInternalHandle,
                       k2_tiRelExternalHandle,
                       k2_tiRelInternalHandle,
                       k2_tiInternalVerLink,
                       k2_tiExternalVerLink,

                       k2_tiName,
                       k2_tiShortName,

                       k2_tiPriceLevel,
                       k2_tiPriority,
                       k2_tiType,
                       k2_tiUserType]);

  { устанавливаем порядок }
  SetTagOrder([k2_tiHandle,
               k2_tiInternalHandle,
               k2_tiExternalHandle,
               k2_tiEditableParts,
               k2_tiLanguage,
               k2_tiType,
               k2_tiUserType,
               k2_tiShortName,
               k2_tiName,
               k2_tiNameComment,
               k2_tiComment,
               k2_tiAccGroups,
               k2_tiGroups]);
//#UC END# *4857B5260267atom*
 end;//Document
 // SimpleDocumentTextPara
 t_SimpleDocumentTextPara := DefineType(k2_idSimpleDocumentTextPara {52}, [t_TextPara], 'текстовый параграф в "простых документах"', SimpleDocumentTextParaTag) As SimpleDocumentTextParaTag;
 with t_SimpleDocumentTextPara do
 begin
  AtomClass := SimpleDocumentTextParaTagClass;
  with Tk2CustomProperty(Prop[k2_attrFirstIndent]) do
  begin
   DefaultValue := 0;
  end;//FirstIndent
  with Tk2CustomProperty(Prop[k2_attrLeftIndent]) do
  begin
   DefaultValue := 0;
  end;//LeftIndent
  with Tk2CustomProperty(Prop[k2_attrFirstLineIndent]) do
  begin
   DefaultValue := 0;
  end;//FirstLineIndent
  with Tk2CustomProperty(Prop[k2_attrStyle]) do
  begin
   DefaultValue := ev_saToLeft;
  end;//Style
 end;//SimpleDocumentTextPara
 // QueryCard
 t_QueryCard := DefineType(k2_idQueryCard {129}, [t_Document], 'Новая КЗ', QueryCardTag) As QueryCardTag;
 with t_QueryCard do
 begin
  AtomClass := QueryCardTagClass;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevQueryCardInterfaceFactory;
  {$IfEnd} //k2ForEditor

  t_QueryCard_CardType := DefineAutoType([t_Enum], 'Новая КЗ Тип КЗ', QueryCard_CardType_Tag) As QueryCard_CardType_Tag;
  try
   t_QueryCard_CardType.AtomType := TypeInfo(TevQueryType);
   DefineProperty(k2_attrCardType, t_QueryCard_CardType, 'Тип КЗ');
   t_QueryCard_CardType.Recalc;
  except
   FreeAndNil(t_QueryCard_CardType);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrCardType]) do
  begin
   DefaultValue := Ord(ev_qtAttributeSearch);
  end;//CardType
 end;//QueryCard
 // TableTextPara
 t_TableTextPara := DefineType(k2_idTableTextPara {53}, [t_TextPara], 'Текстовый параграф в таблице', TableTextParaTag) As TableTextParaTag;
 with t_TableTextPara do
 begin
  AtomClass := TableTextParaTagClass;
  with Tk2CustomProperty(Prop[k2_attrStyle]) do
  begin
   DefaultValue := evd_saNormalTable;
  end;//Style
 end;//TableTextPara
 // TableCell
 t_TableCell := DefineType(k2_idTableCell {27}, [t_ParaList], 'Ячейка таблицы', TableCellTag) As TableCellTag;
 with t_TableCell do
 begin
  AtomClass := TableCellTagClass;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevTableCellInterfaceFactory;
  {$IfEnd} //k2ForEditor

  with Tk2CustomProperty(Prop[k2_attrOrientation]) do
  begin
   ReadOnly := true;
  end;//Orientation
  with Tk2CustomProperty(Prop[k2_attrWidth]) do
  begin
   AfterChange := TableCellWidthAfterChange;
  end;//Width
  with Tk2CustomProperty(Prop[k2_attrFixedWidth]) do
  begin
   DefaultValue := Ord(true);
  end;//FixedWidth
  with Tk2CustomProperty(Prop[k2_attrLeftIndent]) do
  begin
   DefaultValue := def_inchSBSIndent div 2;
   AfterChange := TableCellLeftIndentAfterChange;
  end;//LeftIndent
  with Tk2CustomProperty(Prop[k2_attrRightIndent]) do
  begin
   DefaultValue := def_inchSBSIndent div 2;
   AfterChange := TableCellRightIndentAfterChange;
  end;//RightIndent
  with Tk2CustomProperty(Prop[k2_attrSpaceBefore]) do
  begin
   DefaultValue := def_inchSBSIndent div 3;
  end;//SpaceBefore
  with Tk2CustomProperty(Prop[k2_attrSpaceAfter]) do
  begin
   DefaultValue := def_inchSBSIndent div 3;
  end;//SpaceAfter
  with DefineProperty(k2_attrStateCount, t_Long, 'Вычисление ширины по верхним ячейкам') do
  begin
   DefaultValue := 0;
   Stored := false;
  end;//StateCount
  t_TableCell_MergeStatus := DefineAutoType([t_Enum], 'Ячейка таблицы Признак объединения', TableCell_MergeStatus_Tag) As TableCell_MergeStatus_Tag;
  try
   t_TableCell_MergeStatus.AtomType := TypeInfo(TevMergeStatus);
   DefineProperty(k2_attrMergeStatus, t_TableCell_MergeStatus, 'Признак объединения');
   t_TableCell_MergeStatus.Recalc;
  except
   FreeAndNil(t_TableCell_MergeStatus);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrMergeStatus]) do
  begin
   DefaultValue := Ord(ev_msNone);
   AfterChange := TableCellMergeStatusAfterChange;
  end;//MergeStatus
  t_TableCell_VerticalAligment := DefineAutoType([t_Enum], 'Ячейка таблицы Выравнивание по вертикали', TableCell_VerticalAligment_Tag) As TableCell_VerticalAligment_Tag;
  try
   t_TableCell_VerticalAligment.AtomType := TypeInfo(TevVerticalAligment);
   DefineProperty(k2_attrVerticalAligment, t_TableCell_VerticalAligment, 'Выравнивание по вертикали');
   t_TableCell_VerticalAligment.Recalc;
  except
   FreeAndNil(t_TableCell_VerticalAligment);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrVerticalAligment]) do
  begin
   DefaultValue := Ord(ev_valTop);
   NeedMarkModified := true;
   AfterChange := TableCellVerticalAligmentAfterChange;
  end;//VerticalAligment
  with Tk2CustomProperty(Prop[k2_attrFrame]) do
  begin
   DefaultValue := evd_fvSolid;
  end;//Frame
  ArrayProp[k2_tiChildren].DefaultChildType := t_TableTextPara;
  AddDisabledChildTypeID(t_QueryCard.ID);
 end;//TableCell
 // SBSCell
 t_SBSCell := DefineType(k2_idSBSCell {109}, [t_TableCell], 'Ячейка подписи', SBSCellTag) As SBSCellTag;
 with t_SBSCell do
 begin
  AtomClass := SBSCellTagClass;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevSBSCellInterfaceFactory;
  {$IfEnd} //k2ForEditor

  with Tk2CustomProperty(Prop[k2_attrVerticalAligment]) do
  begin
   DefaultValue := Ord(ev_valBottom);
  end;//VerticalAligment
  with Tk2CustomProperty(Prop[k2_attrLeftIndent]) do
  begin
   DefaultValue := 0;
  end;//LeftIndent
  with Tk2CustomProperty(Prop[k2_attrFrame]) do
  begin
   DefaultValue := evd_fvEmpty;
  end;//Frame
 end;//SBSCell
 // TableRow
 t_TableRow := DefineType(k2_idTableRow {26}, [t_ParaList], 'Строка таблицы', TableRowTag) As TableRowTag;
 with t_TableRow do
 begin
  AtomClass := TableRowTagClass;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevTableRowInterfaceFactory;
  {$IfEnd} //k2ForEditor

  with Tk2CustomProperty(Prop[k2_attrOrientation]) do
  begin
   ReadOnly := true;
   DefaultValue := Ord(ev_orHorizontal);
  end;//Orientation
  with ArrayProp[k2_tiChildren] do
  begin
   ChildType := t_TableCell;
  end;//
 end;//TableRow
 // SBSRow
 t_SBSRow := DefineType(k2_idSBSRow {108}, [t_TableRow], 'Строка подписи', SBSRowTag) As SBSRowTag;
 with t_SBSRow do
 begin
  AtomClass := SBSRowTagClass;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevSBSRowInterfaceFactory;
  {$IfEnd} //k2ForEditor

  with Tk2CustomProperty(Prop[k2_attrRubber]) do
  begin
   DefaultValue := Ord(true);
  end;//Rubber
  with ArrayProp[k2_tiChildren] do
  begin
   ChildType := t_SBSCell;
//#UC START# *4857DF07030Dattr*
   OnValidateChild := SBSRowValidateChild;
//#UC END# *4857DF07030Dattr*
  end;//
 end;//SBSRow
 // Table
 t_Table := DefineType(k2_idTable {24}, [t_ParaList], 'Таблица', TableTag) As TableTag;
 with t_Table do
 begin
  AtomClass := TableTagClass;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevTableInterfaceFactory;
  {$IfEnd} //k2ForEditor

//#UC START# *4857D48E00F4atom1*
//#UC END# *4857D48E00F4atom1*
  with Tk2CustomProperty(Prop[k2_attrSpaceBefore]) do
  begin
   DefaultValue := def_inchSBSIndent div 3;
  end;//SpaceBefore
  with Tk2CustomProperty(Prop[k2_attrSpaceAfter]) do
  begin
   DefaultValue := def_inchSBSIndent div 3;
  end;//SpaceAfter
  with Tk2CustomProperty(Prop[k2_attrRubber]) do
  begin
   DefaultValue := Ord(true);
  end;//Rubber
  with DefineProperty(k2_attrOldNSRC, t_Bool, 'Писать в старом формате NSRC') do
  begin
   DefaultValue := Ord(false);
   NeedMarkModified := true;
  end;//OldNSRC
  with DefineProperty(k2_attrZoom, t_Long, 'Масштаб') do
  begin
   DefaultValue := 100;
  end;//Zoom
  with DefineProperty(k2_attrStyle, t_TextStyle, '') do
  begin
   DefaultValue := k2_TransparentValue;
   NeedMarkModified := true;
   AfterChange := TableStyleAfterChange;
  end;//Style
  with ArrayProp[k2_tiChildren] do
  begin
   ChildType := t_TableRow;
  end;//
//#UC START# *4857D48E00F4atom*
  SetTagOrder([k2_tiOldNSRC, k2_tiZoom]);
//#UC END# *4857D48E00F4atom*
 end;//Table
 // ReqCell
 t_ReqCell := DefineType(k2_idReqCell {131}, [t_TableCell], 'Ячейка с контролом', ReqCellTag) As ReqCellTag;
 with t_ReqCell do
 begin
  AtomClass := ReqCellTagClass;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevReqCellInterfaceFactory;
  {$IfEnd} //k2ForEditor

  with ArrayProp[k2_tiChildren] do
  begin
   ChildType := t_ControlPara;
  end;//
  with Tk2CustomProperty(Prop[k2_attrFrame]) do
  begin
   DefaultValue := evd_fvEmpty;
  end;//Frame
 end;//ReqCell
 // ReqRow
 t_ReqRow := DefineType(k2_idReqRow {130}, [t_TableRow], 'Строка контролов', ReqRowTag) As ReqRowTag;
 with t_ReqRow do
 begin
  AtomClass := ReqRowTagClass;
  WrapperType := WevReqRow;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevReqRowInterfaceFactory;
  {$IfEnd} //k2ForEditor

//#UC START# *4857EA97011Datom1*
//#UC END# *4857EA97011Datom1*
  with DefineProperty(k2_attrReqID, t_String, 'Идентификатор реквизита') do
  begin
  end;//ReqID
  with DefineProperty(k2_attrEnabled, t_Bool, 'Информационный реквизит') do
  begin
   DefaultValue := Ord(true);
  end;//Enabled
  with DefineProperty(k2_attrRequired, t_Bool, 'Обязательное значение') do
  begin
   DefaultValue := Ord(false);
  end;//Required
  with DefineProperty(k2_attrFilterType, t_Long, 'Тип фильтрации атрибута') do
  begin
   DefaultValue := 0;
  end;//FilterType
  t_ReqRow_ReqKind := DefineAutoType([t_Enum], 'Строка контролов Тип реквизита', ReqRow_ReqKind_Tag) As ReqRow_ReqKind_Tag;
  try
   t_ReqRow_ReqKind.AtomType := TypeInfo(TevReqKind);
   DefineProperty(k2_attrReqKind, t_ReqRow_ReqKind, 'Тип реквизита');
   t_ReqRow_ReqKind.Recalc;
  except
   FreeAndNil(t_ReqRow_ReqKind);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrReqKind]) do
  begin
   DefaultValue := Ord(ev_rkSimple);
  end;//ReqKind
  with DefineProperty(k2_attrMulty, t_Bool, 'Множественный выбор') do
  begin
   DefaultValue := Ord(true);
  end;//Multy
  with DefineProperty(k2_attrNumList, t_Bool, 'Номера') do
  begin
   DefaultValue := Ord(false);
  end;//NumList
  with DefineProperty(k2_attrModelControl, t_Long, 'Ссылка на контрол модели') do
  begin
   Stored := false;
  end;//ModelControl
  with DefineProperty(k2_attrDefaultText, t_String, 'Значение текста по-молчанию') do
  begin
   Stored := false;
  end;//DefaultText
  with DefineProperty(k2_attrDefaultNode, t_IUnknown, 'Значение узла по-молчанию') do
  begin
   Stored := false;
  end;//DefaultNode
  with DefineProperty(k2_attrModified, t_Bool, 'Атрибут модифицирован') do
  begin
   DefaultValue := Ord(false);
   Stored := false;
  end;//Modified
  with DefineProperty(k2_attrOperations, t_Long, 'Набор разрешенных операций') do
  begin
   DefaultValue := 0;
   Stored := false;
  end;//Operations
  ArrayProp[k2_tiChildren].DefaultChildType := t_ReqCell;
  with DefineProperty(k2_attrStateIndex, t_Long, 'Значение состояния кнопки по-умолчнию') do
  begin
   Stored := false;
   AfterChange := ReqRowStateIndexAfterChange;
  end;//StateIndex
  with Tk2CustomProperty(Prop[k2_attrFrame]) do
  begin
   DefaultValue := evd_fvEmpty;
  end;//Frame
//#UC START# *4857EA97011Datom*
  ParamsForClone := l3CatLongArray(ParamsForClone, [k2_tiDefaultText, k2_tiOperations]);
//#UC END# *4857EA97011Datom*
 end;//ReqRow
 // ControlsBlock
 t_ControlsBlock := DefineType(k2_idControlsBlock {121}, [t_Block], 'Блок контролов', ControlsBlockTag) As ControlsBlockTag;
 with t_ControlsBlock do
 begin
  AtomClass := ControlsBlockTagClass;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevControlsBlockInterfaceFactory;
  {$IfEnd} //k2ForEditor

  with Tk2CustomProperty(Prop[k2_attrHandle]) do
  begin
   DefaultValue := Pred(High(Integer));
  end;//Handle
  with DefineProperty(k2_attrModelControl, t_Long, 'Ссылка на контрол модели') do
  begin
   Stored := false;
  end;//ModelControl
  with Tk2CustomProperty(Prop[k2_attrSpaceBefore]) do
  begin
   ReadOnly := true;
   DefaultValue := evControlBlockBefore;
  end;//SpaceBefore
  with Tk2CustomProperty(Prop[k2_attrSpaceAfter]) do
  begin
   ReadOnly := true;
   DefaultValue := 0;
  end;//SpaceAfter
  with DefineProperty(k2_attrEnabled, t_Bool, 'Доступность блока') do
  begin
   DefaultValue := Ord(true);
   AfterChange := ControlsBlockEnabledAfterChange;
  end;//Enabled
  with DefineProperty(k2_attrUpper, t_Bool, 'Мышь над кнопкой') do
  begin
   DefaultValue := Ord(false);
   AfterChange := ControlsBlockUpperAfterChange;
  end;//Upper
  with DefineProperty(k2_attrFlat, t_Bool, 'Режим Flat') do
  begin
   DefaultValue := Ord(true);
   AfterChange := ControlsBlockFlatAfterChange;
  end;//Flat
  with DefineProperty(k2_attrChecked, t_Bool, 'Кнопка нажата/отпущена') do
  begin
   DefaultValue := Ord(false);
  end;//Checked
 end;//ControlsBlock
 // BitmapPara
 t_BitmapPara := DefineType(k2_idBitmapPara {97}, [t_StyledLeafPara], 'Картинка в тексте', BitmapParaTag) As BitmapParaTag;
 with t_BitmapPara do
 begin
  AtomClass := BitmapParaTagClass;
  WrapperType := WevBitmapPara;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevBitmapParaInterfaceFactory;
  {$IfEnd} //k2ForEditor

//#UC START# *4858116B0355atom1*
//#UC END# *4858116B0355atom1*
  with DefineProperty(k2_attrExternalHandle, t_Handle, 'Идентификатор картинки') do
  begin
  end;//ExternalHandle
  with DefineProperty(k2_attrInternalHandle, t_Handle, 'Идентификатор потока картинки - необходимость заведения смотрим тут http://mdp.garant.ru/pages/viewpage.action?pageId=86479913') do
  begin
  end;//InternalHandle
  with DefineProperty(k2_attrExternalPath, t_String, 'Путь к картинке') do
  begin
  end;//ExternalPath
  with DefineProperty(k2_attrName, t_String, 'Имя') do
  begin
  end;//Name
  with DefineProperty(k2_attrShortName, t_String, 'Короткое имя') do
  begin
  end;//ShortName
  with DefineProperty(k2_attrDPI, t_Long, '') do
  begin
  end;//DPI
  with Tk2CustomProperty(Prop[k2_attrLeftIndent]) do
  begin
   DefaultValue := 0;
   AfterChange := BitmapParaLeftIndentAfterChange;
  end;//LeftIndent
  with Tk2CustomProperty(Prop[k2_attrWidth]) do
  begin
  end;//Width
  with DefineProperty(k2_attrHeight, t_Inch, '') do
  begin
   AfterChange := BitmapParaHeightAfterChange;
  end;//Height
  with DefineProperty(k2_attrData, t_RawData, 'Картинка') do
  begin
  end;//Data
  t_BitmapPara_Object := DefineAutoType([t_l3Base], 'Картинка в тексте Object', BitmapPara_Object_Tag) As BitmapPara_Object_Tag;
  try
   t_BitmapPara_Object.AtomType := TypeInfo(TevBitmapParaBitmapContainer);
   DefineProperty(k2_attrObject, t_BitmapPara_Object, '');
   t_BitmapPara_Object.Recalc;
  except
   FreeAndNil(t_BitmapPara_Object);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrObject]) do
  begin
   Stored := false;
  end;//Object
//#UC START# *4858116B0355atom*
  t_BitmapPara.Recalc;
//#UC END# *4858116B0355atom*
 end;//BitmapPara
 // XMLTag
 t_XMLTag := DefineType(k2_idXMLTag {123}, [t_Block], 'XML-тег', XMLTagTag) As XMLTagTag;
 with t_XMLTag do
 begin
  AtomClass := XMLTagTagClass;
  with Tk2CustomProperty(Prop[k2_attrHandle]) do
  begin
   DefaultValue := 1;
  end;//Handle
 end;//XMLTag
 // XML
 t_XML := DefineType(k2_idXML {122}, [t_Document], 'XML-документ', XMLTag) As XMLTag;
 with t_XML do
 begin
  AtomClass := XMLTagClass;
  ArrayProp[k2_tiChildren].DefaultChildType := t_XMLTag;
 end;//XML
 // ExtDataPara
 t_ExtDataPara := DefineType(k2_idExtDataPara {132}, [t_LeafPara], 'Параграф с данными во внешнем формате', ExtDataParaTag) As ExtDataParaTag;
 with t_ExtDataPara do
 begin
  AtomClass := ExtDataParaTagClass;
  with DefineProperty(k2_attrExternalPath, t_String, 'Путь к данным') do
  begin
  end;//ExternalPath
  with DefineProperty(k2_attrType, t_Long, 'Тип данных') do
  begin
  end;//Type
  with DefineProperty(k2_attrInternalHandle, t_Handle, 'Идентификатор потока данных - необходимость заведения смотрим тут http://mdp.garant.ru/pages/viewpage.action?pageId=86479913') do
  begin
  end;//InternalHandle
  with DefineProperty(k2_attrData, t_RawData, 'Данные') do
  begin
  end;//Data
 end;//ExtDataPara
 // AttrValue
 t_AttrValue := DefineType(k2_idAttrValue {127}, [t_TextPara], 'Значение атрибута', AttrValueTag) As AttrValueTag;
 with t_AttrValue do
 begin
  AtomClass := AttrValueTagClass;
 end;//AttrValue
 // AttrName
 t_AttrName := DefineType(k2_idAttrName {126}, [t_TextPara], 'Имя атрибута', AttrNameTag) As AttrNameTag;
 with t_AttrName do
 begin
  AtomClass := AttrNameTagClass;
 end;//AttrName
 // Attr
 t_Attr := DefineType(k2_idAttr {125}, [t_Block], 'Атрибут тега', AttrTag) As AttrTag;
 with t_Attr do
 begin
  AtomClass := AttrTagClass;
  with Tk2CustomProperty(Prop[k2_attrHandle]) do
  begin
   DefaultValue := 1;
  end;//Handle
  ArrayProp[k2_tiChildren].DefaultChildType := t_AttrName;
 end;//Attr
 // TagName
 t_TagName := DefineType(k2_idTagName {124}, [t_TextPara], 'Имя тега', TagNameTag) As TagNameTag;
 with t_TagName do
 begin
  AtomClass := TagNameTagClass;
 end;//TagName
 // TagBody
 t_TagBody := DefineType(k2_idTagBody {128}, [t_TextPara], 'Тело тега', TagBodyTag) As TagBodyTag;
 with t_TagBody do
 begin
  AtomClass := TagBodyTagClass;
 end;//TagBody
 // ImageListBitmap
 t_ImageListBitmap := DefineType(k2_idImageListBitmap {137}, [t_BitmapPara], 'Картинка из списка картинок', ImageListBitmapTag) As ImageListBitmapTag;
 with t_ImageListBitmap do
 begin
  AtomClass := ImageListBitmapTagClass;
 end;//ImageListBitmap
 // PageProperties
 with t_PageProperties do
 begin
  with Tk2CustomProperty(Prop[k2_attrOrientation]) do
  begin
   AfterChange := PagePropertiesOrientationAfterChange;
  end;//Orientation
  with Tk2CustomProperty(Prop[k2_attrWidth]) do
  begin
   AfterChange := PagePropertiesWidthAfterChange;
  end;//Width
 end;//PageProperties
 // SimpleDocument
 t_SimpleDocument := DefineType(k2_idSimpleDocument {105}, [t_Document], 'Простой документ', SimpleDocumentTag) As SimpleDocumentTag;
 with t_SimpleDocument do
 begin
  AtomClass := SimpleDocumentTagClass;
  with Tk2CustomProperty(Prop[k2_attrWidth]) do
  begin
   DefaultValue := def_inchMemoWidth;
  end;//Width
  with Tk2CustomProperty(Prop[k2_attrLeftIndent]) do
  begin
   DefaultValue := 0;
  end;//LeftIndent
  with Tk2CustomProperty(Prop[k2_attrRightIndent]) do
  begin
   DefaultValue := 0;
  end;//RightIndent
  with Tk2CustomProperty(Prop[k2_attrLineSpacing]) do
  begin
   DefaultValue := 100;
  end;//LineSpacing
  ArrayProp[k2_tiChildren].DefaultChildType := t_SimpleDocumentTextPara;
 end;//SimpleDocument
 // CommentPara
 t_CommentPara := DefineType(k2_idCommentPara {120}, [t_Block], 'Блок пользовательского комментария', CommentParaTag) As CommentParaTag;
 with t_CommentPara do
 begin
  AtomClass := CommentParaTagClass;
  WrapperType := WevCommentPara;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevCommentParaInterfaceFactory;
  {$IfEnd} //k2ForEditor

  with Tk2CustomProperty(Prop[k2_attrHandle]) do
  begin
   DefaultValue := Pred(High(Integer));
  end;//Handle
  with Tk2CustomProperty(Prop[k2_attrSpaceBefore]) do
  begin
   ReadOnly := true;
   DefaultValue := evDocumentPartMargin { * 3} + (evDocumentPartMargin * 2) div 3;
  end;//SpaceBefore
  with Tk2CustomProperty(Prop[k2_attrSpaceAfter]) do
  begin
   ReadOnly := true;
   DefaultValue := evDocumentPartMargin;
  end;//SpaceAfter
  with Tk2CustomProperty(Prop[k2_attrLeftIndent]) do
  begin
   ReadOnly := true;
   DefaultValue := evDocumentPartMargin;
  end;//LeftIndent
  with Tk2CustomProperty(Prop[k2_attrLayerID]) do
  begin
   DefaultValue := Ord(Mark);
  end;//LayerID
  with Tk2CustomProperty(Prop[k2_attrFlags]) do
  begin
   DefaultValue := ev_cUserCommentFlags;
   Stored := false;
  end;//Flags
 end;//CommentPara
 // SBS
 t_SBS := DefineType(k2_idSBS {25}, [t_Table], 'Подпись', SBSTag) As SBSTag;
 with t_SBS do
 begin
  AtomClass := SBSTagClass;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevSBSInterfaceFactory;
  {$IfEnd} //k2ForEditor

  with ArrayProp[k2_tiChildren] do
  begin
   ChildType := t_SBSRow;
//#UC START# *4857E2C00005attr*
   OnValidateChild := SBSValidateChild;
//#UC END# *4857E2C00005attr*
  end;//
 end;//SBS
 // TinyDocument
 t_TinyDocument := DefineType(k2_idTinyDocument {83}, [t_SimpleDocument], 'Простой документ', TinyDocumentTag) As TinyDocumentTag;
 with t_TinyDocument do
 begin
  AtomClass := TinyDocumentTagClass;
  with Tk2CustomProperty(Prop[k2_attrSpaceBefore]) do
  begin
   DefaultValue := nev.CrtIC.DP2LP(PointX(1)).X;
  end;//SpaceBefore
  with ArrayProp[k2_tiChildren] do
  begin
   ChildType := t_TextPara;
  end;//
  ArrayProp[k2_tiChildren].DefaultChildType := t_SimpleDocumentTextPara;
 end;//TinyDocument
 // LeafParaDecorationsHolder
 t_LeafParaDecorationsHolder := DefineType(k2_idLeafParaDecorationsHolder {134}, [t_ParaList], 'Контейнер декораций', LeafParaDecorationsHolderTag) As LeafParaDecorationsHolderTag;
 with t_LeafParaDecorationsHolder do
 begin
  AtomClass := LeafParaDecorationsHolderTagClass;
  with Tk2CustomProperty(Prop[k2_attrRubber]) do
  begin
   DefaultValue := Ord(true);
  end;//Rubber
 end;//LeafParaDecorationsHolder
 // ReqGroup
 t_ReqGroup := DefineType(k2_idReqGroup {55}, [t_Table], 'Группа реквизитов', ReqGroupTag) As ReqGroupTag;
 with t_ReqGroup do
 begin
  AtomClass := ReqGroupTagClass;
  WrapperType := WevReqGroup;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevReqGroupInterfaceFactory;
  {$IfEnd} //k2ForEditor

  with DefineProperty(k2_attrChecked, t_Bool, '') do
  begin
   DefaultValue := Ord(true);
  end;//Checked
  ArrayProp[k2_tiChildren].DefaultChildType := t_ReqRow;
 end;//ReqGroup
 // AutoreferatDocument
 t_AutoreferatDocument := DefineType(k2_idAutoreferatDocument {135}, [t_Document], '', AutoreferatDocumentTag) As AutoreferatDocumentTag;
 with t_AutoreferatDocument do
 begin
  AtomClass := AutoreferatDocumentTagClass;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevAutoreferatDocumentInterfaceFactory;
  {$IfEnd} //k2ForEditor

 end;//AutoreferatDocument
 // DictEntry
 t_DictEntry := DefineType(k2_idDictEntry {49}, [t_Document], 'Словарная статья', DictEntryTag) As DictEntryTag;
 with t_DictEntry do
 begin
  AtomClass := DictEntryTagClass;
//#UC START# *4857CB7D0340atom1*
  UndefineProperties([k2_tiShortName]);
//#UC END# *4857CB7D0340atom1*
  t_DictEntry_ShortName := DefineAutoType([t_OList], 'Словарная статья Заголовки', DictEntry_ShortName_Tag) As DictEntry_ShortName_Tag;
  try
   t_DictEntry_ShortName.DefineChildren(t_String);
   DefineProperty(k2_attrShortName, t_DictEntry_ShortName, 'Заголовки');
   t_DictEntry_ShortName.Recalc;
  except
   FreeAndNil(t_DictEntry_ShortName);
  end;//try..except
  with t_DictEntry_ShortName.ArrayProp[k2_tiChildren] do
  begin
  end;//ShortName
  ArrayProp[k2_tiChildren].DefaultChildType := t_DictEntryBlock;
//#UC START# *4857CB7D0340atom*
  Tk2Prop(Prop[k2_tiShortName]).OrderKey := Tk2Prop(Prop[k2_tiUserType]).OrderKey.Succ;
//#UC END# *4857CB7D0340atom*
 end;//DictEntry
 // Cloak
 t_Cloak := DefineType(k2_idCloak {47}, [t_ControlsBlock], 'Схлопывающаяся группа параграфов', CloakTag) As CloakTag;
 with t_Cloak do
 begin
  AtomClass := CloakTagClass;
 end;//Cloak
 // TextStyle
 with t_TextStyle do
 begin
  Recalc;
  // Прижатый влево
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -16;
    IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := 0;
    IntW[k2_attrFirstLineIndent, Tk2NonOptimizeContext.Instance] := 0;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_ToLeft_Name_Value.AsStr;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itLeft);
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Заголовок 1
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -3;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_TxtHeader1_Name_Value.AsStr;
    IntW[k2_attrSpaceBefore, Tk2NonOptimizeContext.Instance] := 75;
    IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := 0;
    IntW[k2_attrFirstLineIndent, Tk2NonOptimizeContext.Instance] := 0;
    IntW[k2_attrLeftIndent, Tk2NonOptimizeContext.Instance] := 0;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itCenter);
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 12;
     BoolW[k2_attrBold, Tk2NonOptimizeContext.Instance] := true;
     BoolW[k2_attrUnderline, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Заголовок 2
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -3;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -4;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_TxtHeader2_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     BoolW[k2_attrItalic, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Заголовок 3
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -4;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -5;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_TxtHeader3_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 10;
     BoolW[k2_attrItalic, Tk2NonOptimizeContext.Instance] := false;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Заголовок 4
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -5;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -6;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_TxtHeader4_Name_Value.AsStr;
    with cAtom(k2_attrFont) do
    begin
     BoolW[k2_attrItalic, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Нормальный (справка)
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -14;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_NormalNote_Name_Value.AsStr;
    IntW[k2_attrWidth, Tk2NonOptimizeContext.Instance] := 7244;
    IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := 118;
    IntW[k2_attrFirstLineIndent, Tk2NonOptimizeContext.Instance] := 0;
    IntW[k2_attrLeftIndent, Tk2NonOptimizeContext.Instance] := 118;
    IntW[k2_attrRightIndent, Tk2NonOptimizeContext.Instance] := 118;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itLeft);
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Комментарий
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -14;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -9;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_TxtComment_Name_Value.AsStr;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itWidth);
    {$If not defined(Nemesis)}
    BoolW[k2_attrVisible, Tk2NonOptimizeContext.Instance] := false;
    {$IfEnd} //not Nemesis
    {$If not defined(Archi)}
    StrW[k2_attrShortName, Tk2NonOptimizeContext.Instance] := str_TextStyle_TxtComment_ShortName_D_Garant_Value.AsStr;
    {$IfEnd} //not Archi
    {$If not defined(Archi)}
    BoolW[k2_attrHeaderHasOwnSpace, Tk2NonOptimizeContext.Instance] := false;
    {$IfEnd} //not Archi
    IntW[k2_attrSpaceBefore, Tk2NonOptimizeContext.Instance] := 75;
    {$If defined(Nemesis)}
    IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := 170;
    {$IfEnd} //Nemesis
    {$If defined(Nemesis)}
    IntW[k2_attrLeftIndent, Tk2NonOptimizeContext.Instance] := 170;
    {$IfEnd} //Nemesis
    {$If defined(Nemesis)}
    IntW[k2_attrRightIndent, Tk2NonOptimizeContext.Instance] := 0;
    {$IfEnd} //Nemesis
    {$If defined(Archi)}
    StrW[k2_attrShortName, Tk2NonOptimizeContext.Instance] := str_TextStyle_TxtComment_ShortName_D_Archi_Value.AsStr;
    {$IfEnd} //Archi
    {$If defined(Nemesis) AND defined(nsTest) AND not defined(Archi) AND not defined(InsiderTest)}
    StrW[k2_attrShortName, Tk2NonOptimizeContext.Instance] := str_TextStyle_TxtComment_ShortName_D_DailyTests_Value.AsStr;
    {$IfEnd} //Nemesis AND nsTest AND not Archi AND not InsiderTest
    with cAtom(k2_attrFont) do
    begin
     BoolW[k2_attrItalic, Tk2NonOptimizeContext.Instance] := true;
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := clPurple;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // информация о версии
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -9;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -22;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_VersionInfo_Name_Value.AsStr;
    {$If not defined(Archi)}
    StrW[k2_attrShortName, Tk2NonOptimizeContext.Instance] := str_TextStyle_VersionInfo_ShortName_Value.AsStr;
    {$IfEnd} //not Archi
    {$If defined(Archi)}
    StrW[k2_attrShortName, Tk2NonOptimizeContext.Instance] := str_TextStyle_VersionInfo_ShortName_D_Archi_Value.AsStr;
    {$IfEnd} //Archi
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := clNavy;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // "Подсказки запросов" для контекстного поиска
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -65535;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_PromptTree_Name_Value.AsStr;
    {$If not defined(Nemesis)}
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    {$IfEnd} //not Nemesis
    BoolW[k2_attrIsChangeableFont, Tk2NonOptimizeContext.Instance] := false;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itLeft);
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 10;
     IntW[k2_attrBold, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Необходимые документы
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saAttention;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -45;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_HLE1_Name_Value.AsStr;
    StrW[k2_attrShortName, Tk2NonOptimizeContext.Instance] := str_TextStyle_HLE1_ShortName_Value.AsStr;
    IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := 118;
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Куда обратиться?
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saAttention;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -46;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_HLE2_Name_Value.AsStr;
    StrW[k2_attrShortName, Tk2NonOptimizeContext.Instance] := str_TextStyle_HLE2_ShortName_Value.AsStr;
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Внимание: недобросовестность!
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saAttention;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -47;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_HLE3_Name_Value.AsStr;
    StrW[k2_attrShortName, Tk2NonOptimizeContext.Instance] := str_TextStyle_HLE3_ShortName_Value.AsStr;
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Внимание: криминал!!
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saAttention;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -48;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_HLE4_Name_Value.AsStr;
    StrW[k2_attrShortName, Tk2NonOptimizeContext.Instance] := str_TextStyle_HLE4_ShortName_Value.AsStr;
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Примечание.
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saAttention;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -49;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_HLE5_Name_Value.AsStr;
    StrW[k2_attrShortName, Tk2NonOptimizeContext.Instance] := str_TextStyle_HLE5_ShortName_Value.AsStr;
    BoolW[k2_attrHeaderHasOwnSpace, Tk2NonOptimizeContext.Instance] := true;
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Пример.
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saAttention;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -50;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_HLE6_Name_Value.AsStr;
    StrW[k2_attrShortName, Tk2NonOptimizeContext.Instance] := str_TextStyle_HLE6_ShortName_Value.AsStr;
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Заголовок для информации об изменениях
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -3;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -54;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_HeaderForChangesInfo_Name_Value.AsStr;
    IntW[k2_attrSpaceBefore, Tk2NonOptimizeContext.Instance] := 0;
    {$If not defined(Nemesis)}
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    {$IfEnd} //not Nemesis
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := clWhite;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Подвал для информации об изменениях
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -3;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -55;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_FooterForChangesInfo_Name_Value.AsStr;
    {$If not defined(Nemesis)}
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    {$IfEnd} //not Nemesis
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 10;
     BoolW[k2_attrBold, Tk2NonOptimizeContext.Instance] := false;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Текст информации об изменениях
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -56;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_TextForChangesInfo_Name_Value.AsStr;
    IntW[k2_attrLineSpacing, Tk2NonOptimizeContext.Instance] := 100;
    {$If not defined(Nemesis)}
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    {$IfEnd} //not Nemesis
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 10;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Информация об изменениях
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -56;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saChangesInfo);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_ChangesInfo_Name_Value.AsStr;
    IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := l3Inch div 4;
    IntW[k2_attrFirstLineIndent, Tk2NonOptimizeContext.Instance] := l3Inch div 4;
    IntW[k2_attrLeftIndent, Tk2NonOptimizeContext.Instance] := l3Inch div 4;
    IntW[k2_attrRightIndent, Tk2NonOptimizeContext.Instance] := l3Inch div 4;
    StrW[k2_attrShortName, Tk2NonOptimizeContext.Instance] := str_TextStyle_ChangesInfo_ShortName_Value.AsStr;
    BoolW[k2_attrCollapsable, Tk2NonOptimizeContext.Instance] := true;
    IntW[k2_attrSpaceBefore, Tk2NonOptimizeContext.Instance] := l3Inch div 8;
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := true;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := $F3EFED;
    end;//with cAtom(k2_attrFont)
    with cAtom(k2_attrHeader) do
    begin
      l_ChangesInfo_Header_HeaderC := t_TextPara.MakeTag.AsObject;
      with l_ChangesInfo_Header_HeaderC do
      begin
       StrW[k2_attrText, Tk2NonOptimizeContext.Instance] := str_TextStyle_ChangesInfo_Header_HeaderC_Text_Value.AsStr;
       {$If defined(Never)}
       IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := clWhite;
       {$IfEnd} //Never
       IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := ev_saHeaderForChangesInfo;
       with cAtom(k2_attrSegments) do
       begin
         l_HeaderC_Segments_Hyperlinks := Tk2Type(TagType).ArrayProp[k2_tiChildren].DefaultChildType.MakeTag.AsObject;
         with l_HeaderC_Segments_Hyperlinks do
         begin
          IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_slHyperlinks);
           l_Segments_Hyperlinks_Hyperlink := t_HyperLink.MakeTag.AsObject;
           with l_Segments_Hyperlinks_Hyperlink do
           begin
            IntW[k2_attrStart, Tk2NonOptimizeContext.Instance] := 2;
            IntW[k2_attrFinish, Tk2NonOptimizeContext.Instance] := 28;
           end;//with MakeTag.AsObject
           AddChild(l_Segments_Hyperlinks_Hyperlink.AsObject);
         end;//with MakeTag.AsObject
         AddChild(l_HeaderC_Segments_Hyperlinks.AsObject);
         l_HeaderC_Segments_Objects := Tk2Type(TagType).ArrayProp[k2_tiChildren].DefaultChildType.MakeTag.AsObject;
         with l_HeaderC_Segments_Objects do
         begin
          IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_slObjects);
           l_Segments_Objects_Collapser := t_ObjectSegment.MakeTag.AsObject;
           with l_Segments_Objects_Collapser do
           begin
            IntW[k2_attrStart, Tk2NonOptimizeContext.Instance] := 27;
            IntW[k2_attrFinish, Tk2NonOptimizeContext.Instance] := 28;
             l_Objects_Collapser_Bitmap := t_ImageListBitmap.MakeTag.AsObject;
             with l_Objects_Collapser_Bitmap do
             begin
              IntW[k2_attrWidth, Tk2NonOptimizeContext.Instance] := nev.CrtIC.DP2LP(PointX(20)).X;
              IntW[k2_attrHeight, Tk2NonOptimizeContext.Instance] := nev.CrtIC.DP2LP(PointY(20)).Y;
             end;//with MakeTag.AsObject
             AddChild(l_Objects_Collapser_Bitmap.AsObject);
           end;//with MakeTag.AsObject
           AddChild(l_Segments_Objects_Collapser.AsObject);
         end;//with MakeTag.AsObject
         AddChild(l_HeaderC_Segments_Objects.AsObject);
       end;//with cAtom(k2_attrSegments)
      end;//with MakeTag.AsObject
      AddChild(l_ChangesInfo_Header_HeaderC.AsObject);
    end;//with cAtom(k2_attrHeader)
    with cAtom(k2_attrFooter) do
    begin
      l_ChangesInfo_Footer_FooterC := t_TextPara.MakeTag.AsObject;
      with l_ChangesInfo_Footer_FooterC do
      begin
       StrW[k2_attrText, Tk2NonOptimizeContext.Instance] := str_TextStyle_ChangesInfo_Footer_FooterC_Text_Value.AsStr;
       IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := ev_saFooterForChangesInfo;
       with cAtom(k2_attrSegments) do
       begin
         l_FooterC_Segments_Hyperlinks := Tk2Type(TagType).ArrayProp[k2_tiChildren].DefaultChildType.MakeTag.AsObject;
         with l_FooterC_Segments_Hyperlinks do
         begin
          IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_slHyperlinks);
           l_Segments_Hyperlinks_Hyperlink := t_HyperLink.MakeTag.AsObject;
           with l_Segments_Hyperlinks_Hyperlink do
           begin
            IntW[k2_attrStart, Tk2NonOptimizeContext.Instance] := 1;
            IntW[k2_attrFinish, Tk2NonOptimizeContext.Instance] := 35;
            StrW[k2_attrURL, Tk2NonOptimizeContext.Instance] := str_TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value.AsStr;
             l_Hyperlinks_Hyperlink_Address := Tk2Type(TagType).ArrayProp[k2_tiChildren].DefaultChildType.MakeTag.AsObject;
             with l_Hyperlinks_Hyperlink_Address do
             begin
              StrW[k2_attrShortName, Tk2NonOptimizeContext.Instance] := str_TextStyle_ChangesInfo_Footer_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value.AsStr;
             end;//with MakeTag.AsObject
             AddChild(l_Hyperlinks_Hyperlink_Address.AsObject);
           end;//with MakeTag.AsObject
           AddChild(l_Segments_Hyperlinks_Hyperlink.AsObject);
         end;//with MakeTag.AsObject
         AddChild(l_FooterC_Segments_Hyperlinks.AsObject);
       end;//with cAtom(k2_attrSegments)
      end;//with MakeTag.AsObject
      AddChild(l_ChangesInfo_Footer_FooterC.AsObject);
    end;//with cAtom(k2_attrFooter)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Подзаголовок для информации об изменениях
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := -56;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -57;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_SubHeaderForChangesInfo_Name_Value.AsStr;
    {$If not defined(Nemesis)}
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    {$IfEnd} //not Nemesis
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := clNavy;
     BoolW[k2_attrBold, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Заголовок группы контролов
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -58;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_ControlsBlockHeader_Name_Value.AsStr;
    {$If not defined(Nemesis)}
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    {$IfEnd} //not Nemesis
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := clBlack;
     BoolW[k2_attrBold, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Заголовок распахивающейся части диалога
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -59;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_CloakHeader_Name_Value.AsStr;
    {$If not defined(Nemesis)}
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    {$IfEnd} //not Nemesis
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 12;
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := clNavy;
     BoolW[k2_attrItalic, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Ссылка на официальную публикацию
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -60;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_LinkToPublication_Name_Value.AsStr;
    {$If not defined(Nemesis)}
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    {$IfEnd} //not Nemesis
    with cAtom(k2_attrHeader) do
    begin
      l_LinkToPublication_Header_FooterC := t_TextPara.MakeTag.AsObject;
      with l_LinkToPublication_Header_FooterC do
      begin
       StrW[k2_attrText, Tk2NonOptimizeContext.Instance] := str_TextStyle_LinkToPublication_Header_FooterC_Text_Value.AsStr;
       IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := ev_saTxtComment;
       with cAtom(k2_attrSegments) do
       begin
         l_FooterC_Segments_Hyperlinks := Tk2Type(TagType).ArrayProp[k2_tiChildren].DefaultChildType.MakeTag.AsObject;
         with l_FooterC_Segments_Hyperlinks do
         begin
          IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_slHyperlinks);
           l_Segments_Hyperlinks_Hyperlink := t_HyperLink.MakeTag.AsObject;
           with l_Segments_Hyperlinks_Hyperlink do
           begin
            StrW[k2_attrURL, Tk2NonOptimizeContext.Instance] := str_TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_URL_Value.AsStr;
             l_Hyperlinks_Hyperlink_Address := Tk2Type(TagType).ArrayProp[k2_tiChildren].DefaultChildType.MakeTag.AsObject;
             with l_Hyperlinks_Hyperlink_Address do
             begin
              StrW[k2_attrShortName, Tk2NonOptimizeContext.Instance] := str_TextStyle_LinkToPublication_Header_FooterC_Segments_Hyperlinks_Hyperlink_Address_ShortName_Value.AsStr;
              IntW[k2_attrViewKind, Tk2NonOptimizeContext.Instance] := Ord(ev_lvkExternal);
             end;//with MakeTag.AsObject
             AddChild(l_Hyperlinks_Hyperlink_Address.AsObject);
           end;//with MakeTag.AsObject
           AddChild(l_Segments_Hyperlinks_Hyperlink.AsObject);
         end;//with MakeTag.AsObject
         AddChild(l_FooterC_Segments_Hyperlinks.AsObject);
       end;//with cAtom(k2_attrSegments)
      end;//with MakeTag.AsObject
      AddChild(l_LinkToPublication_Header_FooterC.AsObject);
    end;//with cAtom(k2_attrHeader)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Подчёркнутый текст
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := -61;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_UnderlinedText_Name_Value.AsStr;
    IntW[k2_attrFrame, Tk2NonOptimizeContext.Instance] := evd_fvDown;
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Заголовок группы редакций
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saNodeGroupHeader);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_NodeGroupHeader_Name_Value.AsStr;
    BoolW[k2_attrIsChangeableFont, Tk2NonOptimizeContext.Instance] := false;
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 11;
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := clWhite;
     BoolW[k2_attrBold, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Текст ЭР (см. также)
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saTxtNormalAACSeeAlso);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_TxtNormalAACSeeAlso_Name_Value.AsStr;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itLeft);
    IntW[k2_attrFirstLineIndent, Tk2NonOptimizeContext.Instance] := 0;
    IntW[k2_attrSpaceBefore, Tk2NonOptimizeContext.Instance] := 200;
    IntW[k2_attrSpaceAfter, Tk2NonOptimizeContext.Instance] := 0;
    IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := 0;
    BoolW[k2_attrVisibleToBlock, Tk2NonOptimizeContext.Instance] := true;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 11;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Заголовок ЭР (левое окно)
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saHeaderAACLeftWindow);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_HeaderAACLeftWindow_Name_Value.AsStr;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itCenter);
    IntW[k2_attrSpaceBefore, Tk2NonOptimizeContext.Instance] := 300;
    IntW[k2_attrSpaceAfter, Tk2NonOptimizeContext.Instance] := 250;
    IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := 0;
    IntW[k2_attrFirstLineIndent, Tk2NonOptimizeContext.Instance] := 0;
    BoolW[k2_attrVisibleToBlock, Tk2NonOptimizeContext.Instance] := true;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 14;
     BoolW[k2_attrBold, Tk2NonOptimizeContext.Instance] := true;
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := $002F2826;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Заголовок ЭР (правое окно)
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := ev_saHeaderAACLeftWindow;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saHeaderAACRightWindow);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_HeaderAACRightWindow_Name_Value.AsStr;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itLeft);
    IntW[k2_attrSpaceAfter, Tk2NonOptimizeContext.Instance] := 0;
    AddValue(Box);
   end;//with MakeTag.AsObject
  // ЭР-содержание (правое окно)
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saContextAACRightWindows);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_ContextAACRightWindows_Name_Value.AsStr;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itLeft);
    IntW[k2_attrFirstLineIndent, Tk2NonOptimizeContext.Instance] := 0;
    IntW[k2_attrSpaceBefore, Tk2NonOptimizeContext.Instance] := 300;
    IntW[k2_attrSpaceAfter, Tk2NonOptimizeContext.Instance] := 0;
    IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := 0;
    BoolW[k2_attrVisibleToBlock, Tk2NonOptimizeContext.Instance] := true;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 13;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Формула
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saFormulaInAAC);
    IntW[k2_attrLeftIndent, Tk2NonOptimizeContext.Instance] := 420;
    IntW[k2_attrRightIndent, Tk2NonOptimizeContext.Instance] := 420;
    IntW[k2_attrSpaceBefore, Tk2NonOptimizeContext.Instance] := 240;
    IntW[k2_attrSpaceAfter, Tk2NonOptimizeContext.Instance] := 240;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_FormulaInAAC_Name_Value.AsStr;
    BoolW[k2_attrVisibleToBlock, Tk2NonOptimizeContext.Instance] := true;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := $DAF3F5;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saTwoColorTable);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_TwoColorTable_Name_Value.AsStr;
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := $DAF3F5;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Выделение текста жирным.
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saBoldSelection);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_BoldSelection_Name_Value.AsStr;
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    IntW[k2_attrVisible, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
    BoolW[k2_attrApply2Para, Tk2NonOptimizeContext.Instance] := false;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     BoolW[k2_attrBold, Tk2NonOptimizeContext.Instance] := true;
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrIndex, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrItalic, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrName, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrPitch, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrStrikeout, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrUnderline, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
   with MakeTag.AsObject do
   begin
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_ExpandedText_Name_Value.AsStr;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saExpandedText);
    BoolW[k2_attrCollapsable, Tk2NonOptimizeContext.Instance] := true;
    IntW[k2_attrLeftIndent, Tk2NonOptimizeContext.Instance] := 720;
    BoolW[k2_attrVisibleToBlock, Tk2NonOptimizeContext.Instance] := true;
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    with cAtom(k2_attrHeader) do
    begin
      l_ExpandedText_Header_HeaderC := t_TextPara.MakeTag.AsObject;
      with l_ExpandedText_Header_HeaderC do
      begin
       StrW[k2_attrText, Tk2NonOptimizeContext.Instance] := str_TextStyle_ExpandedText_Header_HeaderC_Text_Value.AsStr;
       IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := 0;
       IntW[k2_attrLeftIndent, Tk2NonOptimizeContext.Instance] := 0;
       IntW[k2_attrFirstLineIndent, Tk2NonOptimizeContext.Instance] := 0;
       with cAtom(k2_attrSegments) do
       begin
         l_HeaderC_Segments_Hyperlinks := Tk2Type(TagType).ArrayProp[k2_tiChildren].DefaultChildType.MakeTag.AsObject;
         with l_HeaderC_Segments_Hyperlinks do
         begin
          IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_slHyperlinks);
           l_Segments_Hyperlinks_Hyperlink := t_HyperLink.MakeTag.AsObject;
           with l_Segments_Hyperlinks_Hyperlink do
           begin
            IntW[k2_attrStart, Tk2NonOptimizeContext.Instance] := 1;
            IntW[k2_attrFinish, Tk2NonOptimizeContext.Instance] := 21;
            with cAtom(k2_attrFont) do
            begin
             IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := clBlack;
            end;//with cAtom(k2_attrFont)
           end;//with MakeTag.AsObject
           AddChild(l_Segments_Hyperlinks_Hyperlink.AsObject);
         end;//with MakeTag.AsObject
         AddChild(l_HeaderC_Segments_Hyperlinks.AsObject);
       end;//with cAtom(k2_attrSegments)
      end;//with MakeTag.AsObject
      AddChild(l_ExpandedText_Header_HeaderC.AsObject);
    end;//with cAtom(k2_attrHeader)
    AddValue(Box);
   end;//with MakeTag.AsObject
 end;//TextStyle
 // NodeGroup
 t_NodeGroup := DefineType(k2_idNodeGroup {46}, [t_ControlsBlock], '', NodeGroupTag) As NodeGroupTag;
 with t_NodeGroup do
 begin
  AtomClass := NodeGroupTagClass;
 end;//NodeGroup
 // DocumentQuery
 t_DocumentQuery := DefineType(k2_idDocumentQuery {138}, [t_Document], 'Запрос для поиска документа', DocumentQueryTag) As DocumentQueryTag;
 with t_DocumentQuery do
 begin
  AtomClass := DocumentQueryTagClass;
  with Tk2Type(Prop[k2_attrAccGroups].TagType).ArrayProp[k2_tiChildren] do
  begin
   MaxChildrenCount := 1000;
  end;//AccGroups
 end;//DocumentQuery
 // AnnoTopic
 t_AnnoTopic := DefineType(k2_idAnnoTopic {54}, [t_Document], 'Аннотация', AnnoTopicTag) As AnnoTopicTag;
 with t_AnnoTopic do
 begin
  AtomClass := AnnoTopicTagClass;
 end;//AnnoTopic
 // DocumentContainer
 t_DocumentContainer := DefineAutoType([], '', DocumentContainerAtom) As DocumentContainerAtom;
 with t_DocumentContainer do
 begin
 end;//DocumentContainer
 t_StyledLeafPara.Recalc;
 t_TextPara.Recalc;
 t_DecorTextPara.Recalc;
 t_ControlPara.Recalc;
 t_Formula.Recalc;
 t_ParaList.Recalc;
 t_HFParent.Recalc;
 t_Header.Recalc;
 t_Footer.Recalc;
 t_Division.Recalc;
 t_ContentsElement.Recalc;
 t_Participant.Recalc;
 t_Block.Recalc;
 t_Version.Recalc;
 t_DictEntryBlock.Recalc;
 t_EditablePart.Recalc;
 t_Document.Recalc;
 t_SimpleDocumentTextPara.Recalc;
 t_QueryCard.Recalc;
 t_TableTextPara.Recalc;
 t_TableCell.Recalc;
 t_SBSCell.Recalc;
 t_TableRow.Recalc;
 t_SBSRow.Recalc;
 t_Table.Recalc;
 t_ReqCell.Recalc;
 t_ReqRow.Recalc;
 t_ControlsBlock.Recalc;
 t_BitmapPara.Recalc;
 t_XMLTag.Recalc;
 t_XML.Recalc;
 t_ExtDataPara.Recalc;
 t_AttrValue.Recalc;
 t_AttrName.Recalc;
 t_Attr.Recalc;
 t_TagName.Recalc;
 t_TagBody.Recalc;
 t_ImageListBitmap.Recalc;
 t_PageProperties.Recalc;
 t_SimpleDocument.Recalc;
 t_CommentPara.Recalc;
 t_SBS.Recalc;
 t_TinyDocument.Recalc;
 t_LeafParaDecorationsHolder.Recalc;
 t_ReqGroup.Recalc;
 t_AutoreferatDocument.Recalc;
 t_DictEntry.Recalc;
 t_Cloak.Recalc;
 t_TextStyle.Recalc;
 t_NodeGroup.Recalc;
 t_DocumentQuery.Recalc;
 t_AnnoTopic.Recalc;
 t_DocumentContainer.Recalc;
//#UC START# *484CD009023Dttimpl1*
 CreateStandardTextStyles(t_TextStyle);
 t_SubLayer.ArrayProp[k2_tiChildren].OnGetChildTypeForParent := SubLayerChildType;
 // - специально перенесено сюда, чтобы Ak2DocumentSubsLayer не "зацепил".
//#UC END# *484CD009023Dttimpl1*
end;

// определяем стандартные методы схемы


procedure TevNativeSchema.Cleanup;
begin
 t_StyledLeafPara.InterfaceFactory := nil;
 t_TextPara.InterfaceFactory := nil;
 t_TextPara_Segments.InterfaceFactory := nil;
 t_TextPara_TabStops.InterfaceFactory := nil;
 t_DecorTextPara.InterfaceFactory := nil;
 t_ControlPara.InterfaceFactory := nil;
 t_ControlPara_Type.InterfaceFactory := nil;
 t_Formula.InterfaceFactory := nil;
 t_ParaList.InterfaceFactory := nil;
 t_ParaList_Orientation.InterfaceFactory := nil;
 t_HFParent.InterfaceFactory := nil;
 t_HFParent_Type.InterfaceFactory := nil;
 t_Header.InterfaceFactory := nil;
 t_Footer.InterfaceFactory := nil;
 t_Division.InterfaceFactory := nil;
 t_Division_Headers.InterfaceFactory := nil;
 t_Division_Footers.InterfaceFactory := nil;
 t_ContentsElement.InterfaceFactory := nil;
 t_ContentsElement_InContents.InterfaceFactory := nil;
 t_Participant.InterfaceFactory := nil;
 t_Block.InterfaceFactory := nil;
 t_Block_LayerID.InterfaceFactory := nil;
 t_Block_ViewKind.InterfaceFactory := nil;
 t_Version.InterfaceFactory := nil;
 t_DictEntryBlock.InterfaceFactory := nil;
 t_EditablePart.InterfaceFactory := nil;
 t_Document.InterfaceFactory := nil;
 t_Document_Subs.InterfaceFactory := nil;
 t_Document_Groups.InterfaceFactory := nil;
 t_Document_AccGroups.InterfaceFactory := nil;
 t_Document_Sources.InterfaceFactory := nil;
 t_Document_Warnings.InterfaceFactory := nil;
 t_Document_NumANDDates.InterfaceFactory := nil;
 t_Document_LogRecords.InterfaceFactory := nil;
 t_Document_SysLogRecords.InterfaceFactory := nil;
 t_Document_Versions.InterfaceFactory := nil;
 t_Document_Stages.InterfaceFactory := nil;
 t_Document_Checks.InterfaceFactory := nil;
 t_Document_PublishedIn.InterfaceFactory := nil;
 t_Document_Territory.InterfaceFactory := nil;
 t_Document_Norm.InterfaceFactory := nil;
 t_Document_ActiveIntervals.InterfaceFactory := nil;
 t_Document_Alarms.InterfaceFactory := nil;
 t_Document_AnnoClasses.InterfaceFactory := nil;
 t_Document_LinkedDocuments.InterfaceFactory := nil;
 t_Document_CaseDocParticipants.InterfaceFactory := nil;
 t_Document_EditableParts.InterfaceFactory := nil;
 t_SimpleDocumentTextPara.InterfaceFactory := nil;
 t_QueryCard.InterfaceFactory := nil;
 t_QueryCard_CardType.InterfaceFactory := nil;
 t_TableTextPara.InterfaceFactory := nil;
 t_TableCell.InterfaceFactory := nil;
 t_TableCell_MergeStatus.InterfaceFactory := nil;
 t_TableCell_VerticalAligment.InterfaceFactory := nil;
 t_SBSCell.InterfaceFactory := nil;
 t_TableRow.InterfaceFactory := nil;
 t_SBSRow.InterfaceFactory := nil;
 t_Table.InterfaceFactory := nil;
 t_ReqCell.InterfaceFactory := nil;
 t_ReqRow.InterfaceFactory := nil;
 t_ReqRow_ReqKind.InterfaceFactory := nil;
 t_ControlsBlock.InterfaceFactory := nil;
 t_BitmapPara.InterfaceFactory := nil;
 t_BitmapPara_Object.InterfaceFactory := nil;
 t_XMLTag.InterfaceFactory := nil;
 t_XML.InterfaceFactory := nil;
 t_ExtDataPara.InterfaceFactory := nil;
 t_AttrValue.InterfaceFactory := nil;
 t_AttrName.InterfaceFactory := nil;
 t_Attr.InterfaceFactory := nil;
 t_TagName.InterfaceFactory := nil;
 t_TagBody.InterfaceFactory := nil;
 t_ImageListBitmap.InterfaceFactory := nil;
 t_SimpleDocument.InterfaceFactory := nil;
 t_CommentPara.InterfaceFactory := nil;
 t_SBS.InterfaceFactory := nil;
 t_TinyDocument.InterfaceFactory := nil;
 t_LeafParaDecorationsHolder.InterfaceFactory := nil;
 t_ReqGroup.InterfaceFactory := nil;
 t_AutoreferatDocument.InterfaceFactory := nil;
 t_DictEntry.InterfaceFactory := nil;
 t_DictEntry_ShortName.InterfaceFactory := nil;
 t_Cloak.InterfaceFactory := nil;
 t_NodeGroup.InterfaceFactory := nil;
 t_DocumentQuery.InterfaceFactory := nil;
 t_AnnoTopic.InterfaceFactory := nil;
 t_DocumentContainer.InterfaceFactory := nil;
 FreeAndNil(t_StyledLeafPara);
 FreeAndNil(t_TextPara);
 FreeAndNil(t_TextPara_Segments);
 FreeAndNil(t_TextPara_TabStops);
 FreeAndNil(t_DecorTextPara);
 FreeAndNil(t_ControlPara);
 FreeAndNil(t_ControlPara_Type);
 FreeAndNil(t_Formula);
 FreeAndNil(t_ParaList);
 FreeAndNil(t_ParaList_Orientation);
 FreeAndNil(t_HFParent);
 FreeAndNil(t_HFParent_Type);
 FreeAndNil(t_Header);
 FreeAndNil(t_Footer);
 FreeAndNil(t_Division);
 FreeAndNil(t_Division_Headers);
 FreeAndNil(t_Division_Footers);
 FreeAndNil(t_ContentsElement);
 FreeAndNil(t_ContentsElement_InContents);
 FreeAndNil(t_Participant);
 FreeAndNil(t_Block);
 FreeAndNil(t_Block_LayerID);
 FreeAndNil(t_Block_ViewKind);
 FreeAndNil(t_Version);
 FreeAndNil(t_DictEntryBlock);
 FreeAndNil(t_EditablePart);
 FreeAndNil(t_Document);
 FreeAndNil(t_Document_Subs);
 FreeAndNil(t_Document_Groups);
 FreeAndNil(t_Document_AccGroups);
 FreeAndNil(t_Document_Sources);
 FreeAndNil(t_Document_Warnings);
 FreeAndNil(t_Document_NumANDDates);
 FreeAndNil(t_Document_LogRecords);
 FreeAndNil(t_Document_SysLogRecords);
 FreeAndNil(t_Document_Versions);
 FreeAndNil(t_Document_Stages);
 FreeAndNil(t_Document_Checks);
 FreeAndNil(t_Document_PublishedIn);
 FreeAndNil(t_Document_Territory);
 FreeAndNil(t_Document_Norm);
 FreeAndNil(t_Document_ActiveIntervals);
 FreeAndNil(t_Document_Alarms);
 FreeAndNil(t_Document_AnnoClasses);
 FreeAndNil(t_Document_LinkedDocuments);
 FreeAndNil(t_Document_CaseDocParticipants);
 FreeAndNil(t_Document_EditableParts);
 FreeAndNil(t_SimpleDocumentTextPara);
 FreeAndNil(t_QueryCard);
 FreeAndNil(t_QueryCard_CardType);
 FreeAndNil(t_TableTextPara);
 FreeAndNil(t_TableCell);
 FreeAndNil(t_TableCell_MergeStatus);
 FreeAndNil(t_TableCell_VerticalAligment);
 FreeAndNil(t_SBSCell);
 FreeAndNil(t_TableRow);
 FreeAndNil(t_SBSRow);
 FreeAndNil(t_Table);
 FreeAndNil(t_ReqCell);
 FreeAndNil(t_ReqRow);
 FreeAndNil(t_ReqRow_ReqKind);
 FreeAndNil(t_ControlsBlock);
 FreeAndNil(t_BitmapPara);
 FreeAndNil(t_BitmapPara_Object);
 FreeAndNil(t_XMLTag);
 FreeAndNil(t_XML);
 FreeAndNil(t_ExtDataPara);
 FreeAndNil(t_AttrValue);
 FreeAndNil(t_AttrName);
 FreeAndNil(t_Attr);
 FreeAndNil(t_TagName);
 FreeAndNil(t_TagBody);
 FreeAndNil(t_ImageListBitmap);
 FreeAndNil(t_SimpleDocument);
 FreeAndNil(t_CommentPara);
 FreeAndNil(t_SBS);
 FreeAndNil(t_TinyDocument);
 FreeAndNil(t_LeafParaDecorationsHolder);
 FreeAndNil(t_ReqGroup);
 FreeAndNil(t_AutoreferatDocument);
 FreeAndNil(t_DictEntry);
 FreeAndNil(t_DictEntry_ShortName);
 FreeAndNil(t_Cloak);
 FreeAndNil(t_NodeGroup);
 FreeAndNil(t_DocumentQuery);
 FreeAndNil(t_AnnoTopic);
 FreeAndNil(t_DocumentContainer);
 inherited;
end;


initialization
 TevNativeSchema.SetAsDefault;

end.