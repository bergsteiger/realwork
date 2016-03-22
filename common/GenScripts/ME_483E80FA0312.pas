unit NOT_FINISHED_evdNativeReader;
 {* Читатель тегов в формате evd. }

// Модуль: "w:\common\components\rtl\Garant\EVD\NOT_FINISHED_evdNativeReader.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevdNativeReader" MUID: (483E80FA0312)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , k2CustomFileParser
;

type
 TevdNativeReader = class(Tk2CustomFileParser)
  {* Читатель тегов в формате evd. }
 end;//TevdNativeReader

implementation

uses
 l3ImplUses
 , evdNativeReaderServices
;

end.
