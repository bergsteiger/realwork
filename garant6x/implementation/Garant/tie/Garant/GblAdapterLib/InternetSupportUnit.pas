unit InternetSupportUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/InternetSupportUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::InternetSupport
//
// Возможности, доступные через интернет
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit
  ;

type
 IInternetSupport = interface(IUnknown)
  {* поддержка работы пользователей через internet }
   ['{7DF56131-CBD6-47F5-B8B1-495409AFE6E4}']
   function RevisionCheckEnabled: ByteBool; stdcall;
     {* Разрешена ли онлайн проверка ревизий документов (для супермобильной версии) }
   procedure GetUrlForDocument(aDocId: Cardinal;
    aParaId: Cardinal; out aRet {: IString}); stdcall;
     {* получить URL для заданного документа }
   function IsInternetAgentEnabled: ByteBool; stdcall;
     {* Разрешен ли Интернет-Агент. }
   procedure GetUrlForInternetVersion(out aRet {: IString}); stdcall;
     {* получить URL для интранет версии }
   function ShowWarning: ByteBool; stdcall;
     {* Нужно ли показывать блямбу об отключении онлайн проверки }
 end;//IInternetSupport

 IDecisionsArchiveSupport = interface(IUnknown)
  {* Интерфейс доступа к архивам судебных решений }
   ['{CD81011E-549D-406A-964C-9FE291552EB4}']
   procedure GetArchiveUrl(out aRet {: IString}); stdcall;
     {* получить ссылку для перехода на архив судебных решений }
   function ArchiveAvailable: ByteBool; stdcall;
     {* архив судебных решений доступен }
 end;//IDecisionsArchiveSupport

implementation

end.