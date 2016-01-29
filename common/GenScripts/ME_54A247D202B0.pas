unit csTasksHelpers;

interface

uses
 l3IntfUses
 , File_Const
 , evdTasksHelpers
 , PlainFile_Const
 , Classes
 , l3Variant
;

type
 ReplacementFileHelper = interface
 end;//ReplacementFileHelper
 
 AdditionalFilesHelper = interface(StringListHelper)
  procedure ChangeName(anIndex: Integer;
   const aValue: AnsiString);
 end;//AdditionalFilesHelper
 
 SourceFilesHelper = interface(AdditionalFilesHelper)
 end;//SourceFilesHelper
 
 TAdditionalFilesHelper = class(TAbstractStringListHelper, AdditionalFilesHelper)
  function Make(aValue: Tl3Tag): AdditionalFilesHelper;
  procedure DoAdd(const anItem: AnsiString);
  function DoGetStrings(anIndex: Integer): AnsiString;
  procedure ChangeName(anIndex: Integer;
   const aValue: AnsiString);
 end;//TAdditionalFilesHelper
 
 TSourceFilesHelper = class(TAdditionalFilesHelper, SourceFilesHelper)
  function Make(aValue: Tl3Tag): SourceFilesHelper;
  function NeedCheckNSRC: Boolean;
  procedure CheckNSRC(anIndex: Integer;
   const anItem: AnsiString);
  function AdditionalFiles: AdditionalFilesHelper;
 end;//TSourceFilesHelper
 
 TReplacementFileHelper = class(TSourceFilesHelper, ReplacementFileHelper)
  function Make(aValue: Tl3Tag): ReplacementFileHelper;
  function Name: AnsiString;
 end;//TReplacementFileHelper
 
implementation

uses
 l3ImplUses
 , evNSRCConst
 , l3Base
 , l3Stream
 , SysUtils
 , l3Types
 , ddSegmentScanner
 , StrUtils
 , l3String
 , l3FileUtils
 , l3Const
 , ddNSRCSegments
;

end.
