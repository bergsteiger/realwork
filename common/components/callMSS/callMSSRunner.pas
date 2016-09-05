unit callMSSRunner;

// Модуль: "w:\common\components\callMSS\callMSSRunner.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcallMSSRunner" MUID: (55C482EC023E)

{$Include w:\common\components\callMSS\callMSS.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TcallMSSRunner = class
  protected
   class procedure DoRunScript(const aFileName: AnsiString;
    const aCaller: ItfwScriptCaller); virtual;
   class function CheckFileExists(const aFileName: AnsiString): Boolean; virtual;
  public
   class procedure Run; virtual;
 end;//TcallMSSRunner

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , kwMain
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwDefaultScriptCaller
 {$IfEnd} // NOT Defined(NoScripts)
 , l3String
 {$If NOT Defined(NoScripts)}
 , tfwConsoleScriptCaller
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngine
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngineEX
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3FileUtils
 , l3Base
 , Windows
 , StrUtils
 , l3StringList
 {$If NOT Defined(NoScripts)}
 , tfwOutToFileScriptCaller
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *55C482EC023Eimpl_uses*
 //#UC END# *55C482EC023Eimpl_uses*
;

class procedure TcallMSSRunner.Run;
//#UC START# *55C483850136_55C482EC023E_var*
var
 l_WasError : Boolean;

 procedure RunScript(const aFileName: AnsiString);
 begin//RunScript
  try
   DoRunScript(aFileName, TtfwConsoleScriptCaller.Make);
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
   DoRunScript(aFileName, TtfwOutToFileScriptCaller.Make(l_OutName));
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
        if CheckFileExists(l_S) then
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

class procedure TcallMSSRunner.DoRunScript(const aFileName: AnsiString;
 const aCaller: ItfwScriptCaller);
//#UC START# *57B6E409029C_55C482EC023E_var*
//#UC END# *57B6E409029C_55C482EC023E_var*
begin
//#UC START# *57B6E409029C_55C482EC023E_impl*
 TtfwScriptEngine.ScriptFromFile(aFileName, aCaller);
//#UC END# *57B6E409029C_55C482EC023E_impl*
end;//TcallMSSRunner.DoRunScript

class function TcallMSSRunner.CheckFileExists(const aFileName: AnsiString): Boolean;
//#UC START# *57B6F81500E3_55C482EC023E_var*
//#UC END# *57B6F81500E3_55C482EC023E_var*
begin
//#UC START# *57B6F81500E3_55C482EC023E_impl*
 Result := FileExists(aFileName);
//#UC END# *57B6F81500E3_55C482EC023E_impl*
end;//TcallMSSRunner.CheckFileExists

end.
