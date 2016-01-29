unit QueryCardAddAttributeTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestFormsTest"
// ������: "w:/common/components/gui/Garant/Daily/QueryCardAddAttributeTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TQueryCardAddAttributeTest
//
// ���� ���������� �������� � ��.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  TextViaEditorProcessor,
  PrimTextLoad_Form
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TQueryCardAddAttributeTest = {abstract} class(TTextViaEditorProcessor)
  {* ���� ���������� �������� � ��. }
 protected
 // realized methods
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* ���������� ������� ��������� ������ }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function QFLike: Boolean; override;
     {* ������� �����-�������� ��� ������ � ��. }
   procedure DoBeforeLoad(aForm: TPrimTextLoadForm); override;
     {* �������� �������������� �������� ��������� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TQueryCardAddAttributeTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  evQueryCardInt,
  evControlContainerEX,
  evQueryDocumentContainer,
  l3Base,
  nevTools,
  TestFrameWork,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TQueryCardAddAttributeTest

procedure TQueryCardAddAttributeTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4CA099DB01B7_var*
var
 l_QueryCard : IevQueryCard;
 l_Cont      : InevQueryDocumentContainer;
//#UC END# *4BE13147032C_4CA099DB01B7_var*
begin
//#UC START# *4BE13147032C_4CA099DB01B7_impl*
 l_QueryCard := TevControlContainerEX.Make;
 if l3IOk(aForm.Text.TextSource.DocumentContainer.QueryInterface(InevQueryDocumentContainer, l_Cont)) then
  l_QueryCard.LinkView(l_Cont);
 l_QueryCard.QueryGroup[0].FirstReq.FirstField.Text := l3CStr('1111');
 l_QueryCard.QueryGroup[0].FirstReq.AddField(aForm.Text.View, True);
//#UC END# *4BE13147032C_4CA099DB01B7_impl*
end;//TQueryCardAddAttributeTest.Process

function TQueryCardAddAttributeTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TQueryCardAddAttributeTest.GetFolder

function TQueryCardAddAttributeTest.QFLike: Boolean;
//#UC START# *4CA0947C03CE_4CA099DB01B7_var*
//#UC END# *4CA0947C03CE_4CA099DB01B7_var*
begin
//#UC START# *4CA0947C03CE_4CA099DB01B7_impl*
 Result := True;
//#UC END# *4CA0947C03CE_4CA099DB01B7_impl*
end;//TQueryCardAddAttributeTest.QFLike

procedure TQueryCardAddAttributeTest.DoBeforeLoad(aForm: TPrimTextLoadForm);
//#UC START# *4CA18D6B0088_4CA099DB01B7_var*
//#UC END# *4CA18D6B0088_4CA099DB01B7_var*
begin
//#UC START# *4CA18D6B0088_4CA099DB01B7_impl*
 aForm.Text.TextSource.DocumentContainer := nil;
 aForm.Text.TextSource.DocumentContainer := TevQueryDocumentContainer.Make;
//#UC END# *4CA18D6B0088_4CA099DB01B7_impl*
end;//TQueryCardAddAttributeTest.DoBeforeLoad

function TQueryCardAddAttributeTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CA099DB01B7';
end;//TQueryCardAddAttributeTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.