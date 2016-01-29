unit ietBaseTest;

interface

uses
 l3IntfUses
 , archiDBTest
 , ddImportPipe
 , ExportPipe
 , evdDTTypes
;

type
 TietBaseTest = class(TarchiDBTest)
  procedure DoIt;
  procedure DoImport;
  procedure DoExport;
  procedure CompareResults;
  procedure DoBeforeImport(const aPipe: TddImportPipe);
  procedure DoAfterImport(const aPipe: TddImportPipe);
  procedure DoBeforeExport(const aPipe: TExportPipe);
  procedure DoAfterExport(const aPipe: TExportPipe);
  procedure TopicEvent(aTopicNo: Integer;
   const aMessage: AnsiString);
  function GetOutputPath: AnsiString;
  function GetOutputFormat: TepSupportFileType;
 end;//TietBaseTest
 
implementation

uses
 l3ImplUses
 , KTestRunner
 , l3IniFile
 , TestFrameWork
 , dt_AttrSchema
 , dt_LinkServ
 , SysUtils
 , dt_Const
 , dt_Sab
 , dt_Types
 , ddPipeOutInterfaces
 , dt_Renum
;

end.
