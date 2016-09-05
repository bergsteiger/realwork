unit msGenRunner;

// Модуль: "w:\common\components\msgen\msGenRunner.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsGenRunner" MUID: (57B6E3BA005F)

{$Include w:\common\components\msgen\msgen.inc}

interface

uses
 l3IntfUses
 , callMSSRunner
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TmsGenRunner = class(TcallMSSRunner)
  protected
   class procedure DoRunScript(const aFileName: AnsiString;
    const aCaller: ItfwScriptCaller); override;
   class function CheckFileExists(const aFileName: AnsiString): Boolean; override;
  public
   class procedure Run; override;
 end;//TmsGenRunner

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , msmWordsCachePack
 {$IfEnd} // NOT Defined(NoScripts)
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
 //#UC START# *57B6E3BA005Fimpl_uses*
 , Classes
 , l3Types
 , l3Stream
 //#UC END# *57B6E3BA005Fimpl_uses*
;

var g_ModelOnly: Boolean = False;
var g_NullOnly: Boolean = False;
var g_SpellOnly: Boolean = False;

class procedure TmsGenRunner.Run;
//#UC START# *55C483850136_57B6E3BA005F_var*
var
 l_Index : Integer;
//#UC END# *55C483850136_57B6E3BA005F_var*
begin
//#UC START# *55C483850136_57B6E3BA005F_impl*
 g_SpellOnly := false;
 g_ModelOnly := false;
 g_NullOnly := false;
 for l_Index := 1 to ParamCount do
 begin
  if (ParamStr(l_Index) = '-modelonly') then
  begin
   g_ModelOnly := true;
  end//ParamStr(l_Index) = '-modelonly'
  else
  if (ParamStr(l_Index) = '-nullonly') then
  begin
   g_NullOnly := true;
  end//ParamStr(l_Index) = '-nullonly'
  else
  if (ParamStr(l_Index) = '-spellonly') then
  begin
   g_SpellOnly := true;
  end;//ParamStr(l_Index) = '-spellonly'
 end;//for l_Index
 inherited;
//#UC END# *55C483850136_57B6E3BA005F_impl*
end;//TmsGenRunner.Run

class procedure TmsGenRunner.DoRunScript(const aFileName: AnsiString;
 const aCaller: ItfwScriptCaller);
//#UC START# *57B6E409029C_57B6E3BA005F_var*
const
 cPath = 'C:\Temp\Scripts\Runners\';
 cQuote = '''';
var
 l_N : String;
 l_N1 : String;
 l_E : String;
 l_S : String;
 l_W : String;
 l_F : Tl3FileStream;
 l_Script : Boolean;
 l_Path : String;
//#UC END# *57B6E409029C_57B6E3BA005F_var*
begin
//#UC START# *57B6E409029C_57B6E3BA005F_impl*
 l_N := ExtractFileName(aFileName);
 l_E := ExtractFileExt(l_N);
 l_Script := AnsiEndsText('.pas.ms.script', l_N)
             OR AnsiEndsText('.ms.model.script', l_N);
 if l_Script OR AnsiSameText(l_E, '.runner') then
 begin
  //GetDeviceFileName
  //SetLength(l_S, 1000);
  //QueryDosDevice('U:', PChar(l_S), 1000);
  if not l_Script then
   l_N := ChangeFileExt(l_N, '');
  l_W := l_N;
  while (ExtractFileExt(l_W) <> '') do
  begin
   l_W := ChangeFileExt(l_W, '');
  end;//ExtractFileExt(l_N)
  l_S :=
   'USES' + #13#10 +
   ' Generation.ms.dict' + #13#10 +
   ' ' + cQuote + l_N + cQuote + #13#10 +
   ';' + #13#10 +
   #13#10 +
   'ME_' + l_W + ' '
  ;
  if g_SpellOnly then
   l_S := l_S + '.GenerateModelSpell'
  else
  if g_NullOnly then
   l_S := l_S + '.GenerateNull'
  else 
  if g_ModelOnly then
   l_S := l_S + '.GenerateModel'
  else
   l_S := l_S + '.Generate';
  l_Path := cPath; 
  if g_SpellOnly then
  begin
   l_Path := ConcatDirName(l_Path, 'Spell');
   l_N := ConcatDirName(l_Path, l_N) + '.spell.runner';
  end//g_SpellOnly
  else
  if g_NullOnly then
  begin
   l_Path := ConcatDirName(l_Path, 'Null');
   l_N := ConcatDirName(l_Path, l_N) + '.null.runner';
  end//g_NullOnly
  else
  if g_ModelOnly then
  begin
   l_Path := ConcatDirName(l_Path, 'Model');
   l_N := ConcatDirName(l_Path, l_N) + '.model.runner';
  end//g_ModelOnly
  else
  begin
   l_N := ConcatDirName(l_Path, l_N) + '.runner';
  end;//else
  ForceDirectories(l_Path);
  l_N1 := l_N + '.tmp';
  l_F := Tl3FileStream.Create(l_N1, l3_fmWrite);
  try
   l_F.Write(PChar(l_S)^, Length(l_S));
  finally
   FreeAndNil(l_F);
  end;//try..finally
  if not FileExists(l_N) OR
     not l3CompareFiles(l_N1, l_N)
   then
  begin
   l3FileUtils.CopyFile(l_N1, l_N, cmNoBakCopy);
  end;//not FileExists(l_N) 
  TtfwScriptEngine.ScriptFromFile(l_N, aCaller);
 end//AnsiSameText(l_E, '.runner')
 else
  inherited;
//#UC END# *57B6E409029C_57B6E3BA005F_impl*
end;//TmsGenRunner.DoRunScript

class function TmsGenRunner.CheckFileExists(const aFileName: AnsiString): Boolean;
//#UC START# *57B6F81500E3_57B6E3BA005F_var*
//#UC END# *57B6F81500E3_57B6E3BA005F_var*
begin
//#UC START# *57B6F81500E3_57B6E3BA005F_impl*
 Result := inherited CheckFileExists(aFileName)
           OR AnsiSameText(ExtractFileExt(aFileName), '.runner');
//#UC END# *57B6F81500E3_57B6E3BA005F_impl*
end;//TmsGenRunner.CheckFileExists

end.
