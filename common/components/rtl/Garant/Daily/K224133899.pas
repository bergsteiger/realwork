unit K224133899;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K224133899.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K224133899
//
// [$224133899]
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
  Translate2TextTest,
  nevTools
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK224133899 = class(TTranslate2TextTest)
  {* [$224133899] }
 protected
 // overridden protected methods
   function SelectTableWholly: Boolean; override;
     {* ������ ������� ������� }
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetTablePara(const aDocument: InevParaList): InevParaList; override;
     {* ���������� �������� � �������� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK224133899
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evMsgCode,
  evOp
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  
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

// start class TK224133899

function TK224133899.SelectTableWholly: Boolean;
//#UC START# *4C34625E021F_4C346A9C0180_var*
//#UC END# *4C34625E021F_4C346A9C0180_var*
begin
//#UC START# *4C34625E021F_4C346A9C0180_impl*
 Result := True;
//#UC END# *4C34625E021F_4C346A9C0180_impl*
end;//TK224133899.SelectTableWholly

function TK224133899.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK224133899.GetFolder

function TK224133899.GetTablePara(const aDocument: InevParaList): InevParaList;
//#UC START# *4CC818F4022D_4C346A9C0180_var*
//#UC END# *4CC818F4022D_4C346A9C0180_var*
begin
//#UC START# *4CC818F4022D_4C346A9C0180_impl*
 Result := aDocument.Para[1].AsList;
//#UC END# *4CC818F4022D_4C346A9C0180_impl*
end;//TK224133899.GetTablePara

function TK224133899.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C346A9C0180';
end;//TK224133899.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK224133899.Suite);

end.