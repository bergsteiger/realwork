unit NOT_COMPLETED_AutoreferatInterfaces;
 {* ���������� ��� ������ � ��������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Autoreferat\NOT_COMPLETED_AutoreferatInterfaces.pas"
// ���������: "ControllerInterfaces"
// ������� ������: "AutoreferatInterfaces" MUID: (492F0586030C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , SearchInterfaces
 , DocumentInterfaces
 , DocumentUnit
 , bsTypesNew
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 IdsNewsLine = interface(IvcmViewAreaController)
  {* ��������� ����� }
  ['{34D4F64F-ABFB-48BE-B04F-DD609BB32DAB}']
 end;//IdsNewsLine

 IsdsAutoreferat = interface(IsdsBaseDocument)
  ['{22A93E6D-D6A0-4D95-BA27-C6A9CFBBF259}']
  function pm_GetMakeNewsLineFakeDS: IdsNewsLine;
  property MakeNewsLineFakeDS: IdsNewsLine
   read pm_GetMakeNewsLineFakeDS;
   {* ��������� ������ ������ ��������� ����� }
 end;//IsdsAutoreferat
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
