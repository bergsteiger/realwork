unit NOT_FINISHED_dt_DictTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DT"
// Модуль: "w:/common/components/rtl/Garant/DT/NOT_FINISHED_dt_DictTypes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::DT::Dictionary::dt_DictTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

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