unit m3StorageIndexStreamForIterate;

// Модуль: "w:\common\components\rtl\Garant\m3\m3StorageIndexStreamForIterate.pas"
// Стереотип: "SimpleClass"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , m3StorageIndexStream
;

type
 Tm3StorageIndexStreamForIterate = class(Tm3StorageIndexStream)
  protected
   class function NeedBuffering: Boolean; override;
 end;//Tm3StorageIndexStreamForIterate

implementation

uses
 l3ImplUses
;

class function Tm3StorageIndexStreamForIterate.NeedBuffering: Boolean;
//#UC START# *544A2D9F0368_544A2D800202_var*
//#UC END# *544A2D9F0368_544A2D800202_var*
begin
//#UC START# *544A2D9F0368_544A2D800202_impl*
 Result := true;
//#UC END# *544A2D9F0368_544A2D800202_impl*
end;//Tm3StorageIndexStreamForIterate.NeedBuffering

end.
