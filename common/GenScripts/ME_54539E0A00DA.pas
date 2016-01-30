unit m3ArcHandleList;

// Модуль: "w:\common\components\rtl\Garant\m3\m3ArcHandleList.pas"
// Стереотип: "SimpleClass"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , m3ArcHandle
 , ActiveX
 , l3ProtoDataContainer
 , Classes
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
;

type
 _ItemType_ = Tm3ArcHandle;
 _KeyType_ = Int64;
 {$Include m3PersistentList.imp.pas}
 Tm3ArcHandleList = class(_m3PersistentList_)
  protected
   function CompareKeyByItem(const aKey: _KeyType_;
    const anItem: _ItemType_): Integer; override;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tm3ArcHandleList

implementation

uses
 l3ImplUses
 , m2S64Lib
 , m3Persistent
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = Tm3ArcHandleList;

{$Include m3PersistentList.imp.pas}

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

{$If NOT Defined(DesignTimeLibrary)}
class function Tm3ArcHandleList.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_54539E0A00DA_var*
//#UC END# *47A6FEE600FC_54539E0A00DA_var*
begin
//#UC START# *47A6FEE600FC_54539E0A00DA_impl*
 Result := true;
//#UC END# *47A6FEE600FC_54539E0A00DA_impl*
end;//Tm3ArcHandleList.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
