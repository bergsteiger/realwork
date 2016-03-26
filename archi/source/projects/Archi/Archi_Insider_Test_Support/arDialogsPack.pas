unit arDialogsPack;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\arDialogsPack.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "arDialogsPack" MUID: (4E244C8400D2)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwOpenInsDWin
 , kwMakeChangeDoc
 , kwInsertDocChanges
 , kwIniRecSetZoom
 , kwIniRecGetZoom
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
