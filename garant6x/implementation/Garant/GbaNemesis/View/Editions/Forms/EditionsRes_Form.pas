unit EditionsRes_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Editions/Forms/EditionsRes_Form.pas"
// �����: 15.01.2010 17:58
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMDataModule::Class>> F1 ���������������� �������::CompareEditions::View::Editions::EditionsRes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  PrimEditionsRes_Form,
  vtPngImgList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TEditionsResForm = {final form} class(TPrimEditionsResForm)
  EditionsStateIcons: TvtPngImageList;
 end;//TEditionsResForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$R *.DFM}

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� EditionsRes
 TtfwClassRef.Register(TEditionsResForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.