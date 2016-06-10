unit stDocumentShowChangesInfoItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/stDocumentShowChangesInfoItem.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::TstDocumentShowChangesInfoItem
//
// ������������ ��� ��������� "���������� ������� ��������� � ���������"
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
  ddAppConfigTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TstDocumentShowChangesInfoItem = class(TddComboBoxConfigItem)
  {* ������������ ��� ��������� "���������� ������� ��������� � ���������" }
 public
 // public methods
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
     {* undefined }
 end;//TstDocumentShowChangesInfoItem
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentShowChangesInfoSettingRes,
  l3Base,
  ddAppConfigConst
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TstDocumentShowChangesInfoItem

constructor TstDocumentShowChangesInfoItem.Create(aMasterItem: TddBaseConfigItem = nil);
var
 l_Value : TddConfigValue;
begin
 l3FillChar(l_Value, SizeOf(l_Value));
 l_Value.Kind := dd_vkBoolean;
 l_Value.AsBoolean := dv_Document_ShowChangesInfo;
 inherited Create(pi_Document_ShowChangesInfo,
  str_ShowChangesInfo.AsStr,
  l_Value, TShowChangesInfoValuesMapImpl.Make, aMasterItem);
end;//TstDocumentShowChangesInfoItem.Create

{$IfEnd} //not Admin AND not Monitorings

end.