{$IfNDef ListAnalizeUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListAnalizeUserTypes.imp.pas"
// Стереотип: "VCMForm"

{$Define ListAnalizeUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _ListAnalizeUserTypes_ = {abstract} class(_ListAnalizeUserTypes_Parent_)
 end;//_ListAnalizeUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_ListAnalizeUserTypes_ = _ListAnalizeUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else ListAnalizeUserTypes_imp}

{$IfNDef ListAnalizeUserTypes_imp_impl}

{$Define ListAnalizeUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* Локализуемые строки AnalizeLocalConstants }
 str_AnalizeCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AnalizeCaption'; rValue : 'Анализ списка');
  {* Заголовок пользовательского типа "Анализ списка" }

{$Else ListAnalizeUserTypes_imp_impl}

 str_AnalizeCaption.Init;
 {* Инициализация str_AnalizeCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf ListAnalizeUserTypes_imp_impl}

{$EndIf ListAnalizeUserTypes_imp}

