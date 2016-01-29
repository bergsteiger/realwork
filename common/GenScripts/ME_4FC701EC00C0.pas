unit evCellWidthCorrecterSpy;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Filer
;

type
 IevCellsWidthCorrecterLogger = interface
  function OpenLog: AnsiString;
  procedure CloseLog(const aLogName: AnsiString);
 end;//IevCellsWidthCorrecterLogger
 
 TevCellLogData = record
 end;//TevCellLogData
 
 TevCellWidthCorrecterSpy = class(Tl3ProtoObject)
  {* Собиратель информации для тестов. }
  function Exists: Boolean;
  procedure SetLogger(const aLogger: IevCellsWidthCorrecterLogger);
  procedure RemoveLogger(const aLogger: IevCellsWidthCorrecterLogger);
  procedure StartSaveData;
  procedure EndSaveData;
  procedure SaveAlignmentData(const aCellLogData: TevCellLogData);
  procedure SaveRowData(anIndex: Integer;
   aOldRowWidth: Integer;
   aNewRowWidth: Integer);
  function NeedLog: Boolean;
 end;//TevCellWidthCorrecterSpy
 
implementation

uses
 l3ImplUses
 , l3Types
 , SysUtils
 , l3Chars
 , l3String
 , l3Interfaces
;

end.
