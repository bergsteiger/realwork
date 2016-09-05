unit NOT_FINISHED_UsersMacro;

// Модуль: "w:\archi\source\projects\Archi\Main\NOT_FINISHED_UsersMacro.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "UsersMacro" MUID: (4E4B60A30391)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
;

procedure Macros_MakeChangeDoc;
 {* полнотекстовая редакция }
procedure Macros_InsertDocChanges;
procedure Macros_ReplaceFutureEditionToCurrent;
 {* замена текущей редакции на будущую }
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 //#UC START# *4E4B60A30391impl_uses*
 //#UC END# *4E4B60A30391impl_uses*
;

procedure Macros_MakeChangeDoc;
 {* полнотекстовая редакция }
//#UC START# *4E4B60FC0037_4E4B60A30391_var*
//#UC END# *4E4B60FC0037_4E4B60A30391_var*
begin
//#UC START# *4E4B60FC0037_4E4B60A30391_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E4B60FC0037_4E4B60A30391_impl*
end;//Macros_MakeChangeDoc

procedure Macros_InsertDocChanges;
//#UC START# *4E4B61100328_4E4B60A30391_var*
//#UC END# *4E4B61100328_4E4B60A30391_var*
begin
//#UC START# *4E4B61100328_4E4B60A30391_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E4B61100328_4E4B60A30391_impl*
end;//Macros_InsertDocChanges

procedure Macros_ReplaceFutureEditionToCurrent;
 {* замена текущей редакции на будущую }
//#UC START# *4E4B612A0321_4E4B60A30391_var*
//#UC END# *4E4B612A0321_4E4B60A30391_var*
begin
//#UC START# *4E4B612A0321_4E4B60A30391_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E4B612A0321_4E4B60A30391_impl*
end;//Macros_ReplaceFutureEditionToCurrent
{$IfEnd} // Defined(AppClientSide)

end.
