unit vcmInsiderTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DUnitTuning"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/DUnitTuning/vcmInsiderTest.pas"
// Начат: 20.04.2011 16:16
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Testing Framework::DUnitTuning::VCM_TFW::TvcmInsiderTest
//
// Базовый тест запускающийся "внутри" тестируемого приложения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DUnitTuning\tfwDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NotTunedDUnit)}
uses
  l3Filer,
  BaseTest,
  tfwScriptingInterfaces,
  l3Interfaces
  ;
{$IfEnd} //nsTest AND not NoScripts AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NotTunedDUnit)}
type
 _Scripter_Parent_ = TBaseTest;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\Scripter.imp.pas}
 TvcmInsiderTest = {abstract} class(_Scripter_, ItfwScriptCaller)
  {* Базовый тест запускающийся "внутри" тестируемого приложения }
 private
 // private fields
   f_Output : Tl3CustomDosFiler;
   f_DontRaiseIfEtalonCreated : Boolean;
 protected
 // realized methods
   function ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
   function ResolveOutputFilePath(const aFile: AnsiString): AnsiString;
   function ResolveInputFilePath(const aFile: AnsiString): AnsiString;
   function KPage: AnsiString;
   procedure ToLog(const aSt: AnsiString);
   function CompileOnly: Boolean;
 public
 // realized methods
   procedure Check(aCondition: Boolean;
    const aMessage: AnsiString = '');
     {* Проверяет инвариант }
   procedure Print(const aStr: Tl3WString); overload; 
   procedure Print(const aStr: Il3CString); overload; 
   procedure CheckPrintEtalon(const aLogName: AnsiString;
    const aOutputName: AnsiString);
   function ShouldStop: Boolean;
   procedure CheckTimeout(aNow: Cardinal;
    aTimeout: Cardinal);
   function StartTimer: Longword;
   function StopTimer(const aSt: AnsiString = '';
    const aSubName: AnsiString = '';
    aNeedTimeToLog: Boolean = true): Longword;
   function GetIsWritingToK: Boolean;
   function GetIsFakeCVS: Boolean;
   function GetCVSPath: AnsiString;
   procedure DontRaiseIfEtalonCreated;
   procedure TimeToLog(aTime: Cardinal;
     const aSt: AnsiString;
     const aSubName: AnsiString);
   function GetTestSetFolderName: AnsiString;
   function GetEtalonSuffix: AnsiString;
 protected
 // overridden protected methods
   procedure Cleanup; override;
   procedure InitFields; override;
   function EtalonNeedsComputerName: Boolean; override;
   function RaiseIfEtalonCreated: Boolean; override;
   function ResolveScriptFilePath(const aFileName: AnsiString): AnsiString; override;
    {$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
    {$IfEnd} //XE AND nsTest AND not NotTunedDUnit
   function EtalonNeedsOSName: Boolean; override;
   function EtalonNeeds64: Boolean; override;
 public
 // overridden public methods
   function AlwaysShowAFC: Boolean; override;
     {* Всегда показывать сравнивалку файлов, когда не пишем в К }
 protected
 // protected methods
   procedure OwnScriptFromFile;
     {* Запускает "собственный" тест из файла }
   procedure CheckOutputFiler(aWasException: Boolean);
   function GetScriptName: AnsiString; virtual;
 public
 // public methods
   class function DoResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
   class function DoResolveOutputFilePath(const aFile: AnsiString): AnsiString;
   class function DoResolveInputFilePath(const aFile: AnsiString): AnsiString;
 end;//TvcmInsiderTest
{$IfEnd} //nsTest AND not NoScripts AND not NotTunedDUnit

  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NotTunedDUnit)}
var
   g_CompileOnly : Boolean = false;
  {$IfEnd} //nsTest AND not NoScripts AND not NotTunedDUnit

implementation

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NotTunedDUnit)}
uses
  SysUtils,
  l3String,
  KTestRunner
  {$If defined(InsiderTest) AND not defined(NoScripts)}
  ,
  kwPrintDataSaver
  {$IfEnd} //InsiderTest AND not NoScripts
  ,
  TestFrameWork,
  StrUtils,
  l3EtalonsService,
  l3_String,
  l3Chars,
  tfwScriptEngine
  ;
{$IfEnd} //nsTest AND not NoScripts AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NotTunedDUnit)}

type _Instance_R_ = TvcmInsiderTest;

{$Include w:\common\components\rtl\Garant\ScriptEngine\Scripter.imp.pas}

// start class TvcmInsiderTest

procedure TvcmInsiderTest.OwnScriptFromFile;
//#UC START# *4DB0333103BF_4DAECE5D0060_var*
//#UC END# *4DB0333103BF_4DAECE5D0060_var*
begin
//#UC START# *4DB0333103BF_4DAECE5D0060_impl*
 ScriptFromFile(GetScriptName);
//#UC END# *4DB0333103BF_4DAECE5D0060_impl*
end;//TvcmInsiderTest.OwnScriptFromFile

class function TvcmInsiderTest.DoResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *4DC2E1040098_4DAECE5D0060_var*
//#UC END# *4DC2E1040098_4DAECE5D0060_var*
begin
//#UC START# *4DC2E1040098_4DAECE5D0060_impl*
 if ANSIStartsText('@\', aFile) then
  Result := FileFromCurrent('Common\' + Copy(aFile, 3, Length(aFile)-2))
 else 
 if (ExtractFileDrive(aFile) <> '') OR
    AnsiStartsText('axiom:', aFile) then
 begin
  Result := aFile;
  if (Length(Result) > 2) then
   if (Result[2] = ':') then
    l3MakeLowerCase(@Result[1], 1);
 end//ExtractFileDrive(aFile) <> ''
 else
  Result := FileFromCurrent('Dictionary\' + aFile);
//#UC END# *4DC2E1040098_4DAECE5D0060_impl*
end;//TvcmInsiderTest.DoResolveIncludedFilePath

procedure TvcmInsiderTest.CheckOutputFiler(aWasException: Boolean);
//#UC START# *4DCA421B0227_4DAECE5D0060_var*
var
 l_FileName : String;
 l_Exists   : Boolean;
 l_CVSPath  : String;
//#UC END# *4DCA421B0227_4DAECE5D0060_var*
begin
//#UC START# *4DCA421B0227_4DAECE5D0060_impl*
 if (f_Output <> nil) then
 begin
  try
   f_Output.Close;
   if not aWasException AND not CompileOnly then
    CheckOutputWithInput(ChangeFileExt(
                          ExtractFileName(f_Output.Identifier),
                          EtalonSuffix) + '.prn',
                         #0,
                         '',
                         IsWritingToK
                         // - не надо падать при различии в эталонах, идём дальше
                         );
  finally
   FreeAndNil(f_Output);
  end;//try..finally
 end//f_Output <> nil
 else
 if not aWasException AND not CompileOnly then
 begin
  l_FileName := ChangeFileExt(FileForOutput, EtalonSuffix) + '.prn';
  l_Exists := FileExists(l_FileName);
  if not IsWritingToK then
  begin
   if l_Exists then
   begin
    if DeleteFile(l_FileName) then
     Assert(false,
            Format('Файл %s не должен существовать. Он был стёрт',
                   [l_FileName]))
    else
     Assert(false,
            Format('Не удалось стереть файл %s',
                   [l_FileName]));
   end;//l_Exists
   l_CVSPath := g_CVSPath + '\' + TBaseTest.TestSetFolderName + '\';
   if DirectoryExists(l_CVSPath) then
   begin
    l_FileName := l_CVSPath + ExtractFileName(l_FileName);
    l_Exists := FileExists(l_FileName);
    if l_Exists then
    begin
     if DeleteFile(l_FileName) then
      Assert(false,
             Format('Файл %s не должен существовать. Он был стёрт',
                    [l_FileName]))
     else
      Assert(false,
             Format('Не удалось стереть файл %s',
                    [l_FileName]));
    end;//l_Exists
   end;//DirectoryExists(l_CVSPath)
  end//not IsWritingToK
  else
  if not IsGK then
  // - это чтобы облегчить поиск ошибки про удаление эталонов у Владимира Селянкина
   Assert(not l_Exists,
          Format('Файл %s не должен существовать',
                 [l_FileName]));
 end;//f_Output <> nil
//#UC END# *4DCA421B0227_4DAECE5D0060_impl*
end;//TvcmInsiderTest.CheckOutputFiler

class function TvcmInsiderTest.DoResolveOutputFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *4DCA92D403C9_4DAECE5D0060_var*
//#UC END# *4DCA92D403C9_4DAECE5D0060_var*
begin
//#UC START# *4DCA92D403C9_4DAECE5D0060_impl*
 if (ExtractFilePath(aFile) <> '') then
  Result := aFile
 else
  Result := OutputPath + aFile;
//#UC END# *4DCA92D403C9_4DAECE5D0060_impl*
end;//TvcmInsiderTest.DoResolveOutputFilePath

class function TvcmInsiderTest.DoResolveInputFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *4DECF5A5003B_4DAECE5D0060_var*
//#UC END# *4DECF5A5003B_4DAECE5D0060_var*
begin
//#UC START# *4DECF5A5003B_4DAECE5D0060_impl*
 Result := FileFromCurrent(aFile);
//#UC END# *4DECF5A5003B_4DAECE5D0060_impl*
end;//TvcmInsiderTest.DoResolveInputFilePath

function TvcmInsiderTest.GetScriptName: AnsiString;
//#UC START# *4DC263E8038F_4DAECE5D0060_var*
//#UC END# *4DC263E8038F_4DAECE5D0060_var*
begin
//#UC START# *4DC263E8038F_4DAECE5D0060_impl*
 Result := ClassName + '.script';
//#UC END# *4DC263E8038F_4DAECE5D0060_impl*
end;//TvcmInsiderTest.GetScriptName

procedure TvcmInsiderTest.Check(aCondition: Boolean;
  const aMessage: AnsiString = '');
//#UC START# *4DAF1A280116_4DAECE5D0060_var*
//#UC END# *4DAF1A280116_4DAECE5D0060_var*
begin
//#UC START# *4DAF1A280116_4DAECE5D0060_impl*
 inherited Check(aCondition, aMessage);
//#UC END# *4DAF1A280116_4DAECE5D0060_impl*
end;//TvcmInsiderTest.Check

procedure TvcmInsiderTest.Print(const aStr: Tl3WString);
//#UC START# *4DB173AA005A_4DAECE5D0060_var*
var
 l_S : Tl3_String;
//#UC END# *4DB173AA005A_4DAECE5D0060_var*
begin
//#UC START# *4DB173AA005A_4DAECE5D0060_impl*
 //ToLog(l3Str(aStr));
 if not l3IsANSI(aStr.SCodePage) then
 begin
  l_S := Tl3_String.Make(aStr);
  try
   l_S.CodePage := CP_ANSI;
   Print(l_S.AsWStr);
   Exit;
  finally
   FreeAndNil(l_S);
  end;//try..finally
 end;//not l3IsANSI(aStr.SCodePage)
 if (f_Output = nil) then
 begin
  f_Output := FilerForOutput;
  f_Output.Open;
 end;//f_Output = nil
 f_Output.WriteLn(aStr);
//#UC END# *4DB173AA005A_4DAECE5D0060_impl*
end;//TvcmInsiderTest.Print

procedure TvcmInsiderTest.Print(const aStr: Il3CString);
//#UC START# *4DB1785F011A_4DAECE5D0060_var*
//#UC END# *4DB1785F011A_4DAECE5D0060_var*
begin
//#UC START# *4DB1785F011A_4DAECE5D0060_impl*
 Print(l3PCharLen(aStr));
//#UC END# *4DB1785F011A_4DAECE5D0060_impl*
end;//TvcmInsiderTest.Print

function TvcmInsiderTest.ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *4DC2E1470046_4DAECE5D0060_var*
//#UC END# *4DC2E1470046_4DAECE5D0060_var*
begin
//#UC START# *4DC2E1470046_4DAECE5D0060_impl*
 Result := DoResolveIncludedFilePath(aFile);
//#UC END# *4DC2E1470046_4DAECE5D0060_impl*
end;//TvcmInsiderTest.ResolveIncludedFilePath

function TvcmInsiderTest.ResolveOutputFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *4DCA915C0120_4DAECE5D0060_var*
//#UC END# *4DCA915C0120_4DAECE5D0060_var*
begin
//#UC START# *4DCA915C0120_4DAECE5D0060_impl*
 Result := DoResolveOutputFilePath(aFile);
//#UC END# *4DCA915C0120_4DAECE5D0060_impl*
end;//TvcmInsiderTest.ResolveOutputFilePath

function TvcmInsiderTest.ResolveInputFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *4DECF57B02D2_4DAECE5D0060_var*
//#UC END# *4DECF57B02D2_4DAECE5D0060_var*
begin
//#UC START# *4DECF57B02D2_4DAECE5D0060_impl*
 Result := DoResolveInputFilePath(aFile);
//#UC END# *4DECF57B02D2_4DAECE5D0060_impl*
end;//TvcmInsiderTest.ResolveInputFilePath

procedure TvcmInsiderTest.CheckPrintEtalon(const aLogName: AnsiString;
  const aOutputName: AnsiString);
//#UC START# *4F0D7AC900FA_4DAECE5D0060_var*
var
 l_N : String;
 l_Extra : String;
 l_Counter : Boolean;
//#UC END# *4F0D7AC900FA_4DAECE5D0060_var*
begin
//#UC START# *4F0D7AC900FA_4DAECE5D0060_impl*
 l_N := ExtractFileName(aLogName);
 l_Counter := (Pos('.C_', l_N) > 0);
 if l_Counter then
  l_Extra := ''
 else
  l_Extra := ChangeFileExt(l_N, '.png');
 try
  CheckOutputWithInput(FileFromCurrent(ChangeFileExt(l_N, EtalonSuffix + '.shapes')),
                       aOutputName,
                       #0,
                       EtalonNeedsComputerName,
                       EtalonCanHaveDiff,
                       l_Extra,
                       not l_Counter);
 except
  on ETestFailure do
  begin
   {$IFDEF InsiderTest}
   if TkwPrintDataSaver.Instance.IsWaitingPrint then
    TkwPrintDataSaver.Instance.GetPanel.Done;
   {$ENDIF InsiderTest}
   raise;
  end;
 end;
//#UC END# *4F0D7AC900FA_4DAECE5D0060_impl*
end;//TvcmInsiderTest.CheckPrintEtalon

function TvcmInsiderTest.ShouldStop: Boolean;
//#UC START# *4F0D8B740186_4DAECE5D0060_var*
//#UC END# *4F0D8B740186_4DAECE5D0060_var*
begin
//#UC START# *4F0D8B740186_4DAECE5D0060_impl*
 Result := inherited ShouldStop;
//#UC END# *4F0D8B740186_4DAECE5D0060_impl*
end;//TvcmInsiderTest.ShouldStop

procedure TvcmInsiderTest.CheckTimeout(aNow: Cardinal;
  aTimeout: Cardinal);
//#UC START# *4F0D8C360085_4DAECE5D0060_var*
//#UC END# *4F0D8C360085_4DAECE5D0060_var*
begin
//#UC START# *4F0D8C360085_4DAECE5D0060_impl*
 inherited CheckTimeout(aNow, aTimeout);
//#UC END# *4F0D8C360085_4DAECE5D0060_impl*
end;//TvcmInsiderTest.CheckTimeout

function TvcmInsiderTest.StartTimer: Longword;
//#UC START# *4F0D8C5A01A2_4DAECE5D0060_var*
//#UC END# *4F0D8C5A01A2_4DAECE5D0060_var*
begin
//#UC START# *4F0D8C5A01A2_4DAECE5D0060_impl*
 Result := inherited StartTimer;
//#UC END# *4F0D8C5A01A2_4DAECE5D0060_impl*
end;//TvcmInsiderTest.StartTimer

function TvcmInsiderTest.StopTimer(const aSt: AnsiString = '';
  const aSubName: AnsiString = '';
  aNeedTimeToLog: Boolean = true): Longword;
//#UC START# *4F0D8CB0015D_4DAECE5D0060_var*
//#UC END# *4F0D8CB0015D_4DAECE5D0060_var*
begin
//#UC START# *4F0D8CB0015D_4DAECE5D0060_impl*
 Result := inherited StopTimer(aSt, aSubName, aNeedTimeToLog);
//#UC END# *4F0D8CB0015D_4DAECE5D0060_impl*
end;//TvcmInsiderTest.StopTimer

function TvcmInsiderTest.KPage: AnsiString;
//#UC START# *4F0D91AA0080_4DAECE5D0060_var*
//#UC END# *4F0D91AA0080_4DAECE5D0060_var*
begin
//#UC START# *4F0D91AA0080_4DAECE5D0060_impl*
 Result := inherited KPage;
//#UC END# *4F0D91AA0080_4DAECE5D0060_impl*
end;//TvcmInsiderTest.KPage

procedure TvcmInsiderTest.ToLog(const aSt: AnsiString);
//#UC START# *4F0DA2A7024A_4DAECE5D0060_var*
//#UC END# *4F0DA2A7024A_4DAECE5D0060_var*
begin
//#UC START# *4F0DA2A7024A_4DAECE5D0060_impl*
 inherited ToLog(aSt);
//#UC END# *4F0DA2A7024A_4DAECE5D0060_impl*
end;//TvcmInsiderTest.ToLog

function TvcmInsiderTest.GetIsWritingToK: Boolean;
//#UC START# *4F72CEFE016D_4DAECE5D0060_var*
//#UC END# *4F72CEFE016D_4DAECE5D0060_var*
begin
//#UC START# *4F72CEFE016D_4DAECE5D0060_impl*
 Result := IsWritingToK;
//#UC END# *4F72CEFE016D_4DAECE5D0060_impl*
end;//TvcmInsiderTest.GetIsWritingToK

function TvcmInsiderTest.GetIsFakeCVS: Boolean;
//#UC START# *4F72CF27029A_4DAECE5D0060_var*
//#UC END# *4F72CF27029A_4DAECE5D0060_var*
begin
//#UC START# *4F72CF27029A_4DAECE5D0060_impl*
 Result := IsFakeCVS;
//#UC END# *4F72CF27029A_4DAECE5D0060_impl*
end;//TvcmInsiderTest.GetIsFakeCVS

function TvcmInsiderTest.GetCVSPath: AnsiString;
//#UC START# *4F72CF78027D_4DAECE5D0060_var*
//#UC END# *4F72CF78027D_4DAECE5D0060_var*
begin
//#UC START# *4F72CF78027D_4DAECE5D0060_impl*
 Result := g_CVSPath;
//#UC END# *4F72CF78027D_4DAECE5D0060_impl*
end;//TvcmInsiderTest.GetCVSPath

procedure TvcmInsiderTest.DontRaiseIfEtalonCreated;
//#UC START# *4F851D7B0399_4DAECE5D0060_var*
//#UC END# *4F851D7B0399_4DAECE5D0060_var*
begin
//#UC START# *4F851D7B0399_4DAECE5D0060_impl*
 f_DontRaiseIfEtalonCreated := True; 
//#UC END# *4F851D7B0399_4DAECE5D0060_impl*
end;//TvcmInsiderTest.DontRaiseIfEtalonCreated

procedure TvcmInsiderTest.TimeToLog(aTime: Cardinal;
  const aSt: AnsiString;
  const aSubName: AnsiString);
//#UC START# *511BC7C60063_4DAECE5D0060_var*
//#UC END# *511BC7C60063_4DAECE5D0060_var*
begin
//#UC START# *511BC7C60063_4DAECE5D0060_impl*
 inherited TimeToLog(aTime, aSt, aSubName, true);
//#UC END# *511BC7C60063_4DAECE5D0060_impl*
end;//TvcmInsiderTest.TimeToLog

function TvcmInsiderTest.GetTestSetFolderName: AnsiString;
//#UC START# *513866B10237_4DAECE5D0060_var*
//#UC END# *513866B10237_4DAECE5D0060_var*
begin
//#UC START# *513866B10237_4DAECE5D0060_impl*
 Result := TestSetFolderName;
//#UC END# *513866B10237_4DAECE5D0060_impl*
end;//TvcmInsiderTest.GetTestSetFolderName

function TvcmInsiderTest.GetEtalonSuffix: AnsiString;
//#UC START# *5138790002FF_4DAECE5D0060_var*
//#UC END# *5138790002FF_4DAECE5D0060_var*
begin
//#UC START# *5138790002FF_4DAECE5D0060_impl*
 Result := EtalonSuffix;
//#UC END# *5138790002FF_4DAECE5D0060_impl*
end;//TvcmInsiderTest.GetEtalonSuffix

function TvcmInsiderTest.CompileOnly: Boolean;
//#UC START# *52EBC5BB0300_4DAECE5D0060_var*
//#UC END# *52EBC5BB0300_4DAECE5D0060_var*
begin
//#UC START# *52EBC5BB0300_4DAECE5D0060_impl*
 Result := g_CompileOnly;
//#UC END# *52EBC5BB0300_4DAECE5D0060_impl*
end;//TvcmInsiderTest.CompileOnly

procedure TvcmInsiderTest.Cleanup;
//#UC START# *4B2F40FD0088_4DAECE5D0060_var*
//#UC END# *4B2F40FD0088_4DAECE5D0060_var*
begin
//#UC START# *4B2F40FD0088_4DAECE5D0060_impl*
 f_DontRaiseIfEtalonCreated := False;
 FreeAndNil(f_Output);
 inherited;
//#UC END# *4B2F40FD0088_4DAECE5D0060_impl*
end;//TvcmInsiderTest.Cleanup

procedure TvcmInsiderTest.InitFields;
//#UC START# *4B30EEA10210_4DAECE5D0060_var*
//#UC END# *4B30EEA10210_4DAECE5D0060_var*
begin
//#UC START# *4B30EEA10210_4DAECE5D0060_impl*
 f_DontRaiseIfEtalonCreated := False;
//#UC END# *4B30EEA10210_4DAECE5D0060_impl*
end;//TvcmInsiderTest.InitFields

function TvcmInsiderTest.EtalonNeedsComputerName: Boolean;
//#UC START# *4CA45DAA01BA_4DAECE5D0060_var*
//#UC END# *4CA45DAA01BA_4DAECE5D0060_var*
begin
//#UC START# *4CA45DAA01BA_4DAECE5D0060_impl*
 Result := Tl3EtalonsService.Instance.EtalonNeedsComputerName;
//#UC END# *4CA45DAA01BA_4DAECE5D0060_impl*
end;//TvcmInsiderTest.EtalonNeedsComputerName

function TvcmInsiderTest.RaiseIfEtalonCreated: Boolean;
//#UC START# *4CA5DAD4014C_4DAECE5D0060_var*
//#UC END# *4CA5DAD4014C_4DAECE5D0060_var*
begin
//#UC START# *4CA5DAD4014C_4DAECE5D0060_impl*
 Result := not f_DontRaiseIfEtalonCreated;
//#UC END# *4CA5DAD4014C_4DAECE5D0060_impl*
end;//TvcmInsiderTest.RaiseIfEtalonCreated

function TvcmInsiderTest.ResolveScriptFilePath(const aFileName: AnsiString): AnsiString;
//#UC START# *4DB03121022B_4DAECE5D0060_var*
//#UC END# *4DB03121022B_4DAECE5D0060_var*
begin
//#UC START# *4DB03121022B_4DAECE5D0060_impl*
 if ANSIStartsText('@\', aFileName) then
  Result := FileFromCurrent('Common\' + Copy(aFileName, 3, Length(aFileName)-2))
 else 
 if (ExtractFilePath(aFileName) <> '') then
  Result := aFileName
 else
  Result := FileFromCurrent('Scripts\' + aFileName);
//#UC END# *4DB03121022B_4DAECE5D0060_impl*
end;//TvcmInsiderTest.ResolveScriptFilePath

function TvcmInsiderTest.AlwaysShowAFC: Boolean;
//#UC START# *4F5F28EB0242_4DAECE5D0060_var*
//#UC END# *4F5F28EB0242_4DAECE5D0060_var*
begin
//#UC START# *4F5F28EB0242_4DAECE5D0060_impl*
 Result := true;
//#UC END# *4F5F28EB0242_4DAECE5D0060_impl*
end;//TvcmInsiderTest.AlwaysShowAFC

{$If defined(XE) AND defined(nsTest) AND not defined(NotTunedDUnit)}
function TvcmInsiderTest.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4DAECE5D0060_var*
//#UC END# *51AF49E5001B_4DAECE5D0060_var*
begin
//#UC START# *51AF49E5001B_4DAECE5D0060_impl*
 Result := Tl3EtalonsService.Instance.EtalonNeedsXE;
//#UC END# *51AF49E5001B_4DAECE5D0060_impl*
end;//TvcmInsiderTest.EtalonNeedsXE
{$IfEnd} //XE AND nsTest AND not NotTunedDUnit

function TvcmInsiderTest.EtalonNeedsOSName: Boolean;
//#UC START# *51AF4A1C036E_4DAECE5D0060_var*
//#UC END# *51AF4A1C036E_4DAECE5D0060_var*
begin
//#UC START# *51AF4A1C036E_4DAECE5D0060_impl*
 Result := Tl3EtalonsService.Instance.EtalonNeedsOSName;
//#UC END# *51AF4A1C036E_4DAECE5D0060_impl*
end;//TvcmInsiderTest.EtalonNeedsOSName

function TvcmInsiderTest.EtalonNeeds64: Boolean;
//#UC START# *51B0AF8E0378_4DAECE5D0060_var*
//#UC END# *51B0AF8E0378_4DAECE5D0060_var*
begin
//#UC START# *51B0AF8E0378_4DAECE5D0060_impl*
 Result := Tl3EtalonsService.Instance.EtalonNeeds64;
//#UC END# *51B0AF8E0378_4DAECE5D0060_impl*
end;//TvcmInsiderTest.EtalonNeeds64

{$IfEnd} //nsTest AND not NoScripts AND not NotTunedDUnit

end.