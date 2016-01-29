unit InternetAgentInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "InternetAgent"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/InternetAgent/InternetAgentInterfaces.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 ���������� ��������::InternetAgent::InternetAgent::InternetAgentInterfaces
//
// ���������� ��� ���������� [��������-������|$124453728]
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
  vcmInterfaces {a},
  vcmControllers {a}
  ;

type
 IdsInternetAgent = interface(IvcmViewAreaController)
  {* ������� ������ ��������-������ }
   ['{9CECE11A-2DD8-4A7E-B87C-77350FE9903C}']
   function Get_URL: WideString;
   property URL: WideString
     read Get_URL;
 end;//IdsInternetAgent

 IsdsInternetAgent = interface(IvcmUseCaseController)
  {* ��������� ������ � ��������-������� }
   ['{CEB1B5A7-53B6-4359-90F3-AF6DEF048C0D}']
   function pm_GetMainViewArea: IdsInternetAgent;
   property MainViewArea: IdsInternetAgent
     read pm_GetMainViewArea;
 end;//IsdsInternetAgent
{$IfEnd} //not Admin AND not Monitorings

implementation

end.