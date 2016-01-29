unit K518756624;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/K518756624.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.10::K518756624
//
// {RequestLink:518756624}
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
  EVDtoRTFRender
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK518756624 = class(TEVDtoRTFRender)
  {* [RequestLink:518756624] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
   function NeedEliminateCommentDecorations: Boolean; override;
 end;//TK518756624
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK518756624

function TK518756624.GetFolder: AnsiString;
 {-}
begin
 Result := '7.10';
end;//TK518756624.GetFolder

function TK518756624.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '530C925400E5';
end;//TK518756624.GetModelElementGUID

function TK518756624.NeedEliminateCommentDecorations: Boolean;
//#UC START# *530C91FB00BD_530C925400E5_var*
//#UC END# *530C91FB00BD_530C925400E5_var*
begin
//#UC START# *530C91FB00BD_530C925400E5_impl*
 Result := True;
//#UC END# *530C91FB00BD_530C925400E5_impl*
end;//TK518756624.NeedEliminateCommentDecorations

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK518756624.Suite);

end.