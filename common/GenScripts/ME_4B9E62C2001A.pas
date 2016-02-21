unit ddAppConfigStringsRes;

// ������: "w:\common\components\rtl\Garant\dd\ddAppConfigStringsRes.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ Local }
 str_ddcmCheckButton: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmCheckButton'; rValue : '��������');
  {* '��������' }
 str_ddcmSoundFiles: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmSoundFiles'; rValue : '�������� ����� (*.wav)|*.wav');
  {* '�������� ����� (*.wav)|*.wav' }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_ddcmCheckButton.Init;
 {* ������������� str_ddcmCheckButton }
 str_ddcmSoundFiles.Init;
 {* ������������� str_ddcmSoundFiles }

end.
