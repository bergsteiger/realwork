unit QueryCardAddAttributeTest;
 {* ���� ���������� �������� � ��. }

// ������: "w:\common\components\gui\Garant\Daily\QueryCardAddAttributeTest.pas"
// ���������: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TQueryCardAddAttributeTest = {abstract} class(TTextViaEditorProcessor)
  {* ���� ���������� �������� � ��. }
  protected
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* ���������� ������� ��������� ������ }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function QFLike: Boolean; override;
    {* ������� �����-�������� ��� ������ � ��. }
   procedure DoBeforeLoad(aForm: TPrimTextLoadForm); override;
    {* �������� �������������� �������� ��������� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TQueryCardAddAttributeTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , evQueryCardInt
 , evControlContainerEX
 , evQueryDocumentContainer
 , l3Base
 , nevTools
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TQueryCardAddAttributeTest.Process(aForm: TPrimTextLoadForm);
 {* ���������� ������� ��������� ������ }
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
 {* ����� � ������� ������ ���� }
begin
 Result := 'Everest';
end;//TQueryCardAddAttributeTest.GetFolder

function TQueryCardAddAttributeTest.QFLike: Boolean;
 {* ������� �����-�������� ��� ������ � ��. }
//#UC START# *4CA0947C03CE_4CA099DB01B7_var*
//#UC END# *4CA0947C03CE_4CA099DB01B7_var*
begin
//#UC START# *4CA0947C03CE_4CA099DB01B7_impl*
 Result := True;
//#UC END# *4CA0947C03CE_4CA099DB01B7_impl*
end;//TQueryCardAddAttributeTest.QFLike

procedure TQueryCardAddAttributeTest.DoBeforeLoad(aForm: TPrimTextLoadForm);
 {* �������� �������������� �������� ��������� }
//#UC START# *4CA18D6B0088_4CA099DB01B7_var*
//#UC END# *4CA18D6B0088_4CA099DB01B7_var*
begin
//#UC START# *4CA18D6B0088_4CA099DB01B7_impl*
 aForm.Text.TextSource.DocumentContainer := nil;
 aForm.Text.TextSource.DocumentContainer := TevQueryDocumentContainer.Make;
//#UC END# *4CA18D6B0088_4CA099DB01B7_impl*
end;//TQueryCardAddAttributeTest.DoBeforeLoad

function TQueryCardAddAttributeTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4CA099DB01B7';
end;//TQueryCardAddAttributeTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
