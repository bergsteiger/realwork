unit nsPromptForDocFilter;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsPromptForDocFilter.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3CacheableBase
 , BaseSearchInterfaces
;

type
 TnsPromptForDocFilter = class(Tl3CacheableBase, InsPromptForDocFilter)
  private
   f_DocNum: LongWord;
  protected
   function Get_InternalDocNumber: Longword;
  public
   constructor Create(aDocNum: LongWord); reintroduce;
   class function Make(aDocNum: LongWord): InsPromptForDocFilter; reintroduce;
 end;//TnsPromptForDocFilter
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

constructor TnsPromptForDocFilter.Create(aDocNum: LongWord);
//#UC START# *4AA4D72303A9_4AA4D6CF02A9_var*
//#UC END# *4AA4D72303A9_4AA4D6CF02A9_var*
begin
//#UC START# *4AA4D72303A9_4AA4D6CF02A9_impl*
 inherited Create;
 f_DocNum := aDocNum;
//#UC END# *4AA4D72303A9_4AA4D6CF02A9_impl*
end;//TnsPromptForDocFilter.Create

class function TnsPromptForDocFilter.Make(aDocNum: LongWord): InsPromptForDocFilter;
var
 l_Inst : TnsPromptForDocFilter;
begin
 l_Inst := Create(aDocNum);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsPromptForDocFilter.Make

function TnsPromptForDocFilter.Get_InternalDocNumber: Longword;
//#UC START# *4AA4D5150176_4AA4D6CF02A9get_var*
//#UC END# *4AA4D5150176_4AA4D6CF02A9get_var*
begin
//#UC START# *4AA4D5150176_4AA4D6CF02A9get_impl*
 Result := f_DocNum;
//#UC END# *4AA4D5150176_4AA4D6CF02A9get_impl*
end;//TnsPromptForDocFilter.Get_InternalDocNumber
{$IfEnd} // NOT Defined(Admin)

end.
