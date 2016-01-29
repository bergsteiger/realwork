unit nsListExceptions;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Business"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/nsListExceptions.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Core::Common::Business::Document::nsListExceptions
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  l3MessageID
  ;

type
 EListIsTooLong = class(Exception)
 end;//EListIsTooLong

var
  { ������������ ������ EListIsTooLong local }
 str_ListIsTooLong : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ListIsTooLong'; rValue : '������ �������� ������� ���������� ����������, �� �� ����� ���� ������������. ����������, �������� ������.');
  { '������ �������� ������� ���������� ����������, �� �� ����� ���� ������������. ����������, �������� ������.' }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3StringIDEx
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  
  ;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_ListIsTooLong
 str_ListIsTooLong.Init;
 str_ListIsTooLong.SetDlgType(mtWarning);
{$IfEnd} //not Admin AND not Monitorings

end.