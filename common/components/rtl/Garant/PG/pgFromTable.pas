unit pgFromTable;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "PG"
// ������: "w:/common/components/rtl/Garant/PG/pgFromTable.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::PG::Provider::TpgFromTable
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\PG\pgDefine.inc}

interface

{$If defined(UsePostgres)}
uses
  daFromTable
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}
type
 TpgFromTable = class(TdaFromTable)
 end;//TpgFromTable
{$IfEnd} //UsePostgres

implementation

end.