{$IfNDef RedactionsUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\RedactionsUserTypes.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "RedactionsUserTypes" MUID: (5009475801E4)
// Имя типа: "_RedactionsUserTypes_"

{$Define RedactionsUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _RedactionsUserTypes_ = {abstract} class(_RedactionsUserTypes_Parent_)
  protected
   procedure UtRedactionQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события utRedaction.OnQueryClose }
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
{$If NOT Defined(NoVCM)}
procedure _RedactionsUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(utRedactionName,
  str_utRedactionCaption,
  str_utRedactionSettingsCaption,
  True,
  46,
  60,
  '',
  nil,
  nil,
  UtRedactionQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utRedactionName
end;//_RedactionsUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf RedactionsUserTypes_imp_impl}

{$EndIf RedactionsUserTypes_imp}

