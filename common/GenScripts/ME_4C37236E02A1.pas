unit vtSaveDialog;

interface

uses
 l3IntfUses
 , Dialogs
;

type
 TvtSaveDialog = class(TSaveDialog)
  function GetFileNameForAdjust: AnsiString;
  procedure FirstCorrectFileName;
  procedure SetAdjustedFileName(const aFileName: AnsiString);
   {* Установить откорректированное имя файла }
 end;//TvtSaveDialog
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
