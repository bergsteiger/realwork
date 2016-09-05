unit evPara_Wrap;

// Модуль: "w:\common\components\rtl\Garant\EVD\evPara_Wrap.pas"
// Стереотип: "Wrapper"
// Элемент модели: "WevPara" MUID: (484FD34600BA)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , k2Tag_Wrap
 , l3Variant
;

type
 RevdParaModifier = class of TevdParaModifier;

 TevdParaModifier = class
  public
   class function MarkModified(aTag: Tl3Variant): Boolean; virtual;
 end;//TevdParaModifier

 WevPara = class(Wk2Tag)
  public
   function MarkModified(aTag: Tl3Variant): Boolean; override;
 end;//WevPara

var g_ParaModifier: RevdParaModifier = nil;

implementation

uses
 l3ImplUses
 , Para_Const
 //#UC START# *484FD34600BAimpl_uses*
 //#UC END# *484FD34600BAimpl_uses*
;

class function TevdParaModifier.MarkModified(aTag: Tl3Variant): Boolean;
//#UC START# *4CEE6187015A_4CEE60C90052_var*
//#UC END# *4CEE6187015A_4CEE60C90052_var*
begin
//#UC START# *4CEE6187015A_4CEE60C90052_impl*
 Result := false;
//#UC END# *4CEE6187015A_4CEE60C90052_impl*
end;//TevdParaModifier.MarkModified

function WevPara.MarkModified(aTag: Tl3Variant): Boolean;
//#UC START# *4CEE5D3002FC_484FD34600BA_var*
//#UC END# *4CEE5D3002FC_484FD34600BA_var*
begin
//#UC START# *4CEE5D3002FC_484FD34600BA_impl*
 if (g_ParaModifier = nil) then
  Result := TevdParaModifier.MarkModified(aTag)
 else
  Result := g_ParaModifier.MarkModified(aTag);
//#UC END# *4CEE5D3002FC_484FD34600BA_impl*
end;//WevPara.MarkModified

end.
