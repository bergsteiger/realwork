unit l3StringMap;

// Модуль: "w:\common\components\gui\Garant\VCM\Implementation\l3StringMap.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3StringMap" MUID: (4B8BC059018C)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3StringMapPrim
 , l3KeyWrd
 , l3IDIndex
 , l3Interfaces
 , l3Types
;

 {$Define l3Items_NeedsBeforeFreeItem}

 {$Undef l3Items_NoSort}

type
 _l3Dictionary_Parent_ = Tl3StringMapPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Dictionary.imp.pas}
 Tl3StringMap = class(_l3Dictionary_)
  private
   f_Hi: Integer;
  public
   function ResolveString(const aString: AnsiString): Integer;
    {* Возвращает идентификатор строки }
 end;//Tl3StringMap
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , SysUtils
 , l3String
 , l3Variant
 , l3Memory
;

type _Instance_R_ = Tl3StringMap;

{$Include w:\common\components\rtl\Garant\L3\l3Dictionary.imp.pas}

function Tl3StringMap.ResolveString(const aString: AnsiString): Integer;
 {* Возвращает идентификатор строки }
var l_Item: Tl3KeyWord;
//#UC START# *4B8BC0D40179_4B8BC059018C_var*
//#UC END# *4B8BC0D40179_4B8BC059018C_var*
begin
//#UC START# *4B8BC0D40179_4B8BC059018C_impl*
 l_Item := Tl3KeyWord(DRByName[aString]);
 if (l_Item = nil) then
 begin
  l_Item := Tl3KeyWord.Create(aString, f_Hi);
  try
   Add(l_Item);
  finally
   l3Free(l_Item);
  end;{try..finally}
  Result := f_Hi;
  Inc(f_Hi);
 end else
  Result := l_Item.StringID;
//#UC END# *4B8BC0D40179_4B8BC059018C_impl*
end;//Tl3StringMap.ResolveString
{$IfEnd} // NOT Defined(NoVCM)

end.
