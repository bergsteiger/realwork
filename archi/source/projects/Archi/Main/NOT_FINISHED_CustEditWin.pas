unit NOT_FINISHED_CustEditWin;

// Модуль: "w:\archi\source\projects\Archi\Main\NOT_FINISHED_CustEditWin.pas"
// Стереотип: "UtilityPack"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , afwNavigation
;

type
 TCustomEditorWindow = class
  protected
   function DocEditorJumpTo(const aMoniker: IevMoniker): Boolean;
 end;//TCustomEditorWindow
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , D_spell
 , arHyperLinkProcessor
;

function TCustomEditorWindow.DocEditorJumpTo(const aMoniker: IevMoniker): Boolean;
//#UC START# *4E5C89E1034B_4E5C8996022B_var*
//#UC END# *4E5C89E1034B_4E5C8996022B_var*
begin
//#UC START# *4E5C89E1034B_4E5C8996022B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E5C89E1034B_4E5C8996022B_impl*
end;//TCustomEditorWindow.DocEditorJumpTo
{$IfEnd} // Defined(AppClientSide)

end.
