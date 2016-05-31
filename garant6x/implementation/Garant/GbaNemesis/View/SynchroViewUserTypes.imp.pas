{$IfNDef SynchroViewUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\SynchroViewUserTypes.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "SynchroViewUserTypes" MUID: (4FFBDD570171)
// Имя типа: "_SynchroViewUserTypes_"

{$Define SynchroViewUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _SynchroViewUserTypes_ = {abstract} class(_SynchroViewUserTypes_Parent_)
  protected
   procedure SvSynchroViewQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события svSynchroView.OnQueryClose }
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_SynchroViewUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_SynchroViewUserTypes_ = _SynchroViewUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else SynchroViewUserTypes_imp}

{$IfNDef SynchroViewUserTypes_imp_impl}

{$Define SynchroViewUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$If NOT Defined(NoVCM)}
procedure _SynchroViewUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(svSynchroViewName,
  str_svSynchroViewCaption,
  str_svSynchroViewCaption,
  False,
  84,
  20,
  '',
  nil,
  nil,
  SvSynchroViewQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(svSynchroViewName
end;//_SynchroViewUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf SynchroViewUserTypes_imp_impl}

{$EndIf SynchroViewUserTypes_imp}

