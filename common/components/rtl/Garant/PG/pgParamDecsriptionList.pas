unit pgParamDecsriptionList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "PG"
// ������: "w:/common/components/rtl/Garant/PG/pgParamDecsriptionList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::PG::Provider::TpgParamDecsriptionList
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
  l3ProtoDataContainer,
  daInterfaces,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}
type
 _ItemType_ = IdaParamDescription;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TpgParamDecsriptionList = class(_l3InterfacePtrList_)
 end;//TpgParamDecsriptionList
{$IfEnd} //UsePostgres

implementation

{$If defined(UsePostgres)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}

type _Instance_R_ = TpgParamDecsriptionList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}


{$IfEnd} //UsePostgres
end.