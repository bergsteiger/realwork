{$IfNDef PageControlNotification_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PageControlNotification.imp.pas"
// ���������: "Impurity"
// ������� ������: "PageControlNotification" MUID: (497F0F17036D)
// ��� ����: "_PageControlNotification_"

{$Define PageControlNotification_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _PageControlNotification_ = class(_PageControlNotification_Parent_{$If Defined(Nemesis)}
 , InscPageControlNotification
 {$IfEnd} // Defined(Nemesis)
 )
  {* ����� ��� ������� ���������� InscPageControlNotification }
  protected
   procedure DoTabActivate; virtual; abstract;
    {* ������� �� ������������ ������� }
   {$If Defined(Nemesis)}
   procedure TabActivate;
    {* C������ ��������� ������� }
   {$IfEnd} // Defined(Nemesis)
 end;//_PageControlNotification_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_PageControlNotification_ = _PageControlNotification_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else PageControlNotification_imp}

{$IfNDef PageControlNotification_imp_impl}

{$Define PageControlNotification_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$If Defined(Nemesis)}
procedure _PageControlNotification_.TabActivate;
 {* C������ ��������� ������� }
//#UC START# *496B781903E3_497F0F17036D_var*
//#UC END# *496B781903E3_497F0F17036D_var*
begin
//#UC START# *496B781903E3_497F0F17036D_impl*
 DoTabActivate;
//#UC END# *496B781903E3_497F0F17036D_impl*
end;//_PageControlNotification_.TabActivate
{$IfEnd} // Defined(Nemesis)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf PageControlNotification_imp_impl}

{$EndIf PageControlNotification_imp}

