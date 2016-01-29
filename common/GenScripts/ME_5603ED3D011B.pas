unit ddPipeOutInterfaces;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Filer
;

type
 TddExportDocPart = (
  edpDocument
  , edpReference
  , edpAnnotation
 );//TddExportDocPart
 
 IddExportFilerDispatcherElem = interface
  procedure RollBack;
 end;//IddExportFilerDispatcherElem
 
 TddFilerDispatcherMapKeyRecord = record
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
  procedure Add(aTopic: Integer);
 end;//IddAnnoKindSortItem
 
implementation

uses
 l3ImplUses
;

end.
