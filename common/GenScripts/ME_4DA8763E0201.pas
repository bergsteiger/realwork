{$IfNDef WarningUserTypes_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\WarningUserTypes.imp.pas"
// ���������: "VCMForm"
// ������� ������: "WarningUserTypes" MUID: (4DA8763E0201)
// ��� ����: "_WarningUserTypes_"

{$Define WarningUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _WarningUserTypes_ = {abstract} class(_WarningUserTypes_Parent_)
  protected
   procedure WarningQueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� Warning.OnQueryClose }
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_WarningUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_WarningUserTypes_ = _WarningUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else WarningUserTypes_imp}

{$IfNDef WarningUserTypes_imp_impl}

{$Define WarningUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* ������������ ������ WarningLocalConstants }
 str_WarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarningCaption'; rValue : '��������������');
  {* ��������� ����������������� ���� "��������������" }
 str_WarningSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarningSettingsCaption'; rValue : '��������: ��������������');
  {* ��������� ����������������� ���� "��������������" ��� ��������� ������� ������������ }

{$If NOT Defined(NoVCM)}
procedure _WarningUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(WarningName,
  str_WarningCaption,
  str_WarningSettingsCaption,
  False,
  127,
  10,
  '',
  nil,
  nil,
  WarningQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(WarningName
end;//_WarningUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$Else WarningUserTypes_imp_impl}

 str_WarningCaption.Init;
 {* ������������� str_WarningCaption }
 str_WarningSettingsCaption.Init;
 {* ������������� str_WarningSettingsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf WarningUserTypes_imp_impl}

{$EndIf WarningUserTypes_imp}

