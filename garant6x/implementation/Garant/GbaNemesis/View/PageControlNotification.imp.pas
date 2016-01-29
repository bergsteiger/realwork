{$IfNDef PageControlNotification_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/PageControlNotification.imp.pas"
// �����: 27.01.2009 16:42
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Core::Base Operations::View::Base Forms::PageControlNotification
//
// ����� ��� ������� ���������� InscPageControlNotification
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define PageControlNotification_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _PageControlNotification_ = {mixin} class(_PageControlNotification_Parent_ {$If defined(Nemesis)}, InscPageControlNotification{$IfEnd} //Nemesis
 )
  {* ����� ��� ������� ���������� InscPageControlNotification }
 protected
 // realized methods
   {$If defined(Nemesis)}
   procedure TabActivate;
     {* C������ ��������� ������� }
   {$IfEnd} //Nemesis
 protected
 // protected methods
   procedure DoTabActivate; virtual; abstract;
     {* ������� �� ������������ ������� }
 end;//_PageControlNotification_
{$Else}

 _PageControlNotification_ = _PageControlNotification_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else PageControlNotification_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _PageControlNotification_

{$If defined(Nemesis)}
procedure _PageControlNotification_.TabActivate;
//#UC START# *496B781903E3_497F0F17036D_var*
//#UC END# *496B781903E3_497F0F17036D_var*
begin
//#UC START# *496B781903E3_497F0F17036D_impl*
 DoTabActivate;
//#UC END# *496B781903E3_497F0F17036D_impl*
end;//_PageControlNotification_.TabActivate
{$IfEnd} //Nemesis

{$IfEnd} //not Admin AND not Monitorings

{$EndIf PageControlNotification_imp}
