unit NOT_FINISHED_InsDWin;

// Модуль: "w:\archi\source\projects\Archi\Dlg\NOT_FINISHED_InsDWin.pas"
// Стереотип: "UtilityPack"

{$Include arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , l3Tree_TLB
 , DictMetaForm
;

type
 TInsertTextDictForm = class(TDictMetaForm)
 end;//TInsertTextDictForm

function GetInsTextNode(var anInsText: PAnsiChar): Boolean;
function GetInsText(var aNode: Il3Node): Boolean;
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
;

function GetInsTextNode(var anInsText: PAnsiChar): Boolean;
//#UC START# *4E202ADD0180_4E202A8502E6_var*
//#UC END# *4E202ADD0180_4E202A8502E6_var*
begin
//#UC START# *4E202ADD0180_4E202A8502E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E202ADD0180_4E202A8502E6_impl*
end;//GetInsTextNode

function GetInsText(var aNode: Il3Node): Boolean;
//#UC START# *4E202AEC00C0_4E202A8502E6_var*
//#UC END# *4E202AEC00C0_4E202A8502E6_var*
begin
//#UC START# *4E202AEC00C0_4E202A8502E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E202AEC00C0_4E202A8502E6_impl*
end;//GetInsText
{$IfEnd} // Defined(AppClientSide)

end.
