unit NOT_FINISHED_dt_DictTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DT"
// ������: "w:/common/components/rtl/Garant/DT/NOT_FINISHED_dt_DictTypes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::DT::Dictionary::dt_DictTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\DT\DtDefine.inc}

interface

{$If not defined(Nemesis)}
type
 TDictMessageRec = record
 end;//TDictMessageRec

 IDictChangeNotifyRecipient = interface(IUnknown)
   ['{29F5993F-AEC6-4EAF-B8E6-393D6C6DFD09}']
   procedure Dcn_DictionaryChange(const Info: TDictMessageRec);
 end;//IDictChangeNotifyRecipient
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
{$IfEnd} //not Nemesis
end.