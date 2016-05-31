{$IfNDef AttributesUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AttributesUserTypes.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "AttributesUserTypes" MUID: (4D776CFE031E)
// Имя типа: "_AttributesUserTypes_"

{$Define AttributesUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _AttributesUserTypes_ = {abstract} class(_AttributesUserTypes_Parent_)
  protected
   procedure FDocAttributeQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события fDocAttribute.OnQueryClose }
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_AttributesUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_AttributesUserTypes_ = _AttributesUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else AttributesUserTypes_imp}

{$IfNDef AttributesUserTypes_imp_impl}

{$Define AttributesUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$If NOT Defined(NoVCM)}
procedure _AttributesUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(fDocAttributeName,
  str_fDocAttributeCaption,
  str_fDocAttributeCaption,
  False,
  19,
  20,
  '',
  nil,
  nil,
  FDocAttributeQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(fDocAttributeName
 with AddUsertype(fAttributeSynchroViewName,
  str_fAttributeSynchroViewCaption,
  str_fAttributeSynchroViewCaption,
  False,
  19,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(fAttributeSynchroViewName
end;//_AttributesUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf AttributesUserTypes_imp_impl}

{$EndIf AttributesUserTypes_imp}

