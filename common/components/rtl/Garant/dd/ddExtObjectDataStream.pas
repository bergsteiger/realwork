unit ddExtObjectDataStream;

// Модуль: "w:\common\components\rtl\Garant\dd\ddExtObjectDataStream.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddExtObjectDataStream" MUID: (5798D19702A1)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , k2MemoryStream
;

type
 TddExtObjectDataStream = class(Tk2MemoryStream)
  protected
   function GetIsModified: Boolean; override;
 end;//TddExtObjectDataStream

implementation

uses
 l3ImplUses
;

function TddExtObjectDataStream.GetIsModified: Boolean;
//#UC START# *5798CBD10051_5798D19702A1_var*
//#UC END# *5798CBD10051_5798D19702A1_var*
begin
//#UC START# *5798CBD10051_5798D19702A1_impl*
 Result := false;
//#UC END# *5798CBD10051_5798D19702A1_impl*
end;//TddExtObjectDataStream.GetIsModified

end.
