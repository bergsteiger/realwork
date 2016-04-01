unit nevStringItemPara;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevStringItemPara.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevStringItemPara" MUID: (48D1184C02B9)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevTextPara
 , nevTools
 , l3Variant
 , nevBase
;

type
 TnevStringItemPara = class(TnevTextPara)
  private
   f_StrID: Integer;
    {* Ссылка на номер строки в списке }
  protected
   function GetPID: TnevParaIndex; override;
  public
   constructor Create(aTag: Tl3Variant;
    anIndex: Integer); reintroduce;
   class function Make(aTag: Tl3Variant;
    anIndex: Integer): InevTextPara; reintroduce;
 end;//TnevStringItemPara
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
;

constructor TnevStringItemPara.Create(aTag: Tl3Variant;
 anIndex: Integer);
//#UC START# *48D118B5038A_48D1184C02B9_var*
//#UC END# *48D118B5038A_48D1184C02B9_var*
begin
//#UC START# *48D118B5038A_48D1184C02B9_impl*
 inherited Create(aTag);
 f_StrID := anIndex;
//#UC END# *48D118B5038A_48D1184C02B9_impl*
end;//TnevStringItemPara.Create

class function TnevStringItemPara.Make(aTag: Tl3Variant;
 anIndex: Integer): InevTextPara;
var
 l_Inst : TnevStringItemPara;
begin
 l_Inst := Create(aTag, anIndex);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevStringItemPara.Make

function TnevStringItemPara.GetPID: TnevParaIndex;
//#UC START# *48CFB61F01FA_48D1184C02B9_var*
//#UC END# *48CFB61F01FA_48D1184C02B9_var*
begin
//#UC START# *48CFB61F01FA_48D1184C02B9_impl*
 Result := f_StrID;
//#UC END# *48CFB61F01FA_48D1184C02B9_impl*
end;//TnevStringItemPara.GetPID
{$IfEnd} // Defined(k2ForEditor)

end.
