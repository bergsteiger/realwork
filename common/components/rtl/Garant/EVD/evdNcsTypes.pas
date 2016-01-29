unit evdNcsTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/evdNcsTypes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EVD::Standard::evdNcsTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

type
 TncsMessageKind = (
   ncs_mkMessage // ��������� �� ������� ��������� �����
 , ncs_mkReply // ����� �� ���������
 , ncs_mkSignal // ��������� �� ������� �� ��������� �����
 );//TncsMessageKind

 TncsResultKind = (
   ncs_rkOk
 , ncs_rkFail
 , ncs_rkRetry
 , ncs_rkEmpty
 );//TncsResultKind

implementation

end.