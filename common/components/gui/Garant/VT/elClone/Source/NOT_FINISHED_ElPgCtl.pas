unit NOT_FINISHED_ElPgCtl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT"
// ������: "w:/common/components/gui/Garant/VT/elClone/Source/NOT_FINISHED_ElPgCtl.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VT::elClone::ElPgCtl
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
  ElXPThemedControl
  ;

type
 TElTabPosition = (
   
 );//TElTabPosition

 TElTabSheet = class
 end;//TElTabSheet

 TElCustomPageControl = class(TElXPThemedControl)
 protected
 // protected methods
   procedure RequestTabPosition; virtual;
     {* ��������� ������ RequestTabPosition }
 public
 // public methods
   procedure DoActivePrevPage; virtual;
     {* ��������� ������ DoActivePrevPage }
 end;//TElCustomPageControl

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  PageControlWordsPack
  {$IfEnd} //not NoScripts
  
  ;

// start class TElCustomPageControl

procedure TElCustomPageControl.RequestTabPosition;
//#UC START# *52B9A7B2027D_4E36C0C3014B_var*
//#UC END# *52B9A7B2027D_4E36C0C3014B_var*
begin
//#UC START# *52B9A7B2027D_4E36C0C3014B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52B9A7B2027D_4E36C0C3014B_impl*
end;//TElCustomPageControl.RequestTabPosition

procedure TElCustomPageControl.DoActivePrevPage;
//#UC START# *52B9A85201C2_4E36C0C3014B_var*
//#UC END# *52B9A85201C2_4E36C0C3014B_var*
begin
//#UC START# *52B9A85201C2_4E36C0C3014B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52B9A85201C2_4E36C0C3014B_impl*
end;//TElCustomPageControl.DoActivePrevPage

initialization
{$If not defined(NoScripts)}
// ����������� TElCustomPageControl
 TtfwClassRef.Register(TElCustomPageControl);
{$IfEnd} //not NoScripts

end.