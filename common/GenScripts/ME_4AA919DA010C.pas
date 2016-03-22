unit moCommonPost;
 {* Файл }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moCommonPost.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "CommonPost" MUID: (4AA919DA010C)
// Имя типа: "Tmo_CommonPost"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , CommonPost_Module
;

type
 Tmo_CommonPost = {final} class(TCommonPostModule)
  {* Файл }
 end;//Tmo_CommonPost
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin)

end.
