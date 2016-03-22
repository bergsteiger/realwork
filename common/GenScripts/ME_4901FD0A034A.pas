unit nsCutToLeafFilter;
 {* Коллеги, это что? }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsCutToLeafFilter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsCutToLeafFilter" MUID: (4901FD0A034A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3CacheableBase
 , BaseSearchInterfaces
;

type
 TnsCutToLeafFilter = class(Tl3CacheableBase, InsCutToLeafFilter)
  {* Коллеги, это что? }
  private
   f_LeafCount: LongWord;
  protected
   function pm_GetLeafCount: LongWord;
  public
   constructor Create(aCount: LongWord); reintroduce;
   class function Make(aCount: LongWord): InsCutToLeafFilter; reintroduce;
    {* Создаёт фильтр }
 end;//TnsCutToLeafFilter
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

constructor TnsCutToLeafFilter.Create(aCount: LongWord);
//#UC START# *4901FD3E03AD_4901FD0A034A_var*
//#UC END# *4901FD3E03AD_4901FD0A034A_var*
begin
//#UC START# *4901FD3E03AD_4901FD0A034A_impl*
 inherited Create;
 f_LeafCount := aCount;
//#UC END# *4901FD3E03AD_4901FD0A034A_impl*
end;//TnsCutToLeafFilter.Create

class function TnsCutToLeafFilter.Make(aCount: LongWord): InsCutToLeafFilter;
 {* Создаёт фильтр }
var
 l_Inst : TnsCutToLeafFilter;
begin
 l_Inst := Create(aCount);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsCutToLeafFilter.Make

function TnsCutToLeafFilter.pm_GetLeafCount: LongWord;
//#UC START# *4901F74E0224_4901FD0A034Aget_var*
//#UC END# *4901F74E0224_4901FD0A034Aget_var*
begin
//#UC START# *4901F74E0224_4901FD0A034Aget_impl*
 Result := f_LeafCount;
//#UC END# *4901F74E0224_4901FD0A034Aget_impl*
end;//TnsCutToLeafFilter.pm_GetLeafCount
{$IfEnd} // NOT Defined(Admin)

end.
