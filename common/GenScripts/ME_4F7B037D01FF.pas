unit nsSettingsConst;

// ������: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\nsSettingsConst.pas"
// ���������: "UtilityPack"
// ������� ������: "nsSettingsConst" MUID: (4F7B037D01FF)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vtNavigator
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 gi_Internal = '����������';
 pi_Navigator_RightSize = gi_Internal + '/���������/������ ������';
 pi_Navigator_LeftSize = gi_Internal + '/���������/����� ������';
 dv_Navigator_LeftSize = 200;
 dv_Navigator_RightSize = 200;
 gi_IfaceSettings = '��������� ����������';
 piHistoryItems = gi_IfaceSettings + '/HistoryItems';
 cv6xHistoryItems = 25;
 dvHistoryItems = cv6xHistoryItems;
 pi_LeftNavigator = gi_IfaceSettings + '/����� ���������';
 dv_LeftNavigator = vtNavigator.nsNormal;
 pi_RightNavigator = gi_IfaceSettings + '/������ ���������';
 dv_RightNavigator = vtNavigator.nsNormal;
 pi_lnAutoHideFloat = pi_LeftNavigator + '/AutoFloat';
 dv_lnAutoHideFloat = False;
 pi_rnAutoHideFloat = pi_RightNavigator + '/AutoFloat';
 dv_rnAutoHideFloat = False;

implementation

uses
 l3ImplUses
;

end.
