unit NOT_FINISHED_dt_DictTypes;

// Модуль: "w:\common\components\rtl\Garant\DT\NOT_FINISHED_dt_DictTypes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "dt_DictTypes" MUID: (55E6B6330367)

{$Include w:\common\components\rtl\Garant\DT\DtDefine.inc}

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
