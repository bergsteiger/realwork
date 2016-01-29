unit kwClearDataBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwClearDataBase.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwClearDataBase
//
// *������:*  'File_Name.zip' 'Path2Base' ClearDataBase
// *��������:* ������������ ���� �� ������ 'File_Name.zip' � �������� ������� 'Path2Base'. �������,
// � ������� �������������� ����, �������������� ���������..
// *������:*
// {code}
// 'testBase.zip' 'C:\Base\TestBase' ClearDataBase
// {code}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwClearDataBase = {scriptword} class(TtfwRegisterableWord)
  {* *������:*  'File_Name.zip' 'Path2Base' ClearDataBase
*��������:* ������������ ���� �� ������ 'File_Name.zip' � �������� ������� 'Path2Base'. �������, � ������� �������������� ����, �������������� ���������.. 
*������:*
[code]
  'testBase.zip' 'C:\Base\TestBase' ClearDataBase
[code] }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwClearDataBase
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arDBUtils,
  arArchiTestsAdapter
  {$If not defined(Nemesis)}
  ,
  dt_Jour
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwClearDataBase

procedure TkwClearDataBase.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E4A181002B0_var*
var
 l_Msg      : AnsiString;
 l_DirName  : AnsiString;
 l_FileName : AnsiString;
//#UC END# *4DAEEDE10285_4E4A181002B0_var*
begin
//#UC START# *4DAEEDE10285_4E4A181002B0_impl*
 inherited;
 RunnerAssert(aCtx.rEngine.IsTopString, '�� ������ ���������� ��� ����!', aCtx);
 l_DirName := aCtx.rEngine.PopDelphiString;
 RunnerAssert(aCtx.rEngine.IsTopString, '�� ������ ��� ������ � �����!', aCtx);
 l_FileName := aCtx.rCaller.ResolveInputFilePath(aCtx.rEngine.PopDelphiString);
 try
  acDeInitDB;
 except
  on EdtBrokenFileLock do;
 end;
 if not ArUnackBaseFromArchive(l_FileName, l_DirName, l_Msg) then
  Assert(False, l_Msg);
 acInitDB; 
//#UC END# *4DAEEDE10285_4E4A181002B0_impl*
end;//TkwClearDataBase.DoDoIt

class function TkwClearDataBase.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ClearDataBase';
end;//TkwClearDataBase.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� TkwClearDataBase
 TkwClearDataBase.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.