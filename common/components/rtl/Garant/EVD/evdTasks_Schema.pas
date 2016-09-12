unit evdTasks_Schema;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/evdTasks_Schema.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TagTable::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks
//
// Схема для поддержки заданий в ALCU. Потом её надо будет выпилить отдельно
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  evdTypes,
  k2Native_Schema,
  evdTaskTypes,
  evdDTTypes,
  evdNcsTypes,
  l3MarshalledTypes,
  l3Variant {a},
  k2Base {a},
  l3Interfaces {a},
  k2Interfaces {a},
  k2TypedAtomicTag {a},
  k2TypedSmallLeafTag {a},
  k2ParentedTypedSmallLeafTag {a},
  k2ParentedTypedHugeLeafTag {a}
  ;

type
 ULongAtomClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "ULong" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ULongAtomClass

 ULongAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ULongAtom

 DateTimeTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "DateTime" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//DateTimeTagClass

 DateTimeTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DateTimeTag

 DateTimeNotNullTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "DateTimeNotNull" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//DateTimeNotNullTagClass

 DateTimeNotNullTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DateTimeNotNullTag

 TaskTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "Task" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TaskTagClass

 TaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TaskTag

 Task_TaskType_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Task_TaskType" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//Task_TaskType_TagClass

 Task_TaskType_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Task_TaskType_Tag

 RequestTaskTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "RequestTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//RequestTaskTagClass

 RequestTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//RequestTaskTag

 TypeAtomClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Type" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TypeAtomClass

 TypeAtom = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TypeAtom

 AddressTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "Address" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AddressTagClass

 AddressTag = class(Tk2Type)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AddressTag

 Address_ViewKind_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "Address_ViewKind" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//Address_ViewKind_TagClass

 Address_ViewKind_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//Address_ViewKind_Tag

 ProcessTaskTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "ProcessTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ProcessTaskTagClass

 ProcessTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ProcessTaskTag

 ProcessTask_Status_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "ProcessTask_Status" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//ProcessTask_Status_TagClass

 ProcessTask_Status_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//ProcessTask_Status_Tag

 ProcessTask_DocumentIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//ProcessTask_DocumentIDList_Tag

 ExportTaskTagClass = class(Tk2ParentedTypedHugeLeafTag)
  {* Класс реализации тега "ExportTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ExportTaskTagClass

 ExportTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ExportTaskTag

 ExportTask_DiapasonType_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "ExportTask_DiapasonType" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//ExportTask_DiapasonType_TagClass

 ExportTask_DiapasonType_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//ExportTask_DiapasonType_Tag

 ExportTask_OutFileType_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "ExportTask_OutFileType" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//ExportTask_OutFileType_TagClass

 ExportTask_OutFileType_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//ExportTask_OutFileType_Tag

 ExportTask_SeparateFiles_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "ExportTask_SeparateFiles" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//ExportTask_SeparateFiles_TagClass

 ExportTask_SeparateFiles_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//ExportTask_SeparateFiles_Tag

 ExportTask_SABStream_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//ExportTask_SABStream_Tag

 ExportTask_RegionIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//ExportTask_RegionIDList_Tag

 DictEditQueryTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "DictEditQuery" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//DictEditQueryTagClass

 DictEditQueryTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DictEditQueryTag

 UserEditQueryTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "UserEditQuery" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//UserEditQueryTagClass

 UserEditQueryTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//UserEditQueryTag

 PlainFileTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "PlainFile" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//PlainFileTagClass

 PlainFileTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//PlainFileTag

 AutoSpellTaskTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "AutoSpellTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AutoSpellTaskTagClass

 AutoSpellTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AutoSpellTaskTag

 CommonDataRequestTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "CommonDataRequest" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//CommonDataRequestTagClass

 CommonDataRequestTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//CommonDataRequestTag

 LineRequestTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "LineRequest" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//LineRequestTagClass

 LineRequestTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//LineRequestTag

 ServerStatusRequestTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "ServerStatusRequest" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ServerStatusRequestTagClass

 ServerStatusRequestTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ServerStatusRequestTag

 DeleteDocsQueryTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "DeleteDocsQuery" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//DeleteDocsQueryTagClass

 DeleteDocsQueryTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DeleteDocsQueryTag

 TaskResultRequestTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "TaskResultRequest" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TaskResultRequestTagClass

 TaskResultRequestTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TaskResultRequestTag

 GetTaskRequestTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "GetTaskRequest" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//GetTaskRequestTagClass

 GetTaskRequestTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//GetTaskRequestTag

 AutoClassTaskTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "AutoClassTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AutoClassTaskTagClass

 AutoClassTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AutoClassTaskTag

 AnnotationTaskTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "AnnotationTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AnnotationTaskTagClass

 AnnotationTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AnnotationTaskTag

 AnnotationTask_BelongsIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AnnotationTask_BelongsIDList_Tag

{$If not defined(Region)}

 AnnotationTask_ExcludeAccGroupsIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AnnotationTask_ExcludeAccGroupsIDList_Tag
{$IfEnd} //not Region

 AnnotationTask_AccGroupsIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AnnotationTask_AccGroupsIDList_Tag

 AnnotationTask_CommentsIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AnnotationTask_CommentsIDList_Tag

 AnnotationTask_ExcludeDocTypesIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AnnotationTask_ExcludeDocTypesIDList_Tag

 AnnotationTask_ExcludeDocBasesIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AnnotationTask_ExcludeDocBasesIDList_Tag

 AutoExportTaskTagClass = class(Tk2ParentedTypedHugeLeafTag)
  {* Класс реализации тега "AutoExportTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AutoExportTaskTagClass

 AutoExportTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AutoExportTaskTag

 AutoExportTask_OutFormat_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "AutoExportTask_OutFormat" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//AutoExportTask_OutFormat_TagClass

 AutoExportTask_OutFormat_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AutoExportTask_OutFormat_Tag

 AutoExportTask_DocumentsSource_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "AutoExportTask_DocumentsSource" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//AutoExportTask_DocumentsSource_TagClass

 AutoExportTask_DocumentsSource_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AutoExportTask_DocumentsSource_Tag

 AutoExportTask_AccGroupsIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AutoExportTask_AccGroupsIDList_Tag

{$If not defined(LUK) AND not defined(SGC)}

 AutoExportTask_BasesIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AutoExportTask_BasesIDList_Tag
{$IfEnd} //not LUK AND not SGC

 AutoExportTask_InfoIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AutoExportTask_InfoIDList_Tag

 AutoExportTask_Stages_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "AutoExportTask_Stages" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//AutoExportTask_Stages_TagClass

 AutoExportTask_Stages_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AutoExportTask_Stages_Tag

 RunCommandTaskTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "RunCommandTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//RunCommandTaskTagClass

 RunCommandTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//RunCommandTaskTag

 FileTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "File" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//FileTagClass

 FileTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//FileTag

 File_AdditionalFiles_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//File_AdditionalFiles_Tag

 CaseCodeTaskTagClass = class(Tk2ParentedTypedHugeLeafTag)
  {* Класс реализации тега "CaseCodeTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//CaseCodeTaskTagClass

 CaseCodeTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//CaseCodeTaskTag

 AutoAnnoExportTaskTagClass = class(Tk2ParentedTypedHugeLeafTag)
  {* Класс реализации тега "AutoAnnoExportTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AutoAnnoExportTaskTagClass

 AutoAnnoExportTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AutoAnnoExportTaskTag

 AutoAnnoExportTask_BelongsIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AutoAnnoExportTask_BelongsIDList_Tag

 ImportTaskTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "ImportTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ImportTaskTagClass

 ImportTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ImportTaskTag

 ImportTask_SourceFiles_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//ImportTask_SourceFiles_Tag

 ImportTask_RegionIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//ImportTask_RegionIDList_Tag

 SpellCorrectTaskTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "SpellCorrectTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//SpellCorrectTaskTagClass

 SpellCorrectTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//SpellCorrectTaskTag

 SpellCorrectTask_ReplacementFile_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//SpellCorrectTask_ReplacementFile_Tag

 UserDefinedExportTaskTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "UserDefinedExportTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//UserDefinedExportTaskTagClass

 UserDefinedExportTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//UserDefinedExportTaskTag

 CourtDecisionPhraseTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "CourtDecisionPhrase" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//CourtDecisionPhraseTagClass

 CourtDecisionPhraseTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//CourtDecisionPhraseTag

 ClientMessageTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "ClientMessage" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ClientMessageTagClass

 ClientMessageTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ClientMessageTag

 ClientMessage_NotifyType_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "ClientMessage_NotifyType" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//ClientMessage_NotifyType_TagClass

 ClientMessage_NotifyType_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//ClientMessage_NotifyType_Tag

 AnoncedExportTaskTagClass = class(Tk2ParentedTypedHugeLeafTag)
  {* Класс реализации тега "AnoncedExportTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AnoncedExportTaskTagClass

 AnoncedExportTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AnoncedExportTaskTag

 AnoncedExportTask_AccGroupsIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AnoncedExportTask_AccGroupsIDList_Tag

 HavanskyExportTaskTagClass = class(Tk2ParentedTypedHugeLeafTag)
  {* Класс реализации тега "HavanskyExportTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//HavanskyExportTaskTagClass

 HavanskyExportTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//HavanskyExportTaskTag

 TaskResultTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "TaskResult" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TaskResultTagClass

 TaskResultTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TaskResultTag

 ImportTaskResultTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "ImportTaskResult" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ImportTaskResultTagClass

 ImportTaskResultTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ImportTaskResultTag

 ImportTaskResult_ImportedDocList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//ImportTaskResult_ImportedDocList_Tag

 RelPublishTaskResultTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "RelPublishTaskResult" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//RelPublishTaskResultTagClass

 RelPublishTaskResultTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//RelPublishTaskResultTag

 AACImportTaskResultTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "AACImportTaskResult" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AACImportTaskResultTagClass

 AACImportTaskResultTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AACImportTaskResultTag

 CourtDescriptionTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "CourtDescription" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//CourtDescriptionTagClass

 CourtDescriptionTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//CourtDescriptionTag

 CourtDescription_DecisionPhrases_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//CourtDescription_DecisionPhrases_Tag

 CourtDecisionSabCheckerParamsTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "CourtDecisionSabCheckerParams" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//CourtDecisionSabCheckerParamsTagClass

 CourtDecisionSabCheckerParamsTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//CourtDecisionSabCheckerParamsTag

 CourtDecisionSabCheckerParams_CourtsList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//CourtDecisionSabCheckerParams_CourtsList_Tag

 AACImportTagClass = class(Tk2ParentedTypedHugeLeafTag)
  {* Класс реализации тега "AACImport" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AACImportTagClass

 AACImportTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AACImportTag

 AACImport_SourceIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AACImport_SourceIDList_Tag

 AACImport_DossierSourceIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AACImport_DossierSourceIDList_Tag

 AACImport_DocTypesIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AACImport_DocTypesIDList_Tag

 AACImport_FASSourceIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AACImport_FASSourceIDList_Tag

 AutoClassTaskResultTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "AutoClassTaskResult" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AutoClassTaskResultTagClass

 AutoClassTaskResultTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AutoClassTaskResultTag

 AutoClassTaskResult_DocumentIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//AutoClassTaskResult_DocumentIDList_Tag

 AnnotationTaskResultTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "AnnotationTaskResult" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AnnotationTaskResultTagClass

 AnnotationTaskResultTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AnnotationTaskResultTag

 AutoSpellTaskResultTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "AutoSpellTaskResult" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AutoSpellTaskResultTagClass

 AutoSpellTaskResultTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AutoSpellTaskResultTag

 AutoExportTaskResultTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "AutoExportTaskResult" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//AutoExportTaskResultTagClass

 AutoExportTaskResultTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//AutoExportTaskResultTag

 FTPBrowserTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "FTPBrowser" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//FTPBrowserTagClass

 FTPBrowserTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//FTPBrowserTag

 RegionAutoExportTaskTagClass = class(Tk2ParentedTypedHugeLeafTag)
  {* Класс реализации тега "RegionAutoExportTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//RegionAutoExportTaskTagClass

 RegionAutoExportTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//RegionAutoExportTaskTag

 RegionImportTaskTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "RegionImportTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//RegionImportTaskTagClass

 RegionImportTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//RegionImportTaskTag

 RegionImportTaskResultTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "RegionImportTaskResult" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//RegionImportTaskResultTagClass

 RegionImportTaskResultTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//RegionImportTaskResultTag

 DataProviderParamsTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "DataProviderParams" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//DataProviderParamsTagClass

 DataProviderParamsTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DataProviderParamsTag

 HyTechProviderParamsTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "HyTechProviderParams" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//HyTechProviderParamsTagClass

 HyTechProviderParamsTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//HyTechProviderParamsTag

 PostgresProviderParamsTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "PostgresProviderParams" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//PostgresProviderParamsTagClass

 PostgresProviderParamsTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//PostgresProviderParamsTag

 csMessageTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csMessage" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csMessageTagClass

 csMessageTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csMessageTag

 csMessage_Kind_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "csMessage_Kind" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//csMessage_Kind_TagClass

 csMessage_Kind_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//csMessage_Kind_Tag

 csLoginTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csLogin" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csLoginTagClass

 csLoginTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csLoginTag

 csLoginReplyTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csLoginReply" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csLoginReplyTagClass

 csLoginReplyTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csLoginReplyTag

 csMessageWithReplyTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csMessageWithReply" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csMessageWithReplyTagClass

 csMessageWithReplyTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csMessageWithReplyTag

 TaskIDTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "TaskID" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TaskIDTagClass

 TaskIDTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TaskIDTag

 csReplyTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csReply" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csReplyTagClass

 csReplyTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csReplyTag

 csGetReadyToDeliveryTasksReplyTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csGetReadyToDeliveryTasksReply" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csGetReadyToDeliveryTasksReplyTagClass

 csGetReadyToDeliveryTasksReplyTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csGetReadyToDeliveryTasksReplyTag

 csGetReadyToDeliveryTasksReply_TasksIDList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//csGetReadyToDeliveryTasksReply_TasksIDList_Tag

 csGetReadyToDeliveryTasksTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csGetReadyToDeliveryTasks" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csGetReadyToDeliveryTasksTagClass

 csGetReadyToDeliveryTasksTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csGetReadyToDeliveryTasksTag

 csGetTaskDescriptionTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csGetTaskDescription" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csGetTaskDescriptionTagClass

 csGetTaskDescriptionTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csGetTaskDescriptionTag

 FileDescTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "FileDesc" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//FileDescTagClass

 FileDescTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//FileDescTag

 csGetTaskDescriptionReplyTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csGetTaskDescriptionReply" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csGetTaskDescriptionReplyTagClass

 csGetTaskDescriptionReplyTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csGetTaskDescriptionReplyTag

 csGetTaskDescriptionReply_FileDesc_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//csGetTaskDescriptionReply_FileDesc_Tag

 TaskedFileDescTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "TaskedFileDesc" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//TaskedFileDescTagClass

 TaskedFileDescTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//TaskedFileDescTag

 csTaskProgressTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csTaskProgress" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csTaskProgressTagClass

 csTaskProgressTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csTaskProgressTag

 csDeliveryResultTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csDeliveryResult" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csDeliveryResultTagClass

 csDeliveryResultTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csDeliveryResultTag

 csDeliveryResult_ResultKind_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "csDeliveryResult_ResultKind" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//csDeliveryResult_ResultKind_TagClass

 csDeliveryResult_ResultKind_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//csDeliveryResult_ResultKind_Tag

 csGetFilePartTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csGetFilePart" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csGetFilePartTagClass

 csGetFilePartTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csGetFilePartTag

 csGetFilePartReplyTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csGetFilePartReply" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csGetFilePartReplyTagClass

 csGetFilePartReplyTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csGetFilePartReplyTag

 csDisconnectTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csDisconnect" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csDisconnectTagClass

 csDisconnectTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csDisconnectTag

 csDisconnectReplyTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csDisconnectReply" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csDisconnectReplyTagClass

 csDisconnectReplyTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csDisconnectReplyTag

 csSendTaskTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csSendTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csSendTaskTagClass

 csSendTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csSendTaskTag

 csSendTaskReplyTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csSendTaskReply" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csSendTaskReplyTagClass

 csSendTaskReplyTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csSendTaskReplyTag

 csPushFilePartTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csPushFilePart" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csPushFilePartTagClass

 csPushFilePartTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csPushFilePartTag

 csCorrectFolderTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csCorrectFolder" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csCorrectFolderTagClass

 csCorrectFolderTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csCorrectFolderTag

 RelPublishTaskTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "RelPublishTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//RelPublishTaskTagClass

 RelPublishTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//RelPublishTaskTag

 csGetPartialTaskDescriptionTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csGetPartialTaskDescription" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csGetPartialTaskDescriptionTagClass

 csGetPartialTaskDescriptionTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csGetPartialTaskDescriptionTag

 mdpSyncTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "mdpSync" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//mdpSyncTagClass

 mdpSyncTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//mdpSyncTag

 mdpImportDocsTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "mdpImportDocs" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//mdpImportDocsTagClass

 mdpImportDocsTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//mdpImportDocsTag

 ComboAccessProviderParamsTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "ComboAccessProviderParams" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ComboAccessProviderParamsTagClass

 ComboAccessProviderParamsTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ComboAccessProviderParamsTag

 ContainerTaskTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "ContainerTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//ContainerTaskTagClass

 ContainerTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//ContainerTaskTag

 ContainerTask_TasksList_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//ContainerTask_TasksList_Tag

 SchedulerProxyTaskTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "SchedulerProxyTask" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//SchedulerProxyTaskTagClass

 SchedulerProxyTaskTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//SchedulerProxyTaskTag

 mdpSyncDictsTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "mdpSyncDicts" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//mdpSyncDictsTagClass

 mdpSyncDictsTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//mdpSyncDictsTag

 mdpSyncStagesTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "mdpSyncStages" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//mdpSyncStagesTagClass

 mdpSyncStagesTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//mdpSyncStagesTag

 mdpSyncImportTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "mdpSyncImport" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//mdpSyncImportTagClass

 mdpSyncImportTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//mdpSyncImportTag

 FoundSelectorTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//FoundSelectorTag

 csDownloadDocStreamReplyTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csDownloadDocStreamReply" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csDownloadDocStreamReplyTagClass

 csDownloadDocStreamReplyTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csDownloadDocStreamReplyTag

 csDownloadDocStreamTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csDownloadDocStream" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csDownloadDocStreamTagClass

 csDownloadDocStreamTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csDownloadDocStreamTag

 csDownloadDocStream_FoundSelector_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//csDownloadDocStream_FoundSelector_Tag

 csDownloadDocStream_DocPart_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "csDownloadDocStream_DocPart" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//csDownloadDocStream_DocPart_TagClass

 csDownloadDocStream_DocPart_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//csDownloadDocStream_DocPart_Tag

 csDownloadDocStream_DocPartSel_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "csDownloadDocStream_DocPartSel" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//csDownloadDocStream_DocPartSel_TagClass

 csDownloadDocStream_DocPartSel_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//csDownloadDocStream_DocPartSel_Tag

 DownloadDocRequestTagClass = class(Tk2ParentedTypedSmallLeafTag)
  {* Класс реализации тега "DownloadDocRequest" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//DownloadDocRequestTagClass

 DownloadDocRequestTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//DownloadDocRequestTag

 csUploadDocStreamTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csUploadDocStream" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csUploadDocStreamTagClass

 csUploadDocStreamTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csUploadDocStreamTag

 csUploadDocStream_DocPart_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "csUploadDocStream_DocPart" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//csUploadDocStream_DocPart_TagClass

 csUploadDocStream_DocPart_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//csUploadDocStream_DocPart_Tag

 csUploadDocStream_DocClass_TagClass = class(Tk2TypedAtomicTag)
  {* Класс реализации тега "csUploadDocStream_DocClass" }
 protected
 // realized methods
  function GetTagType: Tl3Type; override;
   {* Тип параграфа }
 end;//csUploadDocStream_DocClass_TagClass

 csUploadDocStream_DocClass_Tag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
   function DoMakeTag(aRef : Integer): Il3TagRef; override;
 end;//csUploadDocStream_DocClass_Tag

 csUploadDocStreamReplyTagClass = class(Tk2TypedSmallLeafTag)
  {* Класс реализации тега "csUploadDocStreamReply" }
 protected
 // realized methods
   function GetTagType: Tl3Type; override;
     {* Тип параграфа }
 end;//csUploadDocStreamReplyTagClass

 csUploadDocStreamReplyTag = class(Tk2AutoType)
 protected
   function GetAsPCharLen: Tl3PCharLenPrim; override;
   function GetIsKindOf(anAtomType: Tk2TypePrim): Boolean; override;
 public
   function DoMakeTag(aRef: Integer): Il3TagRef; override;
 end;//csUploadDocStreamReplyTag

 TevdTasksSchema = class(Tk2NativeSchema)
 public
 // типы, определённые в данной схеме:
   t_ULong : ULongAtom;
   t_DateTime : DateTimeTag;
   t_DateTimeNotNull : DateTimeNotNullTag;
   t_Task : TaskTag;
   t_Task_TaskType : Task_TaskType_Tag;
   t_RequestTask : RequestTaskTag;
   t_Type : TypeAtom;
   t_Address : AddressTag;
   t_Address_ViewKind : Address_ViewKind_Tag;
   t_ProcessTask : ProcessTaskTag;
   t_ProcessTask_Status : ProcessTask_Status_Tag;
   t_ProcessTask_DocumentIDList : ProcessTask_DocumentIDList_Tag;
   t_ExportTask : ExportTaskTag;
   t_ExportTask_DiapasonType : ExportTask_DiapasonType_Tag;
   t_ExportTask_OutFileType : ExportTask_OutFileType_Tag;
   t_ExportTask_SeparateFiles : ExportTask_SeparateFiles_Tag;
   t_ExportTask_SABStream : ExportTask_SABStream_Tag;
   t_ExportTask_RegionIDList : ExportTask_RegionIDList_Tag;
   t_DictEditQuery : DictEditQueryTag;
   t_UserEditQuery : UserEditQueryTag;
   t_PlainFile : PlainFileTag;
   t_AutoSpellTask : AutoSpellTaskTag;
   t_CommonDataRequest : CommonDataRequestTag;
   t_LineRequest : LineRequestTag;
   t_ServerStatusRequest : ServerStatusRequestTag;
   t_DeleteDocsQuery : DeleteDocsQueryTag;
   t_TaskResultRequest : TaskResultRequestTag;
   t_GetTaskRequest : GetTaskRequestTag;
   t_AutoClassTask : AutoClassTaskTag;
   t_AnnotationTask : AnnotationTaskTag;
   t_AnnotationTask_BelongsIDList : AnnotationTask_BelongsIDList_Tag;
   {$If not defined(Region)}
   t_AnnotationTask_ExcludeAccGroupsIDList : AnnotationTask_ExcludeAccGroupsIDList_Tag;
   {$IfEnd} //not Region
   t_AnnotationTask_AccGroupsIDList : AnnotationTask_AccGroupsIDList_Tag;
   t_AnnotationTask_CommentsIDList : AnnotationTask_CommentsIDList_Tag;
   t_AnnotationTask_ExcludeDocTypesIDList : AnnotationTask_ExcludeDocTypesIDList_Tag;
   t_AnnotationTask_ExcludeDocBasesIDList : AnnotationTask_ExcludeDocBasesIDList_Tag;
   t_AutoExportTask : AutoExportTaskTag;
   t_AutoExportTask_OutFormat : AutoExportTask_OutFormat_Tag;
   t_AutoExportTask_DocumentsSource : AutoExportTask_DocumentsSource_Tag;
   t_AutoExportTask_AccGroupsIDList : AutoExportTask_AccGroupsIDList_Tag;
   {$If not defined(LUK) AND not defined(SGC)}
   t_AutoExportTask_BasesIDList : AutoExportTask_BasesIDList_Tag;
   {$IfEnd} //not LUK AND not SGC
   t_AutoExportTask_InfoIDList : AutoExportTask_InfoIDList_Tag;
   t_AutoExportTask_Stages : AutoExportTask_Stages_Tag;
   t_RunCommandTask : RunCommandTaskTag;
   t_File : FileTag;
   t_File_AdditionalFiles : File_AdditionalFiles_Tag;
   t_CaseCodeTask : CaseCodeTaskTag;
   t_AutoAnnoExportTask : AutoAnnoExportTaskTag;
   t_AutoAnnoExportTask_BelongsIDList : AutoAnnoExportTask_BelongsIDList_Tag;
   t_ImportTask : ImportTaskTag;
   t_ImportTask_SourceFiles : ImportTask_SourceFiles_Tag;
   t_ImportTask_RegionIDList : ImportTask_RegionIDList_Tag;
   t_SpellCorrectTask : SpellCorrectTaskTag;
   t_SpellCorrectTask_ReplacementFile : SpellCorrectTask_ReplacementFile_Tag;
   t_UserDefinedExportTask : UserDefinedExportTaskTag;
   t_CourtDecisionPhrase : CourtDecisionPhraseTag;
   t_ClientMessage : ClientMessageTag;
   t_ClientMessage_NotifyType : ClientMessage_NotifyType_Tag;
   t_AnoncedExportTask : AnoncedExportTaskTag;
   t_AnoncedExportTask_AccGroupsIDList : AnoncedExportTask_AccGroupsIDList_Tag;
   t_HavanskyExportTask : HavanskyExportTaskTag;
   t_TaskResult : TaskResultTag;
   t_ImportTaskResult : ImportTaskResultTag;
   t_ImportTaskResult_ImportedDocList : ImportTaskResult_ImportedDocList_Tag;
   t_RelPublishTaskResult : RelPublishTaskResultTag;
   t_AACImportTaskResult : AACImportTaskResultTag;
   t_CourtDescription : CourtDescriptionTag;
   t_CourtDescription_DecisionPhrases : CourtDescription_DecisionPhrases_Tag;
   t_CourtDecisionSabCheckerParams : CourtDecisionSabCheckerParamsTag;
   t_CourtDecisionSabCheckerParams_CourtsList : CourtDecisionSabCheckerParams_CourtsList_Tag;
   t_AACImport : AACImportTag;
   t_AACImport_SourceIDList : AACImport_SourceIDList_Tag;
   t_AACImport_DossierSourceIDList : AACImport_DossierSourceIDList_Tag;
   t_AACImport_DocTypesIDList : AACImport_DocTypesIDList_Tag;
   t_AACImport_FASSourceIDList : AACImport_FASSourceIDList_Tag;
   t_AutoClassTaskResult : AutoClassTaskResultTag;
   t_AutoClassTaskResult_DocumentIDList : AutoClassTaskResult_DocumentIDList_Tag;
   t_AnnotationTaskResult : AnnotationTaskResultTag;
   t_AutoSpellTaskResult : AutoSpellTaskResultTag;
   t_AutoExportTaskResult : AutoExportTaskResultTag;
   t_FTPBrowser : FTPBrowserTag;
   t_RegionAutoExportTask : RegionAutoExportTaskTag;
   t_RegionImportTask : RegionImportTaskTag;
   t_RegionImportTaskResult : RegionImportTaskResultTag;
   t_DataProviderParams : DataProviderParamsTag;
   t_HyTechProviderParams : HyTechProviderParamsTag;
   t_PostgresProviderParams : PostgresProviderParamsTag;
   t_csMessage : csMessageTag;
   t_csMessage_Kind : csMessage_Kind_Tag;
   t_csLogin : csLoginTag;
   t_csLoginReply : csLoginReplyTag;
   t_csMessageWithReply : csMessageWithReplyTag;
   t_TaskID : TaskIDTag;
   t_csReply : csReplyTag;
   t_csGetReadyToDeliveryTasksReply : csGetReadyToDeliveryTasksReplyTag;
   t_csGetReadyToDeliveryTasksReply_TasksIDList : csGetReadyToDeliveryTasksReply_TasksIDList_Tag;
   t_csGetReadyToDeliveryTasks : csGetReadyToDeliveryTasksTag;
   t_csGetTaskDescription : csGetTaskDescriptionTag;
   t_FileDesc : FileDescTag;
   t_csGetTaskDescriptionReply : csGetTaskDescriptionReplyTag;
   t_csGetTaskDescriptionReply_FileDesc : csGetTaskDescriptionReply_FileDesc_Tag;
   t_TaskedFileDesc : TaskedFileDescTag;
   t_csTaskProgress : csTaskProgressTag;
   t_csDeliveryResult : csDeliveryResultTag;
   t_csDeliveryResult_ResultKind : csDeliveryResult_ResultKind_Tag;
   t_csGetFilePart : csGetFilePartTag;
   t_csGetFilePartReply : csGetFilePartReplyTag;
   t_csDisconnect : csDisconnectTag;
   t_csDisconnectReply : csDisconnectReplyTag;
   t_csSendTask : csSendTaskTag;
   t_csSendTaskReply : csSendTaskReplyTag;
   t_csPushFilePart : csPushFilePartTag;
   t_csCorrectFolder : csCorrectFolderTag;
   t_RelPublishTask : RelPublishTaskTag;
   t_csGetPartialTaskDescription : csGetPartialTaskDescriptionTag;
   t_mdpSync : mdpSyncTag;
   t_mdpImportDocs : mdpImportDocsTag;
   t_ComboAccessProviderParams : ComboAccessProviderParamsTag;
   t_ContainerTask : ContainerTaskTag;
   t_ContainerTask_TasksList : ContainerTask_TasksList_Tag;
   t_SchedulerProxyTask : SchedulerProxyTaskTag;
   t_mdpSyncDicts : mdpSyncDictsTag;
   t_mdpSyncStages : mdpSyncStagesTag;
   t_mdpSyncImport : mdpSyncImportTag;
   t_FoundSelector : FoundSelectorTag;
   t_csDownloadDocStreamReply : csDownloadDocStreamReplyTag;
   t_csDownloadDocStream : csDownloadDocStreamTag;
   t_csDownloadDocStream_FoundSelector : csDownloadDocStream_FoundSelector_Tag;
   t_csDownloadDocStream_DocPart : csDownloadDocStream_DocPart_Tag;
   t_csDownloadDocStream_DocPartSel : csDownloadDocStream_DocPartSel_Tag;
   t_DownloadDocRequest : DownloadDocRequestTag;
   t_csUploadDocStream : csUploadDocStreamTag;
   t_csUploadDocStream_DocPart : csUploadDocStream_DocPart_Tag;
   t_csUploadDocStream_DocClass : csUploadDocStream_DocClass_Tag;
   t_csUploadDocStreamReply : csUploadDocStreamReplyTag;
 protected
 // определяем стандартные методы схемы
   procedure Cleanup; override;
 public
   constructor Create; override;
 end;//TevdTasksSchema

implementation

uses
  ULong_Const,
  DateTime_Const,
  DateTimeNotNull_Const,
  Task_Const,
  RequestTask_Const,
  Type_Const,
  Address_Const,
  ProcessTask_Const,
  ExportTask_Const,
  DictEditQuery_Const,
  UserEditQuery_Const,
  PlainFile_Const,
  AutoSpellTask_Const,
  CommonDataRequest_Const,
  LineRequest_Const,
  ServerStatusRequest_Const,
  DeleteDocsQuery_Const,
  TaskResultRequest_Const,
  GetTaskRequest_Const,
  AutoClassTask_Const,
  AnnotationTask_Const,
  AutoExportTask_Const,
  RunCommandTask_Const,
  File_Const,
  CaseCodeTask_Const,
  AutoAnnoExportTask_Const,
  ImportTask_Const,
  SpellCorrectTask_Const,
  UserDefinedExportTask_Const,
  CourtDecisionPhrase_Const,
  ClientMessage_Const,
  AnoncedExportTask_Const,
  HavanskyExportTask_Const,
  TaskResult_Const,
  ImportTaskResult_Const,
  RelPublishTaskResult_Const,
  AACImportTaskResult_Const,
  CourtDescription_Const,
  CourtDecisionSabCheckerParams_Const,
  AACImport_Const,
  AutoClassTaskResult_Const,
  AnnotationTaskResult_Const,
  AutoSpellTaskResult_Const,
  AutoExportTaskResult_Const,
  FTPBrowser_Const,
  RegionAutoExportTask_Const,
  RegionImportTask_Const,
  RegionImportTaskResult_Const,
  DataProviderParams_Const,
  HyTechProviderParams_Const,
  PostgresProviderParams_Const,
  csMessage_Const,
  csLogin_Const,
  csLoginReply_Const,
  csMessageWithReply_Const,
  TaskID_Const,
  csReply_Const,
  csGetReadyToDeliveryTasksReply_Const,
  csGetReadyToDeliveryTasks_Const,
  csGetTaskDescription_Const,
  FileDesc_Const,
  csGetTaskDescriptionReply_Const,
  TaskedFileDesc_Const,
  csTaskProgress_Const,
  csDeliveryResult_Const,
  csGetFilePart_Const,
  csGetFilePartReply_Const,
  csDisconnect_Const,
  csDisconnectReply_Const,
  csSendTask_Const,
  csSendTaskReply_Const,
  csPushFilePart_Const,
  csCorrectFolder_Const,
  RelPublishTask_Const,
  csGetPartialTaskDescription_Const,
  mdpSync_Const,
  mdpImportDocs_Const,
  ComboAccessProviderParams_Const,
  ContainerTask_Const,
  SchedulerProxyTask_Const,
  mdpSyncDicts_Const,
  mdpSyncStages_Const,
  mdpSyncImport_Const,
  FoundSelector_Const,
  csDownloadDocStreamReply_Const,
  csDownloadDocStream_Const,
  DownloadDocRequest_Const,
  csUploadDocStream_Const,
  csUploadDocStreamReply_Const,
  SysUtils {a},
  TypInfo {a},
  k2Const {a},
  k2Tags {a},
  k2BaseStruct {a},
  l3Types {a},
  l3String {a},
  evdTask_Wrap,
  evdProcessTask_Wrap,
  k2Tag_Const,
  k2Long_Const,
  k2Handle_Const,
  k2Bool_Const,
  k2String_Const,
  k2RawData_Const,
  k2Int64_Const,
  k2List {a},
  k2NonOptimizeContext {a},
  ddTaskItemPrim
  ;


// start class ULongAtom

function ULongAtomClass.GetTagType: Tl3Type;
begin
 Result := k2_typULong;
end;//ULongAtomClass.TagType

function ULongAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ULong'));
end;

function ULongAtom.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Long.IsKindOf(anAtomType);
end;

function ULongAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, ULongAtomClass);
end;

function DateTimeTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typDateTime;
end;//DateTimeTagClass.TagType

function DateTimeTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DateTime'));
end;

function DateTimeTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Int64.IsKindOf(anAtomType);
end;

function DateTimeTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := DateTimeTagClass.Make(Self);
end;

function DateTimeNotNullTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typDateTimeNotNull;
end;//DateTimeNotNullTagClass.TagType

function DateTimeNotNullTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DateTimeNotNull'));
end;

function DateTimeNotNullTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_DateTime.IsKindOf(anAtomType);
end;

function DateTimeNotNullTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := DateTimeNotNullTagClass.Make(Self);
end;

function Task_TaskType_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Task_TaskType'));
end;

function Task_TaskType_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function Task_TaskType_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTask_TaskType;
end;//TaskTypeClass.TagType

function Task_TaskType_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, Task_TaskType_TagClass);
end;

procedure TaskPriorityAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *53B67FA701E5var_AfterChange*
//#UC END# *53B67FA701E5var_AfterChange*
begin
//#UC START# *53B67FA701E5AfterChange*
 if V.rTag.Owner.IsValid then
  if (V.rTag.Owner Is TddTaskItemPrim) then
   TddTaskItemPrim(V.rTag.Owner).Changed(cs_tsNone);
//#UC END# *53B67FA701E5AfterChange*
end;

function TaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTask;
end;//TaskTagClass.TagType

function TaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Task'));
end;

function TaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function TaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TaskTagClass.Make(Self);
end;

function RequestTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typRequestTask;
end;//RequestTaskTagClass.TagType

function RequestTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('RequestTask'));
end;

function RequestTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Task.IsKindOf(anAtomType);
end;

function RequestTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := RequestTaskTagClass.Make(Self);
end;

function TypeAtomClass.GetTagType: Tl3Type;
begin
 Result := k2_typType;
end;//TypeAtomClass.TagType

function TypeAtom.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Type'));
end;

function TypeAtom.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Long.IsKindOf(anAtomType);
end;

function TypeAtom.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, TypeAtomClass);
end;

function Address_ViewKind_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Address_ViewKind'));
end;

function Address_ViewKind_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function Address_ViewKind_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAddress_ViewKind;
end;//ViewKindClass.TagType

function Address_ViewKind_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, Address_ViewKind_TagClass);
end;

function AddressTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAddress;
end;//AddressTagClass.TagType

function AddressTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('Address'));
end;

function AddressTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function AddressTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AddressTagClass.Make(Self);
end;

procedure ProcessTaskCommentAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *53A95DBE0235var_AfterChange*
//#UC END# *53A95DBE0235var_AfterChange*
begin
//#UC START# *53A95DBE0235AfterChange*
 TaskPriorityAfterChange(V, aProp, aContext);
//#UC END# *53A95DBE0235AfterChange*
end;

function ProcessTask_Status_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ProcessTask_Status'));
end;

function ProcessTask_Status_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function ProcessTask_Status_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typProcessTask_Status;
end;//StatusClass.TagType

function ProcessTask_Status_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, ProcessTask_Status_TagClass);
end;

procedure ProcessTaskStatusAfterChange(const V : Tk2Values;
 const aProp    : Tk2Prop;
 const aContext : Ik2Op);
//#UC START# *53A9A7250379var_AfterChange*
//#UC END# *53A9A7250379var_AfterChange*
begin
//#UC START# *53A9A7250379AfterChange*
 if V.rTag.Owner.IsValid then
  if (V.rTag.Owner Is TddTaskItemPrim) then
   if not V.rOld.IsValid then
    TddTaskItemPrim(V.rTag.Owner).Changed(cs_tsNone)
   else
    TddTaskItemPrim(V.rTag.Owner).Changed(TcsTaskStatus(V.rOld.AsLong));
//#UC END# *53A9A7250379AfterChange*
end;

function ProcessTask_DocumentIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ProcessTask_DocumentIDList'));
end;

function ProcessTask_DocumentIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function ProcessTask_DocumentIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function ProcessTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typProcessTask;
end;//ProcessTaskTagClass.TagType

function ProcessTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ProcessTask'));
end;

function ProcessTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Task.IsKindOf(anAtomType);
end;

function ProcessTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ProcessTaskTagClass.Make(Self);
end;

function ExportTask_DiapasonType_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ExportTask_DiapasonType'));
end;

function ExportTask_DiapasonType_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function ExportTask_DiapasonType_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typExportTask_DiapasonType;
end;//DiapasonTypeClass.TagType

function ExportTask_DiapasonType_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, ExportTask_DiapasonType_TagClass);
end;

function ExportTask_OutFileType_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ExportTask_OutFileType'));
end;

function ExportTask_OutFileType_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function ExportTask_OutFileType_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typExportTask_OutFileType;
end;//OutFileTypeClass.TagType

function ExportTask_OutFileType_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, ExportTask_OutFileType_TagClass);
end;

function ExportTask_SeparateFiles_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ExportTask_SeparateFiles'));
end;

function ExportTask_SeparateFiles_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function ExportTask_SeparateFiles_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typExportTask_SeparateFiles;
end;//SeparateFilesClass.TagType

function ExportTask_SeparateFiles_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, ExportTask_SeparateFiles_TagClass);
end;

function ExportTask_SABStream_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ExportTask_SABStream'));
end;

function ExportTask_SABStream_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function ExportTask_SABStream_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function ExportTask_RegionIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ExportTask_RegionIDList'));
end;

function ExportTask_RegionIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function ExportTask_RegionIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function ExportTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typExportTask;
end;//ExportTaskTagClass.TagType

function ExportTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ExportTask'));
end;

function ExportTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function ExportTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ExportTaskTagClass.Make(Self);
end;

function DictEditQueryTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typDictEditQuery;
end;//DictEditQueryTagClass.TagType

function DictEditQueryTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DictEditQuery'));
end;

function DictEditQueryTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function DictEditQueryTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := DictEditQueryTagClass.Make(Self);
end;

function UserEditQueryTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typUserEditQuery;
end;//UserEditQueryTagClass.TagType

function UserEditQueryTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('UserEditQuery'));
end;

function UserEditQueryTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function UserEditQueryTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := UserEditQueryTagClass.Make(Self);
end;

function PlainFileTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typPlainFile;
end;//PlainFileTagClass.TagType

function PlainFileTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('PlainFile'));
end;

function PlainFileTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function PlainFileTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := PlainFileTagClass.Make(Self);
end;

function AutoSpellTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAutoSpellTask;
end;//AutoSpellTaskTagClass.TagType

function AutoSpellTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoSpellTask'));
end;

function AutoSpellTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function AutoSpellTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AutoSpellTaskTagClass.Make(Self);
end;

function CommonDataRequestTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typCommonDataRequest;
end;//CommonDataRequestTagClass.TagType

function CommonDataRequestTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('CommonDataRequest'));
end;

function CommonDataRequestTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_RequestTask.IsKindOf(anAtomType);
end;

function CommonDataRequestTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := CommonDataRequestTagClass.Make(Self);
end;

function LineRequestTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typLineRequest;
end;//LineRequestTagClass.TagType

function LineRequestTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('LineRequest'));
end;

function LineRequestTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_RequestTask.IsKindOf(anAtomType);
end;

function LineRequestTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := LineRequestTagClass.Make(Self);
end;

function ServerStatusRequestTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typServerStatusRequest;
end;//ServerStatusRequestTagClass.TagType

function ServerStatusRequestTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ServerStatusRequest'));
end;

function ServerStatusRequestTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_RequestTask.IsKindOf(anAtomType);
end;

function ServerStatusRequestTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ServerStatusRequestTagClass.Make(Self);
end;

function DeleteDocsQueryTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typDeleteDocsQuery;
end;//DeleteDocsQueryTagClass.TagType

function DeleteDocsQueryTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DeleteDocsQuery'));
end;

function DeleteDocsQueryTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function DeleteDocsQueryTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := DeleteDocsQueryTagClass.Make(Self);
end;

function TaskResultRequestTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTaskResultRequest;
end;//TaskResultRequestTagClass.TagType

function TaskResultRequestTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TaskResultRequest'));
end;

function TaskResultRequestTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_RequestTask.IsKindOf(anAtomType);
end;

function TaskResultRequestTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TaskResultRequestTagClass.Make(Self);
end;

function GetTaskRequestTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typGetTaskRequest;
end;//GetTaskRequestTagClass.TagType

function GetTaskRequestTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('GetTaskRequest'));
end;

function GetTaskRequestTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_RequestTask.IsKindOf(anAtomType);
end;

function GetTaskRequestTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := GetTaskRequestTagClass.Make(Self);
end;

function AutoClassTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAutoClassTask;
end;//AutoClassTaskTagClass.TagType

function AutoClassTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoClassTask'));
end;

function AutoClassTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function AutoClassTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AutoClassTaskTagClass.Make(Self);
end;

function AnnotationTask_BelongsIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AnnotationTask_BelongsIDList'));
end;

function AnnotationTask_BelongsIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function AnnotationTask_BelongsIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

{$If not defined(Region)}

function AnnotationTask_ExcludeAccGroupsIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AnnotationTask_ExcludeAccGroupsIDList'));
end;

function AnnotationTask_ExcludeAccGroupsIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function AnnotationTask_ExcludeAccGroupsIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;
{$IfEnd} //not Region

function AnnotationTask_AccGroupsIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AnnotationTask_AccGroupsIDList'));
end;

function AnnotationTask_AccGroupsIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function AnnotationTask_AccGroupsIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function AnnotationTask_CommentsIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AnnotationTask_CommentsIDList'));
end;

function AnnotationTask_CommentsIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function AnnotationTask_CommentsIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function AnnotationTask_ExcludeDocTypesIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AnnotationTask_ExcludeDocTypesIDList'));
end;

function AnnotationTask_ExcludeDocTypesIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function AnnotationTask_ExcludeDocTypesIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function AnnotationTask_ExcludeDocBasesIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AnnotationTask_ExcludeDocBasesIDList'));
end;

function AnnotationTask_ExcludeDocBasesIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function AnnotationTask_ExcludeDocBasesIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function AnnotationTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAnnotationTask;
end;//AnnotationTaskTagClass.TagType

function AnnotationTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AnnotationTask'));
end;

function AnnotationTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function AnnotationTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AnnotationTaskTagClass.Make(Self);
end;

function AutoExportTask_OutFormat_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoExportTask_OutFormat'));
end;

function AutoExportTask_OutFormat_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function AutoExportTask_OutFormat_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAutoExportTask_OutFormat;
end;//OutFormatClass.TagType

function AutoExportTask_OutFormat_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, AutoExportTask_OutFormat_TagClass);
end;

function AutoExportTask_DocumentsSource_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoExportTask_DocumentsSource'));
end;

function AutoExportTask_DocumentsSource_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function AutoExportTask_DocumentsSource_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAutoExportTask_DocumentsSource;
end;//DocumentsSourceClass.TagType

function AutoExportTask_DocumentsSource_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, AutoExportTask_DocumentsSource_TagClass);
end;

function AutoExportTask_AccGroupsIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoExportTask_AccGroupsIDList'));
end;

function AutoExportTask_AccGroupsIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function AutoExportTask_AccGroupsIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

{$If not defined(LUK) AND not defined(SGC)}
{$IfEnd} //not LUK AND not SGC

{$If not defined(LUK) AND not defined(SGC)}

function AutoExportTask_BasesIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoExportTask_BasesIDList'));
end;

function AutoExportTask_BasesIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function AutoExportTask_BasesIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;
{$IfEnd} //not LUK AND not SGC

{$If not defined(LUK) AND not defined(SGC)}
{$IfEnd} //not LUK AND not SGC

{$If not defined(LUK) AND not defined(SGC)}
{$IfEnd} //not LUK AND not SGC

{$If not defined(AEByBelongs)}
{$IfEnd} //not AEByBelongs

{$If not defined(LUK) AND not defined(SGC)}
{$IfEnd} //not LUK AND not SGC

{$If not defined(LUK) AND not defined(SGC)}
{$IfEnd} //not LUK AND not SGC

function AutoExportTask_InfoIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoExportTask_InfoIDList'));
end;

function AutoExportTask_InfoIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function AutoExportTask_InfoIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function AutoExportTask_Stages_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoExportTask_Stages'));
end;

function AutoExportTask_Stages_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_SetOf.IsKindOf(anAtomType);
end;

function AutoExportTask_Stages_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAutoExportTask_Stages;
end;//StagesClass.TagType

function AutoExportTask_Stages_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, AutoExportTask_Stages_TagClass);
end;

function AutoExportTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAutoExportTask;
end;//AutoExportTaskTagClass.TagType

function AutoExportTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoExportTask'));
end;

function AutoExportTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function AutoExportTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AutoExportTaskTagClass.Make(Self);
end;

function RunCommandTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typRunCommandTask;
end;//RunCommandTaskTagClass.TagType

function RunCommandTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('RunCommandTask'));
end;

function RunCommandTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function RunCommandTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := RunCommandTaskTagClass.Make(Self);
end;

function File_AdditionalFiles_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('File_AdditionalFiles'));
end;

function File_AdditionalFiles_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function File_AdditionalFiles_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function FileTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typFile;
end;//FileTagClass.TagType

function FileTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('File'));
end;

function FileTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_PlainFile.IsKindOf(anAtomType);
end;

function FileTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := FileTagClass.Make(Self);
end;

function CaseCodeTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typCaseCodeTask;
end;//CaseCodeTaskTagClass.TagType

function CaseCodeTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('CaseCodeTask'));
end;

function CaseCodeTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ExportTask.IsKindOf(anAtomType);
end;

function CaseCodeTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := CaseCodeTaskTagClass.Make(Self);
end;

function AutoAnnoExportTask_BelongsIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoAnnoExportTask_BelongsIDList'));
end;

function AutoAnnoExportTask_BelongsIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function AutoAnnoExportTask_BelongsIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function AutoAnnoExportTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAutoAnnoExportTask;
end;//AutoAnnoExportTaskTagClass.TagType

function AutoAnnoExportTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoAnnoExportTask'));
end;

function AutoAnnoExportTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ExportTask.IsKindOf(anAtomType);
end;

function AutoAnnoExportTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AutoAnnoExportTaskTagClass.Make(Self);
end;

function ImportTask_SourceFiles_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ImportTask_SourceFiles'));
end;

function ImportTask_SourceFiles_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function ImportTask_SourceFiles_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function ImportTask_RegionIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ImportTask_RegionIDList'));
end;

function ImportTask_RegionIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function ImportTask_RegionIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function ImportTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typImportTask;
end;//ImportTaskTagClass.TagType

function ImportTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ImportTask'));
end;

function ImportTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function ImportTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ImportTaskTagClass.Make(Self);
end;

function SpellCorrectTask_ReplacementFile_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('SpellCorrectTask_ReplacementFile'));
end;

function SpellCorrectTask_ReplacementFile_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function SpellCorrectTask_ReplacementFile_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function SpellCorrectTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typSpellCorrectTask;
end;//SpellCorrectTaskTagClass.TagType

function SpellCorrectTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('SpellCorrectTask'));
end;

function SpellCorrectTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function SpellCorrectTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := SpellCorrectTaskTagClass.Make(Self);
end;

function UserDefinedExportTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typUserDefinedExportTask;
end;//UserDefinedExportTaskTagClass.TagType

function UserDefinedExportTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('UserDefinedExportTask'));
end;

function UserDefinedExportTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function UserDefinedExportTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := UserDefinedExportTaskTagClass.Make(Self);
end;

function CourtDecisionPhraseTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typCourtDecisionPhrase;
end;//CourtDecisionPhraseTagClass.TagType

function CourtDecisionPhraseTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('CourtDecisionPhrase'));
end;

function CourtDecisionPhraseTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function CourtDecisionPhraseTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := CourtDecisionPhraseTagClass.Make(Self);
end;

function ClientMessage_NotifyType_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ClientMessage_NotifyType'));
end;

function ClientMessage_NotifyType_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function ClientMessage_NotifyType_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typClientMessage_NotifyType;
end;//NotifyTypeClass.TagType

function ClientMessage_NotifyType_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, ClientMessage_NotifyType_TagClass);
end;

function ClientMessageTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typClientMessage;
end;//ClientMessageTagClass.TagType

function ClientMessageTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ClientMessage'));
end;

function ClientMessageTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_RequestTask.IsKindOf(anAtomType);
end;

function ClientMessageTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ClientMessageTagClass.Make(Self);
end;

function AnoncedExportTask_AccGroupsIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AnoncedExportTask_AccGroupsIDList'));
end;

function AnoncedExportTask_AccGroupsIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function AnoncedExportTask_AccGroupsIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function AnoncedExportTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAnoncedExportTask;
end;//AnoncedExportTaskTagClass.TagType

function AnoncedExportTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AnoncedExportTask'));
end;

function AnoncedExportTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ExportTask.IsKindOf(anAtomType);
end;

function AnoncedExportTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AnoncedExportTaskTagClass.Make(Self);
end;

function HavanskyExportTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typHavanskyExportTask;
end;//HavanskyExportTaskTagClass.TagType

function HavanskyExportTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('HavanskyExportTask'));
end;

function HavanskyExportTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ExportTask.IsKindOf(anAtomType);
end;

function HavanskyExportTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := HavanskyExportTaskTagClass.Make(Self);
end;

function TaskResultTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTaskResult;
end;//TaskResultTagClass.TagType

function TaskResultTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TaskResult'));
end;

function TaskResultTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function TaskResultTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TaskResultTagClass.Make(Self);
end;

function ImportTaskResult_ImportedDocList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ImportTaskResult_ImportedDocList'));
end;

function ImportTaskResult_ImportedDocList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function ImportTaskResult_ImportedDocList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function ImportTaskResultTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typImportTaskResult;
end;//ImportTaskResultTagClass.TagType

function ImportTaskResultTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ImportTaskResult'));
end;

function ImportTaskResultTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_TaskResult.IsKindOf(anAtomType);
end;

function ImportTaskResultTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ImportTaskResultTagClass.Make(Self);
end;

function RelPublishTaskResultTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typRelPublishTaskResult;
end;//RelPublishTaskResultTagClass.TagType

function RelPublishTaskResultTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('RelPublishTaskResult'));
end;

function RelPublishTaskResultTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_TaskResult.IsKindOf(anAtomType);
end;

function RelPublishTaskResultTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := RelPublishTaskResultTagClass.Make(Self);
end;

function AACImportTaskResultTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAACImportTaskResult;
end;//AACImportTaskResultTagClass.TagType

function AACImportTaskResultTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AACImportTaskResult'));
end;

function AACImportTaskResultTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_TaskResult.IsKindOf(anAtomType);
end;

function AACImportTaskResultTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AACImportTaskResultTagClass.Make(Self);
end;

function CourtDescription_DecisionPhrases_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('CourtDescription_DecisionPhrases'));
end;

function CourtDescription_DecisionPhrases_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function CourtDescription_DecisionPhrases_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function CourtDescriptionTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typCourtDescription;
end;//CourtDescriptionTagClass.TagType

function CourtDescriptionTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('CourtDescription'));
end;

function CourtDescriptionTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function CourtDescriptionTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := CourtDescriptionTagClass.Make(Self);
end;

{$If not defined(Region)}
{$IfEnd} //not Region

function CourtDecisionSabCheckerParams_CourtsList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('CourtDecisionSabCheckerParams_CourtsList'));
end;

function CourtDecisionSabCheckerParams_CourtsList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function CourtDecisionSabCheckerParams_CourtsList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function CourtDecisionSabCheckerParamsTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typCourtDecisionSabCheckerParams;
end;//CourtDecisionSabCheckerParamsTagClass.TagType

function CourtDecisionSabCheckerParamsTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('CourtDecisionSabCheckerParams'));
end;

function CourtDecisionSabCheckerParamsTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function CourtDecisionSabCheckerParamsTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := CourtDecisionSabCheckerParamsTagClass.Make(Self);
end;

function AACImport_SourceIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AACImport_SourceIDList'));
end;

function AACImport_SourceIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function AACImport_SourceIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function AACImport_DossierSourceIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AACImport_DossierSourceIDList'));
end;

function AACImport_DossierSourceIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function AACImport_DossierSourceIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function AACImport_DocTypesIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AACImport_DocTypesIDList'));
end;

function AACImport_DocTypesIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function AACImport_DocTypesIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function AACImport_FASSourceIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AACImport_FASSourceIDList'));
end;

function AACImport_FASSourceIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function AACImport_FASSourceIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function AACImportTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAACImport;
end;//AACImportTagClass.TagType

function AACImportTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AACImport'));
end;

function AACImportTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ImportTask.IsKindOf(anAtomType);
end;

function AACImportTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AACImportTagClass.Make(Self);
end;

function AutoClassTaskResult_DocumentIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoClassTaskResult_DocumentIDList'));
end;

function AutoClassTaskResult_DocumentIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function AutoClassTaskResult_DocumentIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function AutoClassTaskResultTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAutoClassTaskResult;
end;//AutoClassTaskResultTagClass.TagType

function AutoClassTaskResultTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoClassTaskResult'));
end;

function AutoClassTaskResultTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_TaskResult.IsKindOf(anAtomType);
end;

function AutoClassTaskResultTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AutoClassTaskResultTagClass.Make(Self);
end;

function AnnotationTaskResultTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAnnotationTaskResult;
end;//AnnotationTaskResultTagClass.TagType

function AnnotationTaskResultTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AnnotationTaskResult'));
end;

function AnnotationTaskResultTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_TaskResult.IsKindOf(anAtomType);
end;

function AnnotationTaskResultTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AnnotationTaskResultTagClass.Make(Self);
end;

function AutoSpellTaskResultTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAutoSpellTaskResult;
end;//AutoSpellTaskResultTagClass.TagType

function AutoSpellTaskResultTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoSpellTaskResult'));
end;

function AutoSpellTaskResultTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_TaskResult.IsKindOf(anAtomType);
end;

function AutoSpellTaskResultTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AutoSpellTaskResultTagClass.Make(Self);
end;

function AutoExportTaskResultTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typAutoExportTaskResult;
end;//AutoExportTaskResultTagClass.TagType

function AutoExportTaskResultTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('AutoExportTaskResult'));
end;

function AutoExportTaskResultTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_TaskResult.IsKindOf(anAtomType);
end;

function AutoExportTaskResultTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := AutoExportTaskResultTagClass.Make(Self);
end;

function FTPBrowserTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typFTPBrowser;
end;//FTPBrowserTagClass.TagType

function FTPBrowserTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('FTPBrowser'));
end;

function FTPBrowserTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function FTPBrowserTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := FTPBrowserTagClass.Make(Self);
end;

function RegionAutoExportTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typRegionAutoExportTask;
end;//RegionAutoExportTaskTagClass.TagType

function RegionAutoExportTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('RegionAutoExportTask'));
end;

function RegionAutoExportTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_AutoExportTask.IsKindOf(anAtomType);
end;

function RegionAutoExportTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := RegionAutoExportTaskTagClass.Make(Self);
end;

function RegionImportTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typRegionImportTask;
end;//RegionImportTaskTagClass.TagType

function RegionImportTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('RegionImportTask'));
end;

function RegionImportTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ImportTask.IsKindOf(anAtomType);
end;

function RegionImportTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := RegionImportTaskTagClass.Make(Self);
end;

function RegionImportTaskResultTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typRegionImportTaskResult;
end;//RegionImportTaskResultTagClass.TagType

function RegionImportTaskResultTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('RegionImportTaskResult'));
end;

function RegionImportTaskResultTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ImportTaskResult.IsKindOf(anAtomType);
end;

function RegionImportTaskResultTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := RegionImportTaskResultTagClass.Make(Self);
end;

function DataProviderParamsTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typDataProviderParams;
end;//DataProviderParamsTagClass.TagType

function DataProviderParamsTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DataProviderParams'));
end;

function DataProviderParamsTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function DataProviderParamsTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := DataProviderParamsTagClass.Make(Self);
end;

function HyTechProviderParamsTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typHyTechProviderParams;
end;//HyTechProviderParamsTagClass.TagType

function HyTechProviderParamsTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('HyTechProviderParams'));
end;

function HyTechProviderParamsTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_DataProviderParams.IsKindOf(anAtomType);
end;

function HyTechProviderParamsTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := HyTechProviderParamsTagClass.Make(Self);
end;

function PostgresProviderParamsTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typPostgresProviderParams;
end;//PostgresProviderParamsTagClass.TagType

function PostgresProviderParamsTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('PostgresProviderParams'));
end;

function PostgresProviderParamsTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_DataProviderParams.IsKindOf(anAtomType);
end;

function PostgresProviderParamsTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := PostgresProviderParamsTagClass.Make(Self);
end;

function csMessage_Kind_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csMessage_Kind'));
end;

function csMessage_Kind_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function csMessage_Kind_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsMessage_Kind;
end;//KindClass.TagType

function csMessage_Kind_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, csMessage_Kind_TagClass);
end;

function csMessageTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsMessage;
end;//csMessageTagClass.TagType

function csMessageTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csMessage'));
end;

function csMessageTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function csMessageTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csMessageTagClass.Make(Self);
end;

function csLoginTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsLogin;
end;//csLoginTagClass.TagType

function csLoginTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csLogin'));
end;

function csLoginTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csMessage.IsKindOf(anAtomType);
end;

function csLoginTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csLoginTagClass.Make(Self);
end;

function csLoginReplyTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsLoginReply;
end;//csLoginReplyTagClass.TagType

function csLoginReplyTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csLoginReply'));
end;

function csLoginReplyTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csMessage.IsKindOf(anAtomType);
end;

function csLoginReplyTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csLoginReplyTagClass.Make(Self);
end;

function csMessageWithReplyTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsMessageWithReply;
end;//csMessageWithReplyTagClass.TagType

function csMessageWithReplyTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csMessageWithReply'));
end;

function csMessageWithReplyTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csMessage.IsKindOf(anAtomType);
end;

function csMessageWithReplyTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csMessageWithReplyTagClass.Make(Self);
end;

function TaskIDTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTaskID;
end;//TaskIDTagClass.TagType

function TaskIDTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TaskID'));
end;

function TaskIDTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function TaskIDTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TaskIDTagClass.Make(Self);
end;

function csReplyTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsReply;
end;//csReplyTagClass.TagType

function csReplyTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csReply'));
end;

function csReplyTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csMessage.IsKindOf(anAtomType);
end;

function csReplyTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csReplyTagClass.Make(Self);
end;

function csGetReadyToDeliveryTasksReply_TasksIDList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csGetReadyToDeliveryTasksReply_TasksIDList'));
end;

function csGetReadyToDeliveryTasksReply_TasksIDList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function csGetReadyToDeliveryTasksReply_TasksIDList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function csGetReadyToDeliveryTasksReplyTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsGetReadyToDeliveryTasksReply;
end;//csGetReadyToDeliveryTasksReplyTagClass.TagType

function csGetReadyToDeliveryTasksReplyTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csGetReadyToDeliveryTasksReply'));
end;

function csGetReadyToDeliveryTasksReplyTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csReply.IsKindOf(anAtomType);
end;

function csGetReadyToDeliveryTasksReplyTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csGetReadyToDeliveryTasksReplyTagClass.Make(Self);
end;

function csGetReadyToDeliveryTasksTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsGetReadyToDeliveryTasks;
end;//csGetReadyToDeliveryTasksTagClass.TagType

function csGetReadyToDeliveryTasksTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csGetReadyToDeliveryTasks'));
end;

function csGetReadyToDeliveryTasksTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csMessageWithReply.IsKindOf(anAtomType);
end;

function csGetReadyToDeliveryTasksTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csGetReadyToDeliveryTasksTagClass.Make(Self);
end;

function csGetTaskDescriptionTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsGetTaskDescription;
end;//csGetTaskDescriptionTagClass.TagType

function csGetTaskDescriptionTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csGetTaskDescription'));
end;

function csGetTaskDescriptionTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csMessageWithReply.IsKindOf(anAtomType);
end;

function csGetTaskDescriptionTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csGetTaskDescriptionTagClass.Make(Self);
end;

function FileDescTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typFileDesc;
end;//FileDescTagClass.TagType

function FileDescTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('FileDesc'));
end;

function FileDescTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_Tag.IsKindOf(anAtomType);
end;

function FileDescTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := FileDescTagClass.Make(Self);
end;

function csGetTaskDescriptionReply_FileDesc_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csGetTaskDescriptionReply_FileDesc'));
end;

function csGetTaskDescriptionReply_FileDesc_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function csGetTaskDescriptionReply_FileDesc_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function csGetTaskDescriptionReplyTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsGetTaskDescriptionReply;
end;//csGetTaskDescriptionReplyTagClass.TagType

function csGetTaskDescriptionReplyTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csGetTaskDescriptionReply'));
end;

function csGetTaskDescriptionReplyTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csReply.IsKindOf(anAtomType);
end;

function csGetTaskDescriptionReplyTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csGetTaskDescriptionReplyTagClass.Make(Self);
end;

function TaskedFileDescTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typTaskedFileDesc;
end;//TaskedFileDescTagClass.TagType

function TaskedFileDescTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('TaskedFileDesc'));
end;

function TaskedFileDescTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_FileDesc.IsKindOf(anAtomType);
end;

function TaskedFileDescTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := TaskedFileDescTagClass.Make(Self);
end;

function csTaskProgressTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsTaskProgress;
end;//csTaskProgressTagClass.TagType

function csTaskProgressTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csTaskProgress'));
end;

function csTaskProgressTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csMessage.IsKindOf(anAtomType);
end;

function csTaskProgressTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csTaskProgressTagClass.Make(Self);
end;

function csDeliveryResult_ResultKind_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csDeliveryResult_ResultKind'));
end;

function csDeliveryResult_ResultKind_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function csDeliveryResult_ResultKind_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsDeliveryResult_ResultKind;
end;//ResultKindClass.TagType

function csDeliveryResult_ResultKind_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, csDeliveryResult_ResultKind_TagClass);
end;

function csDeliveryResultTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsDeliveryResult;
end;//csDeliveryResultTagClass.TagType

function csDeliveryResultTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csDeliveryResult'));
end;

function csDeliveryResultTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csMessage.IsKindOf(anAtomType);
end;

function csDeliveryResultTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csDeliveryResultTagClass.Make(Self);
end;

function csGetFilePartTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsGetFilePart;
end;//csGetFilePartTagClass.TagType

function csGetFilePartTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csGetFilePart'));
end;

function csGetFilePartTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csMessageWithReply.IsKindOf(anAtomType);
end;

function csGetFilePartTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csGetFilePartTagClass.Make(Self);
end;

function csGetFilePartReplyTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsGetFilePartReply;
end;//csGetFilePartReplyTagClass.TagType

function csGetFilePartReplyTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csGetFilePartReply'));
end;

function csGetFilePartReplyTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csReply.IsKindOf(anAtomType);
end;

function csGetFilePartReplyTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csGetFilePartReplyTagClass.Make(Self);
end;

function csDisconnectTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsDisconnect;
end;//csDisconnectTagClass.TagType

function csDisconnectTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csDisconnect'));
end;

function csDisconnectTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csMessageWithReply.IsKindOf(anAtomType);
end;

function csDisconnectTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csDisconnectTagClass.Make(Self);
end;

function csDisconnectReplyTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsDisconnectReply;
end;//csDisconnectReplyTagClass.TagType

function csDisconnectReplyTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csDisconnectReply'));
end;

function csDisconnectReplyTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csReply.IsKindOf(anAtomType);
end;

function csDisconnectReplyTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csDisconnectReplyTagClass.Make(Self);
end;

function csSendTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsSendTask;
end;//csSendTaskTagClass.TagType

function csSendTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csSendTask'));
end;

function csSendTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csMessageWithReply.IsKindOf(anAtomType);
end;

function csSendTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csSendTaskTagClass.Make(Self);
end;

function csSendTaskReplyTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsSendTaskReply;
end;//csSendTaskReplyTagClass.TagType

function csSendTaskReplyTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csSendTaskReply'));
end;

function csSendTaskReplyTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csReply.IsKindOf(anAtomType);
end;

function csSendTaskReplyTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csSendTaskReplyTagClass.Make(Self);
end;

function csPushFilePartTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsPushFilePart;
end;//csPushFilePartTagClass.TagType

function csPushFilePartTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csPushFilePart'));
end;

function csPushFilePartTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csMessage.IsKindOf(anAtomType);
end;

function csPushFilePartTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csPushFilePartTagClass.Make(Self);
end;

function csCorrectFolderTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsCorrectFolder;
end;//csCorrectFolderTagClass.TagType

function csCorrectFolderTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csCorrectFolder'));
end;

function csCorrectFolderTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csMessage.IsKindOf(anAtomType);
end;

function csCorrectFolderTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csCorrectFolderTagClass.Make(Self);
end;

function RelPublishTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typRelPublishTask;
end;//RelPublishTaskTagClass.TagType

function RelPublishTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('RelPublishTask'));
end;

function RelPublishTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ImportTask.IsKindOf(anAtomType);
end;

function RelPublishTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := RelPublishTaskTagClass.Make(Self);
end;

function csGetPartialTaskDescriptionTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsGetPartialTaskDescription;
end;//csGetPartialTaskDescriptionTagClass.TagType

function csGetPartialTaskDescriptionTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csGetPartialTaskDescription'));
end;

function csGetPartialTaskDescriptionTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csGetTaskDescription.IsKindOf(anAtomType);
end;

function csGetPartialTaskDescriptionTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csGetPartialTaskDescriptionTagClass.Make(Self);
end;

function mdpSyncTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typmdpSync;
end;//mdpSyncTagClass.TagType

function mdpSyncTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('mdpSync'));
end;

function mdpSyncTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function mdpSyncTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := mdpSyncTagClass.Make(Self);
end;

function mdpImportDocsTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typmdpImportDocs;
end;//mdpImportDocsTagClass.TagType

function mdpImportDocsTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('mdpImportDocs'));
end;

function mdpImportDocsTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function mdpImportDocsTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := mdpImportDocsTagClass.Make(Self);
end;

function ComboAccessProviderParamsTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typComboAccessProviderParams;
end;//ComboAccessProviderParamsTagClass.TagType

function ComboAccessProviderParamsTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ComboAccessProviderParams'));
end;

function ComboAccessProviderParamsTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_HyTechProviderParams.IsKindOf(anAtomType);
end;

function ComboAccessProviderParamsTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ComboAccessProviderParamsTagClass.Make(Self);
end;

function ContainerTask_TasksList_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ContainerTask_TasksList'));
end;

function ContainerTask_TasksList_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function ContainerTask_TasksList_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function ContainerTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typContainerTask;
end;//ContainerTaskTagClass.TagType

function ContainerTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('ContainerTask'));
end;

function ContainerTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function ContainerTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := ContainerTaskTagClass.Make(Self);
end;

function SchedulerProxyTaskTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typSchedulerProxyTask;
end;//SchedulerProxyTaskTagClass.TagType

function SchedulerProxyTaskTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('SchedulerProxyTask'));
end;

function SchedulerProxyTaskTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function SchedulerProxyTaskTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := SchedulerProxyTaskTagClass.Make(Self);
end;

function mdpSyncDictsTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typmdpSyncDicts;
end;//mdpSyncDictsTagClass.TagType

function mdpSyncDictsTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('mdpSyncDicts'));
end;

function mdpSyncDictsTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_mdpSync.IsKindOf(anAtomType);
end;

function mdpSyncDictsTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := mdpSyncDictsTagClass.Make(Self);
end;

function mdpSyncStagesTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typmdpSyncStages;
end;//mdpSyncStagesTagClass.TagType

function mdpSyncStagesTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('mdpSyncStages'));
end;

function mdpSyncStagesTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_mdpSync.IsKindOf(anAtomType);
end;

function mdpSyncStagesTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := mdpSyncStagesTagClass.Make(Self);
end;

function mdpSyncImportTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typmdpSyncImport;
end;//mdpSyncImportTagClass.TagType

function mdpSyncImportTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('mdpSyncImport'));
end;

function mdpSyncImportTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_mdpSync.IsKindOf(anAtomType);
end;

function mdpSyncImportTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := mdpSyncImportTagClass.Make(Self);
end;

function FoundSelectorTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('FoundSelector'));
end;

function FoundSelectorTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := inherited DoMakeTag(aRef);
end;

function csDownloadDocStreamReplyTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsDownloadDocStreamReply;
end;//csDownloadDocStreamReplyTagClass.TagType

function csDownloadDocStreamReplyTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csDownloadDocStreamReply'));
end;

function csDownloadDocStreamReplyTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csReply.IsKindOf(anAtomType);
end;

function csDownloadDocStreamReplyTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csDownloadDocStreamReplyTagClass.Make(Self);
end;

function csDownloadDocStream_FoundSelector_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csDownloadDocStream_FoundSelector'));
end;

function csDownloadDocStream_FoundSelector_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_OList.IsKindOf(anAtomType);
end;

function csDownloadDocStream_FoundSelector_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Tk2List.Make(Self);
end;

function csDownloadDocStream_DocPart_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csDownloadDocStream_DocPart'));
end;

function csDownloadDocStream_DocPart_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function csDownloadDocStream_DocPart_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsDownloadDocStream_DocPart;
end;//DocPartClass.TagType

function csDownloadDocStream_DocPart_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, csDownloadDocStream_DocPart_TagClass);
end;

function csDownloadDocStream_DocPartSel_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csDownloadDocStream_DocPartSel'));
end;

function csDownloadDocStream_DocPartSel_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function csDownloadDocStream_DocPartSel_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsDownloadDocStream_DocPartSel;
end;//DocPartSelClass.TagType

function csDownloadDocStream_DocPartSel_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, csDownloadDocStream_DocPartSel_TagClass);
end;

function csDownloadDocStreamTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsDownloadDocStream;
end;//csDownloadDocStreamTagClass.TagType

function csDownloadDocStreamTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csDownloadDocStream'));
end;

function csDownloadDocStreamTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csMessageWithReply.IsKindOf(anAtomType);
end;

function csDownloadDocStreamTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csDownloadDocStreamTagClass.Make(Self);
end;

function DownloadDocRequestTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typDownloadDocRequest;
end;//DownloadDocRequestTagClass.TagType

function DownloadDocRequestTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('DownloadDocRequest'));
end;

function DownloadDocRequestTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_ProcessTask.IsKindOf(anAtomType);
end;

function DownloadDocRequestTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := DownloadDocRequestTagClass.Make(Self);
end;

function csUploadDocStream_DocPart_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csUploadDocStream_DocPart'));
end;

function csUploadDocStream_DocPart_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function csUploadDocStream_DocPart_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsUploadDocStream_DocPart;
end;//DocPartClass.TagType

function csUploadDocStream_DocPart_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, csUploadDocStream_DocPart_TagClass);
end;

function csUploadDocStream_DocClass_Tag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csUploadDocStream_DocClass'));
end;

function csUploadDocStream_DocClass_Tag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR TevdTasksSchema(TypeTable).t_Enum.IsKindOf(anAtomType);
end;

function csUploadDocStream_DocClass_TagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsUploadDocStream_DocClass;
end;//DocClassClass.TagType

function csUploadDocStream_DocClass_Tag.DoMakeTag(aRef : Integer): Il3TagRef;
begin
 Result := Self.MakeFromInt(aRef, csUploadDocStream_DocClass_TagClass);
end;

function csUploadDocStreamTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsUploadDocStream;
end;//csUploadDocStreamTagClass.TagType

function csUploadDocStreamTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csUploadDocStream'));
end;

function csUploadDocStreamTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csMessageWithReply.IsKindOf(anAtomType);
end;

function csUploadDocStreamTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csUploadDocStreamTagClass.Make(Self);
end;

function csUploadDocStreamReplyTagClass.GetTagType: Tl3Type;
begin
 Result := k2_typcsUploadDocStreamReply;
end;//csUploadDocStreamReplyTagClass.TagType

function csUploadDocStreamReplyTag.GetAsPCharLen: Tl3PCharLenPrim;
begin
 Result := l3PCharLen(AnsiString('csUploadDocStreamReply'));
end;

function csUploadDocStreamReplyTag.GetIsKindOf(anAtomType: Tk2TypePrim): Boolean;
begin
 Result := (Self = anAtomType) OR 
           TevdTasksSchema(TypeTable).t_csReply.IsKindOf(anAtomType);
end;

function csUploadDocStreamReplyTag.DoMakeTag(aRef: Integer): Il3TagRef;
begin
 Result := csUploadDocStreamReplyTagClass.Make(Self);
end;

constructor TevdTasksSchema.Create;
begin
 inherited;
 // ULong
 t_ULong := DefineAutoType([t_Long], '', ULongAtom) As ULongAtom;
 with t_ULong do
 begin
 end;//ULong
 // DateTime
 t_DateTime := DefineAutoType([t_Int64], '', DateTimeTag) As DateTimeTag;
 with t_DateTime do
 begin
  AtomClass := DateTimeTagClass;
 end;//DateTime
 // DateTimeNotNull
 t_DateTimeNotNull := DefineAutoType([t_DateTime], '', DateTimeNotNullTag) As DateTimeNotNullTag;
 with t_DateTimeNotNull do
 begin
  AtomClass := DateTimeNotNullTagClass;
 end;//DateTimeNotNull
 // Task
 t_Task := DefineAutoType([t_Tag], 'Задание', TaskTag) As TaskTag;
 with t_Task do
 begin
  AtomClass := TaskTagClass;
  WrapperType := WevdTask;
  t_Task_TaskType := DefineAutoType([t_Enum], 'Задание TaskType', Task_TaskType_Tag) As Task_TaskType_Tag;
  try
   t_Task_TaskType.AtomType := TypeInfo(TcsTaskType);
   DefineProperty(k2_attrTaskType, t_Task_TaskType, '');
   t_Task_TaskType.Recalc;
  except
   FreeAndNil(t_Task_TaskType);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   ReadOnly := true;
   DefaultValue := Ord(cs_ttUnknown);
  end;//TaskType
  with DefineProperty(k2_attrPriority, t_Long, '') do
  begin
   DefaultValue := 50;
   AfterChange := TaskPriorityAfterChange;
  end;//Priority
  with DefineProperty(k2_attrVersion, t_Long, '') do
  begin
   DefaultValue := 1;
  end;//Version
  with DefineProperty(k2_attrTaskID, t_String, 'Идентификатор задания') do
  begin
  end;//TaskID
  with DefineProperty(k2_attrDate, t_DateTimeNotNull, '') do
  begin
  end;//Date
  with DefineProperty(k2_attrUser, t_ULong, '') do
  begin
  end;//User
  with DefineProperty(k2_attrDescription, t_String, 'Description') do
  begin
  end;//Description
  with DefineProperty(k2_attrTaskFolder, t_String, 'TaskFolder') do
  begin
  end;//TaskFolder
 end;//Task
 // RequestTask
 t_RequestTask := DefineAutoType([t_Task], '', RequestTaskTag) As RequestTaskTag;
 with t_RequestTask do
 begin
  AtomClass := RequestTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttRequest);
  end;//TaskType
 end;//RequestTask
 // Type
 t_Type := DefineAutoType([t_Long], 'Тип объекта', TypeAtom) As TypeAtom;
 with t_Type do
 begin
 end;//Type
 // Address
 t_Address := DefineType(k2_idAddress {77}, [t_Tag], 'Адрес', AddressTag) As AddressTag;
 with t_Address do
 begin
  AtomClass := AddressTagClass;
  with DefineProperty(k2_attrDocID, t_Handle, 'Идентификатор документа') do
  begin
   DefaultValue := 0;
  end;//DocID
  with DefineProperty(k2_attrSubID, t_Handle, 'Идентификатор метки') do
  begin
   DefaultValue := 0;
  end;//SubID
  with DefineProperty(k2_attrType, t_Type, 'Тип объекта') do
  begin
   DefaultValue := ev_defAddressType;
  end;//Type
  with DefineProperty(k2_attrRevision, t_Long, 'Ревизия') do
  begin
   DefaultValue := 0;
  end;//Revision
  t_Address_ViewKind := DefineAutoType([t_Enum], 'Адрес Вид ссылки', Address_ViewKind_Tag) As Address_ViewKind_Tag;
  try
   t_Address_ViewKind.AtomType := TypeInfo(TevLinkViewKind);
   DefineProperty(k2_attrViewKind, t_Address_ViewKind, 'Вид ссылки');
   t_Address_ViewKind.Recalc;
  except
   FreeAndNil(t_Address_ViewKind);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrViewKind]) do
  begin
   DefaultValue := Ord(ev_lvkUnknown);
   Stored := false;
  end;//ViewKind
  with DefineProperty(k2_attrShortName, t_String, 'Hint') do
  begin
   Stored := false;
  end;//ShortName
  with DefineProperty(k2_attrName, t_String, 'Name') do
  begin
  end;//Name
 end;//Address
 // ProcessTask
 t_ProcessTask := DefineAutoType([t_Task], '', ProcessTaskTag) As ProcessTaskTag;
 with t_ProcessTask do
 begin
  AtomClass := ProcessTaskTagClass;
  WrapperType := WevdProcessTask;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttProcess);
  end;//TaskType
  with DefineProperty(k2_attrComment, t_String, '') do
  begin
   AfterChange := ProcessTaskCommentAfterChange;
  end;//Comment
  t_ProcessTask_Status := DefineAutoType([t_Enum], 'ProcessTask Status', ProcessTask_Status_Tag) As ProcessTask_Status_Tag;
  try
   t_ProcessTask_Status.AtomType := TypeInfo(TcsTaskStatus);
   DefineProperty(k2_attrStatus, t_ProcessTask_Status, '');
   t_ProcessTask_Status.Recalc;
  except
   FreeAndNil(t_ProcessTask_Status);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrStatus]) do
  begin
   AfterChange := ProcessTaskStatusAfterChange;
  end;//Status
  t_ProcessTask_DocumentIDList := DefineAutoType([t_OList], 'ProcessTask DocumentIDList', ProcessTask_DocumentIDList_Tag) As ProcessTask_DocumentIDList_Tag;
  try
   t_ProcessTask_DocumentIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrDocumentIDList, t_ProcessTask_DocumentIDList, '');
   t_ProcessTask_DocumentIDList.Recalc;
  except
   FreeAndNil(t_ProcessTask_DocumentIDList);
  end;//try..except
  with t_ProcessTask_DocumentIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//DocumentIDList
  with DefineProperty(k2_attrReplyAddress, t_String, '') do
  begin
  end;//ReplyAddress
 end;//ProcessTask
 // ExportTask
 t_ExportTask := DefineAutoType([t_ProcessTask], '', ExportTaskTag) As ExportTaskTag;
 with t_ExportTask do
 begin
  AtomClass := ExportTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttExport);
  end;//TaskType
  with DefineProperty(k2_attrAnnoTopicFileName, t_String, '') do
  begin
  end;//AnnoTopicFileName
  t_ExportTask_DiapasonType := DefineAutoType([t_Enum], 'ExportTask DiapasonType', ExportTask_DiapasonType_Tag) As ExportTask_DiapasonType_Tag;
  try
   t_ExportTask_DiapasonType.AtomType := TypeInfo(TDiapType);
   DefineProperty(k2_attrDiapasonType, t_ExportTask_DiapasonType, '');
   t_ExportTask_DiapasonType.Recalc;
  except
   FreeAndNil(t_ExportTask_DiapasonType);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrDiapasonType]) do
  begin
  end;//DiapasonType
  with DefineProperty(k2_attrDocID, t_Long, '') do
  begin
  end;//DocID
  with DefineProperty(k2_attrDocumentFileNameMask, t_String, '') do
  begin
  end;//DocumentFileNameMask
  with DefineProperty(k2_attrExportAnnoTopics, t_Bool, '') do
  begin
  end;//ExportAnnoTopics
  with DefineProperty(k2_attrExportDirectory, t_String, '') do
  begin
  end;//ExportDirectory
  with DefineProperty(k2_attrExportDocImage, t_Bool, '') do
  begin
  end;//ExportDocImage
  with DefineProperty(k2_attrExportDocument, t_Bool, '') do
  begin
  end;//ExportDocument
  with DefineProperty(k2_attrExportEmptyKW, t_Bool, '') do
  begin
  end;//ExportEmptyKW
  with DefineProperty(k2_attrExportKW, t_Bool, '') do
  begin
  end;//ExportKW
  with DefineProperty(k2_attrExportRTFBody, t_Bool, '') do
  begin
  end;//ExportRTFBody
  with DefineProperty(k2_attrFamily, t_Long, '') do
  begin
  end;//Family
  with DefineProperty(k2_attrInternalFormat, t_Bool, '') do
  begin
  end;//InternalFormat
  with DefineProperty(k2_attrKWFileName, t_String, '') do
  begin
  end;//KWFileName
  with DefineProperty(k2_attrMultiUser, t_Bool, '') do
  begin
  end;//MultiUser
  with DefineProperty(k2_attrObjTopicFileName, t_String, '') do
  begin
  end;//ObjTopicFileName
  with DefineProperty(k2_attrOnlyStructure, t_Bool, '') do
  begin
  end;//OnlyStructure
  t_ExportTask_OutFileType := DefineAutoType([t_Enum], 'ExportTask OutFileType', ExportTask_OutFileType_Tag) As ExportTask_OutFileType_Tag;
  try
   t_ExportTask_OutFileType.AtomType := TypeInfo(TepSupportFileType);
   DefineProperty(k2_attrOutFileType, t_ExportTask_OutFileType, '');
   t_ExportTask_OutFileType.Recalc;
  except
   FreeAndNil(t_ExportTask_OutFileType);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrOutFileType]) do
  begin
  end;//OutFileType
  with DefineProperty(k2_attrOutputFileSize, t_Long, '') do
  begin
  end;//OutputFileSize
  with DefineProperty(k2_attrReferenceFileNameMask, t_String, '') do
  begin
  end;//ReferenceFileNameMask
  t_ExportTask_SeparateFiles := DefineAutoType([t_Enum], 'ExportTask SeparateFiles', ExportTask_SeparateFiles_Tag) As ExportTask_SeparateFiles_Tag;
  try
   t_ExportTask_SeparateFiles.AtomType := TypeInfo(TepDivideBy);
   DefineProperty(k2_attrSeparateFiles, t_ExportTask_SeparateFiles, '');
   t_ExportTask_SeparateFiles.Recalc;
  except
   FreeAndNil(t_ExportTask_SeparateFiles);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrSeparateFiles]) do
  begin
  end;//SeparateFiles
  with DefineProperty(k2_attrToRegion, t_ULong, '') do
  begin
  end;//ToRegion
  with DefineProperty(k2_attrExportReference, t_Bool, '') do
  begin
  end;//ExportReference
  with DefineProperty(k2_attrExportEditions, t_Bool, '') do
  begin
  end;//ExportEditions
  with DefineProperty(k2_attrFormulaAsPicture, t_Bool, '') do
  begin
  end;//FormulaAsPicture
  with DefineProperty(k2_attrExportReferences, t_Bool, '') do
  begin
  end;//ExportReferences
  t_ExportTask_SABStream := DefineAutoType([t_OList], 'ExportTask SABStream', ExportTask_SABStream_Tag) As ExportTask_SABStream_Tag;
  try
   t_ExportTask_SABStream.DefineChildren(t_Address);
   DefineProperty(k2_attrSABStream, t_ExportTask_SABStream, '');
   t_ExportTask_SABStream.Recalc;
  except
   FreeAndNil(t_ExportTask_SABStream);
  end;//try..except
  with t_ExportTask_SABStream.ArrayProp[k2_tiChildren] do
  begin
  end;//SABStream
  with DefineProperty(k2_attrAdditionalProcess, t_String, '') do
  begin
  end;//AdditionalProcess
  t_ExportTask_RegionIDList := DefineAutoType([t_OList], 'ExportTask RegionIDList', ExportTask_RegionIDList_Tag) As ExportTask_RegionIDList_Tag;
  try
   t_ExportTask_RegionIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrRegionIDList, t_ExportTask_RegionIDList, '');
   t_ExportTask_RegionIDList.Recalc;
  except
   FreeAndNil(t_ExportTask_RegionIDList);
  end;//try..except
  with t_ExportTask_RegionIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//RegionIDList
 end;//ExportTask
 // DictEditQuery
 t_DictEditQuery := DefineAutoType([t_ProcessTask], '', DictEditQueryTag) As DictEditQueryTag;
 with t_DictEditQuery do
 begin
  AtomClass := DictEditQueryTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttDictEdit);
  end;//TaskType
  with DefineProperty(k2_attrFamily, t_Long, '') do
  begin
  end;//Family
  with DefineProperty(k2_attrDictType, t_Long, '') do
  begin
  end;//DictType
  with DefineProperty(k2_attrOperation, t_Long, '') do
  begin
  end;//Operation
  with DefineProperty(k2_attrID, t_Long, '') do
  begin
  end;//ID
  with DefineProperty(k2_attrParentID, t_Long, '') do
  begin
  end;//ParentID
  with DefineProperty(k2_attrNextID, t_Long, '') do
  begin
  end;//NextID
 end;//DictEditQuery
 // UserEditQuery
 t_UserEditQuery := DefineAutoType([t_ProcessTask], '', UserEditQueryTag) As UserEditQueryTag;
 with t_UserEditQuery do
 begin
  AtomClass := UserEditQueryTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttUserEdit);
  end;//TaskType
  with DefineProperty(k2_attrID, t_Long, '') do
  begin
  end;//ID
  with DefineProperty(k2_attrIsGroup, t_Bool, '') do
  begin
  end;//IsGroup
 end;//UserEditQuery
 // PlainFile
 t_PlainFile := DefineAutoType([t_Tag], '', PlainFileTag) As PlainFileTag;
 with t_PlainFile do
 begin
  AtomClass := PlainFileTagClass;
  with DefineProperty(k2_attrName, t_String, '') do
  begin
  end;//Name
 end;//PlainFile
 // AutoSpellTask
 t_AutoSpellTask := DefineAutoType([t_ProcessTask], '', AutoSpellTaskTag) As AutoSpellTaskTag;
 with t_AutoSpellTask do
 begin
  AtomClass := AutoSpellTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttAutoSpellCheck);
  end;//TaskType
 end;//AutoSpellTask
 // CommonDataRequest
 t_CommonDataRequest := DefineAutoType([t_RequestTask], '', CommonDataRequestTag) As CommonDataRequestTag;
 with t_CommonDataRequest do
 begin
  AtomClass := CommonDataRequestTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttCommonData);
  end;//TaskType
 end;//CommonDataRequest
 // LineRequest
 t_LineRequest := DefineAutoType([t_RequestTask], '', LineRequestTag) As LineRequestTag;
 with t_LineRequest do
 begin
  AtomClass := LineRequestTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttLine);
  end;//TaskType
 end;//LineRequest
 // ServerStatusRequest
 t_ServerStatusRequest := DefineAutoType([t_RequestTask], '', ServerStatusRequestTag) As ServerStatusRequestTag;
 with t_ServerStatusRequest do
 begin
  AtomClass := ServerStatusRequestTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttServerStatus);
  end;//TaskType
 end;//ServerStatusRequest
 // DeleteDocsQuery
 t_DeleteDocsQuery := DefineAutoType([t_ProcessTask], '', DeleteDocsQueryTag) As DeleteDocsQueryTag;
 with t_DeleteDocsQuery do
 begin
  AtomClass := DeleteDocsQueryTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttDeleteDocs);
  end;//TaskType
 end;//DeleteDocsQuery
 // TaskResultRequest
 t_TaskResultRequest := DefineAutoType([t_RequestTask], '', TaskResultRequestTag) As TaskResultRequestTag;
 with t_TaskResultRequest do
 begin
  AtomClass := TaskResultRequestTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttTaskResult);
  end;//TaskType
 end;//TaskResultRequest
 // GetTaskRequest
 t_GetTaskRequest := DefineAutoType([t_RequestTask], '', GetTaskRequestTag) As GetTaskRequestTag;
 with t_GetTaskRequest do
 begin
  AtomClass := GetTaskRequestTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttGetTask);
  end;//TaskType
 end;//GetTaskRequest
 // AutoClassTask
 t_AutoClassTask := DefineAutoType([t_ProcessTask], '', AutoClassTaskTag) As AutoClassTaskTag;
 with t_AutoClassTask do
 begin
  AtomClass := AutoClassTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttAutoClass);
  end;//TaskType
  with DefineProperty(k2_attrBuilderFileName, t_String, '') do
  begin
  end;//BuilderFileName
  with DefineProperty(k2_attrResultFileName, t_String, '') do
  begin
  end;//ResultFileName
  with DefineProperty(k2_attrSourceFolder, t_String, '') do
  begin
  end;//SourceFolder
  with DefineProperty(k2_attrLogFileName, t_String, '') do
  begin
  end;//LogFileName
  with DefineProperty(k2_attreMailNotifyList, t_String, '') do
  begin
  end;//eMailNotifyList
 end;//AutoClassTask
 // AnnotationTask
 t_AnnotationTask := DefineAutoType([t_ProcessTask], '', AnnotationTaskTag) As AnnotationTaskTag;
 with t_AnnotationTask do
 begin
  AtomClass := AnnotationTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttAnnoExport);
  end;//TaskType
  with Tk2CustomProperty(Prop[k2_attrUser]) do
  begin
   ReadOnly := true;
   DefaultValue := usServerService;
  end;//User
  with DefineProperty(k2_attrNeedAnalyzeLog, t_Bool, '') do
  begin
  end;//NeedAnalyzeLog
  with DefineProperty(k2_attrTargetFolder, t_String, '') do
  begin
  end;//TargetFolder
  with DefineProperty(k2_attreMailNotifyList, t_String, '') do
  begin
  end;//eMailNotifyList
  with DefineProperty(k2_attrExternalProcessor, t_String, '') do
  begin
  end;//ExternalProcessor
  with DefineProperty(k2_attrOutFolder, t_String, '') do
  begin
  end;//OutFolder
  with DefineProperty(k2_attrPrimeRobotEMail, t_String, '') do
  begin
  end;//PrimeRobotEMail
  with DefineProperty(k2_attrExportDocuments, t_Bool, '') do
  begin
  end;//ExportDocuments
  with DefineProperty(k2_attrDocListFileName, t_String, '') do
  begin
  end;//DocListFileName
  with DefineProperty(k2_attrDocListFolder, t_String, '') do
  begin
  end;//DocListFolder
  with DefineProperty(k2_attrEndDateKind, t_Long, '') do
  begin
  end;//EndDateKind
  with DefineProperty(k2_attrStartDate, t_DateTime, '') do
  begin
  end;//StartDate
  t_AnnotationTask_BelongsIDList := DefineAutoType([t_OList], 'AnnotationTask BelongsIDList', AnnotationTask_BelongsIDList_Tag) As AnnotationTask_BelongsIDList_Tag;
  try
   t_AnnotationTask_BelongsIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrBelongsIDList, t_AnnotationTask_BelongsIDList, '');
   t_AnnotationTask_BelongsIDList.Recalc;
  except
   FreeAndNil(t_AnnotationTask_BelongsIDList);
  end;//try..except
  with t_AnnotationTask_BelongsIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//BelongsIDList
  {$If not defined(Region)}
  t_AnnotationTask_ExcludeAccGroupsIDList := DefineAutoType([t_OList], 'AnnotationTask ExcludeAccGroupsIDList', AnnotationTask_ExcludeAccGroupsIDList_Tag) As AnnotationTask_ExcludeAccGroupsIDList_Tag;
  try
   t_AnnotationTask_ExcludeAccGroupsIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrExcludeAccGroupsIDList, t_AnnotationTask_ExcludeAccGroupsIDList, '');
   t_AnnotationTask_ExcludeAccGroupsIDList.Recalc;
  except
   FreeAndNil(t_AnnotationTask_ExcludeAccGroupsIDList);
  end;//try..except
  with t_AnnotationTask_ExcludeAccGroupsIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//ExcludeAccGroupsIDList
  {$IfEnd} //not Region
  t_AnnotationTask_AccGroupsIDList := DefineAutoType([t_OList], 'AnnotationTask AccGroupsIDList', AnnotationTask_AccGroupsIDList_Tag) As AnnotationTask_AccGroupsIDList_Tag;
  try
   t_AnnotationTask_AccGroupsIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrAccGroupsIDList, t_AnnotationTask_AccGroupsIDList, '');
   t_AnnotationTask_AccGroupsIDList.Recalc;
  except
   FreeAndNil(t_AnnotationTask_AccGroupsIDList);
  end;//try..except
  with t_AnnotationTask_AccGroupsIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//AccGroupsIDList
  t_AnnotationTask_CommentsIDList := DefineAutoType([t_OList], 'AnnotationTask CommentsIDList', AnnotationTask_CommentsIDList_Tag) As AnnotationTask_CommentsIDList_Tag;
  try
   t_AnnotationTask_CommentsIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrCommentsIDList, t_AnnotationTask_CommentsIDList, '');
   t_AnnotationTask_CommentsIDList.Recalc;
  except
   FreeAndNil(t_AnnotationTask_CommentsIDList);
  end;//try..except
  with t_AnnotationTask_CommentsIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//CommentsIDList
  t_AnnotationTask_ExcludeDocTypesIDList := DefineAutoType([t_OList], 'AnnotationTask ExcludeDocTypesIDList', AnnotationTask_ExcludeDocTypesIDList_Tag) As AnnotationTask_ExcludeDocTypesIDList_Tag;
  try
   t_AnnotationTask_ExcludeDocTypesIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrExcludeDocTypesIDList, t_AnnotationTask_ExcludeDocTypesIDList, '');
   t_AnnotationTask_ExcludeDocTypesIDList.Recalc;
  except
   FreeAndNil(t_AnnotationTask_ExcludeDocTypesIDList);
  end;//try..except
  with t_AnnotationTask_ExcludeDocTypesIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//ExcludeDocTypesIDList
  t_AnnotationTask_ExcludeDocBasesIDList := DefineAutoType([t_OList], 'AnnotationTask ExcludeDocBasesIDList', AnnotationTask_ExcludeDocBasesIDList_Tag) As AnnotationTask_ExcludeDocBasesIDList_Tag;
  try
   t_AnnotationTask_ExcludeDocBasesIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrExcludeDocBasesIDList, t_AnnotationTask_ExcludeDocBasesIDList, '');
   t_AnnotationTask_ExcludeDocBasesIDList.Recalc;
  except
   FreeAndNil(t_AnnotationTask_ExcludeDocBasesIDList);
  end;//try..except
  with t_AnnotationTask_ExcludeDocBasesIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//ExcludeDocBasesIDList
  with DefineProperty(k2_attrAnnoFilenameTemplate, t_String, '') do
  begin
  end;//AnnoFilenameTemplate
 end;//AnnotationTask
 // AutoExportTask
 t_AutoExportTask := DefineAutoType([t_ProcessTask], '', AutoExportTaskTag) As AutoExportTaskTag;
 with t_AutoExportTask do
 begin
  AtomClass := AutoExportTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttAExportDoc);
  end;//TaskType
  with Tk2CustomProperty(Prop[k2_attrUser]) do
  begin
   ReadOnly := true;
   DefaultValue := usServerService;
  end;//User
  with DefineProperty(k2_attrToday, t_DateTime, '') do
  begin
  end;//Today
  with DefineProperty(k2_attrCompileDate, t_DateTime, '') do
  begin
  end;//CompileDate
  with DefineProperty(k2_attrVersionDate, t_DateTime, '') do
  begin
  end;//VersionDate
  t_AutoExportTask_OutFormat := DefineAutoType([t_Enum], 'AutoExportTask OutFormat', AutoExportTask_OutFormat_Tag) As AutoExportTask_OutFormat_Tag;
  try
   t_AutoExportTask_OutFormat.AtomType := TypeInfo(TepSupportFileType);
   DefineProperty(k2_attrOutFormat, t_AutoExportTask_OutFormat, '');
   t_AutoExportTask_OutFormat.Recalc;
  except
   FreeAndNil(t_AutoExportTask_OutFormat);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrOutFormat]) do
  begin
  end;//OutFormat
  with DefineProperty(k2_attrAnnoUseAccGroups, t_Bool, '') do
  begin
  end;//AnnoUseAccGroups
  t_AutoExportTask_DocumentsSource := DefineAutoType([t_Enum], 'AutoExportTask DocumentsSource', AutoExportTask_DocumentsSource_Tag) As AutoExportTask_DocumentsSource_Tag;
  try
   t_AutoExportTask_DocumentsSource.AtomType := TypeInfo(TaeDocSource);
   DefineProperty(k2_attrDocumentsSource, t_AutoExportTask_DocumentsSource, '');
   t_AutoExportTask_DocumentsSource.Recalc;
  except
   FreeAndNil(t_AutoExportTask_DocumentsSource);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrDocumentsSource]) do
  begin
  end;//DocumentsSource
  with DefineProperty(k2_attrWithEditions, t_Bool, '') do
  begin
  end;//WithEditions
  t_AutoExportTask_AccGroupsIDList := DefineAutoType([t_OList], 'AutoExportTask AccGroupsIDList', AutoExportTask_AccGroupsIDList_Tag) As AutoExportTask_AccGroupsIDList_Tag;
  try
   t_AutoExportTask_AccGroupsIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrAccGroupsIDList, t_AutoExportTask_AccGroupsIDList, '');
   t_AutoExportTask_AccGroupsIDList.Recalc;
  except
   FreeAndNil(t_AutoExportTask_AccGroupsIDList);
  end;//try..except
  with t_AutoExportTask_AccGroupsIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//AccGroupsIDList
  {$If not defined(LUK) AND not defined(SGC)}
  with DefineProperty(k2_attrAnnoTemplate, t_String, '') do
  begin
  end;//AnnoTemplate
  {$IfEnd} //not LUK AND not SGC
  {$If not defined(LUK) AND not defined(SGC)}
  t_AutoExportTask_BasesIDList := DefineAutoType([t_OList], 'AutoExportTask BasesIDList', AutoExportTask_BasesIDList_Tag) As AutoExportTask_BasesIDList_Tag;
  try
   t_AutoExportTask_BasesIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrBasesIDList, t_AutoExportTask_BasesIDList, '');
   t_AutoExportTask_BasesIDList.Recalc;
  except
   FreeAndNil(t_AutoExportTask_BasesIDList);
  end;//try..except
  with t_AutoExportTask_BasesIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//BasesIDList
  {$IfEnd} //not LUK AND not SGC
  {$If not defined(LUK) AND not defined(SGC)}
  with DefineProperty(k2_attrChangedDocTemplate, t_String, '') do
  begin
  end;//ChangedDocTemplate
  {$IfEnd} //not LUK AND not SGC
  {$If not defined(LUK) AND not defined(SGC)}
  with DefineProperty(k2_attrChangedRelTempate, t_String, '') do
  begin
  end;//ChangedRelTempate
  {$IfEnd} //not LUK AND not SGC
  with DefineProperty(k2_attrExecName, t_String, '') do
  begin
  end;//ExecName
  with DefineProperty(k2_attrExecParams, t_String, '') do
  begin
  end;//ExecParams
  with DefineProperty(k2_attrDocQueryFileName, t_String, '') do
  begin
  end;//DocQueryFileName
  {$If not defined(AEByBelongs)}
  with DefineProperty(k2_attrDoneFileName, t_String, '') do
  begin
  end;//DoneFileName
  {$IfEnd} //not AEByBelongs
  with DefineProperty(k2_attrExportFolder, t_String, '') do
  begin
  end;//ExportFolder
  {$If not defined(LUK) AND not defined(SGC)}
  with DefineProperty(k2_attrIncludedDocTemplate, t_String, '') do
  begin
  end;//IncludedDocTemplate
  {$IfEnd} //not LUK AND not SGC
  {$If not defined(LUK) AND not defined(SGC)}
  with DefineProperty(k2_attrIncludedRelTemplate, t_String, '') do
  begin
  end;//IncludedRelTemplate
  {$IfEnd} //not LUK AND not SGC
  with DefineProperty(k2_attrInfoDocTemplate, t_String, '') do
  begin
  end;//InfoDocTemplate
  t_AutoExportTask_InfoIDList := DefineAutoType([t_OList], 'AutoExportTask InfoIDList', AutoExportTask_InfoIDList_Tag) As AutoExportTask_InfoIDList_Tag;
  try
   t_AutoExportTask_InfoIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrInfoIDList, t_AutoExportTask_InfoIDList, '');
   t_AutoExportTask_InfoIDList.Recalc;
  except
   FreeAndNil(t_AutoExportTask_InfoIDList);
  end;//try..except
  with t_AutoExportTask_InfoIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//InfoIDList
  with DefineProperty(k2_attrInfoRelTemplate, t_String, '') do
  begin
  end;//InfoRelTemplate
  with DefineProperty(k2_attrNeedTopicList, t_Bool, '') do
  begin
  end;//NeedTopicList
  with DefineProperty(k2_attreMailNotifyList, t_String, '') do
  begin
  end;//eMailNotifyList
  with DefineProperty(k2_attrSMSNotifyList, t_String, '') do
  begin
  end;//SMSNotifyList
  with DefineProperty(k2_attrPartSize, t_Long, '') do
  begin
  end;//PartSize
  with DefineProperty(k2_attrMaxExportCount, t_Long, '') do
  begin
  end;//MaxExportCount
  t_AutoExportTask_Stages := DefineAutoType([t_SetOf], 'AutoExportTask Stages', AutoExportTask_Stages_Tag) As AutoExportTask_Stages_Tag;
  try
   t_AutoExportTask_Stages.AtomType := TypeInfo(TaeStagesSet);
   DefineProperty(k2_attrStages, t_AutoExportTask_Stages, '');
   t_AutoExportTask_Stages.Recalc;
  except
   FreeAndNil(t_AutoExportTask_Stages);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrStages]) do
  begin
  end;//Stages
  with DefineProperty(k2_attrExpandEditions, t_Bool, '') do
  begin
  end;//ExpandEditions
  with DefineProperty(k2_attrInfoDocsIncludedOnly, t_Bool, '') do
  begin
  end;//InfoDocsIncludedOnly
 end;//AutoExportTask
 // RunCommandTask
 t_RunCommandTask := DefineAutoType([t_ProcessTask], '', RunCommandTaskTag) As RunCommandTaskTag;
 with t_RunCommandTask do
 begin
  AtomClass := RunCommandTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttRunCommand);
  end;//TaskType
 end;//RunCommandTask
 // File
 t_File := DefineAutoType([t_PlainFile], '', FileTag) As FileTag;
 with t_File do
 begin
  AtomClass := FileTagClass;
  t_File_AdditionalFiles := DefineAutoType([t_OList], 'File AdditionalFiles', File_AdditionalFiles_Tag) As File_AdditionalFiles_Tag;
  try
   t_File_AdditionalFiles.DefineChildren(t_PlainFile);
   DefineProperty(k2_attrAdditionalFiles, t_File_AdditionalFiles, '');
   t_File_AdditionalFiles.Recalc;
  except
   FreeAndNil(t_File_AdditionalFiles);
  end;//try..except
  with t_File_AdditionalFiles.ArrayProp[k2_tiChildren] do
  begin
  end;//AdditionalFiles
 end;//File
 // CaseCodeTask
 t_CaseCodeTask := DefineAutoType([t_ExportTask], '', CaseCodeTaskTag) As CaseCodeTaskTag;
 with t_CaseCodeTask do
 begin
  AtomClass := CaseCodeTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttCaseCode);
  end;//TaskType
 end;//CaseCodeTask
 // AutoAnnoExportTask
 t_AutoAnnoExportTask := DefineAutoType([t_ExportTask], '', AutoAnnoExportTaskTag) As AutoAnnoExportTaskTag;
 with t_AutoAnnoExportTask do
 begin
  AtomClass := AutoAnnoExportTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttAExportAnno);
  end;//TaskType
  with DefineProperty(k2_attrStartDate, t_DateTime, '') do
  begin
  end;//StartDate
  with DefineProperty(k2_attrEndDate, t_DateTime, '') do
  begin
  end;//EndDate
  t_AutoAnnoExportTask_BelongsIDList := DefineAutoType([t_OList], 'AutoAnnoExportTask BelongsIDList', AutoAnnoExportTask_BelongsIDList_Tag) As AutoAnnoExportTask_BelongsIDList_Tag;
  try
   t_AutoAnnoExportTask_BelongsIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrBelongsIDList, t_AutoAnnoExportTask_BelongsIDList, '');
   t_AutoAnnoExportTask_BelongsIDList.Recalc;
  except
   FreeAndNil(t_AutoAnnoExportTask_BelongsIDList);
  end;//try..except
  with t_AutoAnnoExportTask_BelongsIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//BelongsIDList
 end;//AutoAnnoExportTask
 // ImportTask
 t_ImportTask := DefineAutoType([t_ProcessTask], '', ImportTaskTag) As ImportTaskTag;
 with t_ImportTask do
 begin
  AtomClass := ImportTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttImport);
  end;//TaskType
  with DefineProperty(k2_attrDeleteIncluded, t_Bool, '') do
  begin
  end;//DeleteIncluded
  with DefineProperty(k2_attrIsAnnotation, t_Bool, '') do
  begin
  end;//IsAnnotation
  with DefineProperty(k2_attrIsRegion, t_Bool, '') do
  begin
  end;//IsRegion
  with DefineProperty(k2_attrSourceDir, t_String, '') do
  begin
  end;//SourceDir
  t_ImportTask_SourceFiles := DefineAutoType([t_OList], 'ImportTask SourceFiles', ImportTask_SourceFiles_Tag) As ImportTask_SourceFiles_Tag;
  try
   t_ImportTask_SourceFiles.DefineChildren(t_File);
   DefineProperty(k2_attrSourceFiles, t_ImportTask_SourceFiles, '');
   t_ImportTask_SourceFiles.Recalc;
  except
   FreeAndNil(t_ImportTask_SourceFiles);
  end;//try..except
  with t_ImportTask_SourceFiles.ArrayProp[k2_tiChildren] do
  begin
  end;//SourceFiles
  t_ImportTask_RegionIDList := DefineAutoType([t_OList], 'ImportTask RegionIDList', ImportTask_RegionIDList_Tag) As ImportTask_RegionIDList_Tag;
  try
   t_ImportTask_RegionIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrRegionIDList, t_ImportTask_RegionIDList, '');
   t_ImportTask_RegionIDList.Recalc;
  except
   FreeAndNil(t_ImportTask_RegionIDList);
  end;//try..except
  with t_ImportTask_RegionIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//RegionIDList
  with DefineProperty(k2_attrSafeDir, t_String, '') do
  begin
  end;//SafeDir
  with DefineProperty(k2_attrNeedSendMailReport, t_Bool, '') do
  begin
  end;//NeedSendMailReport
 end;//ImportTask
 // SpellCorrectTask
 t_SpellCorrectTask := DefineAutoType([t_ProcessTask], '', SpellCorrectTaskTag) As SpellCorrectTaskTag;
 with t_SpellCorrectTask do
 begin
  AtomClass := SpellCorrectTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttSpellCheck);
  end;//TaskType
  t_SpellCorrectTask_ReplacementFile := DefineAutoType([t_OList], 'SpellCorrectTask ReplacementFile', SpellCorrectTask_ReplacementFile_Tag) As SpellCorrectTask_ReplacementFile_Tag;
  try
   t_SpellCorrectTask_ReplacementFile.DefineChildren(t_File);
   DefineProperty(k2_attrReplacementFile, t_SpellCorrectTask_ReplacementFile, '');
   t_SpellCorrectTask_ReplacementFile.Recalc;
  except
   FreeAndNil(t_SpellCorrectTask_ReplacementFile);
  end;//try..except
  with t_SpellCorrectTask_ReplacementFile.ArrayProp[k2_tiChildren] do
  begin
   MaxChildrenCount := 1;
  end;//ReplacementFile
 end;//SpellCorrectTask
 // UserDefinedExportTask
 t_UserDefinedExportTask := DefineAutoType([t_ProcessTask], '', UserDefinedExportTaskTag) As UserDefinedExportTaskTag;
 with t_UserDefinedExportTask do
 begin
  AtomClass := UserDefinedExportTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttUserDefinedExport);
  end;//TaskType
  with DefineProperty(k2_attrQueryFile, t_String, '') do
  begin
  end;//QueryFile
  with DefineProperty(k2_attrTimeToRun, t_DateTime, '') do
  begin
  end;//TimeToRun
 end;//UserDefinedExportTask
 // CourtDecisionPhrase
 t_CourtDecisionPhrase := DefineAutoType([t_Tag], '', CourtDecisionPhraseTag) As CourtDecisionPhraseTag;
 with t_CourtDecisionPhrase do
 begin
  AtomClass := CourtDecisionPhraseTagClass;
  with DefineProperty(k2_attrPhrase, t_String, '') do
  begin
  end;//Phrase
 end;//CourtDecisionPhrase
 // ClientMessage
 t_ClientMessage := DefineAutoType([t_RequestTask], '', ClientMessageTag) As ClientMessageTag;
 with t_ClientMessage do
 begin
  AtomClass := ClientMessageTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttClientMessage);
  end;//TaskType
  t_ClientMessage_NotifyType := DefineAutoType([t_Enum], 'ClientMessage NotifyType', ClientMessage_NotifyType_Tag) As ClientMessage_NotifyType_Tag;
  try
   t_ClientMessage_NotifyType.AtomType := TypeInfo(TCsNotificationType);
   DefineProperty(k2_attrNotifyType, t_ClientMessage_NotifyType, '');
   t_ClientMessage_NotifyType.Recalc;
  except
   FreeAndNil(t_ClientMessage_NotifyType);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrNotifyType]) do
  begin
  end;//NotifyType
  with DefineProperty(k2_attrData, t_Long, '') do
  begin
  end;//Data
  with DefineProperty(k2_attrText, t_String, '') do
  begin
  end;//Text
 end;//ClientMessage
 // AnoncedExportTask
 t_AnoncedExportTask := DefineAutoType([t_ExportTask], '', AnoncedExportTaskTag) As AnoncedExportTaskTag;
 with t_AnoncedExportTask do
 begin
  AtomClass := AnoncedExportTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttAnoncedExport);
  end;//TaskType
  with DefineProperty(k2_attrOnThursdayMode, t_Bool, 'Режим экспорта "по четвергам"') do
  begin
  end;//OnThursdayMode
  with DefineProperty(k2_attrNotifyEMailList, t_String, '') do
  begin
  end;//NotifyEMailList
  with DefineProperty(k2_attrAnoncedDate, t_Long, '') do
  begin
  end;//AnoncedDate
  t_AnoncedExportTask_AccGroupsIDList := DefineAutoType([t_OList], 'AnoncedExportTask AccGroupsIDList', AnoncedExportTask_AccGroupsIDList_Tag) As AnoncedExportTask_AccGroupsIDList_Tag;
  try
   t_AnoncedExportTask_AccGroupsIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrAccGroupsIDList, t_AnoncedExportTask_AccGroupsIDList, '');
   t_AnoncedExportTask_AccGroupsIDList.Recalc;
  except
   FreeAndNil(t_AnoncedExportTask_AccGroupsIDList);
  end;//try..except
  with t_AnoncedExportTask_AccGroupsIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//AccGroupsIDList
 end;//AnoncedExportTask
 // HavanskyExportTask
 t_HavanskyExportTask := DefineAutoType([t_ExportTask], '', HavanskyExportTaskTag) As HavanskyExportTaskTag;
 with t_HavanskyExportTask do
 begin
  AtomClass := HavanskyExportTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := ord(cs_ttHavanskyExport);
  end;//TaskType
 end;//HavanskyExportTask
 // TaskResult
 t_TaskResult := DefineAutoType([t_Tag], '', TaskResultTag) As TaskResultTag;
 with t_TaskResult do
 begin
  AtomClass := TaskResultTagClass;
  with DefineProperty(k2_attrTaskID, t_String, '') do
  begin
  end;//TaskID
 end;//TaskResult
 // ImportTaskResult
 t_ImportTaskResult := DefineAutoType([t_TaskResult], '', ImportTaskResultTag) As ImportTaskResultTag;
 with t_ImportTaskResult do
 begin
  AtomClass := ImportTaskResultTagClass;
  with DefineProperty(k2_attrMailBody, t_String, '') do
  begin
  end;//MailBody
  t_ImportTaskResult_ImportedDocList := DefineAutoType([t_OList], 'ImportTaskResult ImportedDocList', ImportTaskResult_ImportedDocList_Tag) As ImportTaskResult_ImportedDocList_Tag;
  try
   t_ImportTaskResult_ImportedDocList.DefineChildren(t_Address);
   DefineProperty(k2_attrImportedDocList, t_ImportTaskResult_ImportedDocList, '');
   t_ImportTaskResult_ImportedDocList.Recalc;
  except
   FreeAndNil(t_ImportTaskResult_ImportedDocList);
  end;//try..except
  with t_ImportTaskResult_ImportedDocList.ArrayProp[k2_tiChildren] do
  begin
  end;//ImportedDocList
  with DefineProperty(k2_attrUserNotification, t_String, '') do
  begin
  end;//UserNotification
  with DefineProperty(k2_attrMailSubject, t_String, '') do
  begin
  end;//MailSubject
  with DefineProperty(k2_attrEMailSubject, t_String, '') do
  begin
  end;//EMailSubject
 end;//ImportTaskResult
 // RelPublishTaskResult
 t_RelPublishTaskResult := DefineAutoType([t_TaskResult], '', RelPublishTaskResultTag) As RelPublishTaskResultTag;
 with t_RelPublishTaskResult do
 begin
  AtomClass := RelPublishTaskResultTagClass;
  with DefineProperty(k2_attrMailBody, t_String, '') do
  begin
  end;//MailBody
  with DefineProperty(k2_attrIsError, t_Bool, '') do
  begin
  end;//IsError
 end;//RelPublishTaskResult
 // AACImportTaskResult
 t_AACImportTaskResult := DefineAutoType([t_TaskResult], '', AACImportTaskResultTag) As AACImportTaskResultTag;
 with t_AACImportTaskResult do
 begin
  AtomClass := AACImportTaskResultTagClass;
  with DefineProperty(k2_attrIsSuccess, t_Bool, '') do
  begin
  end;//IsSuccess
  with DefineProperty(k2_attrAttachFileName, t_String, '') do
  begin
  end;//AttachFileName
  with DefineProperty(k2_attrMailBody, t_String, '') do
  begin
  end;//MailBody
  with DefineProperty(k2_attrNeedRestart, t_Bool, '') do
  begin
  end;//NeedRestart
 end;//AACImportTaskResult
 // CourtDescription
 t_CourtDescription := DefineAutoType([t_Tag], '', CourtDescriptionTag) As CourtDescriptionTag;
 with t_CourtDescription do
 begin
  AtomClass := CourtDescriptionTagClass;
  with DefineProperty(k2_attrName, t_String, '') do
  begin
  end;//Name
  with DefineProperty(k2_attrSourceID, t_Long, '') do
  begin
  end;//SourceID
  with DefineProperty(k2_attrNeedProcess, t_Bool, '') do
  begin
  end;//NeedProcess
  t_CourtDescription_DecisionPhrases := DefineAutoType([t_OList], 'CourtDescription DecisionPhrases', CourtDescription_DecisionPhrases_Tag) As CourtDescription_DecisionPhrases_Tag;
  try
   t_CourtDescription_DecisionPhrases.DefineChildren(t_CourtDecisionPhrase);
   DefineProperty(k2_attrDecisionPhrases, t_CourtDescription_DecisionPhrases, '');
   t_CourtDescription_DecisionPhrases.Recalc;
  except
   FreeAndNil(t_CourtDescription_DecisionPhrases);
  end;//try..except
  with t_CourtDescription_DecisionPhrases.ArrayProp[k2_tiChildren] do
  begin
  end;//DecisionPhrases
 end;//CourtDescription
 // CourtDecisionSabCheckerParams
 t_CourtDecisionSabCheckerParams := DefineAutoType([t_Tag], '', CourtDecisionSabCheckerParamsTag) As CourtDecisionSabCheckerParamsTag;
 with t_CourtDecisionSabCheckerParams do
 begin
  AtomClass := CourtDecisionSabCheckerParamsTagClass;
  with DefineProperty(k2_attrDocTypeID, t_Long, '') do
  begin
  end;//DocTypeID
  {$If not defined(Region)}
  with DefineProperty(k2_attrLastUpdateDate, t_DateTime, '') do
  begin
  end;//LastUpdateDate
  {$IfEnd} //not Region
  with DefineProperty(k2_attrNotifyList, t_String, '') do
  begin
  end;//NotifyList
  t_CourtDecisionSabCheckerParams_CourtsList := DefineAutoType([t_OList], 'CourtDecisionSabCheckerParams CourtsList', CourtDecisionSabCheckerParams_CourtsList_Tag) As CourtDecisionSabCheckerParams_CourtsList_Tag;
  try
   t_CourtDecisionSabCheckerParams_CourtsList.DefineChildren(t_CourtDescription);
   DefineProperty(k2_attrCourtsList, t_CourtDecisionSabCheckerParams_CourtsList, '');
   t_CourtDecisionSabCheckerParams_CourtsList.Recalc;
  except
   FreeAndNil(t_CourtDecisionSabCheckerParams_CourtsList);
  end;//try..except
  with t_CourtDecisionSabCheckerParams_CourtsList.ArrayProp[k2_tiChildren] do
  begin
  end;//CourtsList
  with DefineProperty(k2_attrIsParamsValid, t_Bool, '') do
  begin
  end;//IsParamsValid
 end;//CourtDecisionSabCheckerParams
 // AACImport
 t_AACImport := DefineAutoType([t_ImportTask], '', AACImportTag) As AACImportTag;
 with t_AACImport do
 begin
  AtomClass := AACImportTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttAACImport);
  end;//TaskType
  with DefineProperty(k2_attrManualMode, t_Bool, '') do
  begin
  end;//ManualMode
  with DefineProperty(k2_attrCreatedByServer, t_Bool, '') do
  begin
  end;//CreatedByServer
  with DefineProperty(k2_attrLogsFolder, t_String, '') do
  begin
  end;//LogsFolder
  with DefineProperty(k2_attrDestinationFolder, t_String, '') do
  begin
  end;//DestinationFolder
  with DefineProperty(k2_attrZippedLogsFolder, t_String, '') do
  begin
  end;//ZippedLogsFolder
  with DefineProperty(k2_attrMailToLog, t_String, '') do
  begin
  end;//MailToLog
  with DefineProperty(k2_attrDuplicatesFolder, t_String, '') do
  begin
  end;//DuplicatesFolder
  with DefineProperty(k2_attrLinkDataFile, t_String, 'Данные для простановки ссылок') do
  begin
  end;//LinkDataFile
  with DefineProperty(k2_attrKeyThemesFile, t_String, 'Список Ключевых тем') do
  begin
  end;//KeyThemesFile
  t_AACImport_SourceIDList := DefineAutoType([t_OList], 'AACImport SourceIDList', AACImport_SourceIDList_Tag) As AACImport_SourceIDList_Tag;
  try
   t_AACImport_SourceIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrSourceIDList, t_AACImport_SourceIDList, '');
   t_AACImport_SourceIDList.Recalc;
  except
   FreeAndNil(t_AACImport_SourceIDList);
  end;//try..except
  with t_AACImport_SourceIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//SourceIDList
  with DefineProperty(k2_attrBaseArchiveName, t_String, '') do
  begin
  end;//BaseArchiveName
  t_AACImport_DossierSourceIDList := DefineAutoType([t_OList], 'AACImport DossierSourceIDList', AACImport_DossierSourceIDList_Tag) As AACImport_DossierSourceIDList_Tag;
  try
   t_AACImport_DossierSourceIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrDossierSourceIDList, t_AACImport_DossierSourceIDList, '');
   t_AACImport_DossierSourceIDList.Recalc;
  except
   FreeAndNil(t_AACImport_DossierSourceIDList);
  end;//try..except
  with t_AACImport_DossierSourceIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//DossierSourceIDList
  with DefineProperty(k2_attrMisspellsFileName, t_String, '') do
  begin
  end;//MisspellsFileName
  with DefineProperty(k2_attrFASCorrectFileName, t_String, '') do
  begin
  end;//FASCorrectFileName
  t_AACImport_DocTypesIDList := DefineAutoType([t_OList], 'AACImport DocTypesIDList', AACImport_DocTypesIDList_Tag) As AACImport_DocTypesIDList_Tag;
  try
   t_AACImport_DocTypesIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrDocTypesIDList, t_AACImport_DocTypesIDList, '');
   t_AACImport_DocTypesIDList.Recalc;
  except
   FreeAndNil(t_AACImport_DocTypesIDList);
  end;//try..except
  with t_AACImport_DocTypesIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//DocTypesIDList
  t_AACImport_FASSourceIDList := DefineAutoType([t_OList], 'AACImport FASSourceIDList', AACImport_FASSourceIDList_Tag) As AACImport_FASSourceIDList_Tag;
  try
   t_AACImport_FASSourceIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrFASSourceIDList, t_AACImport_FASSourceIDList, '');
   t_AACImport_FASSourceIDList.Recalc;
  except
   FreeAndNil(t_AACImport_FASSourceIDList);
  end;//try..except
  with t_AACImport_FASSourceIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//FASSourceIDList
  with DefineProperty(k2_attrSourceConvertFileName, t_String, '') do
  begin
  end;//SourceConvertFileName
  with DefineProperty(k2_attrTypeRecodeFileName, t_String, '') do
  begin
  end;//TypeRecodeFileName
  with DefineProperty(k2_attrSourceFileName, t_String, '') do
  begin
  end;//SourceFileName
  with DefineProperty(k2_attrPartialLoadPackSize, t_Long, '') do
  begin
  end;//PartialLoadPackSize
  with DefineProperty(k2_attrCourtDecisionSabCheckerParams, t_CourtDecisionSabCheckerParams, '') do
  begin
  end;//CourtDecisionSabCheckerParams
  with DefineProperty(k2_attrTaskCountBeforeRun, t_Long, '') do
  begin
  end;//TaskCountBeforeRun
 end;//AACImport
 // AutoClassTaskResult
 t_AutoClassTaskResult := DefineAutoType([t_TaskResult], '', AutoClassTaskResultTag) As AutoClassTaskResultTag;
 with t_AutoClassTaskResult do
 begin
  AtomClass := AutoClassTaskResultTagClass;
  with DefineProperty(k2_attrReportMessage, t_String, '') do
  begin
  end;//ReportMessage
  with DefineProperty(k2_attrMissedDocsStr, t_String, '') do
  begin
  end;//MissedDocsStr
  t_AutoClassTaskResult_DocumentIDList := DefineAutoType([t_OList], 'AutoClassTaskResult DocumentIDList', AutoClassTaskResult_DocumentIDList_Tag) As AutoClassTaskResult_DocumentIDList_Tag;
  try
   t_AutoClassTaskResult_DocumentIDList.DefineChildren(t_Address);
   DefineProperty(k2_attrDocumentIDList, t_AutoClassTaskResult_DocumentIDList, '');
   t_AutoClassTaskResult_DocumentIDList.Recalc;
  except
   FreeAndNil(t_AutoClassTaskResult_DocumentIDList);
  end;//try..except
  with t_AutoClassTaskResult_DocumentIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//DocumentIDList
 end;//AutoClassTaskResult
 // AnnotationTaskResult
 t_AnnotationTaskResult := DefineAutoType([t_TaskResult], '', AnnotationTaskResultTag) As AnnotationTaskResultTag;
 with t_AnnotationTaskResult do
 begin
  AtomClass := AnnotationTaskResultTagClass;
  with DefineProperty(k2_attrNeedReport, t_Bool, '') do
  begin
  end;//NeedReport
  with DefineProperty(k2_attrIsSuccess, t_Bool, '') do
  begin
  end;//IsSuccess
  with DefineProperty(k2_attrNextDate, t_DateTime, '') do
  begin
  end;//NextDate
  with DefineProperty(k2_attrReportMessage, t_String, '') do
  begin
  end;//ReportMessage
  with DefineProperty(k2_attrReportSubject, t_String, '') do
  begin
  end;//ReportSubject
  with DefineProperty(k2_attrReportAttach, t_String, '') do
  begin
  end;//ReportAttach
  with DefineProperty(k2_attrNeedSendToRobot, t_Bool, '') do
  begin
  end;//NeedSendToRobot
  with DefineProperty(k2_attrRobotMessage, t_String, '') do
  begin
  end;//RobotMessage
  with DefineProperty(k2_attrRobotAttach, t_String, '') do
  begin
  end;//RobotAttach
 end;//AnnotationTaskResult
 // AutoSpellTaskResult
 t_AutoSpellTaskResult := DefineAutoType([t_TaskResult], '', AutoSpellTaskResultTag) As AutoSpellTaskResultTag;
 with t_AutoSpellTaskResult do
 begin
  AtomClass := AutoSpellTaskResultTagClass;
  with DefineProperty(k2_attrReportMessage, t_String, '') do
  begin
  end;//ReportMessage
  with DefineProperty(k2_attrReportAttach, t_String, '') do
  begin
  end;//ReportAttach
 end;//AutoSpellTaskResult
 // AutoExportTaskResult
 t_AutoExportTaskResult := DefineAutoType([t_TaskResult], '', AutoExportTaskResultTag) As AutoExportTaskResultTag;
 with t_AutoExportTaskResult do
 begin
  AtomClass := AutoExportTaskResultTagClass;
  with DefineProperty(k2_attrReportMessage, t_String, '') do
  begin
  end;//ReportMessage
  with DefineProperty(k2_attrIsSuccess, t_Bool, '') do
  begin
  end;//IsSuccess
 end;//AutoExportTaskResult
 // FTPBrowser
 t_FTPBrowser := DefineAutoType([t_Tag], '', FTPBrowserTag) As FTPBrowserTag;
 with t_FTPBrowser do
 begin
  AtomClass := FTPBrowserTagClass;
  with DefineProperty(k2_attrServerName, t_String, '') do
  begin
  end;//ServerName
  with DefineProperty(k2_attrPort, t_Long, '') do
  begin
  end;//Port
  with DefineProperty(k2_attrLogin, t_String, '') do
  begin
  end;//Login
  with DefineProperty(k2_attrPassword, t_String, '') do
  begin
  end;//Password
  with DefineProperty(k2_attrPassiveMode, t_Bool, '') do
  begin
  end;//PassiveMode
  with DefineProperty(k2_attrRemoteFolder, t_String, '') do
  begin
  end;//RemoteFolder
  with DefineProperty(k2_attrLogTitle, t_String, '') do
  begin
  end;//LogTitle
 end;//FTPBrowser
 // RegionAutoExportTask
 t_RegionAutoExportTask := DefineAutoType([t_AutoExportTask], '', RegionAutoExportTaskTag) As RegionAutoExportTaskTag;
 with t_RegionAutoExportTask do
 begin
  AtomClass := RegionAutoExportTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttRegionAutoExport);
  end;//TaskType
  with DefineProperty(k2_attrRegionIndex, t_Long, '') do
  begin
  end;//RegionIndex
  with DefineProperty(k2_attrFTPParams, t_FTPBrowser, '') do
  begin
  end;//FTPParams
  with DefineProperty(k2_attrFileNameMask, t_String, '') do
  begin
  end;//FileNameMask
  with DefineProperty(k2_attrResultWarehouse, t_String, '') do
  begin
  end;//ResultWarehouse
 end;//RegionAutoExportTask
 // RegionImportTask
 t_RegionImportTask := DefineAutoType([t_ImportTask], '', RegionImportTaskTag) As RegionImportTaskTag;
 with t_RegionImportTask do
 begin
  AtomClass := RegionImportTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttRegionImport);
  end;//TaskType
  with DefineProperty(k2_attrRegionIndex, t_Long, '') do
  begin
  end;//RegionIndex
  with DefineProperty(k2_attrFTPParams, t_FTPBrowser, '') do
  begin
  end;//FTPParams
  with DefineProperty(k2_attrFileNameMask, t_String, '') do
  begin
  end;//FileNameMask
  with DefineProperty(k2_attrSourceWarehouse, t_String, '') do
  begin
  end;//SourceWarehouse
 end;//RegionImportTask
 // RegionImportTaskResult
 t_RegionImportTaskResult := DefineAutoType([t_ImportTaskResult], '', RegionImportTaskResultTag) As RegionImportTaskResultTag;
 with t_RegionImportTaskResult do
 begin
  AtomClass := RegionImportTaskResultTagClass;
  with DefineProperty(k2_attrHasMoreFilesToProcess, t_Bool, '') do
  begin
  end;//HasMoreFilesToProcess
 end;//RegionImportTaskResult
 // DataProviderParams
 t_DataProviderParams := DefineAutoType([t_Tag], '', DataProviderParamsTag) As DataProviderParamsTag;
 with t_DataProviderParams do
 begin
  AtomClass := DataProviderParamsTagClass;
  with DefineProperty(k2_attrLogin, t_String, '') do
  begin
  end;//Login
  with DefineProperty(k2_attrPassword, t_String, '') do
  begin
  end;//Password
  with DefineProperty(k2_attrDocStoragePath, t_String, '') do
  begin
  end;//DocStoragePath
  with DefineProperty(k2_attrDocImagePath, t_String, '') do
  begin
  end;//DocImagePath
  with DefineProperty(k2_attrHomeDirPath, t_String, '') do
  begin
  end;//HomeDirPath
  with DefineProperty(k2_attrDocBaseVersion, t_Long, '') do
  begin
  end;//DocBaseVersion
  with DefineProperty(k2_attrAdminBaseVersion, t_Long, '') do
  begin
  end;//AdminBaseVersion
  with DefineProperty(k2_attrDocImageCachePath, t_String, '') do
  begin
  end;//DocImageCachePath
 end;//DataProviderParams
 // HyTechProviderParams
 t_HyTechProviderParams := DefineAutoType([t_DataProviderParams], '', HyTechProviderParamsTag) As HyTechProviderParamsTag;
 with t_HyTechProviderParams do
 begin
  AtomClass := HyTechProviderParamsTagClass;
  with DefineProperty(k2_attrStationName, t_String, '') do
  begin
  end;//StationName
  with DefineProperty(k2_attrTablePath, t_String, '') do
  begin
  end;//TablePath
  with DefineProperty(k2_attrTmpDirPath, t_String, '') do
  begin
  end;//TmpDirPath
  with DefineProperty(k2_attrLockPath, t_String, '') do
  begin
  end;//LockPath
 end;//HyTechProviderParams
 // PostgresProviderParams
 t_PostgresProviderParams := DefineAutoType([t_DataProviderParams], '', PostgresProviderParamsTag) As PostgresProviderParamsTag;
 with t_PostgresProviderParams do
 begin
  AtomClass := PostgresProviderParamsTagClass;
  with DefineProperty(k2_attrDataServerHostName, t_String, '') do
  begin
  end;//DataServerHostName
  with DefineProperty(k2_attrDataServerPort, t_Long, '') do
  begin
  end;//DataServerPort
 end;//PostgresProviderParams
 // csMessage
 t_csMessage := DefineAutoType([t_Tag], '', csMessageTag) As csMessageTag;
 with t_csMessage do
 begin
  AtomClass := csMessageTagClass;
  t_csMessage_Kind := DefineAutoType([t_Enum], 'csMessage На сообщение должен быть послан ответ', csMessage_Kind_Tag) As csMessage_Kind_Tag;
  try
   t_csMessage_Kind.AtomType := TypeInfo(TncsMessageKind);
   DefineProperty(k2_attrKind, t_csMessage_Kind, 'На сообщение должен быть послан ответ');
   t_csMessage_Kind.Recalc;
  except
   FreeAndNil(t_csMessage_Kind);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrKind]) do
  begin
   DefaultValue := Ord(ord(ncs_mkSignal));
  end;//Kind
  with DefineProperty(k2_attrMessageID, t_String, 'Уникальный ключ по котороу ищется сообщение во всяких списках') do
  begin
  end;//MessageID
  with DefineProperty(k2_attrTimeStamp, t_DateTime, '') do
  begin
  end;//TimeStamp
 end;//csMessage
 // csLogin
 t_csLogin := DefineAutoType([t_csMessage], '', csLoginTag) As csLoginTag;
 with t_csLogin do
 begin
  AtomClass := csLoginTagClass;
  with Tk2CustomProperty(Prop[k2_attrKind]) do
  begin
   DefaultValue := ord(ncs_mkMessage);
  end;//Kind
  with DefineProperty(k2_attrServerHost, t_String, '') do
  begin
  end;//ServerHost
  with DefineProperty(k2_attrLogin, t_String, '') do
  begin
  end;//Login
  with DefineProperty(k2_attrPassword, t_String, '') do
  begin
  end;//Password
  with DefineProperty(k2_attrServerPort, t_Long, '') do
  begin
  end;//ServerPort
 end;//csLogin
 // csLoginReply
 t_csLoginReply := DefineAutoType([t_csMessage], '', csLoginReplyTag) As csLoginReplyTag;
 with t_csLoginReply do
 begin
  AtomClass := csLoginReplyTagClass;
  with Tk2CustomProperty(Prop[k2_attrKind]) do
  begin
   DefaultValue := ord(ncs_mkReply);
  end;//Kind
 end;//csLoginReply
 // csMessageWithReply
 t_csMessageWithReply := DefineAutoType([t_csMessage], '', csMessageWithReplyTag) As csMessageWithReplyTag;
 with t_csMessageWithReply do
 begin
  AtomClass := csMessageWithReplyTagClass;
  with Tk2CustomProperty(Prop[k2_attrKind]) do
  begin
   DefaultValue := ord(ncs_mkMessage);
  end;//Kind
 end;//csMessageWithReply
 // TaskID
 t_TaskID := DefineAutoType([t_Tag], '', TaskIDTag) As TaskIDTag;
 with t_TaskID do
 begin
  AtomClass := TaskIDTagClass;
  with DefineProperty(k2_attrName, t_String, '') do
  begin
  end;//Name
 end;//TaskID
 // csReply
 t_csReply := DefineAutoType([t_csMessage], '', csReplyTag) As csReplyTag;
 with t_csReply do
 begin
  AtomClass := csReplyTagClass;
  with Tk2CustomProperty(Prop[k2_attrKind]) do
  begin
   DefaultValue := ord(ncs_mkReply);
  end;//Kind
 end;//csReply
 // csGetReadyToDeliveryTasksReply
 t_csGetReadyToDeliveryTasksReply := DefineAutoType([t_csReply], '', csGetReadyToDeliveryTasksReplyTag) As csGetReadyToDeliveryTasksReplyTag;
 with t_csGetReadyToDeliveryTasksReply do
 begin
  AtomClass := csGetReadyToDeliveryTasksReplyTagClass;
  t_csGetReadyToDeliveryTasksReply_TasksIDList := DefineAutoType([t_OList], 'csGetReadyToDeliveryTasksReply TasksIDList', csGetReadyToDeliveryTasksReply_TasksIDList_Tag) As csGetReadyToDeliveryTasksReply_TasksIDList_Tag;
  try
   t_csGetReadyToDeliveryTasksReply_TasksIDList.DefineChildren(t_TaskID);
   DefineProperty(k2_attrTasksIDList, t_csGetReadyToDeliveryTasksReply_TasksIDList, '');
   t_csGetReadyToDeliveryTasksReply_TasksIDList.Recalc;
  except
   FreeAndNil(t_csGetReadyToDeliveryTasksReply_TasksIDList);
  end;//try..except
  with t_csGetReadyToDeliveryTasksReply_TasksIDList.ArrayProp[k2_tiChildren] do
  begin
  end;//TasksIDList
 end;//csGetReadyToDeliveryTasksReply
 // csGetReadyToDeliveryTasks
 t_csGetReadyToDeliveryTasks := DefineAutoType([t_csMessageWithReply], '', csGetReadyToDeliveryTasksTag) As csGetReadyToDeliveryTasksTag;
 with t_csGetReadyToDeliveryTasks do
 begin
  AtomClass := csGetReadyToDeliveryTasksTagClass;
  with DefineProperty(k2_attrUserID, t_ULong, '') do
  begin
  end;//UserID
 end;//csGetReadyToDeliveryTasks
 // csGetTaskDescription
 t_csGetTaskDescription := DefineAutoType([t_csMessageWithReply], '', csGetTaskDescriptionTag) As csGetTaskDescriptionTag;
 with t_csGetTaskDescription do
 begin
  AtomClass := csGetTaskDescriptionTagClass;
  with DefineProperty(k2_attrTaskID, t_String, '') do
  begin
  end;//TaskID
 end;//csGetTaskDescription
 // FileDesc
 t_FileDesc := DefineAutoType([t_Tag], '', FileDescTag) As FileDescTag;
 with t_FileDesc do
 begin
  AtomClass := FileDescTagClass;
  with DefineProperty(k2_attrName, t_String, '') do
  begin
  end;//Name
  with DefineProperty(k2_attrCRC, t_ULong, '') do
  begin
  end;//CRC
  with DefineProperty(k2_attrDateTime, t_Long, '') do
  begin
  end;//DateTime
  with DefineProperty(k2_attrSize, t_Int64, '') do
  begin
  end;//Size
 end;//FileDesc
 // csGetTaskDescriptionReply
 t_csGetTaskDescriptionReply := DefineAutoType([t_csReply], '', csGetTaskDescriptionReplyTag) As csGetTaskDescriptionReplyTag;
 with t_csGetTaskDescriptionReply do
 begin
  AtomClass := csGetTaskDescriptionReplyTagClass;
  with DefineProperty(k2_attrLocalFolder, t_String, '') do
  begin
  end;//LocalFolder
  with DefineProperty(k2_attrRemoteFolder, t_String, '') do
  begin
  end;//RemoteFolder
  t_csGetTaskDescriptionReply_FileDesc := DefineAutoType([t_OList], 'csGetTaskDescriptionReply FileDesc', csGetTaskDescriptionReply_FileDesc_Tag) As csGetTaskDescriptionReply_FileDesc_Tag;
  try
   t_csGetTaskDescriptionReply_FileDesc.DefineChildren(t_FileDesc);
   DefineProperty(k2_attrFileDesc, t_csGetTaskDescriptionReply_FileDesc, '');
   t_csGetTaskDescriptionReply_FileDesc.Recalc;
  except
   FreeAndNil(t_csGetTaskDescriptionReply_FileDesc);
  end;//try..except
  with t_csGetTaskDescriptionReply_FileDesc.ArrayProp[k2_tiChildren] do
  begin
  end;//FileDesc
 end;//csGetTaskDescriptionReply
 // TaskedFileDesc
 t_TaskedFileDesc := DefineAutoType([t_FileDesc], '', TaskedFileDescTag) As TaskedFileDescTag;
 with t_TaskedFileDesc do
 begin
  AtomClass := TaskedFileDescTagClass;
  with DefineProperty(k2_attrTaskID, t_String, '') do
  begin
  end;//TaskID
  with DefineProperty(k2_attrCopiedSize, t_Int64, '') do
  begin
  end;//CopiedSize
 end;//TaskedFileDesc
 // csTaskProgress
 t_csTaskProgress := DefineAutoType([t_csMessage], '', csTaskProgressTag) As csTaskProgressTag;
 with t_csTaskProgress do
 begin
  AtomClass := csTaskProgressTagClass;
  with DefineProperty(k2_attrTaskID, t_String, '') do
  begin
  end;//TaskID
  with DefineProperty(k2_attrDescription, t_String, '') do
  begin
  end;//Description
  with DefineProperty(k2_attrPercent, t_Long, '') do
  begin
  end;//Percent
 end;//csTaskProgress
 // csDeliveryResult
 t_csDeliveryResult := DefineAutoType([t_csMessage], '', csDeliveryResultTag) As csDeliveryResultTag;
 with t_csDeliveryResult do
 begin
  AtomClass := csDeliveryResultTagClass;
  with DefineProperty(k2_attrTaskID, t_String, '') do
  begin
  end;//TaskID
  t_csDeliveryResult_ResultKind := DefineAutoType([t_Enum], 'csDeliveryResult ResultKind', csDeliveryResult_ResultKind_Tag) As csDeliveryResult_ResultKind_Tag;
  try
   t_csDeliveryResult_ResultKind.AtomType := TypeInfo(TncsResultKind);
   DefineProperty(k2_attrResultKind, t_csDeliveryResult_ResultKind, '');
   t_csDeliveryResult_ResultKind.Recalc;
  except
   FreeAndNil(t_csDeliveryResult_ResultKind);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrResultKind]) do
  begin
  end;//ResultKind
 end;//csDeliveryResult
 // csGetFilePart
 t_csGetFilePart := DefineAutoType([t_csMessageWithReply], '', csGetFilePartTag) As csGetFilePartTag;
 with t_csGetFilePart do
 begin
  AtomClass := csGetFilePartTagClass;
  with DefineProperty(k2_attrTaskID, t_String, '') do
  begin
  end;//TaskID
  with DefineProperty(k2_attrFileName, t_String, 'С относительным путем (полный вычисляется от задачи)') do
  begin
  end;//FileName
  with DefineProperty(k2_attrOffset, t_Int64, '') do
  begin
  end;//Offset
  with DefineProperty(k2_attrPartSize, t_Int64, '') do
  begin
  end;//PartSize
 end;//csGetFilePart
 // csGetFilePartReply
 t_csGetFilePartReply := DefineAutoType([t_csReply], '', csGetFilePartReplyTag) As csGetFilePartReplyTag;
 with t_csGetFilePartReply do
 begin
  AtomClass := csGetFilePartReplyTagClass;
  with DefineProperty(k2_attrIsSuccess, t_Bool, '') do
  begin
  end;//IsSuccess
 end;//csGetFilePartReply
 // csDisconnect
 t_csDisconnect := DefineAutoType([t_csMessageWithReply], '', csDisconnectTag) As csDisconnectTag;
 with t_csDisconnect do
 begin
  AtomClass := csDisconnectTagClass;
 end;//csDisconnect
 // csDisconnectReply
 t_csDisconnectReply := DefineAutoType([t_csReply], '', csDisconnectReplyTag) As csDisconnectReplyTag;
 with t_csDisconnectReply do
 begin
  AtomClass := csDisconnectReplyTagClass;
 end;//csDisconnectReply
 // csSendTask
 t_csSendTask := DefineAutoType([t_csMessageWithReply], '', csSendTaskTag) As csSendTaskTag;
 with t_csSendTask do
 begin
  AtomClass := csSendTaskTagClass;
  with DefineProperty(k2_attrData, t_RawData, '') do
  begin
  end;//Data
 end;//csSendTask
 // csSendTaskReply
 t_csSendTaskReply := DefineAutoType([t_csReply], '', csSendTaskReplyTag) As csSendTaskReplyTag;
 with t_csSendTaskReply do
 begin
  AtomClass := csSendTaskReplyTagClass;
  with DefineProperty(k2_attrIsSuccess, t_Bool, '') do
  begin
  end;//IsSuccess
 end;//csSendTaskReply
 // csPushFilePart
 t_csPushFilePart := DefineAutoType([t_csMessage], '', csPushFilePartTag) As csPushFilePartTag;
 with t_csPushFilePart do
 begin
  AtomClass := csPushFilePartTagClass;
  with DefineProperty(k2_attrTaskID, t_String, '') do
  begin
  end;//TaskID
  with DefineProperty(k2_attrFileName, t_String, '') do
  begin
  end;//FileName
  with DefineProperty(k2_attrOffset, t_Int64, '') do
  begin
  end;//Offset
  with DefineProperty(k2_attrPartSize, t_Int64, '') do
  begin
  end;//PartSize
  with DefineProperty(k2_attrData, t_RawData, '') do
  begin
  end;//Data
 end;//csPushFilePart
 // csCorrectFolder
 t_csCorrectFolder := DefineAutoType([t_csMessage], '', csCorrectFolderTag) As csCorrectFolderTag;
 with t_csCorrectFolder do
 begin
  AtomClass := csCorrectFolderTagClass;
  with DefineProperty(k2_attrTaskID, t_String, '') do
  begin
  end;//TaskID
  with DefineProperty(k2_attrNewFolder, t_String, '') do
  begin
  end;//NewFolder
 end;//csCorrectFolder
 // RelPublishTask
 t_RelPublishTask := DefineAutoType([t_ImportTask], '', RelPublishTaskTag) As RelPublishTaskTag;
 with t_RelPublishTask do
 begin
  AtomClass := RelPublishTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttRelPublish);
  end;//TaskType
 end;//RelPublishTask
 // csGetPartialTaskDescription
 t_csGetPartialTaskDescription := DefineAutoType([t_csGetTaskDescription], '', csGetPartialTaskDescriptionTag) As csGetPartialTaskDescriptionTag;
 with t_csGetPartialTaskDescription do
 begin
  AtomClass := csGetPartialTaskDescriptionTagClass;
  with DefineProperty(k2_attrFileName, t_String, '') do
  begin
  end;//FileName
 end;//csGetPartialTaskDescription
 // mdpSync
 t_mdpSync := DefineAutoType([t_ProcessTask], '', mdpSyncTag) As mdpSyncTag;
 with t_mdpSync do
 begin
  AtomClass := mdpSyncTagClass;
  with DefineProperty(k2_attrSyncURL, t_String, '') do
  begin
  end;//SyncURL
  with DefineProperty(k2_attrUseProxy, t_Bool, '') do
  begin
  end;//UseProxy
  with DefineProperty(k2_attrProxyServer, t_String, '') do
  begin
  end;//ProxyServer
  with DefineProperty(k2_attrProxyPort, t_Long, '') do
  begin
  end;//ProxyPort
  with DefineProperty(k2_attrProxyLogin, t_String, '') do
  begin
  end;//ProxyLogin
  with DefineProperty(k2_attrProxyPassword, t_String, '') do
  begin
  end;//ProxyPassword
 end;//mdpSync
 // mdpImportDocs
 t_mdpImportDocs := DefineAutoType([t_ProcessTask], '', mdpImportDocsTag) As mdpImportDocsTag;
 with t_mdpImportDocs do
 begin
  AtomClass := mdpImportDocsTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttMdpImportDocs);
  end;//TaskType
  with DefineProperty(k2_attrMail, t_String, '') do
  begin
  end;//Mail
  with DefineProperty(k2_attrErrorMail, t_String, '') do
  begin
  end;//ErrorMail
  with DefineProperty(k2_attrMaxCount, t_Long, '') do
  begin
  end;//MaxCount
 end;//mdpImportDocs
 // ComboAccessProviderParams
 t_ComboAccessProviderParams := DefineAutoType([t_HyTechProviderParams], '', ComboAccessProviderParamsTag) As ComboAccessProviderParamsTag;
 with t_ComboAccessProviderParams do
 begin
  AtomClass := ComboAccessProviderParamsTagClass;
  with DefineProperty(k2_attrDataServerHostName, t_String, '') do
  begin
  end;//DataServerHostName
  with DefineProperty(k2_attrDataServerPort, t_Long, '') do
  begin
  end;//DataServerPort
 end;//ComboAccessProviderParams
 // ContainerTask
 t_ContainerTask := DefineAutoType([t_ProcessTask], '', ContainerTaskTag) As ContainerTaskTag;
 with t_ContainerTask do
 begin
  AtomClass := ContainerTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttContainer);
  end;//TaskType
  t_ContainerTask_TasksList := DefineAutoType([t_OList], 'ContainerTask TasksList', ContainerTask_TasksList_Tag) As ContainerTask_TasksList_Tag;
  try
   t_ContainerTask_TasksList.DefineChildren(t_ProcessTask);
   DefineProperty(k2_attrTasksList, t_ContainerTask_TasksList, '');
   t_ContainerTask_TasksList.Recalc;
  except
   FreeAndNil(t_ContainerTask_TasksList);
  end;//try..except
  with t_ContainerTask_TasksList.ArrayProp[k2_tiChildren] do
  begin
  end;//TasksList
  with DefineProperty(k2_attrParallelExecutionMode, t_Bool, '') do
  begin
  end;//ParallelExecutionMode
 end;//ContainerTask
 // SchedulerProxyTask
 t_SchedulerProxyTask := DefineAutoType([t_ProcessTask], '', SchedulerProxyTaskTag) As SchedulerProxyTaskTag;
 with t_SchedulerProxyTask do
 begin
  AtomClass := SchedulerProxyTaskTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttSchedulerProxy);
  end;//TaskType
  with DefineProperty(k2_attrSchedulerTaskType, t_Long, '') do
  begin
  end;//SchedulerTaskType
 end;//SchedulerProxyTask
 // mdpSyncDicts
 t_mdpSyncDicts := DefineAutoType([t_mdpSync], '', mdpSyncDictsTag) As mdpSyncDictsTag;
 with t_mdpSyncDicts do
 begin
  AtomClass := mdpSyncDictsTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttMdpSyncDicts);
  end;//TaskType
  with DefineProperty(k2_attrSyncFolderMask, t_String, '') do
  begin
  end;//SyncFolderMask
  with DefineProperty(k2_attrGuardName, t_String, '') do
  begin
  end;//GuardName
 end;//mdpSyncDicts
 // mdpSyncStages
 t_mdpSyncStages := DefineAutoType([t_mdpSync], '', mdpSyncStagesTag) As mdpSyncStagesTag;
 with t_mdpSyncStages do
 begin
  AtomClass := mdpSyncStagesTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttMdpSyncStages);
  end;//TaskType
 end;//mdpSyncStages
 // mdpSyncImport
 t_mdpSyncImport := DefineAutoType([t_mdpSync], '', mdpSyncImportTag) As mdpSyncImportTag;
 with t_mdpSyncImport do
 begin
  AtomClass := mdpSyncImportTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttMdpSyncImport);
  end;//TaskType
 end;//mdpSyncImport
 // FoundSelector
 t_FoundSelector := DefineAutoType([], '', FoundSelectorTag) As FoundSelectorTag;
 with t_FoundSelector do
 begin
  with DefineProperty(k2_attrPara, t_Handle, '') do
  begin
  end;//Para
  with DefineProperty(k2_attrWord, t_Handle, '') do
  begin
  end;//Word
  with DefineProperty(k2_attrDocument, t_Handle, '') do
  begin
  end;//Document
 end;//FoundSelector
 // csDownloadDocStreamReply
 t_csDownloadDocStreamReply := DefineAutoType([t_csReply], '', csDownloadDocStreamReplyTag) As csDownloadDocStreamReplyTag;
 with t_csDownloadDocStreamReply do
 begin
  AtomClass := csDownloadDocStreamReplyTagClass;
  with DefineProperty(k2_attrIsSuccess, t_Bool, '') do
  begin
  end;//IsSuccess
  with DefineProperty(k2_attrData, t_RawData, '') do
  begin
  end;//Data
  with DefineProperty(k2_attrErrorMessage, t_String, '') do
  begin
  end;//ErrorMessage
 end;//csDownloadDocStreamReply
 // csDownloadDocStream
 t_csDownloadDocStream := DefineAutoType([t_csMessageWithReply], '', csDownloadDocStreamTag) As csDownloadDocStreamTag;
 with t_csDownloadDocStream do
 begin
  AtomClass := csDownloadDocStreamTagClass;
  with DefineProperty(k2_attrDocID, t_Long, '') do
  begin
  end;//DocID
  with DefineProperty(k2_attrLevel, t_Long, '') do
  begin
  end;//Level
  with DefineProperty(k2_attrWithAttr, t_Bool, '') do
  begin
  end;//WithAttr
  t_csDownloadDocStream_FoundSelector := DefineAutoType([t_OList], 'csDownloadDocStream FoundSelector', csDownloadDocStream_FoundSelector_Tag) As csDownloadDocStream_FoundSelector_Tag;
  try
   t_csDownloadDocStream_FoundSelector.DefineChildren(t_FoundSelector);
   DefineProperty(k2_attrFoundSelector, t_csDownloadDocStream_FoundSelector, '');
   t_csDownloadDocStream_FoundSelector.Recalc;
  except
   FreeAndNil(t_csDownloadDocStream_FoundSelector);
  end;//try..except
  with t_csDownloadDocStream_FoundSelector.ArrayProp[k2_tiChildren] do
  begin
  end;//FoundSelector
  t_csDownloadDocStream_DocPart := DefineAutoType([t_Enum], 'csDownloadDocStream DocPart', csDownloadDocStream_DocPart_Tag) As csDownloadDocStream_DocPart_Tag;
  try
   t_csDownloadDocStream_DocPart.AtomType := TypeInfo(Tm3DocPartSelector);
   DefineProperty(k2_attrDocPart, t_csDownloadDocStream_DocPart, '');
   t_csDownloadDocStream_DocPart.Recalc;
  except
   FreeAndNil(t_csDownloadDocStream_DocPart);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrDocPart]) do
  begin
  end;//DocPart
  t_csDownloadDocStream_DocPartSel := DefineAutoType([t_Enum], 'csDownloadDocStream DocPartSel', csDownloadDocStream_DocPartSel_Tag) As csDownloadDocStream_DocPartSel_Tag;
  try
   t_csDownloadDocStream_DocPartSel.AtomType := TypeInfo(TDocPartSelector);
   DefineProperty(k2_attrDocPartSel, t_csDownloadDocStream_DocPartSel, '');
   t_csDownloadDocStream_DocPartSel.Recalc;
  except
   FreeAndNil(t_csDownloadDocStream_DocPartSel);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrDocPartSel]) do
  begin
  end;//DocPartSel
  with DefineProperty(k2_attrDocFamily, t_Long, '') do
  begin
  end;//DocFamily
  with DefineProperty(k2_attrIsObjTopic, t_Bool, '') do
  begin
  end;//IsObjTopic
  with DefineProperty(k2_attrDocumentType, t_String, '') do
  begin
  end;//DocumentType
 end;//csDownloadDocStream
 // DownloadDocRequest
 t_DownloadDocRequest := DefineAutoType([t_ProcessTask], '', DownloadDocRequestTag) As DownloadDocRequestTag;
 with t_DownloadDocRequest do
 begin
  AtomClass := DownloadDocRequestTagClass;
  with Tk2CustomProperty(Prop[k2_attrTaskType]) do
  begin
   DefaultValue := Ord(cs_ttDownloadDoc);
  end;//TaskType
 end;//DownloadDocRequest
 // csUploadDocStream
 t_csUploadDocStream := DefineAutoType([t_csMessageWithReply], '', csUploadDocStreamTag) As csUploadDocStreamTag;
 with t_csUploadDocStream do
 begin
  AtomClass := csUploadDocStreamTagClass;
  with DefineProperty(k2_attrData, t_RawData, '') do
  begin
  end;//Data
  with DefineProperty(k2_attrIsObjTopic, t_Bool, '') do
  begin
  end;//IsObjTopic
  with DefineProperty(k2_attrDocFamily, t_Long, '') do
  begin
  end;//DocFamily
  with DefineProperty(k2_attrDocID, t_Long, '') do
  begin
  end;//DocID
  t_csUploadDocStream_DocPart := DefineAutoType([t_Enum], 'csUploadDocStream DocPart', csUploadDocStream_DocPart_Tag) As csUploadDocStream_DocPart_Tag;
  try
   t_csUploadDocStream_DocPart.AtomType := TypeInfo(Tm3DocPartSelector);
   DefineProperty(k2_attrDocPart, t_csUploadDocStream_DocPart, '');
   t_csUploadDocStream_DocPart.Recalc;
  except
   FreeAndNil(t_csUploadDocStream_DocPart);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrDocPart]) do
  begin
  end;//DocPart
  with DefineProperty(k2_attrParseToDB, t_Bool, '') do
  begin
  end;//ParseToDB
  with DefineProperty(k2_attrIsClassChanged, t_Bool, '') do
  begin
  end;//IsClassChanged
  with DefineProperty(k2_attrNeedSaveText, t_Bool, '') do
  begin
  end;//NeedSaveText
  t_csUploadDocStream_DocClass := DefineAutoType([t_Enum], 'csUploadDocStream DocClass', csUploadDocStream_DocClass_Tag) As csUploadDocStream_DocClass_Tag;
  try
   t_csUploadDocStream_DocClass.AtomType := TypeInfo(TDocType);
   DefineProperty(k2_attrDocClass, t_csUploadDocStream_DocClass, '');
   t_csUploadDocStream_DocClass.Recalc;
  except
   FreeAndNil(t_csUploadDocStream_DocClass);
  end;//try..except
  with Tk2CustomProperty(Prop[k2_attrDocClass]) do
  begin
  end;//DocClass
 end;//csUploadDocStream
 // csUploadDocStreamReply
 t_csUploadDocStreamReply := DefineAutoType([t_csReply], '', csUploadDocStreamReplyTag) As csUploadDocStreamReplyTag;
 with t_csUploadDocStreamReply do
 begin
  AtomClass := csUploadDocStreamReplyTagClass;
  with DefineProperty(k2_attrIsSuccess, t_Bool, '') do
  begin
  end;//IsSuccess
  with DefineProperty(k2_attrErrorMessage, t_String, '') do
  begin
  end;//ErrorMessage
 end;//csUploadDocStreamReply
 t_ULong.Recalc;
 t_DateTime.Recalc;
 t_DateTimeNotNull.Recalc;
 t_Task.Recalc;
 t_RequestTask.Recalc;
 t_Type.Recalc;
 t_Address.Recalc;
 t_ProcessTask.Recalc;
 t_ExportTask.Recalc;
 t_DictEditQuery.Recalc;
 t_UserEditQuery.Recalc;
 t_PlainFile.Recalc;
 t_AutoSpellTask.Recalc;
 t_CommonDataRequest.Recalc;
 t_LineRequest.Recalc;
 t_ServerStatusRequest.Recalc;
 t_DeleteDocsQuery.Recalc;
 t_TaskResultRequest.Recalc;
 t_GetTaskRequest.Recalc;
 t_AutoClassTask.Recalc;
 t_AnnotationTask.Recalc;
 t_AutoExportTask.Recalc;
 t_RunCommandTask.Recalc;
 t_File.Recalc;
 t_CaseCodeTask.Recalc;
 t_AutoAnnoExportTask.Recalc;
 t_ImportTask.Recalc;
 t_SpellCorrectTask.Recalc;
 t_UserDefinedExportTask.Recalc;
 t_CourtDecisionPhrase.Recalc;
 t_ClientMessage.Recalc;
 t_AnoncedExportTask.Recalc;
 t_HavanskyExportTask.Recalc;
 t_TaskResult.Recalc;
 t_ImportTaskResult.Recalc;
 t_RelPublishTaskResult.Recalc;
 t_AACImportTaskResult.Recalc;
 t_CourtDescription.Recalc;
 t_CourtDecisionSabCheckerParams.Recalc;
 t_AACImport.Recalc;
 t_AutoClassTaskResult.Recalc;
 t_AnnotationTaskResult.Recalc;
 t_AutoSpellTaskResult.Recalc;
 t_AutoExportTaskResult.Recalc;
 t_FTPBrowser.Recalc;
 t_RegionAutoExportTask.Recalc;
 t_RegionImportTask.Recalc;
 t_RegionImportTaskResult.Recalc;
 t_DataProviderParams.Recalc;
 t_HyTechProviderParams.Recalc;
 t_PostgresProviderParams.Recalc;
 t_csMessage.Recalc;
 t_csLogin.Recalc;
 t_csLoginReply.Recalc;
 t_csMessageWithReply.Recalc;
 t_TaskID.Recalc;
 t_csReply.Recalc;
 t_csGetReadyToDeliveryTasksReply.Recalc;
 t_csGetReadyToDeliveryTasks.Recalc;
 t_csGetTaskDescription.Recalc;
 t_FileDesc.Recalc;
 t_csGetTaskDescriptionReply.Recalc;
 t_TaskedFileDesc.Recalc;
 t_csTaskProgress.Recalc;
 t_csDeliveryResult.Recalc;
 t_csGetFilePart.Recalc;
 t_csGetFilePartReply.Recalc;
 t_csDisconnect.Recalc;
 t_csDisconnectReply.Recalc;
 t_csSendTask.Recalc;
 t_csSendTaskReply.Recalc;
 t_csPushFilePart.Recalc;
 t_csCorrectFolder.Recalc;
 t_RelPublishTask.Recalc;
 t_csGetPartialTaskDescription.Recalc;
 t_mdpSync.Recalc;
 t_mdpImportDocs.Recalc;
 t_ComboAccessProviderParams.Recalc;
 t_ContainerTask.Recalc;
 t_SchedulerProxyTask.Recalc;
 t_mdpSyncDicts.Recalc;
 t_mdpSyncStages.Recalc;
 t_mdpSyncImport.Recalc;
 t_FoundSelector.Recalc;
 t_csDownloadDocStreamReply.Recalc;
 t_csDownloadDocStream.Recalc;
 t_DownloadDocRequest.Recalc;
 t_csUploadDocStream.Recalc;
 t_csUploadDocStreamReply.Recalc;
end;

// определяем стандартные методы схемы


procedure TevdTasksSchema.Cleanup;
begin
 t_ULong.InterfaceFactory := nil;
 t_DateTime.InterfaceFactory := nil;
 t_DateTimeNotNull.InterfaceFactory := nil;
 t_Task.InterfaceFactory := nil;
 t_Task_TaskType.InterfaceFactory := nil;
 t_RequestTask.InterfaceFactory := nil;
 t_Type.InterfaceFactory := nil;
 t_Address.InterfaceFactory := nil;
 t_Address_ViewKind.InterfaceFactory := nil;
 t_ProcessTask.InterfaceFactory := nil;
 t_ProcessTask_Status.InterfaceFactory := nil;
 t_ProcessTask_DocumentIDList.InterfaceFactory := nil;
 t_ExportTask.InterfaceFactory := nil;
 t_ExportTask_DiapasonType.InterfaceFactory := nil;
 t_ExportTask_OutFileType.InterfaceFactory := nil;
 t_ExportTask_SeparateFiles.InterfaceFactory := nil;
 t_ExportTask_SABStream.InterfaceFactory := nil;
 t_ExportTask_RegionIDList.InterfaceFactory := nil;
 t_DictEditQuery.InterfaceFactory := nil;
 t_UserEditQuery.InterfaceFactory := nil;
 t_PlainFile.InterfaceFactory := nil;
 t_AutoSpellTask.InterfaceFactory := nil;
 t_CommonDataRequest.InterfaceFactory := nil;
 t_LineRequest.InterfaceFactory := nil;
 t_ServerStatusRequest.InterfaceFactory := nil;
 t_DeleteDocsQuery.InterfaceFactory := nil;
 t_TaskResultRequest.InterfaceFactory := nil;
 t_GetTaskRequest.InterfaceFactory := nil;
 t_AutoClassTask.InterfaceFactory := nil;
 t_AnnotationTask.InterfaceFactory := nil;
 t_AnnotationTask_BelongsIDList.InterfaceFactory := nil;
 {$If not defined(Region)}
 t_AnnotationTask_ExcludeAccGroupsIDList.InterfaceFactory := nil;
 {$IfEnd} //not Region
 t_AnnotationTask_AccGroupsIDList.InterfaceFactory := nil;
 t_AnnotationTask_CommentsIDList.InterfaceFactory := nil;
 t_AnnotationTask_ExcludeDocTypesIDList.InterfaceFactory := nil;
 t_AnnotationTask_ExcludeDocBasesIDList.InterfaceFactory := nil;
 t_AutoExportTask.InterfaceFactory := nil;
 t_AutoExportTask_OutFormat.InterfaceFactory := nil;
 t_AutoExportTask_DocumentsSource.InterfaceFactory := nil;
 t_AutoExportTask_AccGroupsIDList.InterfaceFactory := nil;
 {$If not defined(LUK) AND not defined(SGC)}
 t_AutoExportTask_BasesIDList.InterfaceFactory := nil;
 {$IfEnd} //not LUK AND not SGC
 t_AutoExportTask_InfoIDList.InterfaceFactory := nil;
 t_AutoExportTask_Stages.InterfaceFactory := nil;
 t_RunCommandTask.InterfaceFactory := nil;
 t_File.InterfaceFactory := nil;
 t_File_AdditionalFiles.InterfaceFactory := nil;
 t_CaseCodeTask.InterfaceFactory := nil;
 t_AutoAnnoExportTask.InterfaceFactory := nil;
 t_AutoAnnoExportTask_BelongsIDList.InterfaceFactory := nil;
 t_ImportTask.InterfaceFactory := nil;
 t_ImportTask_SourceFiles.InterfaceFactory := nil;
 t_ImportTask_RegionIDList.InterfaceFactory := nil;
 t_SpellCorrectTask.InterfaceFactory := nil;
 t_SpellCorrectTask_ReplacementFile.InterfaceFactory := nil;
 t_UserDefinedExportTask.InterfaceFactory := nil;
 t_CourtDecisionPhrase.InterfaceFactory := nil;
 t_ClientMessage.InterfaceFactory := nil;
 t_ClientMessage_NotifyType.InterfaceFactory := nil;
 t_AnoncedExportTask.InterfaceFactory := nil;
 t_AnoncedExportTask_AccGroupsIDList.InterfaceFactory := nil;
 t_HavanskyExportTask.InterfaceFactory := nil;
 t_TaskResult.InterfaceFactory := nil;
 t_ImportTaskResult.InterfaceFactory := nil;
 t_ImportTaskResult_ImportedDocList.InterfaceFactory := nil;
 t_RelPublishTaskResult.InterfaceFactory := nil;
 t_AACImportTaskResult.InterfaceFactory := nil;
 t_CourtDescription.InterfaceFactory := nil;
 t_CourtDescription_DecisionPhrases.InterfaceFactory := nil;
 t_CourtDecisionSabCheckerParams.InterfaceFactory := nil;
 t_CourtDecisionSabCheckerParams_CourtsList.InterfaceFactory := nil;
 t_AACImport.InterfaceFactory := nil;
 t_AACImport_SourceIDList.InterfaceFactory := nil;
 t_AACImport_DossierSourceIDList.InterfaceFactory := nil;
 t_AACImport_DocTypesIDList.InterfaceFactory := nil;
 t_AACImport_FASSourceIDList.InterfaceFactory := nil;
 t_AutoClassTaskResult.InterfaceFactory := nil;
 t_AutoClassTaskResult_DocumentIDList.InterfaceFactory := nil;
 t_AnnotationTaskResult.InterfaceFactory := nil;
 t_AutoSpellTaskResult.InterfaceFactory := nil;
 t_AutoExportTaskResult.InterfaceFactory := nil;
 t_FTPBrowser.InterfaceFactory := nil;
 t_RegionAutoExportTask.InterfaceFactory := nil;
 t_RegionImportTask.InterfaceFactory := nil;
 t_RegionImportTaskResult.InterfaceFactory := nil;
 t_DataProviderParams.InterfaceFactory := nil;
 t_HyTechProviderParams.InterfaceFactory := nil;
 t_PostgresProviderParams.InterfaceFactory := nil;
 t_csMessage.InterfaceFactory := nil;
 t_csMessage_Kind.InterfaceFactory := nil;
 t_csLogin.InterfaceFactory := nil;
 t_csLoginReply.InterfaceFactory := nil;
 t_csMessageWithReply.InterfaceFactory := nil;
 t_TaskID.InterfaceFactory := nil;
 t_csReply.InterfaceFactory := nil;
 t_csGetReadyToDeliveryTasksReply.InterfaceFactory := nil;
 t_csGetReadyToDeliveryTasksReply_TasksIDList.InterfaceFactory := nil;
 t_csGetReadyToDeliveryTasks.InterfaceFactory := nil;
 t_csGetTaskDescription.InterfaceFactory := nil;
 t_FileDesc.InterfaceFactory := nil;
 t_csGetTaskDescriptionReply.InterfaceFactory := nil;
 t_csGetTaskDescriptionReply_FileDesc.InterfaceFactory := nil;
 t_TaskedFileDesc.InterfaceFactory := nil;
 t_csTaskProgress.InterfaceFactory := nil;
 t_csDeliveryResult.InterfaceFactory := nil;
 t_csDeliveryResult_ResultKind.InterfaceFactory := nil;
 t_csGetFilePart.InterfaceFactory := nil;
 t_csGetFilePartReply.InterfaceFactory := nil;
 t_csDisconnect.InterfaceFactory := nil;
 t_csDisconnectReply.InterfaceFactory := nil;
 t_csSendTask.InterfaceFactory := nil;
 t_csSendTaskReply.InterfaceFactory := nil;
 t_csPushFilePart.InterfaceFactory := nil;
 t_csCorrectFolder.InterfaceFactory := nil;
 t_RelPublishTask.InterfaceFactory := nil;
 t_csGetPartialTaskDescription.InterfaceFactory := nil;
 t_mdpSync.InterfaceFactory := nil;
 t_mdpImportDocs.InterfaceFactory := nil;
 t_ComboAccessProviderParams.InterfaceFactory := nil;
 t_ContainerTask.InterfaceFactory := nil;
 t_ContainerTask_TasksList.InterfaceFactory := nil;
 t_SchedulerProxyTask.InterfaceFactory := nil;
 t_mdpSyncDicts.InterfaceFactory := nil;
 t_mdpSyncStages.InterfaceFactory := nil;
 t_mdpSyncImport.InterfaceFactory := nil;
 t_FoundSelector.InterfaceFactory := nil;
 t_csDownloadDocStreamReply.InterfaceFactory := nil;
 t_csDownloadDocStream.InterfaceFactory := nil;
 t_csDownloadDocStream_FoundSelector.InterfaceFactory := nil;
 t_csDownloadDocStream_DocPart.InterfaceFactory := nil;
 t_csDownloadDocStream_DocPartSel.InterfaceFactory := nil;
 t_DownloadDocRequest.InterfaceFactory := nil;
 t_csUploadDocStream.InterfaceFactory := nil;
 t_csUploadDocStream_DocPart.InterfaceFactory := nil;
 t_csUploadDocStream_DocClass.InterfaceFactory := nil;
 t_csUploadDocStreamReply.InterfaceFactory := nil;
 FreeAndNil(t_ULong);
 FreeAndNil(t_DateTime);
 FreeAndNil(t_DateTimeNotNull);
 FreeAndNil(t_Task);
 FreeAndNil(t_Task_TaskType);
 FreeAndNil(t_RequestTask);
 FreeAndNil(t_Type);
 FreeAndNil(t_Address);
 FreeAndNil(t_Address_ViewKind);
 FreeAndNil(t_ProcessTask);
 FreeAndNil(t_ProcessTask_Status);
 FreeAndNil(t_ProcessTask_DocumentIDList);
 FreeAndNil(t_ExportTask);
 FreeAndNil(t_ExportTask_DiapasonType);
 FreeAndNil(t_ExportTask_OutFileType);
 FreeAndNil(t_ExportTask_SeparateFiles);
 FreeAndNil(t_ExportTask_SABStream);
 FreeAndNil(t_ExportTask_RegionIDList);
 FreeAndNil(t_DictEditQuery);
 FreeAndNil(t_UserEditQuery);
 FreeAndNil(t_PlainFile);
 FreeAndNil(t_AutoSpellTask);
 FreeAndNil(t_CommonDataRequest);
 FreeAndNil(t_LineRequest);
 FreeAndNil(t_ServerStatusRequest);
 FreeAndNil(t_DeleteDocsQuery);
 FreeAndNil(t_TaskResultRequest);
 FreeAndNil(t_GetTaskRequest);
 FreeAndNil(t_AutoClassTask);
 FreeAndNil(t_AnnotationTask);
 FreeAndNil(t_AnnotationTask_BelongsIDList);
 {$If not defined(Region)}
 FreeAndNil(t_AnnotationTask_ExcludeAccGroupsIDList);
 {$IfEnd} //not Region
 FreeAndNil(t_AnnotationTask_AccGroupsIDList);
 FreeAndNil(t_AnnotationTask_CommentsIDList);
 FreeAndNil(t_AnnotationTask_ExcludeDocTypesIDList);
 FreeAndNil(t_AnnotationTask_ExcludeDocBasesIDList);
 FreeAndNil(t_AutoExportTask);
 FreeAndNil(t_AutoExportTask_OutFormat);
 FreeAndNil(t_AutoExportTask_DocumentsSource);
 FreeAndNil(t_AutoExportTask_AccGroupsIDList);
 {$If not defined(LUK) AND not defined(SGC)}
 FreeAndNil(t_AutoExportTask_BasesIDList);
 {$IfEnd} //not LUK AND not SGC
 FreeAndNil(t_AutoExportTask_InfoIDList);
 FreeAndNil(t_AutoExportTask_Stages);
 FreeAndNil(t_RunCommandTask);
 FreeAndNil(t_File);
 FreeAndNil(t_File_AdditionalFiles);
 FreeAndNil(t_CaseCodeTask);
 FreeAndNil(t_AutoAnnoExportTask);
 FreeAndNil(t_AutoAnnoExportTask_BelongsIDList);
 FreeAndNil(t_ImportTask);
 FreeAndNil(t_ImportTask_SourceFiles);
 FreeAndNil(t_ImportTask_RegionIDList);
 FreeAndNil(t_SpellCorrectTask);
 FreeAndNil(t_SpellCorrectTask_ReplacementFile);
 FreeAndNil(t_UserDefinedExportTask);
 FreeAndNil(t_CourtDecisionPhrase);
 FreeAndNil(t_ClientMessage);
 FreeAndNil(t_ClientMessage_NotifyType);
 FreeAndNil(t_AnoncedExportTask);
 FreeAndNil(t_AnoncedExportTask_AccGroupsIDList);
 FreeAndNil(t_HavanskyExportTask);
 FreeAndNil(t_TaskResult);
 FreeAndNil(t_ImportTaskResult);
 FreeAndNil(t_ImportTaskResult_ImportedDocList);
 FreeAndNil(t_RelPublishTaskResult);
 FreeAndNil(t_AACImportTaskResult);
 FreeAndNil(t_CourtDescription);
 FreeAndNil(t_CourtDescription_DecisionPhrases);
 FreeAndNil(t_CourtDecisionSabCheckerParams);
 FreeAndNil(t_CourtDecisionSabCheckerParams_CourtsList);
 FreeAndNil(t_AACImport);
 FreeAndNil(t_AACImport_SourceIDList);
 FreeAndNil(t_AACImport_DossierSourceIDList);
 FreeAndNil(t_AACImport_DocTypesIDList);
 FreeAndNil(t_AACImport_FASSourceIDList);
 FreeAndNil(t_AutoClassTaskResult);
 FreeAndNil(t_AutoClassTaskResult_DocumentIDList);
 FreeAndNil(t_AnnotationTaskResult);
 FreeAndNil(t_AutoSpellTaskResult);
 FreeAndNil(t_AutoExportTaskResult);
 FreeAndNil(t_FTPBrowser);
 FreeAndNil(t_RegionAutoExportTask);
 FreeAndNil(t_RegionImportTask);
 FreeAndNil(t_RegionImportTaskResult);
 FreeAndNil(t_DataProviderParams);
 FreeAndNil(t_HyTechProviderParams);
 FreeAndNil(t_PostgresProviderParams);
 FreeAndNil(t_csMessage);
 FreeAndNil(t_csMessage_Kind);
 FreeAndNil(t_csLogin);
 FreeAndNil(t_csLoginReply);
 FreeAndNil(t_csMessageWithReply);
 FreeAndNil(t_TaskID);
 FreeAndNil(t_csReply);
 FreeAndNil(t_csGetReadyToDeliveryTasksReply);
 FreeAndNil(t_csGetReadyToDeliveryTasksReply_TasksIDList);
 FreeAndNil(t_csGetReadyToDeliveryTasks);
 FreeAndNil(t_csGetTaskDescription);
 FreeAndNil(t_FileDesc);
 FreeAndNil(t_csGetTaskDescriptionReply);
 FreeAndNil(t_csGetTaskDescriptionReply_FileDesc);
 FreeAndNil(t_TaskedFileDesc);
 FreeAndNil(t_csTaskProgress);
 FreeAndNil(t_csDeliveryResult);
 FreeAndNil(t_csDeliveryResult_ResultKind);
 FreeAndNil(t_csGetFilePart);
 FreeAndNil(t_csGetFilePartReply);
 FreeAndNil(t_csDisconnect);
 FreeAndNil(t_csDisconnectReply);
 FreeAndNil(t_csSendTask);
 FreeAndNil(t_csSendTaskReply);
 FreeAndNil(t_csPushFilePart);
 FreeAndNil(t_csCorrectFolder);
 FreeAndNil(t_RelPublishTask);
 FreeAndNil(t_csGetPartialTaskDescription);
 FreeAndNil(t_mdpSync);
 FreeAndNil(t_mdpImportDocs);
 FreeAndNil(t_ComboAccessProviderParams);
 FreeAndNil(t_ContainerTask);
 FreeAndNil(t_ContainerTask_TasksList);
 FreeAndNil(t_SchedulerProxyTask);
 FreeAndNil(t_mdpSyncDicts);
 FreeAndNil(t_mdpSyncStages);
 FreeAndNil(t_mdpSyncImport);
 FreeAndNil(t_FoundSelector);
 FreeAndNil(t_csDownloadDocStreamReply);
 FreeAndNil(t_csDownloadDocStream);
 FreeAndNil(t_csDownloadDocStream_FoundSelector);
 FreeAndNil(t_csDownloadDocStream_DocPart);
 FreeAndNil(t_csDownloadDocStream_DocPartSel);
 FreeAndNil(t_DownloadDocRequest);
 FreeAndNil(t_csUploadDocStream);
 FreeAndNil(t_csUploadDocStream_DocPart);
 FreeAndNil(t_csUploadDocStream_DocClass);
 FreeAndNil(t_csUploadDocStreamReply);
 inherited;
end;


initialization
 TevdTasksSchema.SetAsDefault;

end.