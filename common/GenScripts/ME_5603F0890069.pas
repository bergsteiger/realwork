unit ddExportFilerDispatcher;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
 , ddExportFilerMap
 , ddPipeOutInterfaces
 , l3Filer
 , dt_Types
;

type
 TddFileMaskArray = array [TddExportDocPart] of Il3CString;
 
 TddExportDivideByArray = array [TddExportDocPart] of TddExportDivideBySet;
 
 TddCurrentFilesArray = array [TddExportDocPart] of IUnknown;
 
 TddExportFilerDispatcher = class(Tl3ProtoObject)
  procedure Create;
  function GetFiler(aTopic: TDocID;
   aPart: TddExportDocPart;
   const aAccGroup: Il3CString): Tl3CustomFiler;
  procedure Start;
   {* Корректирует маски файлов и DivideBy, обнуляет файлеры }
  procedure Finish;
   {* Закрывает все открытые файлеры }
  procedure RollBack;
   {* Удаляет уже вылитые данные текущего топика (случай аварийного отката) }
  procedure DropCurrentFilesData;
  function GetActualDir(const aMain: AnsiString): AnsiString;
 end;//TddExportFilerDispatcher
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Chars
 , ddExportFilerDispatcherElem
 , l3FileUtils
 , l3Types
 , ddUtils
 , l3String
 , l3Const
 , l3Base
 , Classes
;

end.
