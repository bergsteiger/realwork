unit l3TreeFilters;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , l3TreeInterfaces
 , l3Interfaces
;

type
 Tl3TreeFilters = class(Tl3CacheableBase, Il3TreeFilters)
  {* Содержит фильтры дерева. [$96481887] }
  procedure Create(const aSource: Il3TreeFilters);
  function Make(const aSource: Il3TreeFilters): Il3TreeFilters;
  function SetContext(const aValue: Il3CString): Il3TreeFilters;
  function Clone: Il3TreeFilters;
  function Context: Il3CString;
 end;//Tl3TreeFilters
 
implementation

uses
 l3ImplUses
;

end.
