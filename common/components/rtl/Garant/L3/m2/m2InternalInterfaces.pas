unit m2InternalInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/m2/m2InternalInterfaces.pas"
// Начат: 31.10.2001 12:01
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi Low Level::L3::m2InternalInterfaces
//
// Внутренние интерфейсы библиотеки m2
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m2\m2Define.inc}

interface

type
 Im2StoreStat = interface(IUnknown)
  {* Информация о хранилище }
   ['{1B212038-ED47-447A-811D-CA3891B5B5E0}']
   function pm_GetAccess: LongInt;
   function pm_GetLocksSupported: LongInt;
   function pm_GetSize: Int64;
   function pm_GetPosition: Int64;
   function Get_Name: WideString;
   property Access: LongInt
     read pm_GetAccess;
     {* режим доступа }
   property LocksSupported: LongInt
     read pm_GetLocksSupported;
     {* какие замки доступны? }
   property Size: Int64
     read pm_GetSize;
     {* размер }
   property Position: Int64
     read pm_GetPosition;
     {* Позиция }
   property Name: WideString
     read Get_Name;
 end;//Im2StoreStat

implementation

end.