unit NOT_FINISHED_csServerTaskTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/NOT_FINISHED_csServerTaskTypes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::Tasks::csServerTaskTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  csDictEditQueryPrim,
  csUserEditQueryPrim,
  csRemoteDictEditQueryPrim,
  csDeleteDocsQueryPrim,
  ddRunCommandTaskPrim
  ;

type
 TDictEditQuery = class(TcsDictEditQueryPrim)
 end;//TDictEditQuery

 TGetDictEditQuery = class(TDictEditQuery)
 end;//TGetDictEditQuery

 TDeleteDocsQuery = class(TcsDeleteDocsQueryPrim)
 end;//TDeleteDocsQuery

 TRemoteDictEditQuery = class(TcsRemoteDictEditQueryPrim)
 end;//TRemoteDictEditQuery

 TUserEditQuery = class(TcsUserEditQueryPrim)
 end;//TUserEditQuery

 TddRunCommandTask = class(TddRunCommandTaskPrim)
 end;//TddRunCommandTask
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
{$IfEnd} //not Nemesis
end.