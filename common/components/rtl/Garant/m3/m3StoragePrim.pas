unit m3StoragePrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3StoragePrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::m3CoreObjects::Tm3StoragePrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3BaseStorage,
  SyncObjs
  ;

type
 _l3CriticalSectionHolder_Parent_ = Tm3BaseStorage;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 Tm3StoragePrim = {abstract} class(_l3CriticalSectionHolder_)
 end;//Tm3StoragePrim

implementation

uses
  SysUtils
  ;

{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

end.