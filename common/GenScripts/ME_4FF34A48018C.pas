unit DocumentUtil;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUtil.pas"
// ���������: "UtilityPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ Local }
 str_IsDocumentUsefulCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'IsDocumentUsefulCaption'; rValue : '������� �� ��������?');
  {* '������� �� ��������?' }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_IsDocumentUsefulCaption.Init;
 {* ������������� str_IsDocumentUsefulCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
