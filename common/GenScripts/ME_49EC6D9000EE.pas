unit InternetAgentInterfaces;
 {* ���������� ��� ���������� [��������-������|$124453728] }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\InternetAgent\InternetAgentInterfaces.pas"
// ���������: "ControllerInterfaces"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 IsdsInternetAgent = interface;

 IdsInternetAgent = interface
  {* ������� ������ ��������-������ }
  ['{9CECE11A-2DD8-4A7E-B87C-77350FE9903C}']
  function Get_URL: WideString;
  property URL: WideString
   read Get_URL;
 end;//IdsInternetAgent

 IsdsInternetAgent = interface
  {* ��������� ������ � ��������-������� }
  ['{CEB1B5A7-53B6-4359-90F3-AF6DEF048C0D}']
  function pm_GetMainViewArea: IdsInternetAgent;
  property MainViewArea: IdsInternetAgent
   read pm_GetMainViewArea;
 end;//IsdsInternetAgent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
