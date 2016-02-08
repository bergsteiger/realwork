unit NOT_FINISHED_k2TagTool;
 {* Инструмент для работы с тегом. }

// Модуль: "w:\common\components\rtl\Garant\K2\NOT_FINISHED_k2TagTool.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2TagPointer
;

type
 Tk2TagTool = class(Tk2TagPointer)
  {* Инструмент для работы с тегом. }
 end;//Tk2TagTool

implementation

uses
 l3ImplUses
 , k2NullTagImpl
 , k2Tags
 , l3Variant
 , k2Base
 , k2InterfaceFactory
;

end.
