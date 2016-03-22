unit evdNative_Schema;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/evdNative_Schema.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TagTable::Class>> Shared Delphi Low Level::EVD::Standard::evdNative
//
// Собственно схема документа EVD
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  l3Interfaces,
  l3Types,
  evdTypes,
  evdStyles,
  Graphics,
  evdTasks_Schema,
  l3Variant {a},
  k2Base {a},
  k2Interfaces {a},
  k2TypedAtomicTag {a},
  k2TypedSmallLeafTag {a},
  k2ParentedTypedSmallListTag {a},
  k2ParentedTypedSmallLeafTag {a},
  k2TypedSmallSortableListTag {a}
  ;

type
 JustificationAtomClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Justification" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//JustificationAtomClass

 JustificationAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//JustificationAtom

 BulletAtomClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Bullet" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//BulletAtomClass

 BulletAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//BulletAtom

 DateAtomClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Date" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//DateAtomClass

 DateAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DateAtom

 PositionAtomClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Position" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//PositionAtomClass

 PositionAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//PositionAtom

 TimeAtomClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Time" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TimeAtomClass

 TimeAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TimeAtom

 ObjectWithHandleTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ObjectWithHandleTag

 FontTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "Font" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//FontTagClass

 FontTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//FontTag

 Font_Index_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Font_Index" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//Font_Index_TagClass

 Font_Index_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Font_Index_Tag

 Font_Pitch_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Font_Pitch" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//Font_Pitch_TagClass

 Font_Pitch_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Font_Pitch_Tag

 StyleTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//StyleTag

 FramePartTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "FramePart" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//FramePartTagClass

 FramePartTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//FramePartTag

 FrameTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//FrameTag

 NSRCTagTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "NSRCTag" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//NSRCTagTagClass

 NSRCTagTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//NSRCTagTag

 DictRecTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DictRecTag

 DictItemTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DictItemTag

 DictItem_Flags_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "DictItem_Flags" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//DictItem_Flags_TagClass

 DictItem_Flags_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//DictItem_Flags_Tag

 AutoClassTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "AutoClass" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AutoClassTagClass

 AutoClassTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AutoClassTag

 DictItemExTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DictItemExTag

 SubTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "Sub" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//SubTagClass

 SubTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//SubTag

 Sub_Classes_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Sub_Classes_Tag

 Sub_AutoClasses_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Sub_AutoClasses_Tag

 Sub_Types_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Sub_Types_Tag

 Sub_KeyWords_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Sub_KeyWords_Tag

 Sub_Prefix_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Sub_Prefix_Tag

 Sub_ServiceInfo_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Sub_ServiceInfo_Tag

 SubLayerTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//SubLayerTag

 SubLayer_Handle_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "SubLayer_Handle" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//SubLayer_Handle_TagClass

 SubLayer_Handle_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//SubLayer_Handle_Tag

 ParaTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ParaTag

 Para_Subs_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Para_Subs_Tag

 BookmarkTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "Bookmark" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//BookmarkTagClass

 BookmarkTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//BookmarkTag

 MarkTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "Mark" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//MarkTagClass

 MarkTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//MarkTag

 DocumentSubTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "DocumentSub" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//DocumentSubTagClass

 DocumentSubTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DocumentSubTag

 DocSubLayerTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DocSubLayerTag

 TextStyleTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TextStyleTag

 TextStyle_Header_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//TextStyle_Header_Tag

 TextStyle_Footer_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//TextStyle_Footer_Tag

 SegmentTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//SegmentTag

 ActiveIntervalTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "ActiveInterval" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ActiveIntervalTagClass

 ActiveIntervalTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ActiveIntervalTag

 AlarmTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "Alarm" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AlarmTagClass

 AlarmTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AlarmTag

 LogRecordPrimTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "LogRecordPrim" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//LogRecordPrimTagClass

 LogRecordPrimTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//LogRecordPrimTag

 LogRecordTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "LogRecord" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//LogRecordTagClass

 LogRecordTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//LogRecordTag

 StagePrimTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "StagePrim" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//StagePrimTagClass

 StagePrimTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//StagePrimTag

 StageTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "Stage" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//StageTagClass

 StageTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//StageTag

 NumANDDateTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "NumANDDate" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//NumANDDateTagClass

 NumANDDateTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//NumANDDateTag

 CheckTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "Check" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//CheckTagClass

 CheckTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//CheckTag

 PIRecTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "PIRec" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//PIRecTagClass

 PIRecTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//PIRecTag

 TextSegmentTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "TextSegment" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TextSegmentTagClass

 TextSegmentTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
   function CompareTags(A: Tl3Variant;
     B: Tl3Variant;
     aSortIndex: Tl3SortIndex): Integer; override;
     {* Сравнивает теги }
   function CompareTagWithInt(aTag: Tl3Variant;
     aValue: Integer;
     anIndex: Integer): Integer; override;
     {* Сравнивает тег с целым }
 end;//TextSegmentTag

 TabStopTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "TabStop" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TabStopTagClass

 TabStopTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TabStopTag

 TabStop_Type_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "TabStop_Type" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//TabStop_Type_TagClass

 TabStop_Type_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//TabStop_Type_Tag

 SegmentsLayerTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
   function CompareTagWithInt(aTag: Tl3Variant;
     aValue: Integer;
     anIndex: Integer): Integer; override;
     {* Сравнивает тег с целым }
 end;//SegmentsLayerTag

 SegmentsLayer_Handle_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "SegmentsLayer_Handle" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//SegmentsLayer_Handle_TagClass

 SegmentsLayer_Handle_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//SegmentsLayer_Handle_Tag

 SegmentWithChildrenTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "SegmentWithChildren" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//SegmentWithChildrenTagClass

 SegmentWithChildrenTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
   function CompareTags(A: Tl3Variant;
     B: Tl3Variant;
     aSortIndex: Tl3SortIndex): Integer; override;
     {* Сравнивает теги }
   function CompareTagWithInt(aTag: Tl3Variant;
     aValue: Integer;
     anIndex: Integer): Integer; override;
     {* Сравнивает тег с целым }
 end;//SegmentWithChildrenTag

 ObjectSegmentTagClass = class(Tk2ParentedTypedSmallListTag)
  {* Класс реализации тега "ObjectSegment" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ObjectSegmentTagClass

 ObjectSegmentTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
   function CompareTags(A: Tl3Variant;
     B: Tl3Variant;
     aSortIndex: Tl3SortIndex): Integer; override;
     {* Сравнивает теги }
   function CompareTagWithInt(aTag: Tl3Variant;
     aValue: Integer;
     anIndex: Integer): Integer; override;
     {* Сравнивает тег с целым }
 end;//ObjectSegmentTag

 PagePropertiesTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "PageProperties" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//PagePropertiesTagClass

 PagePropertiesTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//PagePropertiesTag

 PageProperties_Orientation_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "PageProperties_Orientation" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//PageProperties_Orientation_TagClass

 PageProperties_Orientation_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//PageProperties_Orientation_Tag

 LeafParaTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "LeafPara" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//LeafParaTagClass

 LeafParaTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//LeafParaTag

 PageBreakTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "PageBreak" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//PageBreakTagClass

 PageBreakTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//PageBreakTag

 SectionBreakTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "SectionBreak" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//SectionBreakTagClass

 SectionBreakTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//SectionBreakTag

 HyperLinkTagClass = class(Tk2TypedSmallSortableListTag)
  {* Класс реализации тега "HyperLink" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//HyperLinkTagClass

 HyperLinkTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
   function CompareTags(A: Tl3Variant;
     B: Tl3Variant;
     aSortIndex: Tl3SortIndex): Integer; override;
     {* Сравнивает теги }
   function CompareTagWithInt(aTag: Tl3Variant;
     aValue: Integer;
     anIndex: Integer): Integer; override;
     {* Сравнивает тег с целым }
 end;//HyperLinkTag

 TevdNativeSchema = class(TevdTasksSchema)
 public
 // типы, определённые в данной схеме:
   t_Justification : JustificationAtom;
   t_Bullet : BulletAtom;
   t_Date : DateAtom;
   t_Position : PositionAtom;
   t_Time : TimeAtom;
   t_ObjectWithHandle : ObjectWithHandleTag;
   t_Font : FontTag;
   t_Font_Index : Font_Index_Tag;
   t_Font_Pitch : Font_Pitch_Tag;
   t_Style : StyleTag;
   t_FramePart : FramePartTag;
   t_Frame : FrameTag;
   t_NSRCTag : NSRCTagTag;
   t_DictRec : DictRecTag;
   t_DictItem : DictItemTag;
   t_DictItem_Flags : DictItem_Flags_Tag;
   t_AutoClass : AutoClassTag;
   t_DictItemEx : DictItemExTag;
   t_Sub : SubTag;
   t_Sub_Classes : Sub_Classes_Tag;
   t_Sub_AutoClasses : Sub_AutoClasses_Tag;
   t_Sub_Types : Sub_Types_Tag;
   t_Sub_KeyWords : Sub_KeyWords_Tag;
   t_Sub_Prefix : Sub_Prefix_Tag;
   t_Sub_ServiceInfo : Sub_ServiceInfo_Tag;
   t_SubLayer : SubLayerTag;
   t_SubLayer_Handle : SubLayer_Handle_Tag;
   t_Para : ParaTag;
   t_Para_Subs : Para_Subs_Tag;
   t_Bookmark : BookmarkTag;
   t_Mark : MarkTag;
   t_DocumentSub : DocumentSubTag;
   t_DocSubLayer : DocSubLayerTag;
   t_TextStyle : TextStyleTag;
   t_TextStyle_Header : TextStyle_Header_Tag;
   t_TextStyle_Footer : TextStyle_Footer_Tag;
   t_Segment : SegmentTag;
   t_ActiveInterval : ActiveIntervalTag;
   t_Alarm : AlarmTag;
   t_LogRecordPrim : LogRecordPrimTag;
   t_LogRecord : LogRecordTag;
   t_StagePrim : StagePrimTag;
   t_Stage : StageTag;
   t_NumANDDate : NumANDDateTag;
   t_Check : CheckTag;
   t_PIRec : PIRecTag;
   t_TextSegment : TextSegmentTag;
   t_TabStop : TabStopTag;
   t_TabStop_Type : TabStop_Type_Tag;
   t_SegmentsLayer : SegmentsLayerTag;
   t_SegmentsLayer_Handle : SegmentsLayer_Handle_Tag;
   t_SegmentWithChildren : SegmentWithChildrenTag;
   t_ObjectSegment : ObjectSegmentTag;
   t_PageProperties : PagePropertiesTag;
   t_PageProperties_Orientation : PageProperties_Orientation_Tag;
   t_LeafPara : LeafParaTag;
   t_PageBreak : PageBreakTag;
   t_SectionBreak : SectionBreakTag;
   t_HyperLink : HyperLinkTag;
 protected
 // определяем стандартные методы схемы
   procedure Cleanup; override;
 public
   constructor Create; override;
 end;//TevdNativeSchema

implementation

uses
  k2DictItem,
  k2List,
  k2Layer,
  evdStyleContainer,
  evStyle,
  l3Base,
  l3Defaults,
  l3Const,
  evdNative_AttrValues,
  Justification_Const,
  Bullet_Const,
  Date_Const,
  Position_Const,
  Time_Const,
  ObjectWithHandle_Const,
  Font_Const,
  Style_Const,
  FramePart_Const,
  evdFrame_Const,
  NSRCTag_Const,
  DictRec_Const,
  DictItem_Const,
  AutoClass_Const,
  DictItemEx_Const,
  Sub_Const,
  SubLayer_Const,
  Para_Const,
  Bookmark_Const,
  Mark_Const,
  DocumentSub_Const,
  DocSubLayer_Const,
  evdTextStyle_Const,
  Segment_Const,
  ActiveInterval_Const,
  Alarm_Const,
  LogRecordPrim_Const,
  LogRecord_Const,
  StagePrim_Const,
  Stage_Const,
  NumANDDate_Const,
  Check_Const,
  PIRec_Const,
  TextSegment_Const,
  TabStop_Const,
  SegmentsLayer_Const,
  SegmentWithChildren_Const,
  ObjectSegment_Const,
  PageProperties_Const,
  LeafPara_Const,
  PageBreak_Const,
  SectionBreak_Const,
  HyperLink_Const,
  SysUtils {a},
  TypInfo {a},
  k2Const {a},
  k2Tags {a},
  k2BaseStruct {a},
  l3String {a},
  evFont_Wrap,
  evStyle_Wrap,
  evFramePart_Wrap,
  evFrame_Wrap,
  evdDictRec_Wrap,
  evSub_Wrap,
  evPara_Wrap
  {$If defined(k2ForEditor)}
  ,
  TevParaInterfaceFactory_Proxy
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  TevLeafParaInterfaceFactory_Proxy
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  TevPageBreakInterfaceFactory_Proxy
  {$IfEnd} //k2ForEditor
  
  {$If defined(k2ForEditor)}
  ,
  TevSectionBreakInterfaceFactory_Proxy
  {$IfEnd} //k2ForEditor
  ,
  k2DictRec,
  k2Tag_Const,
  k2Long_Const,
  k2Enum_Const,
  k2Handle_Const,
  k2Inch_Const,
  k2Bool_Const,
  k2Color_Const,
  k2String_Const,
  k2OList_Const,
  Type_Const,
  Address_Const,
  k2FontName_Const,
  k2NonOptimizeContext {a}
  ;


// start class JustificationAtom

function JustificationAtomClass.GetTagType: Tl3Type;
begin
 Result := k2_typJustification;
end;//JustificationAtomClass.TagType

function JustificationAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Justification'));
end;

function JustificationAtom.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function JustificationAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, JustificationAtomClass);
end;

function BulletAtomClass.GetTagType: Tl3Type;
begin
 Result := k2_typBullet;
end;//BulletAtomClass.TagType

function BulletAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Bullet'));
end;

function BulletAtom.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Long.IsKindOf(anAtomType);
end;

function BulletAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, BulletAtomClass);
end;

function DateAtomClass.GetTagType: Tl3Type;
begin
 Result := k2_typDate;
end;//DateAtomClass.TagType

function DateAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Date'));
end;

function DateAtom.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Long.IsKindOf(anAtomType);
end;

function DateAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, DateAtomClass);
end;

function PositionAtomClass.GetTagType: Tl3Type;
begin
 Result := k2_typPosition;
end;//PositionAtomClass.TagType

function PositionAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Position'));
end;

function PositionAtom.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Long.IsKindOf(anAtomType);
end;

function PositionAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, PositionAtomClass);
end;

function TimeAtomClass.GetTagType: Tl3Type;
begin
 Result := k2_typTime;
end;//TimeAtomClass.TagType

function TimeAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Time'));
end;

function TimeAtom.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Long.IsKindOf(anAtomType);
end;

function TimeAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, TimeAtomClass);
end;

function ObjectWithHandleTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ObjectWithHandle'));
end;

function ObjectWithHandleTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег ObjectWithHandle');
end;

function Font_Index_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Font_Index'));
end;

function Font_Index_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function Font_Index_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typFont_Index;
end;//IndexClass.TagType

function Font_Index_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, Font_Index_TagClass);
end;

function Font_Pitch_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Font_Pitch'));
end;

function Font_Pitch_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function Font_Pitch_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typFont_Pitch;
end;//PitchClass.TagType

function Font_Pitch_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, Font_Pitch_TagClass);
end;

function FontTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typFont;
end;//FontTagClass.TagType

function FontTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Font'));
end;

function FontTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function FontTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := FontTagClass.Make(Self);
end;

function StyleStyleBeforeChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op): Boolean;
//#UC START# *484FD956009Evar_BeforeChange*
var
 A       : Tl3Variant;
 l_PredA : Tl3Variant;
//#UC END# *484FD956009Evar_BeforeChange*
begin
//#UC START# *484FD956009EBeforeChange*
 Result := false;
 A := V.rNew;
 while (A <> nil) AND not A.IsNull do
 begin
  if A.IsSame(V.rTag) then
   Exit
  else
  begin
   l_PredA := A;
   A := A.Attr[aProp.TagIndex];
   if A.IsSame(l_PredA) then
    break;
  end;//A.EQ(P)
 end;//while not A.IsNull
 Result := true;
//#UC END# *484FD956009EBeforeChange*
end;

function StyleTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Style'));
end;

function StyleTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_ObjectWithHandle.IsKindOf(anAtomType);
end;

function StyleTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TevStyle.Make(Self);
end;

function FramePartTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typFramePart;
end;//FramePartTagClass.TagType

function FramePartTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('FramePart'));
end;

function FramePartTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function FramePartTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := FramePartTagClass.Make(Self);
end;

function FrameTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Frame'));
end;

function FrameTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Tag.IsKindOf(anAtomType)
           OR
           TevdNativeSchema(TypeTable).t_ObjectWithHandle.IsKindOf(anAtomType);
end;

function FrameTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Tk2DictRec.Make(Self);
end;

function NSRCTagTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typNSRCTag;
end;//NSRCTagTagClass.TagType

function NSRCTagTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('NSRCTag'));
end;

function NSRCTagTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function NSRCTagTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег NSRCTag');
end;

function DictRecTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DictRec'));
end;

function DictRecTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Tag.IsKindOf(anAtomType)
           OR
           TevdNativeSchema(TypeTable).t_ObjectWithHandle.IsKindOf(anAtomType);
end;

function DictRecTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег DictRec');
end;

function DictItem_Flags_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DictItem_Flags'));
end;

function DictItem_Flags_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function DictItem_Flags_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typDictItem_Flags;
end;//FlagsClass.TagType

function DictItem_Flags_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, DictItem_Flags_TagClass);
end;

function DictItemTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DictItem'));
end;

function DictItemTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_DictRec.IsKindOf(anAtomType)
           OR
           TevdNativeSchema(TypeTable).t_NSRCTag.IsKindOf(anAtomType);
end;

function DictItemTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Tk2DictItem.Make(Self);
end;

function AutoClassTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAutoClass;
end;//AutoClassTagClass.TagType

function AutoClassTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoClass'));
end;

function AutoClassTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Tag.IsKindOf(anAtomType)
           OR
           TevdNativeSchema(TypeTable).t_ObjectWithHandle.IsKindOf(anAtomType);
end;

function AutoClassTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AutoClassTagClass.Make(Self);
end;

function DictItemExTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DictItemEx'));
end;

function DictItemExTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_DictItem.IsKindOf(anAtomType);
end;

function DictItemExTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Tk2DictItem.Make(Self);
end;

function Sub_Classes_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Sub_Classes'));
end;

function Sub_Classes_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Sub_Classes_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Sub_AutoClasses_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Sub_AutoClasses'));
end;

function Sub_AutoClasses_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Sub_AutoClasses_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Sub_Types_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Sub_Types'));
end;

function Sub_Types_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Sub_Types_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Sub_KeyWords_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Sub_KeyWords'));
end;

function Sub_KeyWords_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Sub_KeyWords_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Sub_Prefix_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Sub_Prefix'));
end;

function Sub_Prefix_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Sub_Prefix_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function Sub_ServiceInfo_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Sub_ServiceInfo'));
end;

function Sub_ServiceInfo_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Sub_ServiceInfo_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function SubFlagsStored(aTag : Tl3Variant;
 aValue   : Tl3Variant;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op): Boolean;
//#UC START# *484F9FC101B3var_stored*
//#UC END# *484F9FC101B3var_stored*
begin
//#UC START# *484F9FC101B3stored*
 {$IfDef Nemesis}
 Result := aTag.IsKindOf(k2_typMark) OR
           aTag.IsKindOf(k2_typBookmark);
 {$Else  Nemesis}
 Result := false;
 {$EndIf Nemesis}
//#UC END# *484F9FC101B3stored*
end;

function SubTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typSub;
end;//SubTagClass.TagType

function SubTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Sub'));
end;

function SubTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Tag.IsKindOf(anAtomType)
           OR
           TevdNativeSchema(TypeTable).t_DictRec.IsKindOf(anAtomType);
end;

function SubTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := SubTagClass.Make(Self);
end;

function SubLayerChildStored(aParent : Tl3Variant;
 aChild   : Tl3Variant;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op): Boolean;
//#UC START# *484FB206020Cvar_childstored*
//#UC END# *484FB206020Cvar_childstored*
begin
//#UC START# *484FB206020Cchildstored*
 with aChild.Attr[k2_tiHandle] do
  Result := IsValid AND (AsLong <> 0); 
 {$IfDef Nemesis}
(* if Result then
 begin
  with P._rAtom(k2_tiHandle) do
   if IsValid AND (AsLong = ev_sbtMark) then
   begin
    with Value._rAtom(k2_tiFlags) do
     if not IsValid OR (AsLong <> ev_UserCommentFlags) then
      Result := false;
   end;//IsValid..
 end;//Result*)
 {$EndIf Nemesis}
//#UC END# *484FB206020Cchildstored*
end;

function SubLayer_Handle_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('SubLayer_Handle'));
end;

function SubLayer_Handle_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function SubLayer_Handle_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typSubLayer_Handle;
end;//HandleClass.TagType

function SubLayer_Handle_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, SubLayer_Handle_TagClass);
end;

function SubLayerTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('SubLayer'));
end;

function SubLayerTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType)
           OR
           TevdNativeSchema(TypeTable).t_ObjectWithHandle.IsKindOf(anAtomType);
end;

function SubLayerTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Tk2Layer.Make(Self);
end;

function Para_Subs_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Para_Subs'));
end;

function Para_Subs_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function Para_Subs_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function ParaSubsChildStored(aParent : Tl3Variant;
 aChild   : Tl3Variant;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op): Boolean;
//#UC START# *4856677F0179var_childstored*
var
 H : Integer;
//#UC END# *4856677F0179var_childstored*
begin
//#UC START# *4856677F0179childstored*
 if (aChild.ChildrenCount > 0) then
 begin
  H := aChild.IntA[k2_tiHandle];
  Result := (H = Ord(ev_sbtSub))
            {$IfDef Nemesis}
            OR (H = Ord(ev_sbtBookmark))
            OR (H = Ord(ev_sbtMark))
            {$EndIf Nemesis}
            ;
 end//aChild.ChildrenCount > 0
 else
  Result := false;
//#UC END# *4856677F0179childstored*
end;

function ParaTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Para'));
end;

function ParaTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function ParaTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег Para');
end;

function BookmarkTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typBookmark;
end;//BookmarkTagClass.TagType

function BookmarkTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Bookmark'));
end;

function BookmarkTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Sub.IsKindOf(anAtomType);
end;

function BookmarkTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := BookmarkTagClass.Make(Self);
end;

function MarkTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typMark;
end;//MarkTagClass.TagType

function MarkTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Mark'));
end;

function MarkTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Sub.IsKindOf(anAtomType);
end;

function MarkTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := MarkTagClass.Make(Self);
end;

function DocumentSubTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typDocumentSub;
end;//DocumentSubTagClass.TagType

function DocumentSubTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DocumentSub'));
end;

function DocumentSubTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Sub.IsKindOf(anAtomType);
end;

function DocumentSubTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := DocumentSubTagClass.Make(Self);
end;

function DocSubLayerTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DocSubLayer'));
end;

function DocSubLayerTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_SubLayer.IsKindOf(anAtomType);
end;

function DocSubLayerTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Tk2Layer.Make(Self);
end;

function TextStyle_Header_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TextStyle_Header'));
end;

function TextStyle_Header_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function TextStyle_Header_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function TextStyle_Footer_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TextStyle_Footer'));
end;

function TextStyle_Footer_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function TextStyle_Footer_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function TextStyleTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TextStyle'));
end;

function TextStyleTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Style.IsKindOf(anAtomType);
end;

function TextStyleTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TevStyle.Make(Self);
end;

function SegmentTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Segment'));
end;

function SegmentTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function SegmentTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег Segment');
end;

function ActiveIntervalTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typActiveInterval;
end;//ActiveIntervalTagClass.TagType

function ActiveIntervalTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ActiveInterval'));
end;

function ActiveIntervalTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_NSRCTag.IsKindOf(anAtomType);
end;

function ActiveIntervalTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ActiveIntervalTagClass.Make(Self);
end;

function AlarmTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAlarm;
end;//AlarmTagClass.TagType

function AlarmTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Alarm'));
end;

function AlarmTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_NSRCTag.IsKindOf(anAtomType);
end;

function AlarmTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AlarmTagClass.Make(Self);
end;

function LogRecordPrimTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typLogRecordPrim;
end;//LogRecordPrimTagClass.TagType

function LogRecordPrimTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('LogRecordPrim'));
end;

function LogRecordPrimTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_NSRCTag.IsKindOf(anAtomType);
end;

function LogRecordPrimTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег LogRecordPrim');
end;

function LogRecordTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typLogRecord;
end;//LogRecordTagClass.TagType

function LogRecordTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('LogRecord'));
end;

function LogRecordTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_LogRecordPrim.IsKindOf(anAtomType);
end;

function LogRecordTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := LogRecordTagClass.Make(Self);
end;

function StagePrimTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typStagePrim;
end;//StagePrimTagClass.TagType

function StagePrimTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('StagePrim'));
end;

function StagePrimTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_LogRecordPrim.IsKindOf(anAtomType);
end;

function StagePrimTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег StagePrim');
end;

function StageTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typStage;
end;//StageTagClass.TagType

function StageTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Stage'));
end;

function StageTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_StagePrim.IsKindOf(anAtomType);
end;

function StageTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := StageTagClass.Make(Self);
end;

function NumANDDateTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typNumANDDate;
end;//NumANDDateTagClass.TagType

function NumANDDateTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('NumANDDate'));
end;

function NumANDDateTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_LogRecordPrim.IsKindOf(anAtomType);
end;

function NumANDDateTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := NumANDDateTagClass.Make(Self);
end;

function CheckTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typCheck;
end;//CheckTagClass.TagType

function CheckTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Check'));
end;

function CheckTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_StagePrim.IsKindOf(anAtomType);
end;

function CheckTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := CheckTagClass.Make(Self);
end;

function PIRecTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typPIRec;
end;//PIRecTagClass.TagType

function PIRecTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('PIRec'));
end;

function PIRecTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_NSRCTag.IsKindOf(anAtomType);
end;

function PIRecTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := PIRecTagClass.Make(Self);
end;

function TextSegmentTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTextSegment;
end;//TextSegmentTagClass.TagType

function TextSegmentTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TextSegment'));
end;

function TextSegmentTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Segment.IsKindOf(anAtomType);
end;

function TextSegmentTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TextSegmentTagClass.Make(Self);
end;

function TextSegmentTag.CompareTags(A: Tl3Variant;
    B: Tl3Variant;
    aSortIndex: Tl3SortIndex): Integer;
    {* Сравнивает теги }
//#UC START# *484FDC4F013FCompareTags_var*
var
 l_SStart, l_SFinish : Integer;
 l_FStart, l_FFinish : Integer;
//#UC END# *484FDC4F013FCompareTags_var*
begin
//#UC START# *484FDC4F013FCompareTags*
 if (aSortIndex = l3_siNative) then
 begin
  if (A.AsObject = B.AsObject) then
   Result := 0
  else
  begin
   with A do
   begin
    l_SStart := IntA[k2_tiStart];
    l_SFinish := IntA[k2_tiFinish];
   end;//with A
   with B do
   begin
    l_FStart := IntA[k2_tiStart];
    l_FFinish := IntA[k2_tiFinish];
   end;//with B
   Result := l_SStart - l_FFinish;
   if (Result < 0) then
   begin
    Result := l_SFinish - l_FStart;
    if (Result > 0) then
     Result := 0;
   end;//Result < 0
  end;//Self = AsObject
 end//aSortIndex = l3_siNative
 else
  Result := inherited CompareTags(A, B, aSortIndex);
//#UC END# *484FDC4F013FCompareTags*
end;

function TextSegmentTag.CompareTagWithInt(aTag: Tl3Variant;
    aValue: Integer;
    anIndex: Integer): Integer;
    {* Сравнивает тег с целым }
//#UC START# *484FDC4F013FCompareTagWithInt_var*
//#UC END# *484FDC4F013FCompareTagWithInt_var*
begin
//#UC START# *484FDC4F013FCompareTagWithInt*
 if (anIndex = l3_siNative) then
 begin
  if (aValue < aTag.IntA[k2_tiStart]) then
   Result := 1
  else
  if (aValue <= aTag.IntA[k2_tiFinish]) then
   Result := 0
  else
   Result := -1;
 end//anIndex = l3_siNative
 else
  Result := inherited CompareTagWithInt(aTag, aValue, anIndex);
//#UC END# *484FDC4F013FCompareTagWithInt*
end;

function TabStop_Type_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TabStop_Type'));
end;

function TabStop_Type_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function TabStop_Type_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTabStop_Type;
end;//TypeClass.TagType

function TabStop_Type_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, TabStop_Type_TagClass);
end;

function TabStopTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTabStop;
end;//TabStopTagClass.TagType

function TabStopTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TabStop'));
end;

function TabStopTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function TabStopTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TabStopTagClass.Make(Self);
end;

function SegmentsLayer_Handle_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('SegmentsLayer_Handle'));
end;

function SegmentsLayer_Handle_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function SegmentsLayer_Handle_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typSegmentsLayer_Handle;
end;//HandleClass.TagType

function SegmentsLayer_Handle_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, SegmentsLayer_Handle_TagClass);
end;

function SegmentsLayerTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('SegmentsLayer'));
end;

function SegmentsLayerTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_OList.IsKindOf(anAtomType)
           OR
           TevdNativeSchema(TypeTable).t_ObjectWithHandle.IsKindOf(anAtomType);
end;

function SegmentsLayerTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Tk2Layer.Make(Self);
end;

function SegmentsLayerTag.CompareTagWithInt(aTag: Tl3Variant;
    aValue: Integer;
    anIndex: Integer): Integer;
    {* Сравнивает тег с целым }
//#UC START# *484FD1360343CompareTagWithInt_var*

 function Mangle(aHandle : Integer): Integer;
 const
  cMul = 10;
 begin
  if (aHandle = Ord(ev_slDiff)) then
   Result := (Ord(ev_slHyperlinks) * cMul) - (cMul div 2)
  else
   Result := aHandle * cMul;
 end;

//#UC END# *484FD1360343CompareTagWithInt_var*
begin
//#UC START# *484FD1360343CompareTagWithInt*
 Case anIndex of
  k2_tiHandle :
  begin
   Result := Mangle(aTag.IntA[anIndex]) - Mangle(aValue);
  end;//k2_tiHandle
  else
   Result := inherited CompareTagWithInt(aTag, aValue, anIndex);
 end;//Case anIndex
//#UC END# *484FD1360343CompareTagWithInt*
end;

function SegmentWithChildrenTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typSegmentWithChildren;
end;//SegmentWithChildrenTagClass.TagType

function SegmentWithChildrenTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('SegmentWithChildren'));
end;

function SegmentWithChildrenTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_TextSegment.IsKindOf(anAtomType);
end;

function SegmentWithChildrenTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег SegmentWithChildren');
end;

function SegmentWithChildrenTag.CompareTags(A: Tl3Variant;
    B: Tl3Variant;
    aSortIndex: Tl3SortIndex): Integer;
    {* Сравнивает теги }
begin
 Result := TevdNativeSchema(TypeTable).t_TextSegment.CompareTags(A, B, aSortIndex);
end;

function SegmentWithChildrenTag.CompareTagWithInt(aTag: Tl3Variant;
    aValue: Integer;
    anIndex: Integer): Integer;
    {* Сравнивает тег с целым }
begin
 Result := TevdNativeSchema(TypeTable).t_TextSegment.CompareTagWithInt(aTag, aValue, anIndex);
end;

function ObjectSegmentTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typObjectSegment;
end;//ObjectSegmentTagClass.TagType

function ObjectSegmentTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ObjectSegment'));
end;

function ObjectSegmentTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_SegmentWithChildren.IsKindOf(anAtomType);
end;

function ObjectSegmentTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ObjectSegmentTagClass.Make(Self);
end;

function ObjectSegmentTag.CompareTags(A: Tl3Variant;
    B: Tl3Variant;
    aSortIndex: Tl3SortIndex): Integer;
    {* Сравнивает теги }
begin
 Result := TevdNativeSchema(TypeTable).t_SegmentWithChildren.CompareTags(A, B, aSortIndex);
end;

function ObjectSegmentTag.CompareTagWithInt(aTag: Tl3Variant;
    aValue: Integer;
    anIndex: Integer): Integer;
    {* Сравнивает тег с целым }
begin
 Result := TevdNativeSchema(TypeTable).t_SegmentWithChildren.CompareTagWithInt(aTag, aValue, anIndex);
end;

function PageProperties_Orientation_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('PageProperties_Orientation'));
end;

function PageProperties_Orientation_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdNativeSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function PageProperties_Orientation_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typPageProperties_Orientation;
end;//OrientationClass.TagType

function PageProperties_Orientation_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, PageProperties_Orientation_TagClass);
end;

function PagePropertiesTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typPageProperties;
end;//PagePropertiesTagClass.TagType

function PagePropertiesTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('PageProperties'));
end;

function PagePropertiesTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function PagePropertiesTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := PagePropertiesTagClass.Make(Self);
end;

function LeafParaTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typLeafPara;
end;//LeafParaTagClass.TagType

function LeafParaTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('LeafPara'));
end;

function LeafParaTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_Para.IsKindOf(anAtomType);
end;

function LeafParaTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := nil;
 Assert(false,'Невозможно создать абстрактный тег LeafPara');
end;

function PageBreakTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typPageBreak;
end;//PageBreakTagClass.TagType

function PageBreakTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('PageBreak'));
end;

function PageBreakTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_LeafPara.IsKindOf(anAtomType);
end;

function PageBreakTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := PageBreakTagClass.Make(Self);
end;

function SectionBreakTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typSectionBreak;
end;//SectionBreakTagClass.TagType

function SectionBreakTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('SectionBreak'));
end;

function SectionBreakTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_PageBreak.IsKindOf(anAtomType);
end;

function SectionBreakTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := SectionBreakTagClass.Make(Self);
end;

function HyperLinkTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typHyperLink;
end;//HyperLinkTagClass.TagType

function HyperLinkTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('HyperLink'));
end;

function HyperLinkTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdNativeSchema(TypeTable).t_SegmentWithChildren.IsKindOf(anAtomType)
           OR
           TevdNativeSchema(TypeTable).t_ObjectWithHandle.IsKindOf(anAtomType);
end;

function HyperLinkTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := HyperLinkTagClass.Make(Self);
end;

function HyperLinkTag.CompareTags(A: Tl3Variant;
    B: Tl3Variant;
    aSortIndex: Tl3SortIndex): Integer;
    {* Сравнивает теги }
begin
 Result := TevdNativeSchema(TypeTable).t_SegmentWithChildren.CompareTags(A, B, aSortIndex);
end;

function HyperLinkTag.CompareTagWithInt(aTag: Tl3Variant;
    aValue: Integer;
    anIndex: Integer): Integer;
    {* Сравнивает тег с целым }
begin
 Result := TevdNativeSchema(TypeTable).t_SegmentWithChildren.CompareTagWithInt(aTag, aValue, anIndex);
end;

constructor TevdNativeSchema.Create;
begin
 inherited;
 // Justification
 t_Justification := DefineAutoType([t_Enum], 'Выравнивание текста', JustificationAtom) As JustificationAtom;
 with t_Justification do
 begin
  AtomType := TypeInfo(TevIndentType);
 end;//Justification
 // Bullet
 t_Bullet := DefineAutoType([t_Long], 'Тип маркера', BulletAtom) As BulletAtom;
 with t_Bullet do
 begin
 end;//Bullet
 // Date
 t_Date := DefineAutoType([t_Long], 'Дата', DateAtom) As DateAtom;
 with t_Date do
 begin
 end;//Date
 // Position
 t_Position := DefineAutoType([t_Long], 'Позиция в тексте', PositionAtom) As PositionAtom;
 with t_Position do
 begin
 end;//Position
 // Time
 t_Time := DefineAutoType([t_Long], 'Время', TimeAtom) As TimeAtom;
 with t_Time do
 begin
 end;//Time
 // ObjectWithHandle
 t_ObjectWithHandle := DefineAutoType([], 'Объект с идентификатором', ObjectWithHandleTag) As ObjectWithHandleTag;
 with t_ObjectWithHandle do
 begin
  with DefineProperty(k2_attrHandle, t_Handle, 'Идентификатор объекта') do
  begin
  end;//Handle
 end;//ObjectWithHandle
 // Font
 t_Font := DefineType(k2_idFont {36}, [t_Tag], 'Шрифт', FontTag) As FontTag;
 with t_Font do
 begin
  AtomClass := FontTagClass;
  WrapperType := WevFont;
//#UC START# *484CEE9A0170atom1*
//#UC END# *484CEE9A0170atom1*
  t_Font_Index := DefineAutoType([t_Enum], 'Шрифт Верхний/нижний индекс', Font_Index_Tag) As Font_Index_Tag;
  try
   t_Font_Index.AtomType := TypeInfo(Tl3FontIndex);
   DefineProperty(k2_attrIndex, t_Font_Index, 'Верхний/нижний индекс');
   t_Font_Index.Recalc;
  except
   FreeAndNil(t_Font_Index);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrIndex]) do
  begin
   DefaultValue := Ord(l3_fiNone);
  end;//Index
  with DefineProperty(k2_attrBold, t_Bool, 'Жирный') do
  begin
  end;//Bold
  with DefineProperty(k2_attrItalic, t_Bool, 'Курсив') do
  begin
  end;//Italic
  with DefineProperty(k2_attrUnderline, t_Bool, 'Подчеркивание') do
  begin
  end;//Underline
  with DefineProperty(k2_attrStrikeout, t_Bool, 'Зачеркивание') do
  begin
  end;//Strikeout
  t_Font_Pitch := DefineAutoType([t_Enum], 'Шрифт Тип шрифта', Font_Pitch_Tag) As Font_Pitch_Tag;
  try
   t_Font_Pitch.AtomType := TypeInfo(TFontPitch);
   DefineProperty(k2_attrPitch, t_Font_Pitch, 'Тип шрифта');
   t_Font_Pitch.Recalc;
  except
   FreeAndNil(t_Font_Pitch);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrPitch]) do
  begin
  end;//Pitch
  with DefineProperty(k2_attrSize, t_Long, 'Кегль') do
  begin
  end;//Size
  with DefineProperty(k2_attrName, t_FontName, 'Гарнитура шрифта') do
  begin
   Shared := true;
  end;//Name
  with DefineProperty(k2_attrForeColor, t_Color, 'Цвет текста') do
  begin
  end;//ForeColor
  with DefineProperty(k2_attrBackColor, t_Color, 'Цвет фона') do
  begin
  end;//BackColor
//#UC START# *484CEE9A0170atom*
  Recalc;
//#UC END# *484CEE9A0170atom*
 end;//Font
 // Style
 t_Style := DefineType(k2_idStyle {38}, [t_ObjectWithHandle], 'Стиль оформления', StyleTag) As StyleTag;
 with t_Style do
 begin
  AtomClass := TevStyle;
  WrapperType := WevStyle;
  IDIndex := k2_attrHandle;
  with DefineProperty(k2_attrStyle, t_Style, 'Родительский стиль') do
  begin
   Shared := true;
   BeforeChange := StyleStyleBeforeChange;
  end;//Style
  with DefineProperty(k2_attrName, t_String, 'Имя стиля') do
  begin
  end;//Name
 end;//Style
 // FramePart
 t_FramePart := DefineType(k2_idFramePart {40}, [t_Tag], 'Часть рамки вокруг объекта', FramePartTag) As FramePartTag;
 with t_FramePart do
 begin
  AtomClass := FramePartTagClass;
  WrapperType := WevFramePart;
//#UC START# *484D27FD005Datom1*
//#UC END# *484D27FD005Datom1*
  with DefineProperty(k2_attrForeColor, t_Color, 'Цвет линии') do
  begin
   DefaultValue := clBlack;
  end;//ForeColor
  with DefineProperty(k2_attrWidth, t_Inch, 'Ширина линии') do
  begin
   DefaultValue := def_FrameWidth;
  end;//Width
  with DefineProperty(k2_attrLineType, t_Long, 'Тип линии') do
  begin
   DefaultValue := 0;
  end;//LineType
  with DefineProperty(k2_attrSpaceBefore, t_Inch, 'Отступ сверху') do
  begin
   DefaultValue := 0;
  end;//SpaceBefore
  with DefineProperty(k2_attrSpaceAfter, t_Inch, 'Отступ снизу') do
  begin
   DefaultValue := 0;
  end;//SpaceAfter
//#UC START# *484D27FD005Datom*
  ParamsForClone := l3LongArray([k2_tiForeColor, k2_tiWidth, k2_tiLineType, k2_tiSpaceBefore, k2_tiSpaceAfter]);
  Recalc;
//#UC END# *484D27FD005Datom*
 end;//FramePart
 // Frame
 t_Frame := DefineType(k2_idFrame {41}, [t_Tag, t_ObjectWithHandle], 'Рамка вокруг объекта', FrameTag) As FrameTag;
 with t_Frame do
 begin
  AtomClass := Tk2DictRec;
  WrapperType := WevFrame;
  IDIndex := k2_attrHandle;
//#UC START# *484D2BAB02BBatom1*
//#UC END# *484D2BAB02BBatom1*
  with Tk2CustomProperty(Prop[k2_attrHandle]) do
  begin
   Stored := false;
  end;//Handle
  with DefineProperty(k2_attrName, t_String, '') do
  begin
   Stored := false;
  end;//Name
  with DefineProperty(k2_attrForeColor, t_Color, '') do
  begin
   DefaultValue := clBlack;
  end;//ForeColor
  with DefineProperty(k2_attrFrameUp, t_FramePart, 'Рамка сверху') do
  begin
  end;//FrameUp
  with DefineProperty(k2_attrFrameDown, t_FramePart, 'Рамка снизу') do
  begin
  end;//FrameDown
  with DefineProperty(k2_attrFrameLeft, t_FramePart, 'Рамка слева') do
  begin
  end;//FrameLeft
  with DefineProperty(k2_attrFrameRight, t_FramePart, 'Рамка справа') do
  begin
  end;//FrameRight
//#UC START# *484D2BAB02BBatom*
  ParamsForClone := l3LongArray([k2_tiHandle, k2_tiFrameUp, k2_tiFrameDown, k2_tiFrameLeft, k2_tiFrameRight]);
//#UC END# *484D2BAB02BBatom*
  Recalc;
  // Пустая рамка
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := 0;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_Frame_Empty_Name_Value.AsStr;
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Цельная рамка
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := 1111;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_Frame_Solid_Name_Value.AsStr;
    with cAtom(k2_attrFrameLeft) do
    begin
    end;//with cAtom(k2_attrFrameLeft)
    with cAtom(k2_attrFrameRight) do
    begin
    end;//with cAtom(k2_attrFrameRight)
    with cAtom(k2_attrFrameUp) do
    begin
    end;//with cAtom(k2_attrFrameUp)
    with cAtom(k2_attrFrameDown) do
    begin
    end;//with cAtom(k2_attrFrameDown)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Нижняя рамка
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := 0001;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_Frame_Down_Name_Value.AsStr;
    with cAtom(k2_attrFrameDown) do
    begin
    end;//with cAtom(k2_attrFrameDown)
    AddValue(Box);
   end;//with MakeTag.AsObject
 end;//Frame
 // NSRCTag
 t_NSRCTag := DefineAutoType([t_Tag], 'Атрибут точки входа', NSRCTagTag) As NSRCTagTag;
 with t_NSRCTag do
 begin
  AtomClass := NSRCTagTagClass;
  with DefineProperty(k2_attrName, t_String, 'Name') do
  begin
  end;//Name
 end;//NSRCTag
 // DictRec
 t_DictRec := DefineAutoType([t_Tag, t_ObjectWithHandle], 'Словарная запись', DictRecTag) As DictRecTag;
 with t_DictRec do
 begin
  WrapperType := WevdDictRec;
  with DefineProperty(k2_attrName, t_String, 'Имя') do
  begin
  end;//Name
  with DefineProperty(k2_attrShortName, t_String, 'Короткое имя') do
  begin
  end;//ShortName
 end;//DictRec
 // DictItem
 t_DictItem := DefineType(k2_idDictItem {73}, [t_DictRec, t_NSRCTag], 'Элемент словаря', DictItemTag) As DictItemTag;
 with t_DictItem do
 begin
  AtomClass := Tk2DictItem;
  t_DictItem_Flags := DefineAutoType([t_Enum], 'Элемент словаря Flags', DictItem_Flags_Tag) As DictItem_Flags_Tag;
  try
   t_DictItem_Flags.AtomType := TypeInfo(Tl3ItemFlag);
   DefineProperty(k2_attrFlags, t_DictItem_Flags, '');
   t_DictItem_Flags.Recalc;
  except
   FreeAndNil(t_DictItem_Flags);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrFlags]) do
  begin
   DefaultValue := Ord(l3_ifNone);
  end;//Flags
  SetNeedMarkModifiedAllExcept(k2_attrName);
 end;//DictItem
 // AutoClass
 t_AutoClass := DefineType(k2_idAutoClass {86}, [t_Tag, t_ObjectWithHandle], 'Авто-класс', AutoClassTag) As AutoClassTag;
 with t_AutoClass do
 begin
  AtomClass := AutoClassTagClass;
  with DefineProperty(k2_attrFlags, t_Long, 'Флаги') do
  begin
  end;//Flags
  with DefineProperty(k2_attrWeight, t_Long, 'Вес') do
  begin
  end;//Weight
 end;//AutoClass
 // DictItemEx
 t_DictItemEx := DefineType(k2_idDictItemEx {87}, [t_DictItem], 'Продвинутый элемент словаря', DictItemExTag) As DictItemExTag;
 with t_DictItemEx do
 begin
  with DefineProperty(k2_attrPrivate, t_Bool, '') do
  begin
   DefaultValue := Ord(false);
  end;//Private
 end;//DictItemEx
 // Sub
 t_Sub := DefineType(k2_idSub {15}, [t_Tag, t_DictRec], 'Метка', SubTag) As SubTag;
 with t_Sub do
 begin
  AtomClass := SubTagClass;
  WrapperType := WevSub;
  t_Sub_Classes := DefineAutoType([t_OList], 'Метка Классы', Sub_Classes_Tag) As Sub_Classes_Tag;
  try
   t_Sub_Classes.DefineChildren(t_DictItem);
   DefineProperty(k2_attrClasses, t_Sub_Classes, 'Классы');
   t_Sub_Classes.Recalc;
  except
   FreeAndNil(t_Sub_Classes);
  end;//try..except
  with t_Sub_Classes.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrName;
   Duplicates := l3_dupAccept;
  end;//Classes
  t_Sub_AutoClasses := DefineAutoType([t_OList], 'Метка Авто-классы', Sub_AutoClasses_Tag) As Sub_AutoClasses_Tag;
  try
   t_Sub_AutoClasses.DefineChildren(t_AutoClass);
   DefineProperty(k2_attrAutoClasses, t_Sub_AutoClasses, 'Авто-классы');
   t_Sub_AutoClasses.Recalc;
  except
   FreeAndNil(t_Sub_AutoClasses);
  end;//try..except
  with t_Sub_AutoClasses.ArrayProp[k2_tiChildren] do
  begin
  end;//AutoClasses
  t_Sub_Types := DefineAutoType([t_OList], 'Метка Типы', Sub_Types_Tag) As Sub_Types_Tag;
  try
   t_Sub_Types.DefineChildren(t_DictItem);
   DefineProperty(k2_attrTypes, t_Sub_Types, 'Типы');
   t_Sub_Types.Recalc;
  except
   FreeAndNil(t_Sub_Types);
  end;//try..except
  with t_Sub_Types.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrName;
   Duplicates := l3_dupAccept;
  end;//Types
  t_Sub_KeyWords := DefineAutoType([t_OList], 'Метка Ключевые слова', Sub_KeyWords_Tag) As Sub_KeyWords_Tag;
  try
   t_Sub_KeyWords.DefineChildren(t_DictItem);
   DefineProperty(k2_attrKeyWords, t_Sub_KeyWords, 'Ключевые слова');
   t_Sub_KeyWords.Recalc;
  except
   FreeAndNil(t_Sub_KeyWords);
  end;//try..except
  with t_Sub_KeyWords.ArrayProp[k2_tiChildren] do
  begin
  end;//KeyWords
  t_Sub_Prefix := DefineAutoType([t_OList], 'Метка Префиксы', Sub_Prefix_Tag) As Sub_Prefix_Tag;
  try
   t_Sub_Prefix.DefineChildren(t_DictItem);
   DefineProperty(k2_attrPrefix, t_Sub_Prefix, 'Префиксы');
   t_Sub_Prefix.Recalc;
  except
   FreeAndNil(t_Sub_Prefix);
  end;//try..except
  with t_Sub_Prefix.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrName;
   Duplicates := l3_dupAccept;
  end;//Prefix
  t_Sub_ServiceInfo := DefineAutoType([t_OList], 'Метка Служебная информация', Sub_ServiceInfo_Tag) As Sub_ServiceInfo_Tag;
  try
   t_Sub_ServiceInfo.DefineChildren(t_DictItem);
   DefineProperty(k2_attrServiceInfo, t_Sub_ServiceInfo, 'Служебная информация');
   t_Sub_ServiceInfo.Recalc;
  except
   FreeAndNil(t_Sub_ServiceInfo);
  end;//try..except
  with t_Sub_ServiceInfo.ArrayProp[k2_tiChildren] do
  begin
  end;//ServiceInfo
  with DefineProperty(k2_attrFlags, t_Long, 'Флаги метки') do
  begin
   StoredProc := SubFlagsStored;
  end;//Flags
 end;//Sub
 // SubLayer
 t_SubLayer := DefineType(k2_idSubLayer {17}, [t_OList, t_ObjectWithHandle], 'Слой меток', SubLayerTag) As SubLayerTag;
 with t_SubLayer do
 begin
  AtomClass := Tk2Layer;
//#UC START# *484FAF4D03CCatom1*
  UndefineProperties([k2_tiHandle]);
//#UC END# *484FAF4D03CCatom1*
  with DefineChildren(t_Sub) do
  begin
   SortIndex := k2_attrHandle;
   StoredChildProc := SubLayerChildStored;
  end;//
  t_SubLayer_Handle := DefineAutoType([t_Enum], 'Слой меток Handle', SubLayer_Handle_Tag) As SubLayer_Handle_Tag;
  try
   t_SubLayer_Handle.AtomType := TypeInfo(TevSubHandle);
   DefineProperty(k2_attrHandle, t_SubLayer_Handle, '');
   t_SubLayer_Handle.Recalc;
  except
   FreeAndNil(t_SubLayer_Handle);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrHandle]) do
  begin
  end;//Handle
//#UC START# *484FAF4D03CCatom*
//#UC END# *484FAF4D03CCatom*
 end;//SubLayer
 // Para
 t_Para := DefineAutoType([t_Tag], 'Базовый параграф', ParaTag) As ParaTag;
 with t_Para do
 begin
  WrapperType := WevPara;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevParaInterfaceFactory;
  {$IfEnd} //k2ForEditor

  with DefineProperty(k2_attrRubber, t_Bool, '') do
  begin
   ReadOnly := true;
   DefaultValue := Ord(false);
   Stored := false;
  end;//Rubber
  with DefineProperty(k2_attrVisible, t_Bool, 'Видимый') do
  begin
   DefaultValue := Ord(true);
  end;//Visible
  with DefineProperty(k2_attrWidth, t_Inch, 'Ширина') do
  begin
  end;//Width
  with DefineProperty(k2_attrLeftIndent, t_Inch, 'Отступ слева') do
  begin
  end;//LeftIndent
  with DefineProperty(k2_attrRightIndent, t_Inch, 'Отступ справа') do
  begin
   DefaultValue := 0;
  end;//RightIndent
  with DefineProperty(k2_attrSpaceBefore, t_Inch, 'Отступ сверху') do
  begin
   DefaultValue := 0;
  end;//SpaceBefore
  with DefineProperty(k2_attrSpaceAfter, t_Inch, 'Отступ снизу') do
  begin
   DefaultValue := 0;
  end;//SpaceAfter
  with DefineProperty(k2_attrBackColor, t_Color, 'Цвет фона') do
  begin
   DefaultValue := clDefault;
  end;//BackColor
  with DefineProperty(k2_attrFrame, t_Frame, 'Рамка') do
  begin
  end;//Frame
  t_Para_Subs := DefineAutoType([t_OList], 'Базовый параграф Метки', Para_Subs_Tag) As Para_Subs_Tag;
  try
   t_Para_Subs.DefineChildren(t_SubLayer);
   DefineProperty(k2_attrSubs, t_Para_Subs, 'Метки');
   t_Para_Subs.Recalc;
  except
   FreeAndNil(t_Para_Subs);
  end;//try..except
  with t_Para_Subs.ArrayProp[k2_tiChildren] do
  begin
   SortIndex := k2_attrHandle;
   StoredChildProc := ParaSubsChildStored;
   Duplicates := l3_dupChange;
  end;//Subs
 end;//Para
 // Bookmark
 t_Bookmark := DefineType(k2_idBookmark {115}, [t_Sub], 'Закладка', BookmarkTag) As BookmarkTag;
 with t_Bookmark do
 begin
  AtomClass := BookmarkTagClass;
 end;//Bookmark
 // Mark
 t_Mark := DefineType(k2_idMark {116}, [t_Sub], 'Вспомогательный значок', MarkTag) As MarkTag;
 with t_Mark do
 begin
  AtomClass := MarkTagClass;
  with Tk2CustomProperty(Prop[k2_attrFlags]) do
  begin
   DefaultValue := 0;
   Stored := true;
  end;//Flags
 end;//Mark
 // DocumentSub
 t_DocumentSub := DefineType(k2_idDocumentSub {11}, [t_Sub], 'Метка в документе', DocumentSubTag) As DocumentSubTag;
 with t_DocumentSub do
 begin
  AtomClass := DocumentSubTagClass;
  with DefineProperty(k2_attrObject, t_Para, 'Параграф на котором стоит метка') do
  begin
   Shared := true;
   Stored := false;
  end;//Object
 end;//DocumentSub
 // DocSubLayer
 t_DocSubLayer := DefineType(k2_idDocSubLayer {18}, [t_SubLayer], 'Слой меток документа', DocSubLayerTag) As DocSubLayerTag;
 with t_DocSubLayer do
 begin
  with ArrayProp[k2_tiChildren] do
  begin
   Duplicates := l3_dupAssign;
   ChildType := t_DocumentSub;
  end;//
 end;//DocSubLayer
 // TextStyle
 t_TextStyle := DefineType(k2_idTextStyle {39}, [t_Style], 'Стиль оформления текста', TextStyleTag) As TextStyleTag;
 with t_TextStyle do
 begin
//#UC START# *484D2CBA0213atom1*
//#UC END# *484D2CBA0213atom1*
  with DefineProperty(k2_attrJustification, t_Justification, 'Выравнивание текста') do
  begin
   DefaultValue := Ord(ev_itLeft);
   EmptyMapping := k2_attrStyle;
  end;//Justification
  with DefineProperty(k2_attrVisible, t_Bool, 'Видимый') do
  begin
   DefaultValue := Ord(true);
   EmptyMapping := k2_attrStyle;
  end;//Visible
  with DefineProperty(k2_attrApply2Para, t_Bool, 'Параграфный') do
  begin
   DefaultValue := Ord(true);
   EmptyMapping := k2_attrStyle;
  end;//Apply2Para
  with DefineProperty(k2_attrLeftIndent, t_Inch, 'Левый отступ') do
  begin
   DefaultValue := 0;
   EmptyMapping := k2_attrStyle;
  end;//LeftIndent
  with DefineProperty(k2_attrRightIndent, t_Inch, 'Правый отступ') do
  begin
   DefaultValue := 0;
   EmptyMapping := k2_attrStyle;
  end;//RightIndent
  with DefineProperty(k2_attrFirstIndent, t_Inch, 'Отступ красной строки') do
  begin
   DefaultValue := def_FirstIndent;
   EmptyMapping := k2_attrStyle;
  end;//FirstIndent
  with DefineProperty(k2_attrFirstLineIndent, t_Inch, 'Отступ красной строки относительно левого отступа (пока не поддерживается)') do
  begin
   DefaultValue := def_FirstLineIndent;
   EmptyMapping := k2_attrStyle;
  end;//FirstLineIndent
  with DefineProperty(k2_attrWidth, t_Inch, 'Ширина (устарело)') do
  begin
   DefaultValue := def_inchNormalParaStyleWidth;
   EmptyMapping := k2_attrStyle;
  end;//Width
  with DefineProperty(k2_attrSpaceBefore, t_Inch, 'Отступ от предыдущего') do
  begin
   DefaultValue := 0;
   EmptyMapping := k2_attrStyle;
  end;//SpaceBefore
  with DefineProperty(k2_attrSpaceAfter, t_Inch, 'Отступ до следующего') do
  begin
   DefaultValue := 0;
   EmptyMapping := k2_attrStyle;
  end;//SpaceAfter
  with DefineProperty(k2_attrAllowHyphen, t_Bool, 'Разрешены переносы') do
  begin
   DefaultValue := Ord(false);
  end;//AllowHyphen
  with Tk2CustomProperty(Prop[k2_attrStyle]) do
  begin
   Shared := true;
   AtomType := t_TextStyle;
  end;//Style
  with DefineProperty(k2_attrCollapsable, t_Bool, '') do
  begin
   DefaultValue := Ord(false);
   EmptyMapping := k2_attrStyle;
  end;//Collapsable
  t_TextStyle_Header := DefineAutoType([t_OList], 'Стиль оформления текста Верхний колонтитул', TextStyle_Header_Tag) As TextStyle_Header_Tag;
  try
   t_TextStyle_Header.DefineChildren(t_Para);
   DefineProperty(k2_attrHeader, t_TextStyle_Header, 'Верхний колонтитул');
   t_TextStyle_Header.Recalc;
  except
   FreeAndNil(t_TextStyle_Header);
  end;//try..except
  with t_TextStyle_Header.ArrayProp[k2_tiChildren] do
  begin
   EmptyMapping := k2_attrStyle;
  end;//Header
  t_TextStyle_Footer := DefineAutoType([t_OList], 'Стиль оформления текста Нижний колонтитул', TextStyle_Footer_Tag) As TextStyle_Footer_Tag;
  try
   t_TextStyle_Footer.DefineChildren(t_Para);
   DefineProperty(k2_attrFooter, t_TextStyle_Footer, 'Нижний колонтитул');
   t_TextStyle_Footer.Recalc;
  except
   FreeAndNil(t_TextStyle_Footer);
  end;//try..except
  with t_TextStyle_Footer.ArrayProp[k2_tiChildren] do
  begin
   EmptyMapping := k2_attrStyle;
  end;//Footer
  with DefineProperty(k2_attrHeaderHasOwnSpace, t_Bool, '') do
  begin
   DefaultValue := Ord(true);
   EmptyMapping := k2_attrStyle;
  end;//HeaderHasOwnSpace
  with DefineProperty(k2_attrLineSpacing, t_Long, 'Интерлиньяж') do
  begin
   DefaultValue := Pred(High(Integer));
   EmptyMapping := k2_attrStyle;
  end;//LineSpacing
  with DefineProperty(k2_attrIsChangeableFont, t_Bool, 'Можно ли изменять шрифт стиля кнопками на тулбаре') do
  begin
   DefaultValue := Ord(true);
   EmptyMapping := k2_attrStyle;
  end;//IsChangeableFont
  with DefineProperty(k2_attrVisibleToUser, t_Bool, 'Включать ли в таблицу стилей для пользователя') do
  begin
   DefaultValue := Ord(true);
   EmptyMapping := k2_attrStyle;
  end;//VisibleToUser
  with DefineProperty(k2_attrVisibleToBlock, t_Bool, 'Стиль можно устанавливать на блоки.') do
  begin
   DefaultValue := Ord(false);
   EmptyMapping := k2_attrStyle;
  end;//VisibleToBlock
  with DefineProperty(k2_attrFont, t_Font, 'Шрифт') do
  begin
   EmptyMapping := k2_attrStyle;
  end;//Font
  with DefineProperty(k2_attrShortName, t_String, 'Заголовок, рисуемый перед параграфом данного стиля. Для {RequestLink:235050009}') do
  begin
  end;//ShortName
  with DefineProperty(k2_attrFrame, t_Frame, '') do
  begin
  end;//Frame
//#UC START# *484D2CBA0213atom*
  TevdStyleContainer.CheckValueTable(t_TextStyle);
//#UC END# *484D2CBA0213atom*
  Recalc;
  // Нормальный
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saTxtNormalANSI);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_TxtNormalANSI_Name_Value.AsStr;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itWidth);
    AddValue(Box);
   end;//with MakeTag.AsObject
  // псевдо-стиль, для объектных сегментов
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saObject);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_Object_Name_Value.AsStr;
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrBold, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrItalic, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrUnderline, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrStrikeout, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_Object_Font_Name_Value.AsStr;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Слово с опечаткой
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saMistake);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_Mistake_Name_Value.AsStr;
    BoolW[k2_attrApply2Para, Tk2NonOptimizeContext.Instance] := false;
    {$If not defined(Nemesis)}
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    {$IfEnd} //not Nemesis
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrBold, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrItalic, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrUnderline, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrStrikeout, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := clRed;
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrName, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Цветовое выделение
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saColorSelection);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_ColorSelection_Name_Value.AsStr;
    IntW[k2_attrVisible, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
    BoolW[k2_attrApply2Para, Tk2NonOptimizeContext.Instance] := false;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrName, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrPitch, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrBold, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrItalic, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrUnderline, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrStrikeout, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := clBlue;
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
     IntW[k2_attrIndex, Tk2NonOptimizeContext.Instance] := k2_TransparentValue;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Гипертекстовая ссылка
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saColorSelection;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saHyperLink);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_HyperLink_Name_Value.AsStr;
    BoolW[k2_attrApply2Para, Tk2NonOptimizeContext.Instance] := false;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := clGreen;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Стиль для интерфейсных элементов
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saInterface);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_Interface_Name_Value.AsStr;
    BoolW[k2_attrVisible, Tk2NonOptimizeContext.Instance] := true;
    BoolW[k2_attrIsChangeableFont, Tk2NonOptimizeContext.Instance] := false;
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    with cAtom(k2_attrFont) do
    begin
     StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_Interface_Font_Name_Value.AsStr;
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 10;
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := clWindowText;
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := clWindow;
     BoolW[k2_attrBold, Tk2NonOptimizeContext.Instance] := false;
     BoolW[k2_attrItalic, Tk2NonOptimizeContext.Instance] := false;
     BoolW[k2_attrUnderline, Tk2NonOptimizeContext.Instance] := false;
     BoolW[k2_attrStrikeout, Tk2NonOptimizeContext.Instance] := false;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Активная гиперссылка
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saHyperLink;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saActiveHyperlink);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_ActiveHyperLink_Name_Value.AsStr;
    {$If not defined(Nemesis)}
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    {$IfEnd} //not Nemesis
    with cAtom(k2_attrFont) do
    begin
     BoolW[k2_attrUnderline, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Нормальный для таблиц
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saNormalTable);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_NormalTable_Name_Value.AsStr;
    IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := 0;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itWidth);
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Центрированный в таблице
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saNormalTable;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saCenteredTable);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_CenteredTable_Name_Value.AsStr;
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itCenter);
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Выделение для Базового Поиска
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saColorSelection;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_ColorSelectionForBaseSearch_Name_Value.AsStr;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saColorSelectionForBaseSearch);
    {$If not defined(Nemesis)}
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    {$IfEnd} //not Nemesis
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := $00A95800;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Выделение для Базового Поиска (курсив)
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saColorSelectionForBaseSearch;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saItalicColorSelectionForBaseSearch);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_ItalicColorSelectionForBaseSearch_Name_Value.AsStr;
    {$If not defined(Nemesis)}
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    {$IfEnd} //not Nemesis
    with cAtom(k2_attrFont) do
    begin
     BoolW[k2_attrItalic, Tk2NonOptimizeContext.Instance] := true;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Текст диалогов
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saInterface;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_Dialogs_Name_Value.AsStr;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saDialogs);
    BoolW[k2_attrIsChangeableFont, Tk2NonOptimizeContext.Instance] := false;
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := clDefault;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saInterface;
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_TOC_Name_Value.AsStr;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saTOC);
    BoolW[k2_attrIsChangeableFont, Tk2NonOptimizeContext.Instance] := false;
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 10;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Внимание
   with MakeTag.AsObject do
   begin
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_Attention_Name_Value.AsStr;
    StrW[k2_attrShortName, Tk2NonOptimizeContext.Instance] := str_TextStyle_Attention_ShortName_Value.AsStr;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saAttention);
    IntW[k2_attrLeftIndent, Tk2NonOptimizeContext.Instance] := 420;
    IntW[k2_attrRightIndent, Tk2NonOptimizeContext.Instance] := 420;
    IntW[k2_attrSpaceBefore, Tk2NonOptimizeContext.Instance] := 240;
    IntW[k2_attrSpaceAfter, Tk2NonOptimizeContext.Instance] := 240;
    BoolW[k2_attrVisibleToBlock, Tk2NonOptimizeContext.Instance] := true;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := $DAF3F5;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Напишите нам
   with MakeTag.AsObject do
   begin
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saWriteToUs);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_WriteToUs_Name_Value.AsStr;
    BoolW[k2_attrIsChangeableFont, Tk2NonOptimizeContext.Instance] := false;
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := true;
    BoolW[k2_attrCollapsable, Tk2NonOptimizeContext.Instance] := true;
    IntW[k2_attrLeftIndent, Tk2NonOptimizeContext.Instance] := l3Inch div 8;
    IntW[k2_attrFirstIndent, Tk2NonOptimizeContext.Instance] := l3Inch div 8;
    IntW[k2_attrRightIndent, Tk2NonOptimizeContext.Instance] := l3Inch div 8;
    IntW[k2_attrFirstLineIndent, Tk2NonOptimizeContext.Instance] := l3Inch div 8;
    IntW[k2_attrSpaceBefore, Tk2NonOptimizeContext.Instance] := l3Inch div 16;
    IntW[k2_attrSpaceAfter, Tk2NonOptimizeContext.Instance] := l3Inch div 16;
    BoolW[k2_attrVisibleToBlock, Tk2NonOptimizeContext.Instance] := true;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrBackColor, Tk2NonOptimizeContext.Instance] := $ADFFEF;
     IntW[k2_attrSize, Tk2NonOptimizeContext.Instance] := 10;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saHyperLink;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saAbolishedDocumentLink);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_AbolishedDocumentLink_Name_Value.AsStr;
    BoolW[k2_attrApply2Para, Tk2NonOptimizeContext.Instance] := false;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := $329274;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
  // Стиль для оснонвого текста для ссылки на настройку новостной ленты.
   with MakeTag.AsObject do
   begin
    IntW[k2_attrJustification, Tk2NonOptimizeContext.Instance] := Ord(ev_itCenter);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_NewsConfigStyle_Name_Value.AsStr;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saNewsConfigHyperlink);
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    AddValue(Box);
   end;//with MakeTag.AsObject
   with MakeTag.AsObject do
   begin
    IntW[k2_attrStyle, Tk2NonOptimizeContext.Instance] := evd_saHyperLink;
    IntW[k2_attrHandle, Tk2NonOptimizeContext.Instance] := Ord(ev_saAACLeftHyperlink);
    StrW[k2_attrName, Tk2NonOptimizeContext.Instance] := str_TextStyle_AACHyperlink_Name_Value.AsStr;
    BoolW[k2_attrVisibleToUser, Tk2NonOptimizeContext.Instance] := false;
    with cAtom(k2_attrFont) do
    begin
     IntW[k2_attrForeColor, Tk2NonOptimizeContext.Instance] := clWhite;
    end;//with cAtom(k2_attrFont)
    AddValue(Box);
   end;//with MakeTag.AsObject
 end;//TextStyle
 // Segment
 t_Segment := DefineAutoType([t_Tag], 'Отрезок оформления', SegmentTag) As SegmentTag;
 with t_Segment do
 begin
  with DefineProperty(k2_attrStart, t_Position, 'Начало отрезка') do
  begin
   DefaultValue := 1;
  end;//Start
  with DefineProperty(k2_attrFinish, t_Position, 'Конец отрезка') do
  begin
   DefaultValue := Pred(High(Integer));
  end;//Finish
  with DefineProperty(k2_attrApply2Para, t_Bool, 'Применим к параграфу (не используется)') do
  begin
   DefaultValue := Ord(true);
   EmptyMapping := k2_attrStyle;
  end;//Apply2Para
  with DefineProperty(k2_attrStyle, t_Style, 'Стиль') do
  begin
   Shared := true;
  end;//Style
 end;//Segment
 // ActiveInterval
 t_ActiveInterval := DefineType(k2_idActiveInterval {84}, [t_NSRCTag], 'Интервал действия', ActiveIntervalTag) As ActiveIntervalTag;
 with t_ActiveInterval do
 begin
  AtomClass := ActiveIntervalTagClass;
  with DefineProperty(k2_attrHandle, t_Handle, 'Идентификатор') do
  begin
  end;//Handle
  with DefineProperty(k2_attrStart, t_Date, 'Дата начала') do
  begin
  end;//Start
  with DefineProperty(k2_attrComment, t_String, 'Комментарий') do
  begin
  end;//Comment
  with DefineProperty(k2_attrType, t_Type, 'Тип') do
  begin
  end;//Type
  with DefineProperty(k2_attrFinish, t_Date, 'Дата завершения') do
  begin
  end;//Finish
 end;//ActiveInterval
 // Alarm
 t_Alarm := DefineType(k2_idAlarm {85}, [t_NSRCTag], 'Интервал действия', AlarmTag) As AlarmTag;
 with t_Alarm do
 begin
  AtomClass := AlarmTagClass;
  with DefineProperty(k2_attrHandle, t_Handle, 'Идентификатор') do
  begin
  end;//Handle
  with DefineProperty(k2_attrStart, t_Date, 'Дата начала') do
  begin
  end;//Start
  with DefineProperty(k2_attrComment, t_String, 'Комментарий') do
  begin
  end;//Comment
  SetNeedMarkModifiedAllExcept(k2_attrName);
 end;//Alarm
 // LogRecordPrim
 t_LogRecordPrim := DefineAutoType([t_NSRCTag], '', LogRecordPrimTag) As LogRecordPrimTag;
 with t_LogRecordPrim do
 begin
  AtomClass := LogRecordPrimTagClass;
  with DefineProperty(k2_attrType, t_Type, 'Тип') do
  begin
  end;//Type
  with DefineProperty(k2_attrStart, t_Date, 'Дата начала') do
  begin
  end;//Start
 end;//LogRecordPrim
 // LogRecord
 t_LogRecord := DefineType(k2_idLogRecord {78}, [t_LogRecordPrim], '', LogRecordTag) As LogRecordTag;
 with t_LogRecord do
 begin
  AtomClass := LogRecordTagClass;
  with DefineProperty(k2_attrUser, t_DictItem, 'Пользователь') do
  begin
  end;//User
  with DefineProperty(k2_attrTime, t_Time, 'Время') do
  begin
  end;//Time
  SetNeedMarkModifiedAllExcept(k2_attrName);
 end;//LogRecord
 // StagePrim
 t_StagePrim := DefineAutoType([t_LogRecordPrim], '', StagePrimTag) As StagePrimTag;
 with t_StagePrim do
 begin
  AtomClass := StagePrimTagClass;
  with DefineProperty(k2_attrUser, t_DictItem, 'Пользователь') do
  begin
  end;//User
 end;//StagePrim
 // Stage
 t_Stage := DefineType(k2_idStage {80}, [t_StagePrim], 'Этап', StageTag) As StageTag;
 with t_Stage do
 begin
  AtomClass := StageTagClass;
  with DefineProperty(k2_attrFinish, t_Date, 'Дата окончания') do
  begin
  end;//Finish
  SetNeedMarkModifiedAllExcept(k2_attrName);
 end;//Stage
 // NumANDDate
 t_NumANDDate := DefineType(k2_idNumANDDate {82}, [t_LogRecordPrim], 'Дата/номер', NumANDDateTag) As NumANDDateTag;
 with t_NumANDDate do
 begin
  AtomClass := NumANDDateTagClass;
  with DefineProperty(k2_attrHandle, t_Handle, 'Идентификатор') do
  begin
  end;//Handle
  with DefineProperty(k2_attrNumber, t_String, 'Номер') do
  begin
  end;//Number
  with DefineProperty(k2_attrComment, t_String, 'Комментарий') do
  begin
  end;//Comment
  with DefineProperty(k2_attrDocID, t_Handle, 'Ссылка на документ (точнее - к Вовану)') do
  begin
  end;//DocID
  with DefineProperty(k2_attrLinkAddress, t_Address, '') do
  begin
  end;//LinkAddress
  SetNeedMarkModifiedAllExcept(k2_attrName);
 end;//NumANDDate
 // Check
 t_Check := DefineType(k2_idCheck {81}, [t_StagePrim], 'Вычитка', CheckTag) As CheckTag;
 with t_Check do
 begin
  AtomClass := CheckTagClass;
  with DefineProperty(k2_attrHandle, t_Handle, 'Идентификатор') do
  begin
  end;//Handle
  with DefineProperty(k2_attrSource, t_Long, 'Источник') do
  begin
  end;//Source
  with DefineProperty(k2_attrComment, t_String, 'Комментарий') do
  begin
  end;//Comment
  SetNeedMarkModifiedAllExcept(k2_attrName);
 end;//Check
 // PIRec
 t_PIRec := DefineType(k2_idPIRec {88}, [t_NSRCTag], 'Источник опубликования', PIRecTag) As PIRecTag;
 with t_PIRec do
 begin
  AtomClass := PIRecTagClass;
  with DefineProperty(k2_attrHandle, t_Handle, 'Идентификатор') do
  begin
  end;//Handle
  with DefineProperty(k2_attrSource, t_DictItemEx, 'Источник') do
  begin
  end;//Source
  with DefineProperty(k2_attrStart, t_Date, 'Дата начала') do
  begin
  end;//Start
  with DefineProperty(k2_attrFinish, t_Date, 'Дата окончания') do
  begin
  end;//Finish
  with DefineProperty(k2_attrNumber, t_String, 'Номер') do
  begin
  end;//Number
  with DefineProperty(k2_attrComment, t_String, 'Комментарий') do
  begin
  end;//Comment
  with DefineProperty(k2_attrPages, t_String, 'Страницы') do
  begin
  end;//Pages
  with DefineProperty(k2_attrLinkComment, t_String, 'Комментарий к связи документ->издание') do
  begin
  end;//LinkComment
  with DefineProperty(k2_attrIsPeriodic, t_Bool, '') do
  begin
   DefaultValue := Ord(true);
  end;//IsPeriodic
  with DefineProperty(k2_attrFlags, t_Long, 'http://mdp.garant.ru/pages/viewpage.action?pageId=336135727') do
  begin
  end;//Flags
  SetNeedMarkModifiedAllExcept(k2_attrName);
 end;//PIRec
 // TextSegment
 t_TextSegment := DefineType(k2_idTextSegment {13}, [t_Segment], 'Отрезок оформления текста', TextSegmentTag) As TextSegmentTag;
 with t_TextSegment do
 begin
  AtomClass := TextSegmentTagClass;
//#UC START# *484FDC4F013Fatom1*
//#UC END# *484FDC4F013Fatom1*
  with Tk2CustomProperty(Prop[k2_attrStyle]) do
  begin
   AtomType := t_TextStyle;
  end;//Style
  with DefineProperty(k2_attrFont, t_Font, 'Шрифт') do
  begin
   EmptyMapping := k2_attrStyle;
  end;//Font
  with DefineProperty(k2_attrVisible, t_Bool, 'Видимый') do
  begin
   DefaultValue := Ord(true);
   EmptyMapping := k2_attrStyle;
  end;//Visible
//#UC START# *484FDC4F013Fatom*
  ParamsForClone := l3LongArray([k2_tiStyle, k2_tiFont, k2_tiVisible]);
//#UC END# *484FDC4F013Fatom*
 end;//TextSegment
 // TabStop
 t_TabStop := DefineType(k2_idTabStop {114}, [t_Tag], 'Позиция табуляции', TabStopTag) As TabStopTag;
 with t_TabStop do
 begin
  AtomClass := TabStopTagClass;
  with DefineProperty(k2_attrStart, t_Inch, 'Позиция') do
  begin
  end;//Start
  t_TabStop_Type := DefineAutoType([t_Enum], 'Позиция табуляции Тип', TabStop_Type_Tag) As TabStop_Type_Tag;
  try
   t_TabStop_Type.AtomType := TypeInfo(Tl3TabStopStyle);
   DefineProperty(k2_attrType, t_TabStop_Type, 'Тип');
   t_TabStop_Type.Recalc;
  except
   FreeAndNil(t_TabStop_Type);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrType]) do
  begin
   DefaultValue := Ord(l3_tssLeft);
  end;//Type
  with DefineProperty(k2_attrText, t_String, 'Символ заполнитель') do
  begin
  end;//Text
 end;//TabStop
 // SegmentsLayer
 t_SegmentsLayer := DefineType(k2_idSegmentsLayer {19}, [t_OList, t_ObjectWithHandle], 'Слой отрезков оформления', SegmentsLayerTag) As SegmentsLayerTag;
 with t_SegmentsLayer do
 begin
  AtomClass := Tk2Layer;
//#UC START# *484FD1360343atom1*
  UndefineProperties([k2_tiHandle]);
//#UC END# *484FD1360343atom1*
  with DefineChildren(t_TextSegment) do
  begin
   SortIndex := k2_attrNative;
  end;//
  t_SegmentsLayer_Handle := DefineAutoType([t_Enum], 'Слой отрезков оформления Handle', SegmentsLayer_Handle_Tag) As SegmentsLayer_Handle_Tag;
  try
   t_SegmentsLayer_Handle.AtomType := TypeInfo(TevSegmentHandle);
   DefineProperty(k2_attrHandle, t_SegmentsLayer_Handle, '');
   t_SegmentsLayer_Handle.Recalc;
  except
   FreeAndNil(t_SegmentsLayer_Handle);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrHandle]) do
  begin
  end;//Handle
//#UC START# *484FD1360343atom*
//#UC END# *484FD1360343atom*
 end;//SegmentsLayer
 // SegmentWithChildren
 t_SegmentWithChildren := DefineAutoType([t_TextSegment], '', SegmentWithChildrenTag) As SegmentWithChildrenTag;
 with t_SegmentWithChildren do
 begin
  AtomClass := SegmentWithChildrenTagClass;
//#UC START# *54BE906C029Catom1*
//#UC END# *54BE906C029Catom1*
//#UC START# *54BE906C029Catom*
  ParamsForClone := l3CatLongArray(t_TextSegment.ParamsForClone, [k2_tiChildren]);
//#UC END# *54BE906C029Catom*
 end;//SegmentWithChildren
 // ObjectSegment
 t_ObjectSegment := DefineType(k2_idObjectSegment {51}, [t_SegmentWithChildren], 'Контейнер для объекта', ObjectSegmentTag) As ObjectSegmentTag;
 with t_ObjectSegment do
 begin
  AtomClass := ObjectSegmentTagClass;
  with Tk2CustomProperty(Prop[k2_attrStyle]) do
  begin
   ReadOnly := true;
   DefaultValue := ev_saObject;
  end;//Style
  with DefineChildren(t_Para) do
  begin
  end;//
  with DefineProperty(k2_attrBaseLine, t_Inch, 'Базовая линия') do
  begin
  end;//BaseLine
 end;//ObjectSegment
 // PageProperties
 t_PageProperties := DefineType(k2_idPageProperties {106}, [t_Tag], 'Свойства страницы', PagePropertiesTag) As PagePropertiesTag;
 with t_PageProperties do
 begin
  AtomClass := PagePropertiesTagClass;
  t_PageProperties_Orientation := DefineAutoType([t_Enum], 'Свойства страницы Ориентация', PageProperties_Orientation_Tag) As PageProperties_Orientation_Tag;
  try
   t_PageProperties_Orientation.AtomType := TypeInfo(TevPageOrientation);
   DefineProperty(k2_attrOrientation, t_PageProperties_Orientation, 'Ориентация');
   t_PageProperties_Orientation.Recalc;
  except
   FreeAndNil(t_PageProperties_Orientation);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrOrientation]) do
  begin
   DefaultValue := Ord(ev_poPortrait);
  end;//Orientation
  with DefineProperty(k2_attrWidth, t_Inch, 'Ширина') do
  begin
   DefaultValue := def_inchPaperWidth;
  end;//Width
  with DefineProperty(k2_attrHeight, t_Inch, 'Высота') do
  begin
   DefaultValue := def_inchPaperHeight;
  end;//Height
  with DefineProperty(k2_attrLeftIndent, t_Inch, 'Отступ слева') do
  begin
   DefaultValue := def_inchPaperLeft;
  end;//LeftIndent
  with DefineProperty(k2_attrRightIndent, t_Inch, 'Отступ справа') do
  begin
   DefaultValue := def_inchPaperRight;
  end;//RightIndent
  with DefineProperty(k2_attrSpaceBefore, t_Inch, 'Отступ сверху') do
  begin
   DefaultValue := def_inchPaperTop;
  end;//SpaceBefore
  with DefineProperty(k2_attrSpaceAfter, t_Inch, 'Отступ снизу') do
  begin
   DefaultValue := def_inchPaperBottom;
  end;//SpaceAfter
 end;//PageProperties
 // LeafPara
 t_LeafPara := DefineAutoType([t_Para], '"Листьевой" параграф', LeafParaTag) As LeafParaTag;
 with t_LeafPara do
 begin
  AtomClass := LeafParaTagClass;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevLeafParaInterfaceFactory;
  {$IfEnd} //k2ForEditor

  with DefineProperty(k2_attrContentsLevel, t_Long, 'Уровень оглавления') do
  begin
   DefaultValue := Pred(High(Integer));
  end;//ContentsLevel
  with Tk2CustomProperty(Prop[k2_attrRubber]) do
  begin
   DefaultValue := Ord(true);
  end;//Rubber
 end;//LeafPara
 // PageBreak
 t_PageBreak := DefineType(k2_idPageBreak {103}, [t_LeafPara], 'Разрыв страницы', PageBreakTag) As PageBreakTag;
 with t_PageBreak do
 begin
  AtomClass := PageBreakTagClass;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevPageBreakInterfaceFactory;
  {$IfEnd} //k2ForEditor

//#UC START# *48566A8103C1atom1*
//#UC END# *48566A8103C1atom1*
  with DefineProperty(k2_attrHeight, t_Inch, '') do
  begin
   ReadOnly := true;
   DefaultValue := l3Inch div 6;
  end;//Height
  with Tk2CustomProperty(Prop[k2_attrLeftIndent]) do
  begin
   ReadOnly := true;
   DefaultValue := 0;
  end;//LeftIndent
  with Tk2CustomProperty(Prop[k2_attrWidth]) do
  begin
   ReadOnly := true;
   DefaultValue := def_inchNormalParaStyleWidth;
  end;//Width
//#UC START# *48566A8103C1atom*
  UndefineProperties([k2_tiFrame, k2_tiSpaceBefore,
                      k2_tiSpaceAfter, k2_tiVisible, k2_tiRightIndent,
                      k2_tiBackColor]);
//#UC END# *48566A8103C1atom*
 end;//PageBreak
 // SectionBreak
 t_SectionBreak := DefineType(k2_idSectionBreak {104}, [t_PageBreak], 'Разрыв раздела', SectionBreakTag) As SectionBreakTag;
 with t_SectionBreak do
 begin
  AtomClass := SectionBreakTagClass;
  {$If defined(k2ForEditor)}
  InterfaceFactoryType := TevSectionBreakInterfaceFactory;
  {$IfEnd} //k2ForEditor

  with DefineProperty(k2_attrParas, t_PageProperties, 'Параметры страницы') do
  begin
  end;//Paras
 end;//SectionBreak
 // HyperLink
 t_HyperLink := DefineType(k2_idHyperLink {14}, [t_SegmentWithChildren, t_ObjectWithHandle], 'Гипертекстовая ссылка', HyperLinkTag) As HyperLinkTag;
 with t_HyperLink do
 begin
  AtomClass := HyperLinkTagClass;
  with Tk2CustomProperty(Prop[k2_attrApply2Para]) do
  begin
   DefaultValue := Ord(false);
  end;//Apply2Para
  with Tk2CustomProperty(Prop[k2_attrStyle]) do
  begin
   DefaultValue := ev_saHyperlink;
  end;//Style
  with DefineProperty(k2_attrURL, t_String, 'Путь') do
  begin
  end;//URL
  with DefineChildren(t_Address) do
  begin
   SetSortTags([k2_tiDocID, k2_tiSubID]);
  end;//Address
 end;//HyperLink
 t_Justification.Recalc;
 t_Bullet.Recalc;
 t_Date.Recalc;
 t_Position.Recalc;
 t_Time.Recalc;
 t_ObjectWithHandle.Recalc;
 t_Font.Recalc;
 t_Style.Recalc;
 t_FramePart.Recalc;
 t_Frame.Recalc;
 t_NSRCTag.Recalc;
 t_DictRec.Recalc;
 t_DictItem.Recalc;
 t_AutoClass.Recalc;
 t_DictItemEx.Recalc;
 t_Sub.Recalc;
 t_SubLayer.Recalc;
 t_Para.Recalc;
 t_Bookmark.Recalc;
 t_Mark.Recalc;
 t_DocumentSub.Recalc;
 t_DocSubLayer.Recalc;
 t_TextStyle.Recalc;
 t_Segment.Recalc;
 t_ActiveInterval.Recalc;
 t_Alarm.Recalc;
 t_LogRecordPrim.Recalc;
 t_LogRecord.Recalc;
 t_StagePrim.Recalc;
 t_Stage.Recalc;
 t_NumANDDate.Recalc;
 t_Check.Recalc;
 t_PIRec.Recalc;
 t_TextSegment.Recalc;
 t_TabStop.Recalc;
 t_SegmentsLayer.Recalc;
 t_SegmentWithChildren.Recalc;
 t_ObjectSegment.Recalc;
 t_PageProperties.Recalc;
 t_LeafPara.Recalc;
 t_PageBreak.Recalc;
 t_SectionBreak.Recalc;
 t_HyperLink.Recalc;
end;

// определяем стандартные методы схемы


procedure TevdNativeSchema.Cleanup;
begin
 t_Justification.InterfaceFactory := nil;
 t_Bullet.InterfaceFactory := nil;
 t_Date.InterfaceFactory := nil;
 t_Position.InterfaceFactory := nil;
 t_Time.InterfaceFactory := nil;
 t_ObjectWithHandle.InterfaceFactory := nil;
 t_Font.InterfaceFactory := nil;
 t_Font_Index.InterfaceFactory := nil;
 t_Font_Pitch.InterfaceFactory := nil;
 t_Style.InterfaceFactory := nil;
 t_FramePart.InterfaceFactory := nil;
 t_Frame.InterfaceFactory := nil;
 t_NSRCTag.InterfaceFactory := nil;
 t_DictRec.InterfaceFactory := nil;
 t_DictItem.InterfaceFactory := nil;
 t_DictItem_Flags.InterfaceFactory := nil;
 t_AutoClass.InterfaceFactory := nil;
 t_DictItemEx.InterfaceFactory := nil;
 t_Sub.InterfaceFactory := nil;
 t_Sub_Classes.InterfaceFactory := nil;
 t_Sub_AutoClasses.InterfaceFactory := nil;
 t_Sub_Types.InterfaceFactory := nil;
 t_Sub_KeyWords.InterfaceFactory := nil;
 t_Sub_Prefix.InterfaceFactory := nil;
 t_Sub_ServiceInfo.InterfaceFactory := nil;
 t_SubLayer.InterfaceFactory := nil;
 t_SubLayer_Handle.InterfaceFactory := nil;
 t_Para.InterfaceFactory := nil;
 t_Para_Subs.InterfaceFactory := nil;
 t_Bookmark.InterfaceFactory := nil;
 t_Mark.InterfaceFactory := nil;
 t_DocumentSub.InterfaceFactory := nil;
 t_DocSubLayer.InterfaceFactory := nil;
 t_TextStyle.InterfaceFactory := nil;
 t_TextStyle_Header.InterfaceFactory := nil;
 t_TextStyle_Footer.InterfaceFactory := nil;
 t_Segment.InterfaceFactory := nil;
 t_ActiveInterval.InterfaceFactory := nil;
 t_Alarm.InterfaceFactory := nil;
 t_LogRecordPrim.InterfaceFactory := nil;
 t_LogRecord.InterfaceFactory := nil;
 t_StagePrim.InterfaceFactory := nil;
 t_Stage.InterfaceFactory := nil;
 t_NumANDDate.InterfaceFactory := nil;
 t_Check.InterfaceFactory := nil;
 t_PIRec.InterfaceFactory := nil;
 t_TextSegment.InterfaceFactory := nil;
 t_TabStop.InterfaceFactory := nil;
 t_TabStop_Type.InterfaceFactory := nil;
 t_SegmentsLayer.InterfaceFactory := nil;
 t_SegmentsLayer_Handle.InterfaceFactory := nil;
 t_SegmentWithChildren.InterfaceFactory := nil;
 t_ObjectSegment.InterfaceFactory := nil;
 t_PageProperties.InterfaceFactory := nil;
 t_PageProperties_Orientation.InterfaceFactory := nil;
 t_LeafPara.InterfaceFactory := nil;
 t_PageBreak.InterfaceFactory := nil;
 t_SectionBreak.InterfaceFactory := nil;
 t_HyperLink.InterfaceFactory := nil;
 FreeAndNil(t_Justification);
 FreeAndNil(t_Bullet);
 FreeAndNil(t_Date);
 FreeAndNil(t_Position);
 FreeAndNil(t_Time);
 FreeAndNil(t_ObjectWithHandle);
 FreeAndNil(t_Font);
 FreeAndNil(t_Font_Index);
 FreeAndNil(t_Font_Pitch);
 FreeAndNil(t_Style);
 FreeAndNil(t_FramePart);
 FreeAndNil(t_Frame);
 FreeAndNil(t_NSRCTag);
 FreeAndNil(t_DictRec);
 FreeAndNil(t_DictItem);
 FreeAndNil(t_DictItem_Flags);
 FreeAndNil(t_AutoClass);
 FreeAndNil(t_DictItemEx);
 FreeAndNil(t_Sub);
 FreeAndNil(t_Sub_Classes);
 FreeAndNil(t_Sub_AutoClasses);
 FreeAndNil(t_Sub_Types);
 FreeAndNil(t_Sub_KeyWords);
 FreeAndNil(t_Sub_Prefix);
 FreeAndNil(t_Sub_ServiceInfo);
 FreeAndNil(t_SubLayer);
 FreeAndNil(t_SubLayer_Handle);
 FreeAndNil(t_Para);
 FreeAndNil(t_Para_Subs);
 FreeAndNil(t_Bookmark);
 FreeAndNil(t_Mark);
 FreeAndNil(t_DocumentSub);
 FreeAndNil(t_DocSubLayer);
 FreeAndNil(t_TextStyle);
 FreeAndNil(t_TextStyle_Header);
 FreeAndNil(t_TextStyle_Footer);
 FreeAndNil(t_Segment);
 FreeAndNil(t_ActiveInterval);
 FreeAndNil(t_Alarm);
 FreeAndNil(t_LogRecordPrim);
 FreeAndNil(t_LogRecord);
 FreeAndNil(t_StagePrim);
 FreeAndNil(t_Stage);
 FreeAndNil(t_NumANDDate);
 FreeAndNil(t_Check);
 FreeAndNil(t_PIRec);
 FreeAndNil(t_TextSegment);
 FreeAndNil(t_TabStop);
 FreeAndNil(t_TabStop_Type);
 FreeAndNil(t_SegmentsLayer);
 FreeAndNil(t_SegmentsLayer_Handle);
 FreeAndNil(t_SegmentWithChildren);
 FreeAndNil(t_ObjectSegment);
 FreeAndNil(t_PageProperties);
 FreeAndNil(t_PageProperties_Orientation);
 FreeAndNil(t_LeafPara);
 FreeAndNil(t_PageBreak);
 FreeAndNil(t_SectionBreak);
 FreeAndNil(t_HyperLink);
 inherited;
end;


initialization
 TevdNativeSchema.SetAsDefault;

end.