unit nsSettingsConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/common/components/gui/Garant/VCM/View/ParentAndChild/nsSettingsConst.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi F1 Like Application::F1Like::View::ParentAndChild::nsSettingsConst
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

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

end.