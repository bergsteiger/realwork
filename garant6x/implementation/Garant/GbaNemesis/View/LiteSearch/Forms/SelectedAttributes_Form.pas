unit SelectedAttributes_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/SelectedAttributes_Form.pas"
// �����: 15.09.2009 12:36
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 ������� ����������� ���������� �������::SearchLite::View::LiteSearch::LiteSearch::SelectedAttributes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  PrimSelectedAttributesOptions_Form,
  SearchLite_FormDefinitions_Controls,
  nscTreeViewWithAdapterDragDrop,
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
  TenSelectedAttributes = {final form} class(TPrimSelectedAttributesOptionsForm, SelectedAttributesFormDef)
  Entities : TvcmEntities;
  end;//TenSelectedAttributes

  TSelectedAttributesForm = TenSelectedAttributes;

implementation

{$R *.DFM}

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  SelectedAttributesKeywordsPack
  {$IfEnd} //not NoScripts
  
  ;


initialization
{$If not defined(NoScripts)}
// ����������� SelectedAttributes
 TtfwClassRef.Register(TenSelectedAttributes);
{$IfEnd} //not NoScripts
// ����������� ������� ����� SelectedAttributes
 fm_enSelectedAttributes.SetFactory(TenSelectedAttributes.Make);

end.