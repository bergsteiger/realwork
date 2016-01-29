unit F1AutoScripter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Shell Tests Core"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1AutoScripter.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> F1 ��������� ������::F1 Shell Tests Core::Core::TF1AutoScripter
//
// ������ � ���������� ���������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\GbaNemesis\nsDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  InsiderOwnScripter
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TF1AutoScripter = {abstract} class(TInsiderOwnScripter)
  {* ������ � ���������� ��������������� }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
   function ResolveScriptFilePath(const aFileName: AnsiString): AnsiString; override;
   class function IsScript: Boolean; override;
     {* ��� ��� ������������ - ��-�� ������ �������� � ���� ������������� � TTestSuite. }
 end;//TF1AutoScripter
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  StrUtils,
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(Admin)}
  ,
  nsQueryInterfaces
  {$IfEnd} //not Admin
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  nsUtils,
  nsConst,
  bsTypesNew,
  tfwScriptEngine
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TF1AutoScripter

function TF1AutoScripter.GetFolder: AnsiString;
 {-}
begin
 Result := 'Core';
end;//TF1AutoScripter.GetFolder

function TF1AutoScripter.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DC3F6DD00F1';
end;//TF1AutoScripter.GetModelElementGUID

function TF1AutoScripter.ResolveScriptFilePath(const aFileName: AnsiString): AnsiString;
//#UC START# *4DB03121022B_4DC3F6DD00F1_var*
//#UC END# *4DB03121022B_4DC3F6DD00F1_var*
begin
//#UC START# *4DB03121022B_4DC3F6DD00F1_impl*
 if ANSIStartsText('@\', aFileName) then
  Result := FileFromCurrent('Common\' + Copy(aFileName, 3, Length(aFileName)-2))
 else 
 if (ExtractFilePath(aFileName) <> '') then
  Result := aFileName
 else
  Result := FileFromCurrent('Auto') + '\'+ aFileName;
//#UC END# *4DB03121022B_4DC3F6DD00F1_impl*
end;//TF1AutoScripter.ResolveScriptFilePath

class function TF1AutoScripter.IsScript: Boolean;
//#UC START# *4DC395670274_4DC3F6DD00F1_var*
//#UC END# *4DC395670274_4DC3F6DD00F1_var*
begin
//#UC START# *4DC395670274_4DC3F6DD00F1_impl*
 Result := True;
//#UC END# *4DC395670274_4DC3F6DD00F1_impl*
end;//TF1AutoScripter.IsScript

{$IfEnd} //nsTest AND not NoScripts

end.