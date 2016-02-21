unit kwClearDataBase;
 {* *������:*  'File_Name.zip' 'Path2Base' ClearDataBase
*��������:* ������������ ���� �� ������ 'File_Name.zip' � �������� ������� 'Path2Base'. �������, � ������� �������������� ����, �������������� ���������.. 
*������:*
[code]
  'testBase.zip' 'C:\Base\TestBase' ClearDataBase
[code] }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwClearDataBase.pas"
// ���������: "ScriptKeyword"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwClearDataBase = class(TtfwRegisterableWord)
  {* *������:*  'File_Name.zip' 'Path2Base' ClearDataBase
*��������:* ������������ ���� �� ������ 'File_Name.zip' � �������� ������� 'Path2Base'. �������, � ������� �������������� ����, �������������� ���������.. 
*������:*
[code]
  'testBase.zip' 'C:\Base\TestBase' ClearDataBase
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwClearDataBase
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arDBUtils
 , arArchiTestsAdapter
 {$If NOT Defined(Nemesis)}
 , dt_Jour
 {$IfEnd} // NOT Defined(Nemesis)
;

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
begin
 Result := 'ClearDataBase';
end;//TkwClearDataBase.GetWordNameForRegister

initialization
 TkwClearDataBase.RegisterInEngine;
 {* ����������� TkwClearDataBase }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
