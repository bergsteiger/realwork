unit evStyleTreeSearcher;
 {* Ищет любой стиль, наследующийся от заданного }

// Модуль: "w:\common\components\gui\Garant\Everest\evStyleTreeSearcher.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevStyleTreeSearcher" MUID: (4ADC82E80050)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evSearch
 , l3Variant
;

type
 TevStyleTreeSearcher = class(TevStyleSearcher)
  {* Ищет любой стиль, наследующийся от заданного }
  protected
   function IsStyleFound(aStyle: Tl3Tag): Boolean; override;
 end;//TevStyleTreeSearcher

implementation

uses
 l3ImplUses
 , k2Tags
 //#UC START# *4ADC82E80050impl_uses*
 //#UC END# *4ADC82E80050impl_uses*
;

function TevStyleTreeSearcher.IsStyleFound(aStyle: Tl3Tag): Boolean;
//#UC START# *4ADC80DC013E_4ADC82E80050_var*
var
 l_Style  : Tl3Tag;
 l_Parent : Tl3Tag;
//#UC END# *4ADC80DC013E_4ADC82E80050_var*
begin
//#UC START# *4ADC80DC013E_4ADC82E80050_impl*
 Result := false;
 l_Style := aStyle;
 while (l_Style <> nil) AND l_Style.IsValid do
 begin
  if l_Style.IsSame(Style.Tag) then
  begin
   Result := true;
   Exit;
  end;//l_Style.IsSame(Style.Tag)
  l_Parent := l_Style.Attr[k2_tiStyle];
  if l_Parent.IsSame(l_Style) then
   break;
  l_Style := l_Parent;
 end;//while (l_Style <> nil) AND l_Style.IsValid
//#UC END# *4ADC80DC013E_4ADC82E80050_impl*
end;//TevStyleTreeSearcher.IsStyleFound

end.
