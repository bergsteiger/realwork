{$IfNDef nsUserSettingsListener_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Data"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Common/nsUserSettingsListener.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Data::Common::nsUserSettingsListener
//
// ��������� ��������� �������� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nsUserSettingsListener_imp}
 _nsUserSettingsListener_ = {mixin} class(_nsUserSettingsListener_Parent_, InsUserSettingsListener)
  {* ��������� ��������� �������� ������������ }
 protected
 // realized methods
   procedure Changed;
     {* ���������� ����� ���������\�������������� �������� }
 protected
 // protected methods
   procedure UserSettingsChanged; virtual;
     {* ���������� ��������� ������������ }
   procedure Cleanup; override;
   procedure InitFields; override;
 end;//_nsUserSettingsListener_

{$Else nsUserSettingsListener_imp}

// start class _nsUserSettingsListener_

procedure _nsUserSettingsListener_.UserSettingsChanged;
//#UC START# *4958BE910345_4958BD880163_var*
//#UC END# *4958BE910345_4958BD880163_var*
begin
//#UC START# *4958BE910345_4958BD880163_impl*
 // - ������ �� ������
//#UC END# *4958BE910345_4958BD880163_impl*
end;//_nsUserSettingsListener_.UserSettingsChanged

procedure _nsUserSettingsListener_.Cleanup;
//#UC START# *4958BF0203C3_4958BD880163_var*
var
 l_Settings: InsSettings;
//#UC END# *4958BF0203C3_4958BD880163_var*
begin
//#UC START# *4958BF0203C3_4958BD880163_impl*
 if Supports(afw.Application.Settings, InsSettings, l_Settings) then
 try
  l_Settings.SettingsNotify.RemoveListener(InsUserSettingsListener(Self));
 finally
  l_Settings := nil;
 end;//try..finally
 inherited;
//#UC END# *4958BF0203C3_4958BD880163_impl*
end;//_nsUserSettingsListener_.Cleanup

procedure _nsUserSettingsListener_.InitFields;
//#UC START# *4958BF2302DF_4958BD880163_var*
var
 l_Settings: InsSettings;
//#UC END# *4958BF2302DF_4958BD880163_var*
begin
//#UC START# *4958BF2302DF_4958BD880163_impl*
 inherited;
 if Supports(afw.Application.Settings, InsSettings, l_Settings) then
 try
  l_Settings.SettingsNotify.AddListener(InsUserSettingsListener(Self));
 finally
  l_Settings := nil;
 end;//try..finally
//#UC END# *4958BF2302DF_4958BD880163_impl*
end;//_nsUserSettingsListener_.InitFields

procedure _nsUserSettingsListener_.Changed;
//#UC START# *491443FE01BE_4958BD880163_var*
//#UC END# *491443FE01BE_4958BD880163_var*
begin
//#UC START# *491443FE01BE_4958BD880163_impl*
 UserSettingsChanged;
//#UC END# *491443FE01BE_4958BD880163_impl*
end;//_nsUserSettingsListener_.Changed

{$EndIf nsUserSettingsListener_imp}
