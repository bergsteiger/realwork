unit nsListExceptions;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsListExceptions.pas"
// ���������: "UtilityPack"
// ������� ������: "nsListExceptions" MUID: (55E438930369)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3MessageID
 , SysUtils
;

const
 {* ������������ ������ EListIsTooLong local }
 str_ListIsTooLong: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ListIsTooLong'; rValue : '������ �������� ������� ���������� ����������, �� �� ����� ���� ������������. ����������, �������� ������.');
  {* '������ �������� ������� ���������� ����������, �� �� ����� ���� ������������. ����������, �������� ������.' }

type
 EListIsTooLong = class(Exception)
 end;//EListIsTooLong
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
;

initialization
 str_ListIsTooLong.Init;
 str_ListIsTooLong.SetDlgType(mtWarning);
 {* ������������� str_ListIsTooLong }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
