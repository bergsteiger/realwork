unit callMSSRunner;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/common/components/callMSS/callMSSRunner.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::callMSS::TcallMSSRunner
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\callMSS\callMSS.inc}

interface

type
 TcallMSSRunner = class
 public
 // public methods
   class procedure Run;
     {* Сигнатура метода Run }
 end;//TcallMSSRunner

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  kwMain
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwDefaultScriptCaller
  {$IfEnd} //not NoScripts
  ,
  l3String
  {$If not defined(NoScripts)}
  ,
  tfwConsoleScriptCaller
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptEngine
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptEngineEX
  {$IfEnd} //not NoScripts
  ,
  SysUtils,
  l3FileUtils,
  l3Base,
  Windows,
  StrUtils,
  l3StringList
  {$If not defined(NoScripts)}
  ,
  tfwOutToFileScriptCaller
  {$IfEnd} //not NoScripts
  
  ;

// start class TcallMSSRunner

class procedure TcallMSSRunner.Run;
//#UC START# *55C483850136_55C482EC023E_var*
var
 l_WasError : Boolean;

 procedure RunScript(const aFileName: AnsiString);
 begin//RunScript
  try
   TtfwScriptEngine.ScriptFromFile(aFileName, TtfwConsoleScriptCaller.Make);
  except
   on E: Exception do
   begin
    l_WasError := true;
    System.WriteLn(ExtractFileName(aFileName) + ' : ' + E.Message);
   end;//on E: Exception
  end;//try..except
 end;//RunScript

 procedure RunScriptWithOutput(const aFileName: AnsiString);
 var
  l_OutName : AnsiString;
 begin//RunScriptWithOutput
  l_OutName := aFileName + '.out';
  try
   TtfwScriptEngine.ScriptFromFile(aFileName, TtfwOutToFileScriptCaller.Make(l_OutName));
  except
   on E: Exception do
   begin
    l_WasError := true;
    l3System.Msg2Log(ExtractFileName(aFileName) + ' : ' + E.Message);
   end;//on E: Exception
  end;//try..except
  if FileExists(l_OutName) then
   if (l3FileUtils.GetFileSize(l_OutName) = 0) then
    SysUtils.DeleteFile(l_OutName);
 end;//RunScriptWithOutput

 procedure RunScriptsByMask(const aFileName: AnsiString);
 var
  l_SearchRec  : TSearchRec;
  l_FindResult : Integer;
  l_DirName : AnsiString;
  l_FileName : AnsiString;
  l_Now : Cardinal;
 begin
  l_DirName := ExtractFilePath(aFileName);
  if (l_DirName = '') then
   l_DirName := SysUtils.GetCurrentDir;
  l_FileName := ExtractFileName(aFileName);
  l_FindResult := FindFirst(ConcatDirName(l_DirName, l_FileName),
                            faAnyFile,
                            l_SearchRec);
  try
   l_Now := GetTickCount;
   l3System.Msg2Log('start ' + aFileName);
   try
    while (l_FindResult = 0) {AND not l_WasError} do
    begin
     if ((l_SearchRec.Attr and (faDirectory or faVolumeID or faSymLink)) = 0) then
      RunScriptWithOutput(ConcatDirName(l_DirName, l_SearchRec.Name));
     l_FindResult := FindNext(l_SearchRec);
    end; // while l_FindResult = 0 do
   finally
    l3System.Msg2Log('finish ' + aFileName + ' ' + IntToStr((GetTickCount - l_Now) div 1000) );
   end;//try..finally
  finally
   SysUtils.FindClose(l_SearchRec);
  end;//try..finally
 end;

 const
  cMask = '*';

 procedure RunScriptsListPrim(const aFileName: AnsiString);
 var
  l_F : Text;
  l_S : AnsiString;
  l_Now : Cardinal;
  l_L : Tl3StringList;
  l_In : Tl3StringList;
  l_Index : Integer;
  l_I : Integer;
 begin
  AssignFile(l_F, aFileName);
  l_In := Tl3StringList.Create;
  try
   Reset(l_F);
   try
    while not EOF(l_F) do
    begin
     ReadLn(l_F, l_S);
     l_In.Add(l_S);
    end;//while not EOF(l_F)
   finally
    CloseFile(l_F);
   end;//try..finally
   l_L := Tl3StringList.Create;
   try
    l_L.Sorted := true;
    l_Now := GetTickCount;
    l3System.Msg2Log('start ' + aFileName);
    try
     for l_I := 0 to Pred(l_In.Count) do
     begin
      l_S := l_In.Items[l_I].AsString;
      if not l_L.FindData(l_S, l_Index) then
      begin
       l_L.Add(l_S);
       if (Pos(cMask, aFileName) <= 0) then
       begin
        l_S := TtfwConsoleScriptCaller.DoResolveIncludedFilePath(l_S);
        if FileExists(l_S) then
         RunScriptWithOutput(l_S)
        else
         l3System.Msg2Log('Не найден файл: ' + l_S);
       end//Pos(cMask, aFileName) <= 0
       else
        RunScriptsByMask(l_S);
      end;//not l_L.FindData(l_S, l_Index)
     end;//while not EOF(l_F)
    finally
     l3System.Msg2Log('finish ' + aFileName + ' ' + IntToStr((GetTickCount - l_Now) div 1000) );
    end;//try..finally
   finally
    FreeAndNil(l_L);
   end;//try..finally
  finally
   FreeAndNil(l_In);
  end;//try..finally
 end;

 const
  cList = '-list:';

 procedure RunScriptsList(const aFileName: AnsiString);
 var
  l_N : AnsiString;
 begin
  l_N := aFileName;
  Delete(l_N, 1, Length(cList));
  RunScriptsListPrim(l_N);
 end;

 procedure RunScripts(const aFileName: AnsiString);
 begin//RunScripts
  if AnsiStartsStr(cList, aFilename) then
   RunScriptsList(aFilename)
  else
  if (Pos(cMask, aFileName) <= 0) then
   RunScript(aFileName)
  else
   RunScriptsByMask(aFileName);
 end;//RunScripts

//#UC END# *55C483850136_55C482EC023E_var*
begin
//#UC START# *55C483850136_55C482EC023E_impl*
 l_WasError := false;
 RunScripts(ParamStr(1));
 if l_WasError then
  Halt(2);
//#UC END# *55C483850136_55C482EC023E_impl*
end;//TcallMSSRunner.Run

end.