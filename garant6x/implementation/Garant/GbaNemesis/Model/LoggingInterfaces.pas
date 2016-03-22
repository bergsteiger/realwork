unit LoggingInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Model"
// �����: ������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Model/LoggingInterfaces.pas"
// �����: 2007/07/17 13:26:42
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 ������� ����������� ���������� �������::LegalDomain::Model::LoggingInterfaces
//
// ����������� ������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTypesUnit,
  LoggingUnit,
  l3Interfaces
  ;

type
 InsDefferedEvent = interface(IUnknown)
   ['{DC0ACD6B-F180-4720-8CC0-500683B03458}']
   procedure FireLog;
 end;//InsDefferedEvent

 InsEventHolder = interface(IUnknown)
   ['{E97E1666-E2E3-4661-B773-40EC6B8F6940}']
   procedure SetEvent(const anEvent: InsDefferedEvent);
 end;//InsEventHolder

 InsCachedEventsProcessor = interface(IUnknown)
   ['{A5A50743-4275-4C7F-AD87-945799C7EF03}']
   procedure RegisterEvent(const aEvent: InsDefferedEvent);
   procedure RequestWriteCache;
   procedure ForceWriteCache;
 end;//InsCachedEventsProcessor

implementation

end.