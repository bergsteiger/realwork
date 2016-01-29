unit npControlsListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , npControls
 , Controls
 , vtNavigator
;

type
 TnpControlsListPrim = class(_l3UncomparabeObjectRefList_)
  {* список навигаторов на форме, от которых были отстыкованы компоненты. }
  function Find(aControl: TControl): TnpControls; overload;
   {* найти навигатор с которым связан компонент }
  function Find(aNavigator: TvtNavigatorPrim): TnpControls; overload;
   {* найти Link }
  procedure AddControl(aNavigator: TvtNavigatorPrim;
   aControl: TControl);
   {* анализирует кто является его родителем, если навигатор на форме, то ищет его в списке и добавляет к нему компонент. }
  procedure DeleteControl(aControl: TControl);
   {* удалить компонент из списка (происходит при пристыковки) }
  procedure DockOnForm(aControl: TControl);
   {* пристыковать компонент к навигатору на форме, от которого от был отстыкован }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TnpControlsListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
