unit vcmLocalInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmLocalInterfaces.pas"
// Начат: 12.02.2009 17:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::VCM::vcmLocalInterfaces
//
// Локальные интерфейсы VCM
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3Interfaces,
  vcmUserControls
  ;

type
 IvcmFormSetDataSourceListener = interface(Il3Notify)
  {* Слушатель событий бизнес объекта сборки }
   ['{5F7A6BE6-C326-4A36-8B7C-F3F8140E0CE6}']
   procedure DataChanged;
     {* данные изменились }
 end;//IvcmFormSetDataSourceListener

 IvcmDock = interface(IUnknown)
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
{$IfEnd} //not NoVCM

implementation

end.