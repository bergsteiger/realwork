unit stevStylesPrintAndExportFontSizeItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "dd$AppConfig"
// ������: "w:/common/components/rtl/Garant/dd/stevStylesPrintAndExportFontSizeItem.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd$AppConfig::AppConfig::TstevStylesPrintAndExportFontSizeItem
//
// ������������ ��� ��������� "������������ ��� �������� � ������ ��������� ������ ������"
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  ddAppConfigTypes
  ;

type
 TstevStylesPrintAndExportFontSizeItem = class(TddComboBoxConfigItem)
  {* ������������ ��� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
 public
 // public methods
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
     {* undefined }
 end;//TstevStylesPrintAndExportFontSizeItem

implementation

uses
  evStylesPrintAndExportFontSizeSettingRes,
  l3Base,
  ddAppConfigConst
  ;

// start class TstevStylesPrintAndExportFontSizeItem

constructor TstevStylesPrintAndExportFontSizeItem.Create(aMasterItem: TddBaseConfigItem = nil);
var
 l_Value : TddConfigValue;
begin
 l3FillChar(l_Value, SizeOf(l_Value));
 l_Value.Kind := dd_vkInteger;
 l_Value.AsInteger := dv_evStyles_PrintAndExportFontSize;
 inherited Create(pi_evStyles_PrintAndExportFontSize,
  str_PrintAndExportFontSize.AsStr,
  l_Value, TPrintAndExportFontSizeValuesMapImpl.Make, aMasterItem);
end;//TstevStylesPrintAndExportFontSizeItem.Create

end.