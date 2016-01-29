unit DocumentFactoryKeyHelper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/DocumentFactoryKeyHelper.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::DocumentHelper::DocumentFactoryKeyHelper
//
// Получение ключа мультифабрики по серверному документу или PID
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  DocumentUnit
  ;

function ServerDocumentToKey(document): TFactoryKey;
   {* По серверному документу }
function PIDToKey(pid): TFactoryKey;
   {* По PID'у }

implementation

uses
  ApplicationHelper
  ;

// unit methods

function ServerDocumentToKey(document): TFactoryKey;
//#UC START# *47ED12200202_47ED11E002A7_var*
//#UC END# *47ED12200202_47ED11E002A7_var*
begin
//#UC START# *47ED12200202_47ED11E002A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *47ED12200202_47ED11E002A7_impl*
end;//ServerDocumentToKey

function PIDToKey(pid): TFactoryKey;
//#UC START# *47ED1269019D_47ED11E002A7_var*
//#UC END# *47ED1269019D_47ED11E002A7_var*
begin
//#UC START# *47ED1269019D_47ED11E002A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *47ED1269019D_47ED11E002A7_impl*
end;//PIDToKey

end.