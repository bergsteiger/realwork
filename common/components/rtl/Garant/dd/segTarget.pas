unit segTarget;

// Модуль: "w:\common\components\rtl\Garant\dd\segTarget.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TsegTarget" MUID: (55DC6C1902EB)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 TsegTarget = class(Tl3ProtoObject)
  private
   f_DocID: Integer;
   f_SubID: Integer;
  public
   constructor Create(aDocID: Integer;
    aSubID: Integer); reintroduce;
  public
   property DocID: Integer
    read f_DocID;
   property SubID: Integer
    read f_SubID;
 end;//TsegTarget

implementation

uses
 l3ImplUses
 //#UC START# *55DC6C1902EBimpl_uses*
 //#UC END# *55DC6C1902EBimpl_uses*
;

constructor TsegTarget.Create(aDocID: Integer;
 aSubID: Integer);
//#UC START# *55DC94FC0021_55DC6C1902EB_var*
//#UC END# *55DC94FC0021_55DC6C1902EB_var*
begin
//#UC START# *55DC94FC0021_55DC6C1902EB_impl*
 inherited Create;
 f_DocID := aDocID;
 f_SubID := aSubID;
//#UC END# *55DC94FC0021_55DC6C1902EB_impl*
end;//TsegTarget.Create

end.
