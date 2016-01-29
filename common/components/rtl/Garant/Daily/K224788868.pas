unit K224788868;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/K224788868.pas"
// �����: 08.07.2010 12:36
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K224788868
//
// {RequestLink:224788868}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  SearchAndReplaceTest
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK224788868 = class(TSearchAndReplaceTest)
  {* [RequestLink:224788868] }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function StringForSearch: AnsiString; override;
     {* ������ ��� ������ }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function StringForReplace: AnsiString; override;
     {* ������ ��� ������ }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK224788868
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK224788868

{$If defined(nsTest) AND not defined(NoVCM)}
function TK224788868.StringForSearch: AnsiString;
//#UC START# *4BE051200169_4C358BF70329_var*
//#UC END# *4BE051200169_4C358BF70329_var*
begin
//#UC START# *4BE051200169_4C358BF70329_impl*
 Result := '����';
//#UC END# *4BE051200169_4C358BF70329_impl*
end;//TK224788868.StringForSearch
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK224788868.StringForReplace: AnsiString;
//#UC START# *4BE0513800C9_4C358BF70329_var*
//#UC END# *4BE0513800C9_4C358BF70329_var*
begin
//#UC START# *4BE0513800C9_4C358BF70329_impl*
 Result := '��������';
//#UC END# *4BE0513800C9_4C358BF70329_impl*
end;//TK224788868.StringForReplace
{$IfEnd} //nsTest AND not NoVCM

function TK224788868.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK224788868.GetFolder

function TK224788868.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C358BF70329';
end;//TK224788868.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK224788868.Suite);

end.