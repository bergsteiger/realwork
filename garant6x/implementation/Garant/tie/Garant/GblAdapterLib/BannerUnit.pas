unit BannerUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/BannerUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Banner
//
// Баннеры
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTypesUnit,
  ExternalObjectUnit
  ;

type
 IBanner = interface(IUnknown)
  {* Баннер }
   ['{B869F2FF-7971-44F1-BAA5-F664C978EF7F}']
   procedure OpenLink(out aRet {: IUnknown}); stdcall; // can raise CanNotFindData
     {* Открыть ссылку баннера (возвращает или IDocument или ExternalLink) }
   procedure GetPicture(out aRet {: IExternalObject}); stdcall;
     {* Картинка }
 end;//IBanner

implementation

end.