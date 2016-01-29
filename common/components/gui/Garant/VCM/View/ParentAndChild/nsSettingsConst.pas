unit nsSettingsConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/common/components/gui/Garant/VCM/View/ParentAndChild/nsSettingsConst.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi F1 Like Application::F1Like::View::ParentAndChild::nsSettingsConst
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vtNavigator
  {$IfEnd} //not NoVCM
  
  ;

const
  { Settings Const }
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

end.