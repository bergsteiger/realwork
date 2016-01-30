{$IfNDef SynchroViewUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\SynchroViewUserTypes.imp.pas"
// Стереотип: "VCMForm"

{$Define SynchroViewUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _SynchroViewUserTypes_ = {abstract} class(_SynchroViewUserTypes_Parent_)
  protected
   procedure svSynchroViewQueryClose(aSender: TObject); virtual; abstract;
    {* Обработчик события svSynchroView.OnQueryClose }
 end;//_SynchroViewUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_SynchroViewUserTypes_ = _SynchroViewUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else SynchroViewUserTypes_imp}

{$IfNDef SynchroViewUserTypes_imp_impl}

{$Define SynchroViewUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* Локализуемые строки svSynchroViewLocalConstants }
 str_svSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'svSynchroViewCaption'; rValue : 'Синхронный просмотр');
  {* Заголовок пользовательского типа "Синхронный просмотр" }

{$Else SynchroViewUserTypes_imp_impl}

 str_svSynchroViewCaption.Init;
 {* Инициализация str_svSynchroViewCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf SynchroViewUserTypes_imp_impl}

{$EndIf SynchroViewUserTypes_imp}

