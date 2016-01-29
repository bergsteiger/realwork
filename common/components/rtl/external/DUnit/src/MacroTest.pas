unit MacroTest;

{$Include l3Define.inc}

interface

{$IfNDef NoScripts}
uses
 {$IFDEF InsiderTest}
 {$IF Defined(Archi) or Defined(EverestLite)}
 ArchiAutoTest
 {$ELSE}
 {$IfDef Nemesis}
 F1AutoScripter
 {$ELSE}
 vcmInsiderTest
 {$EndIf Nemesis}
 {$IFEND}
 {$ELSE}
 DailyAutoTest
 {$ENDIF}
 ;

type
 TMacroTest = class(
 {$IFDEF InsiderTest}
 {$IF Defined(Archi) or Defined(EverestLite)}
 TArchiAutoTest
 {$ELSE}
 {$IfDef Nemesis}
 TF1AutoScripter
 {$ELSE}
 TvcmInsiderTest
 {$EndIf Nemesis}
 {$IFEND}
 {$ELSE}
 TDailyAutoTest
 {$ENDIF} )
 private
  f_Folder: String;
 protected
  function ResolveScriptFilePath(const aFileName: AnsiString): AnsiString; override;
 public
  constructor Create(const aMethodName: AnsiString; const aFolder: AnsiString); override;
 end;
{$EndIf NoScripts} 

implementation

uses
 StrUtils;

{$IfNDef NoScripts}
 function TMacroTest.ResolveScriptFilePath(const aFileName: AnsiString): AnsiString;
 begin
  if AnsiStartsStr('@', aFileName) then
   Result := inherited ResolveScriptFilePath(aFileName)
  else
   if f_Folder = '' then
    Result := FileFromCurrent('Macros') + '\'+ aFileName
   else
    Result := FileFromCurrent('Macros\') + f_Folder + '\'+ aFileName;
 end;

 constructor TMacroTest.Create(const aMethodName: AnsiString; const aFolder: AnsiString);
 begin
  inherited;
  f_Folder := aFolder;
 end;
{$EndIf NoScripts} 

end.
