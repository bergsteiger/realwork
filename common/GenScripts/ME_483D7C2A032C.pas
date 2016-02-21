unit NOT_FINISHED_evdCustomNativeWriter;
 {* Писатель тегов в формате evd. }

// Модуль: "w:\common\components\rtl\Garant\EVD\NOT_FINISHED_evdCustomNativeWriter.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , k2CustomFileGenerator
;

type
 TevdCustomNativeWriter = class(Tk2CustomFileGenerator)
  {* Писатель тегов в формате evd. }
 end;//TevdCustomNativeWriter

implementation

uses
 l3ImplUses
 , evdCustomNativeWriterServices
;

end.
