unit NOT_FINISHED_dt_DictTypes;

// ������: "w:\common\components\rtl\Garant\DT\NOT_FINISHED_dt_DictTypes.pas"
// ���������: "UtilityPack"

{$Include DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
;

type
 TDictMessageRec = record
 end;//TDictMessageRec

 IDictChangeNotifyRecipient = interface
  ['{29F5993F-AEC6-4EAF-B8E6-393D6C6DFD09}']
  procedure dcn_DictionaryChange(const Info: TDictMessageRec);
 end;//IDictChangeNotifyRecipient
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
