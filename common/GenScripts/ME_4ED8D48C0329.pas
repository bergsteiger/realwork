{$IfNDef EditionsListCaller_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\EditionsListCaller.imp.pas"
// Стереотип: "VCMForm"

{$Define EditionsListCaller_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _EditionsListCaller_ = {abstract} class(_EditionsListCaller_Parent_)
  {* Форма вызывающая список редакций }
  private
   EditionsHolder: IsdsEditionsHolder;
  public
   procedure RedactionOnID; override;
   procedure ActualRedaction; override;
   procedure OpenRedactionListFrmAct; override;
    {* Список редакций }
   procedure PrevRedaction; override;
   procedure NextRedaction; override;
   procedure OpenRedactionListFrmAct; override;
    {* Список редакций }
 end;//_EditionsListCaller_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_EditionsListCaller_ = _EditionsListCaller_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else EditionsListCaller_imp}

{$IfNDef EditionsListCaller_imp_impl}

{$Define EditionsListCaller_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
procedure _EditionsListCaller_.RedactionOnID;
//#UC START# *4A8EF4B50044_4ED8D48C0329_var*
//#UC END# *4A8EF4B50044_4ED8D48C0329_var*
begin
//#UC START# *4A8EF4B50044_4ED8D48C0329_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8EF4B50044_4ED8D48C0329_impl*
end;//_EditionsListCaller_.RedactionOnID

procedure _EditionsListCaller_.ActualRedaction;
//#UC START# *4AFAF4900270_4ED8D48C0329_var*
//#UC END# *4AFAF4900270_4ED8D48C0329_var*
begin
//#UC START# *4AFAF4900270_4ED8D48C0329_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AFAF4900270_4ED8D48C0329_impl*
end;//_EditionsListCaller_.ActualRedaction

procedure _EditionsListCaller_.OpenRedactionListFrmAct;
 {* Список редакций }
//#UC START# *4B262F9701DE_4ED8D48C0329_var*
//#UC END# *4B262F9701DE_4ED8D48C0329_var*
begin
//#UC START# *4B262F9701DE_4ED8D48C0329_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B262F9701DE_4ED8D48C0329_impl*
end;//_EditionsListCaller_.OpenRedactionListFrmAct

procedure _EditionsListCaller_.PrevRedaction;
//#UC START# *4C3AE0950253_4ED8D48C0329_var*
//#UC END# *4C3AE0950253_4ED8D48C0329_var*
begin
//#UC START# *4C3AE0950253_4ED8D48C0329_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AE0950253_4ED8D48C0329_impl*
end;//_EditionsListCaller_.PrevRedaction

procedure _EditionsListCaller_.NextRedaction;
//#UC START# *4C3AE0CD0079_4ED8D48C0329_var*
//#UC END# *4C3AE0CD0079_4ED8D48C0329_var*
begin
//#UC START# *4C3AE0CD0079_4ED8D48C0329_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AE0CD0079_4ED8D48C0329_impl*
end;//_EditionsListCaller_.NextRedaction

procedure _EditionsListCaller_.OpenRedactionListFrmAct;
 {* Список редакций }
//#UC START# *4ED8CF5700E7_4ED8D48C0329_var*
//#UC END# *4ED8CF5700E7_4ED8D48C0329_var*
begin
//#UC START# *4ED8CF5700E7_4ED8D48C0329_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ED8CF5700E7_4ED8D48C0329_impl*
end;//_EditionsListCaller_.OpenRedactionListFrmAct
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf EditionsListCaller_imp_impl}

{$EndIf EditionsListCaller_imp}

