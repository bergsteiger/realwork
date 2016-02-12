{$IfNDef CommonForTextAndFlashOperations_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\CommonForTextAndFlashOperations.imp.pas"
// Стереотип: "VCMForm"

{$Define CommonForTextAndFlashOperations_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _CommonForTextAndFlash_Parent_ = _CommonForTextAndFlashOperations_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\CommonForTextAndFlash.imp.pas}
 _CommonForTextAndFlashOperations_ = {abstract} class(_CommonForTextAndFlash_)
  public
   procedure MakeHyperlinkToDocument; override;
    {* Создать ссылку на документ }
 end;//_CommonForTextAndFlashOperations_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_CommonForTextAndFlash_Parent_ = _CommonForTextAndFlashOperations_Parent_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\CommonForTextAndFlash.imp.pas}
_CommonForTextAndFlashOperations_ = _CommonForTextAndFlash_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else CommonForTextAndFlashOperations_imp}

{$IfNDef CommonForTextAndFlashOperations_imp_impl}

{$Define CommonForTextAndFlashOperations_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\CommonForTextAndFlash.imp.pas}

procedure _CommonForTextAndFlashOperations_.MakeHyperlinkToDocument;
 {* Создать ссылку на документ }
//#UC START# *4CDE7C2C0258_4CDE81A402A9_var*
//#UC END# *4CDE7C2C0258_4CDE81A402A9_var*
begin
//#UC START# *4CDE7C2C0258_4CDE81A402A9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CDE7C2C0258_4CDE81A402A9_impl*
end;//_CommonForTextAndFlashOperations_.MakeHyperlinkToDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf CommonForTextAndFlashOperations_imp_impl}

{$EndIf CommonForTextAndFlashOperations_imp}

