{$IfNDef WarningUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/WarningUserTypes.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::WarningUserTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define WarningUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _WarningUserTypes_ = {abstract form} class(_WarningUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 protected
 // protected methods
   procedure WarningQueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� Warning.OnQueryClose }
 end;//_WarningUserTypes_
{$Else}

 _WarningUserTypes_ = _WarningUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else WarningUserTypes_imp}

{$IfNDef WarningUserTypes_imp_impl}
{$Define WarningUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { ������������ ������ WarningLocalConstants }
  str_WarningCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarningCaption'; rValue : '��������������');
   { ��������� ����������������� ���� "��������������" }
  str_WarningSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarningSettingsCaption'; rValue : '��������: ��������������');
   { ��������� ����������������� ���� "��������������" ��� ��������� ������� ������������ }

// start class _WarningUserTypes_

procedure _WarningUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(WarningName,
  str_WarningCaption,
  str_WarningSettingsCaption,
  true,
  127,
  10,
  '',
  nil,
  nil,
  WarningQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarningName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  WarningUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_WarningCaption
 str_WarningCaption.Init;
// ������������� str_WarningSettingsCaption
 str_WarningSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf WarningUserTypes_imp_impl}
{$EndIf WarningUserTypes_imp}
