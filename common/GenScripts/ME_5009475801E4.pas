{$IfNDef RedactionsUserTypes_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\RedactionsUserTypes.imp.pas"
// ���������: "VCMForm"
// ������� ������: "RedactionsUserTypes" MUID: (5009475801E4)
// ��� ����: "_RedactionsUserTypes_"

{$Define RedactionsUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _RedactionsUserTypes_ = {abstract} class(_RedactionsUserTypes_Parent_)
  protected
   procedure utRedactionQueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� utRedaction.OnQueryClose }
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_RedactionsUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_RedactionsUserTypes_ = _RedactionsUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else RedactionsUserTypes_imp}

{$IfNDef RedactionsUserTypes_imp_impl}

{$Define RedactionsUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* ������������ ������ utRedactionLocalConstants }
 str_utRedactionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utRedactionCaption'; rValue : '��������');
  {* ��������� ����������������� ���� "��������" }
 str_utRedactionSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utRedactionSettingsCaption'; rValue : '��������: �������� (�������)');
  {* ��������� ����������������� ���� "��������" ��� ��������� ������� ������������ }

{$If NOT Defined(NoVCM)}
procedure _RedactionsUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(utRedactionName,
  str_utRedactionCaption,
  str_utRedactionSettingsCaption,
  False,
  46,
  60,
  '',
  nil,
  nil,
  utRedactionQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utRedactionName
end;//_RedactionsUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$Else RedactionsUserTypes_imp_impl}

 str_utRedactionCaption.Init;
 {* ������������� str_utRedactionCaption }
 str_utRedactionSettingsCaption.Init;
 {* ������������� str_utRedactionSettingsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf RedactionsUserTypes_imp_impl}

{$EndIf RedactionsUserTypes_imp}

