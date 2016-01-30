unit vcmLocalInterfaces;
 {* Локальные интерфейсы VCM }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmLocalInterfaces.pas"
// Стереотип: "Interfaces"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3Interfaces
 , vcmUserControls
;

type
 IvcmFormSetDataSourceListener = interface(Il3Notify)
  {* Слушатель событий бизнес объекта сборки }
  ['{5F7A6BE6-C326-4A36-8B7C-F3F8140E0CE6}']
  procedure DataChanged;
   {* данные изменились }
 end;//IvcmFormSetDataSourceListener

 IvcmDock = interface
  {* интерфейс поддерживаемый dock-ом toolbar-ов }
  ['{D8BE3620-B1A8-4165-8332-BBD4DA958592}']
  function pm_GetFullWidth: Integer;
  function pm_GetFullHeight: Integer;
  function pm_GetPos: TvcmEffectiveToolBarPos;
  property FullWidth: Integer
   read pm_GetFullWidth;
   {* полная ширина dock-а toolbar-ов с учетом того, что dock может быть
           вставлен еще в какой-нибудь компонент }
  property FullHeight: Integer
   read pm_GetFullHeight;
   {* полная высота dock-а toolbar-ов с учетом того, что dock может быть
           вставлен еще в какой-нибудь компонент }
  property Pos: TvcmEffectiveToolBarPos
   read pm_GetPos;
   {* позиция dock-а на форме }
 end;//IvcmDock
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
