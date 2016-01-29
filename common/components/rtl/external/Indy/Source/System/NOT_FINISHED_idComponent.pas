unit NOT_FINISHED_idComponent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Indy"
// ������: "w:/common/components/rtl/external/Indy/Source/System/NOT_FINISHED_idComponent.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Indy::System::idComponent
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

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