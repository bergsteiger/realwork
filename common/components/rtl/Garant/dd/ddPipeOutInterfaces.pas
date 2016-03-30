unit ddPipeOutInterfaces;

// Модуль: "w:\common\components\rtl\Garant\dd\ddPipeOutInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "ddPipeOutInterfaces" MUID: (5603ED3D011B)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Filer
;

const
 cFilerOpenErrorMsg = 'CRITICAL ERROR: Ошибка (%s) открытия файла %s';

type
 TddExportDocPart = (
  edpDocument
  , edpReference
  , edpAnnotation
 );//TddExportDocPart

 IddExportFilerDispatcherElem = interface
  ['{3CED5DB0-6E54-4C2F-A404-FCE80475BDAF}']
  function Get_Filer: Tl3CustomFiler;
  procedure RollBack;
  property Filer: Tl3CustomFiler
   read Get_Filer;
 end;//IddExportFilerDispatcherElem

 TddFilerDispatcherMapKeyRecord = record
  rPart: TddExportDocPart;
  rAccGroup: Il3CString;
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

 TddReportEmptyEvent = procedure(aSender: TObject;
  aEmptyCount: Integer) of object;

 IddAnnoKindSortItem = interface
  ['{D93F4C6D-BBE9-4571-9EB2-E0100534B695}']
  function Get_Name: Il3CString;
  function Get_Count: Integer;
  function Get_ID: Integer;
  function Get_Topics(aIdx: Integer): Integer;
  procedure Add(aTopic: Integer);
  property Name: Il3CString
   read Get_Name;
  property Count: Integer
   read Get_Count;
  property ID: Integer
   read Get_ID;
  property Topics[aIdx: Integer]: Integer
   read Get_Topics;
 end;//IddAnnoKindSortItem

const
 cExportFileMaskPatterns: array [TddExportFileMaskPatternType] of Tl3WString = (
 (S: '%NUMBER%'; SLen: 8; SCodePage: 0)
 , (S: '%MAIN%'; SLen: 6; SCodePage: 0)
 , (S: '%DATE%'; SLen: 6; SCodePage: 0)
 );
 cDefaultFileMask: array [TddExportDocPart] of AnsiString = (
 'document'
 , 'related'
 , 'annotation'
 );

implementation

uses
 l3ImplUses
;

end.
