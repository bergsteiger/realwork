unit K234363615;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/Daily/K234363615.pas"
// �����: 17.09.2010 15:37
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K234363615
//
// {RequestLink:234363615}.
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
  CopyPasteTest,
  nevTools,
  evCustomEditorWindow,
  l3Variant
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK234363615 = class(TCopyPasteTest)
  {* [RequestLink:234363615]. }
 protected
 // realized methods
   function DoSelect(aText: TevCustomEditorWindow;
     const anOp: Il3OpPack): InevRange; override;
     {* �������� ����� � ��������� }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK234363615
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evMsgCode,
  evOp,
  l3Base,
  l3InternalInterfaces
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
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK234363615

function TK234363615.DoSelect(aText: TevCustomEditorWindow;
  const anOp: Il3OpPack): InevRange;
//#UC START# *4C93538E0218_4C9352DE031D_var*
//#UC END# *4C93538E0218_4C9352DE031D_var*
begin
//#UC START# *4C93538E0218_4C9352DE031D_impl*
 Result := aText.Document.Para[4].Range;
//#UC END# *4C93538E0218_4C9352DE031D_impl*
end;//TK234363615.DoSelect

function TK234363615.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK234363615.GetFolder

function TK234363615.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C9352DE031D';
end;//TK234363615.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK234363615.Suite);

end.