unit moFolders;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// �����: ������ �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/moFolders.pas"
// �����: 2003/08/06 08:30:27
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 �������� ����������::Folders::Folders$UC
//
// �����
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
  PrimFolders_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_Folders = {final formspack} class(TPrimFoldersModule)
 {* ����� }
end;//Tmo_Folders
{$IfEnd} //not Admin AND not Monitorings

implementation

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
// ����������� Folders$UC
 TtfwClassRef.Register(Tmo_Folders);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.