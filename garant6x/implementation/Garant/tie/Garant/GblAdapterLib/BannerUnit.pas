unit BannerUnit;
 {* Баннеры }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\BannerUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "Banner" MUID: (4ACC6D940387)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
 , ExternalObjectUnit
;

type
 IBanner = interface
  {* Баннер }
  ['{B869F2FF-7971-44F1-BAA5-F664C978EF7F}']
  function OpenLink: IUnknown; stdcall; { can raise CanNotFindData }
   {* Открыть ссылку баннера (возвращает или IDocument или ExternalLink) }
  function GetPicture: IExternalObject; stdcall;
   {* Картинка }
 end;//IBanner

implementation

uses
 l3ImplUses
;

end.
