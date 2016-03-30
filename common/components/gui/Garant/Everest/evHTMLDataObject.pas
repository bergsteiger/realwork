unit evHTMLDataObject;

// Модуль: "w:\common\components\gui\Garant\Everest\evHTMLDataObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevHTMLDataObject" MUID: (4802FF6101DE)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evReaderDataObject
;

type
 TevHTMLDataObject = class(TevReaderDataObject)
  protected
   function ReaderClass: Rk2CustomReader; override;
 end;//TevHTMLDataObject

implementation

uses
 l3ImplUses
 , ddHTMLReader
;

function TevHTMLDataObject.ReaderClass: Rk2CustomReader;
//#UC START# *48EB6A0700D9_4802FF6101DE_var*
//#UC END# *48EB6A0700D9_4802FF6101DE_var*
begin
//#UC START# *48EB6A0700D9_4802FF6101DE_impl*
 Result := TddHTMLReader;
//#UC END# *48EB6A0700D9_4802FF6101DE_impl*
end;//TevHTMLDataObject.ReaderClass

end.
