unit stListPrintAndExportFontSizeItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "stListPrintAndExportFontSizeItem.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Sand Box$UC::List::View::List::TstListPrintAndExportFontSizeItem
//
// ������������ ��� ��������� "������������ ��� �������� � ������ ��������� ������ ������"
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
  ddAppConfigTypes
  ;

type
 TstListPrintAndExportFontSizeItem = class(TddComboBoxConfigItem)
  {* ������������ ��� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
 public
 // public methods
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
     {* undefined }
 end;//TstListPrintAndExportFontSizeItem

implementation

uses
  ListPrintAndExportFontSizeSettingRes,
  l3Base,
  ddAppConfigConst
  ;

// start class TstListPrintAndExportFontSizeItem

constructor TstListPrintAndExportFontSizeItem.Create(aMasterItem: TddBaseConfigItem = nil);
var
 l_Value : TddConfigValue;
begin
 l3FillChar(l_Value, SizeOf(l_Value));
 l_Value.Kind := dd_vkInteger;
 l_Value.AsInteger := dv_List_PrintAndExportFontSize;
 inherited Create(pi_List_PrintAndExportFontSize,
  str_PrintAndExportFontSize.AsStr,
  l_Value, TPrintAndExportFontSizeValuesMapImpl.Make, aMasterItem);
end;//TstListPrintAndExportFontSizeItem.Create

end.