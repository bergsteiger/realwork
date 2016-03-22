unit NOT_FINISHED_arTextOfAnnoDocument;

// Модуль: "w:\archi\source\projects\Archi\Editor\NOT_FINISHED_arTextOfAnnoDocument.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarTextOfAnnoDocument" MUID: (4E0073BD0223)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , arTextOfDocument
;

type
 TarTextOfAnnoDocument = class(TarTextOfDocument)
 end;//TarTextOfAnnoDocument
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(AppClientSide)

end.
