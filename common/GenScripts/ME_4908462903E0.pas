unit nscContextFilterState;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , vcmExternalInterfaces
 , l3TreeInterfaces
 , nscNewInterfaces
 , l3Interfaces
;

type
 TnscContextFilterState = class(Tl3CacheableBase, IvcmBase, Il3ContextFilterNotifier, InscContextFilterState)
  procedure Create(IsActive: Boolean;
   const aContext: Il3CString;
   aPos: Integer;
   aNeedRefilterTree: Boolean;
   const aContextFilterTarget: Il3ContextFilterTarget);
  function Make(IsActive: Boolean;
   const aContext: Il3CString;
   aPos: Integer;
   aNeedRefilterTree: Boolean;
   const aContextFilterTarget: Il3ContextFilterTarget): InscContextFilterState;
  procedure RequestReapply;
   {* Желательно переприменить фильтр. }
  procedure RequestClearAndTurnOff;
   {* Дерево выключило на себе фильтр. }
  procedure RequestCheckValid;
   {* Дерево поменялось - нужно проверить валидность фильтра. }
  function Active: Boolean;
  function Context: Il3CString;
  function ActiveContext: Il3CString;
  function CaretPos: Integer;
  function NeedRefilterTree: Boolean;
 end;//TnscContextFilterState
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
