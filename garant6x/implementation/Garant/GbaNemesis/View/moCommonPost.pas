unit moCommonPost;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/moCommonPost.pas"
// �����: 15.09.2009 19:19
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 Common For Shell And Monitoring::PostingOrder::CommonPost
//
// ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  CommonPost_Module
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
Tmo_CommonPost = {final formspack} class(TCommonPostModule)
 {* ���� }
end;//Tmo_CommonPost
{$IfEnd} //not Admin

implementation

end.