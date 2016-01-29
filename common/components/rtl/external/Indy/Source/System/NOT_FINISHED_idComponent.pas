unit NOT_FINISHED_idComponent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Indy"
// Модуль: "w:/common/components/rtl/external/Indy/Source/System/NOT_FINISHED_idComponent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Indy::System::idComponent
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

interface

type
 TIdStatus = (
   hsResolving
 , hsConnecting
 , hsConnected
 , hsDisconnecting
 , hsDisconnected
 , hsStatusText
 , ftpTransfer
 , ftpReady
 , ftpAborted
 );//TIdStatus

 TIdStatusEvent = procedure (ASender: TObject;
  const AStatus: TIdStatus;
  const AStatusText: AnsiString) of object;

implementation

end.