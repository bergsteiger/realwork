unit m3NewVersionStream;
 {* Поток, создавший новую версию документа }

// Модуль: "w:\common\components\rtl\Garant\m3\m3NewVersionStream.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3NewVersionStream" MUID: (49BFE43D019F)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3DBProxyWriteStream
;

type
 Tm3NewVersionStream = class(Tm3DBProxyWriteStream)
  {* Поток, создавший новую версию документа }
  protected
   function pm_GetIsNewVersion: Boolean; override;
 end;//Tm3NewVersionStream

implementation

uses
 l3ImplUses
;

function Tm3NewVersionStream.pm_GetIsNewVersion: Boolean;
//#UC START# *49BFE6600304_49BFE43D019Fget_var*
//#UC END# *49BFE6600304_49BFE43D019Fget_var*
begin
//#UC START# *49BFE6600304_49BFE43D019Fget_impl*
 Result := true;
//#UC END# *49BFE6600304_49BFE43D019Fget_impl*
end;//Tm3NewVersionStream.pm_GetIsNewVersion

end.
