unit evEvdDataObject;

// Модуль: "w:\common\components\gui\Garant\Everest\evEvdDataObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevEvdDataObject" MUID: (48EA3A2A0142)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evReaderDataObject
;

type
 TevEvdDataObject = class(TevReaderDataObject)
  protected
   function ReaderClass: Rk2CustomReader; override;
 end;//TevEvdDataObject

implementation

uses
 l3ImplUses
 , evdNativeReader
;

function TevEvdDataObject.ReaderClass: Rk2CustomReader;
//#UC START# *48EB6A0700D9_48EA3A2A0142_var*
//#UC END# *48EB6A0700D9_48EA3A2A0142_var*
begin
//#UC START# *48EB6A0700D9_48EA3A2A0142_impl*
 Result := TevdNativeReader;
//#UC END# *48EB6A0700D9_48EA3A2A0142_impl*
end;//TevEvdDataObject.ReaderClass

end.
