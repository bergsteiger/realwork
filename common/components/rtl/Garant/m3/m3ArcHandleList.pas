unit m3ArcHandleList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3ArcHandleList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::ArchiveStreams::Tm3ArcHandleList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3ArcHandle,
  ActiveX,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Tm3ArcHandle;
 _KeyType_ = Int64;
 {$Include ..\m3\m3PersistentList.imp.pas}
 Tm3ArcHandleList = class(_m3PersistentList_)
 protected
 // realized methods
   function CompareKeyByItem(const aKey: _KeyType_;
     const anItem: _ItemType_): Integer; override;
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 end;//Tm3ArcHandleList

implementation

uses
  m2S64Lib,
  m2COMLib,
  l3Base,
  m3BuffStream,
  m2S32Lib,
  m3Persistent,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tm3ArcHandleList;

{$Include ..\m3\m3PersistentList.imp.pas}

// start class Tm3ArcHandleList

function Tm3ArcHandleList.CompareKeyByItem(const aKey: _KeyType_;
  const anItem: _ItemType_): Integer;
//#UC START# *5421A06902CD_54539E0A00DA_var*
//#UC END# *5421A06902CD_54539E0A00DA_var*
begin
//#UC START# *5421A06902CD_54539E0A00DA_impl*
 if (aKey >= anItem.Data.Position) and (aKey < (anItem.Data.Position + Int64(anItem.Data.DataSize))) then
  Result := 0
 else
  Result := m2S64Compare(aKey, anItem.Data.Position);
//#UC END# *5421A06902CD_54539E0A00DA_impl*
end;//Tm3ArcHandleList.CompareKeyByItem

{$If not defined(DesignTimeLibrary)}
class function Tm3ArcHandleList.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_54539E0A00DA_var*
//#UC END# *47A6FEE600FC_54539E0A00DA_var*
begin
//#UC START# *47A6FEE600FC_54539E0A00DA_impl*
 Result := true;
//#UC END# *47A6FEE600FC_54539E0A00DA_impl*
end;//Tm3ArcHandleList.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.