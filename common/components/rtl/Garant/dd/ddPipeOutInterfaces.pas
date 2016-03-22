unit ddPipeOutInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddPipeOutInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::dd::ddPipeOutInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3Interfaces,
  l3Filer
  ;

type
 TddExportDocPart = (
   edpDocument
 , edpReference
 , edpAnnotation
 );//TddExportDocPart

 IddExportFilerDispatcherElem = interface(IUnknown)
   ['{3CED5DB0-6E54-4C2F-A404-FCE80475BDAF}']
   procedure RollBack;
     {* Сигнатура метода RollBack }
   function Get_Filer: Tl3CustomFiler;
   property Filer: Tl3CustomFiler
     read Get_Filer;
 end;//IddExportFilerDispatcherElem

 TddFilerDispatcherMapKeyRecord = record
   rPart : TddExportDocPart;
   rAccGroup : Il3CString;
 end;//TddFilerDispatcherMapKeyRecord

 TddExportDivideBy = (
   edbTopic
 , edbSize
 , edbAccGroup
 );//TddExportDivideBy

 TddExportDivideBySet = set of TddExportDivideBy;

 TddExportFileMaskPatternType = (
   eptPartNum
 , eptAccGroup
 , eptExportDate
 );//TddExportFileMaskPatternType

const
  { cExportFileMaskPatterns }
 cExportFileMaskPatterns : array [TddExportFileMaskPatternType] of Tl3WString = (
  (S: '%NUMBER%'; SLen: 8; SCodePage: 0)
  , (S: '%MAIN%'; SLen: 6; SCodePage: 0)
  , (S: '%DATE%'; SLen: 6; SCodePage: 0)
 );//cExportFileMaskPatterns
  { cDefaultFileMask }
 cDefaultFileMask : array [TddExportDocPart] of AnsiString = (
  'document'
  , 'related'
  , 'annotation'
 );//cDefaultFileMask
  { Сообщения }
 cFilerOpenErrorMsg = 'CRITICAL ERROR: Ошибка (%s) открытия файла %s';

type
 TddReportEmptyEvent = procedure (aSender: TObject;
  aEmptyCount: Integer) of object;

 IddAnnoKindSortItem = interface(IUnknown)
   ['{D93F4C6D-BBE9-4571-9EB2-E0100534B695}']
   procedure Add(aTopic: Integer);
   function Get_Name: Il3CString;
   function Get_Count: Integer;
   function Get_ID: Integer;
   function Get_Topics(aIdx: Integer): Integer;
   property Name: Il3CString
     read Get_Name;
   property Count: Integer
     read Get_Count;
   property ID: Integer
     read Get_ID;
   property Topics[aIdx: Integer]: Integer
     read Get_Topics;
 end;//IddAnnoKindSortItem

implementation

end.