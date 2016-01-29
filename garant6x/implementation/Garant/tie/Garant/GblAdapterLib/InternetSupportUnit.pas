unit InternetSupportUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/InternetSupportUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::InternetSupport
//
// �����������, ��������� ����� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit
  ;

type
 IInternetSupport = interface(IUnknown)
  {* ��������� ������ ������������� ����� internet }
   ['{7DF56131-CBD6-47F5-B8B1-495409AFE6E4}']
   function RevisionCheckEnabled: ByteBool; stdcall;
     {* ��������� �� ������ �������� ������� ���������� (��� �������������� ������) }
   procedure GetUrlForDocument(aDocId: Cardinal;
    aParaId: Cardinal; out aRet {: IString}); stdcall;
     {* �������� URL ��� ��������� ��������� }
   function IsInternetAgentEnabled: ByteBool; stdcall;
     {* �������� �� ��������-�����. }
   procedure GetUrlForInternetVersion(out aRet {: IString}); stdcall;
     {* �������� URL ��� �������� ������ }
   function ShowWarning: ByteBool; stdcall;
     {* ����� �� ���������� ������ �� ���������� ������ �������� }
 end;//IInternetSupport

 IDecisionsArchiveSupport = interface(IUnknown)
  {* ��������� ������� � ������� �������� ������� }
   ['{CD81011E-549D-406A-964C-9FE291552EB4}']
   procedure GetArchiveUrl(out aRet {: IString}); stdcall;
     {* �������� ������ ��� �������� �� ����� �������� ������� }
   function ArchiveAvailable: ByteBool; stdcall;
     {* ����� �������� ������� �������� }
 end;//IDecisionsArchiveSupport

implementation

end.