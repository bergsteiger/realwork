unit K253668263;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K253668263.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K253668263
//
// [$253668263]
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
  SplitCellTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK253668263 = class(TSplitCellTest)
  {* [$253668263] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetLineCount: Integer; override;
   function GetTabCount: Integer; override;
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK253668263
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

// start class TK253668263

function TK253668263.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK253668263.GetFolder

function TK253668263.GetLineCount: Integer;
//#UC START# *4D5A6EE600D3_4D5A644B03A8_var*
//#UC END# *4D5A6EE600D3_4D5A644B03A8_var*
begin
//#UC START# *4D5A6EE600D3_4D5A644B03A8_impl*
 Result := 1;
//#UC END# *4D5A6EE600D3_4D5A644B03A8_impl*
end;//TK253668263.GetLineCount

function TK253668263.GetTabCount: Integer;
//#UC START# *4D5A6F4802CB_4D5A644B03A8_var*
//#UC END# *4D5A6F4802CB_4D5A644B03A8_var*
begin
//#UC START# *4D5A6F4802CB_4D5A644B03A8_impl*
 Result := 1;
//#UC END# *4D5A6F4802CB_4D5A644B03A8_impl*
end;//TK253668263.GetTabCount

function TK253668263.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D5A644B03A8';
end;//TK253668263.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK253668263.Suite);

end.