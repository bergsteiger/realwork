unit ddAppConfigStringsRes;

// ������: "w:\common\components\rtl\Garant\dd\ddAppConfigStringsRes.pas"
// ���������: "UtilityPack"
// ������� ������: "ddAppConfigStringsRes" MUID: (4B9E62C2001A)

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
 //#UC START# *4B9E62C2001Aimpl_uses*
 //#UC END# *4B9E62C2001Aimpl_uses*
;

initialization
 str_ddcmCheckButton.Init;
 {* ������������� str_ddcmCheckButton }
 str_ddcmSoundFiles.Init;
 {* ������������� str_ddcmSoundFiles }

end.
