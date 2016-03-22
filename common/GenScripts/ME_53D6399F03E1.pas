unit k2InterfaceMapper;

// Модуль: "w:\common\components\rtl\Garant\K2\k2InterfaceMapper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2InterfaceMapper" MUID: (53D6399F03E1)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3Variant
 , l3IID
;

type
 Tk2InterfaceMapper = {abstract} class
  public
   class function Make(aTag: Tl3Variant;
    const IID: Tl3GUID;
    out Tool;
    const aProcessor: Ik2Processor): Boolean; virtual; abstract;
 end;//Tk2InterfaceMapper

implementation

uses
 l3ImplUses
;

end.
