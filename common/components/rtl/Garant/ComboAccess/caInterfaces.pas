unit caInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ComboAccess"
// ������: "w:/common/components/rtl/Garant/ComboAccess/caInterfaces.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi For Archi::ComboAccess::caInterfaces
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\ComboAccess\caDefine.inc}

interface

{$If defined(TestComboAccess) AND defined(UsePostgres)}
uses
  daInterfaces,
  htInterfaces,
  pgInterfaces
  ;

type
 IcaDataConverter = interface(IdaDataConverter)
   ['{FADCE1E5-6997-478B-A413-7A8B0074DD9C}']
   function Get_HTConverter: IhtDataConverter;
   function Get_PGConverter: IpgDataConverter;
   property HTConverter: IhtDataConverter
     read Get_HTConverter;
   property PGConverter: IpgDataConverter
     read Get_PGConverter;
 end;//IcaDataConverter
{$IfEnd} //TestComboAccess AND UsePostgres

implementation

end.