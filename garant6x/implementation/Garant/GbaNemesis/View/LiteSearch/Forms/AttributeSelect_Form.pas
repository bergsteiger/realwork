unit AttributeSelect_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/AttributeSelect_Form.pas"
// �����: 15.09.2009 12:26
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 ������� ����������� ���������� �������::SearchLite::View::LiteSearch::LiteSearch::AttributeSelect
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  PrimAttributeSelectOptions_Form,
  SearchLite_FormDefinitions_Controls,
  vtProportionalPanel,
  vtSizeablePanel,
  vtPanel,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;

type
  TcfAttributeSelect = {final form} class(TPrimAttributeSelectOptionsForm, AttributeSelectFormDef)
  Entities : TvcmEntities;
  end;//TcfAttributeSelect

  TAttributeSelectForm = TcfAttributeSelect;

implementation

{$R *.DFM}

uses
  l3String
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  AttributeSelectKeywordsPack
  {$IfEnd} //not NoScripts
  
  ;


initialization
{$If not defined(NoScripts)}
// ����������� AttributeSelect
 TtfwClassRef.Register(TcfAttributeSelect);
{$IfEnd} //not NoScripts
// ����������� ������� ����� AttributeSelect
 fm_cfAttributeSelect.SetFactory(TcfAttributeSelect.Make);

end.