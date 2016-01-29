{$IfNDef RedactionsUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/RedactionsUserTypes.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::RedactionsUserTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define RedactionsUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _RedactionsUserTypes_ = {abstract form} class(_RedactionsUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 protected
 // protected methods
   procedure UtRedactionQueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� utRedaction.OnQueryClose }
 end;//_RedactionsUserTypes_
{$Else}

 _RedactionsUserTypes_ = _RedactionsUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else RedactionsUserTypes_imp}

{$IfNDef RedactionsUserTypes_imp_impl}
{$Define RedactionsUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { ������������ ������ utRedactionLocalConstants }
  str_utRedactionCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utRedactionCaption'; rValue : '��������');
   { ��������� ����������������� ���� "��������" }
  str_utRedactionSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utRedactionSettingsCaption'; rValue : '��������: �������� (�������)');
   { ��������� ����������������� ���� "��������" ��� ��������� ������� ������������ }

// start class _RedactionsUserTypes_

procedure _RedactionsUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(utRedactionName,
  str_utRedactionCaption,
  str_utRedactionSettingsCaption,
  true,
  46,
  60,
  '',
  nil,
  nil,
  UtRedactionQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utRedactionName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  RedactionsUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_utRedactionCaption
 str_utRedactionCaption.Init;
// ������������� str_utRedactionSettingsCaption
 str_utRedactionSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf RedactionsUserTypes_imp_impl}
{$EndIf RedactionsUserTypes_imp}
