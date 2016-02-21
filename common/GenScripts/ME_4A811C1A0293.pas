unit BaseWorkJournal_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\BaseWorkJournal_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , WorkJournalInterfaces
;

type
 TBaseWorkJournalModule = class
  protected
   procedure OpenJournal;
  public
   function MakeWorkJournal: IbsWorkJournal;
 end;//TBaseWorkJournalModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , PrimWorkJournal_utWorkJournal_UserType
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , bsWorkJournal
;

function TBaseWorkJournalModule.MakeWorkJournal: IbsWorkJournal;
//#UC START# *4A827E40004E_4A811C1A0293_var*
//#UC END# *4A827E40004E_4A811C1A0293_var*
begin
//#UC START# *4A827E40004E_4A811C1A0293_impl*
 Result := TbsWorkJournal.Make;
//#UC END# *4A827E40004E_4A811C1A0293_impl*
end;//TBaseWorkJournalModule.MakeWorkJournal

procedure TBaseWorkJournalModule.OpenJournal;
//#UC START# *4A97C7C0019C_4A811C1A0293_var*
//#UC END# *4A97C7C0019C_4A811C1A0293_var*
begin
//#UC START# *4A97C7C0019C_4A811C1A0293_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97C7C0019C_4A811C1A0293_impl*
end;//TBaseWorkJournalModule.OpenJournal
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
