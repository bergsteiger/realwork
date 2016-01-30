unit BannerUnit;
 {* Баннеры }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\BannerUnit.pas"
// Стереотип: "Interfaces"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , ExternalObjectUnit
 , BaseTypesUnit
;

type
 IBanner = interface
  {* Баннер }
  ['{B869F2FF-7971-44F1-BAA5-F664C978EF7F}']
  function open_link: IUnknown; { can raise CanNotFindData }
   {* Открыть ссылку баннера (возвращает или IDocument или ExternalLink) }
  function get_picture: IExternalObject;
   {* Картинка }
 end;//IBanner

class function make: BadFactoryType; { can raise CanNotFindData }

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType; { can raise CanNotFindData }
var
 l_Inst : IBanner;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
