unit InsertStreamTestWithImplementedNavigate;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/InsertStreamTestWithImplementedNavigate.pas"
// �����: 28.07.2010 15:34
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TInsertStreamTestWithImplementedNavigate
//
// �� �� ��� � TInsertStreamTest, �� � ������ Navigate
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
  InsertStreamTest,
  evCustomEditorWindow,
  l3Variant
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TInsertStreamTestWithImplementedNavigate = {abstract} class(TInsertStreamTest)
  {* �� �� ��� � TInsertStreamTest, �� � ������ Navigate }
 protected
 // realized methods
   procedure Navigate(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
     {* ������������� ������ ��� ��������� }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TInsertStreamTestWithImplementedNavigate
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

// start class TInsertStreamTestWithImplementedNavigate

procedure TInsertStreamTestWithImplementedNavigate.Navigate(aText: TevCustomEditorWindow;
  const anOp: Il3OpPack);
//#UC START# *4C4FE56300FB_4C501582010E_var*
//#UC END# *4C4FE56300FB_4C501582010E_var*
begin
//#UC START# *4C4FE56300FB_4C501582010E_impl*
 // - ������ �� ������
//#UC END# *4C4FE56300FB_4C501582010E_impl*
end;//TInsertStreamTestWithImplementedNavigate.Navigate

function TInsertStreamTestWithImplementedNavigate.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TInsertStreamTestWithImplementedNavigate.GetFolder

function TInsertStreamTestWithImplementedNavigate.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C501582010E';
end;//TInsertStreamTestWithImplementedNavigate.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.