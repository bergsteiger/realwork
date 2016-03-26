unit nsSettingsConst;

// Модуль: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\nsSettingsConst.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsSettingsConst" MUID: (4F7B037D01FF)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vtNavigator
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 gi_Internal = 'Внутренняя';
 pi_Navigator_RightSize = gi_Internal + '/Навигатор/Правый размер';
 pi_Navigator_LeftSize = gi_Internal + '/Навигатор/Левый размер';
 dv_Navigator_LeftSize = 200;
 dv_Navigator_RightSize = 200;
 gi_IfaceSettings = 'Настройки интерфейса';
 piHistoryItems = gi_IfaceSettings + '/HistoryItems';
 cv6xHistoryItems = 25;
 dvHistoryItems = cv6xHistoryItems;
 pi_LeftNavigator = gi_IfaceSettings + '/Левый навигатор';
 dv_LeftNavigator = vtNavigator.nsNormal;
 pi_RightNavigator = gi_IfaceSettings + '/Правый навигатор';
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
