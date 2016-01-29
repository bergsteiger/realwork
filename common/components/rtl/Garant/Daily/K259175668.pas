unit K259175668;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K259175668.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K259175668
//
// [$259175668]
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
  WrongSearchTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK259175668 = class(TWrongSearchTest)
  {* [$259175668] }
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
 end;//TK259175668
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

// start class TK259175668

{$If defined(nsTest) AND not defined(NoVCM)}
function TK259175668.StringForSearch: AnsiString;
//#UC START# *4BE051200169_4D940F400178_var*
//#UC END# *4BE051200169_4D940F400178_var*
begin
//#UC START# *4BE051200169_4D940F400178_impl*
 Result := '*';
//#UC END# *4BE051200169_4D940F400178_impl*
end;//TK259175668.StringForSearch
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK259175668.StringForReplace: AnsiString;
//#UC START# *4BE0513800C9_4D940F400178_var*
//#UC END# *4BE0513800C9_4D940F400178_var*
begin
//#UC START# *4BE0513800C9_4D940F400178_impl*
 Result := ' ';
//#UC END# *4BE0513800C9_4D940F400178_impl*
end;//TK259175668.StringForReplace
{$IfEnd} //nsTest AND not NoVCM

function TK259175668.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK259175668.GetFolder

function TK259175668.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D940F400178';
end;//TK259175668.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK259175668.Suite);

end.