unit nevNullPara;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevNullPara.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevNullPara" MUID: (48E0BD200269)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevParaPrim
 , nevTools
;

type
 TnevNullPara = class(TnevParaPrim)
  public
   class function Make: InevPara; reintroduce;
   constructor Create; reintroduce;
 end;//TnevNullPara
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 //#UC START# *48E0BD200269impl_uses*
 //#UC END# *48E0BD200269impl_uses*
;

class function TnevNullPara.Make: InevPara;
var
 l_Inst : TnevNullPara;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevNullPara.Make

constructor TnevNullPara.Create;
//#UC START# *48E0BD4D0277_48E0BD200269_var*
//#UC END# *48E0BD4D0277_48E0BD200269_var*
begin
//#UC START# *48E0BD4D0277_48E0BD200269_impl*
 inherited Create(nil);
//#UC END# *48E0BD4D0277_48E0BD200269_impl*
end;//TnevNullPara.Create
{$IfEnd} // Defined(k2ForEditor)

end.
