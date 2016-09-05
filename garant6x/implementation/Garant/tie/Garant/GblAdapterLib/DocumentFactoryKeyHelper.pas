unit DocumentFactoryKeyHelper;
 {* Получение ключа мультифабрики по серверному документу или PID }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DocumentFactoryKeyHelper.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "DocumentFactoryKeyHelper" MUID: (47ED11E002A7)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , DocumentUnit
;

function ServerDocumentToKey(const document): TFactoryKey; stdcall;
 {* По серверному документу }
function PIDToKey(const pid): TFactoryKey; stdcall;
 {* По PID'у }

implementation

uses
 l3ImplUses
 , ApplicationHelper
 //#UC START# *47ED11E002A7impl_uses*
 //#UC END# *47ED11E002A7impl_uses*
;

function ServerDocumentToKey(const document): TFactoryKey;
 {* По серверному документу }
//#UC START# *47ED12200202_47ED11E002A7_var*
//#UC END# *47ED12200202_47ED11E002A7_var*
begin
//#UC START# *47ED12200202_47ED11E002A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *47ED12200202_47ED11E002A7_impl*
end;//ServerDocumentToKey

function PIDToKey(const pid): TFactoryKey;
 {* По PID'у }
//#UC START# *47ED1269019D_47ED11E002A7_var*
//#UC END# *47ED1269019D_47ED11E002A7_var*
begin
//#UC START# *47ED1269019D_47ED11E002A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *47ED1269019D_47ED11E002A7_impl*
end;//PIDToKey

end.
