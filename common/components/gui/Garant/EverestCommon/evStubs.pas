unit evStubs;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestCommon"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/EverestCommon/NOT_FINISHED_evStubs.pas"
// �����: 03.06.2009 11:09
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EverestCommon::evFacade::evStubs
//
// ��������� ��� ������������ �������� ��������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include evDefine.inc}

interface

uses                  
  nevTools,
  evInternalInterfaces
  ;

function  evL2SubA(Action: Pointer): InevSubList_Iterate_Action;
  {* - ������ �������� ��� ��������� ���������. }

implementation

uses
  l3Base
  ;

function  evL2SubA(Action: Pointer): InevSubList_Iterate_Action;
  {* - ������ �������� ��� ��������� ���������. }
  register;
  {-}
asm
          jmp  l3LocalStub
end;{asm}

end.