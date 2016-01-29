unit Contnrs;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Rtl"
// Модуль: "w:/common/components/rtl/external/NotFinished/Borland/Delphi/Rtl/Common/Contnrs.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Rtl::Rtl::Common::Contnrs
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  Classes
  ;

type
 TObjectList = class(TList)
  {* TObjectList maintains a list of (owned) objects. }
 end;//TObjectList

 TOrderedList = class(TObject)
  {* TOrderedList maintains an array of pointers that must be accessed in serial order. }
 end;//TOrderedList

 TStack = class(TOrderedList)
  {* TStack maintains a last-in first-out array of pointers. }
 end;//TStack

 TBucketList = class(TObject)
  {* TBucketList is a simple hash table that stores pointers indexed by pointers. }
 end;//TBucketList

implementation

end.