unit l3AsincMessageWindowRes;

// ������: "w:\common\components\rtl\Garant\L3\l3AsincMessageWindowRes.pas"
// ���������: "UtilityPack"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ Local }
 str_l3mmLongOperation: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmLongOperation'; rValue : '����������� ���������� ��������...');
  {* '����������� ���������� ��������...' }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_l3mmLongOperation.Init;
 {* ������������� str_l3mmLongOperation }

end.
