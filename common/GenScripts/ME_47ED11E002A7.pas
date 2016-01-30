unit DocumentFactoryKeyHelper;
 {* Получение ключа мультифабрики по серверному документу или PID }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DocumentFactoryKeyHelper.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , DocumentUnit
;

function server_document_to_key(document): TFactoryKey;
 {* По серверному документу }
function PID_to_key(pid): TFactoryKey;
 {* По PID'у }

implementation

uses
 l3ImplUses
 , ApplicationHelper
;

function server_document_to_key(document): TFactoryKey;
 {* По серверному документу }
//#UC START# *47ED12200202_47ED11E002A7_var*
//#UC END# *47ED12200202_47ED11E002A7_var*
begin
//#UC START# *47ED12200202_47ED11E002A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *47ED12200202_47ED11E002A7_impl*
end;//server_document_to_key

function PID_to_key(pid): TFactoryKey;
 {* По PID'у }
//#UC START# *47ED1269019D_47ED11E002A7_var*
//#UC END# *47ED1269019D_47ED11E002A7_var*
begin
//#UC START# *47ED1269019D_47ED11E002A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *47ED1269019D_47ED11E002A7_impl*
end;//PID_to_key

end.
