unit vtNavigatorFormListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$WithVCM"
// Модуль: "w:/common/components/gui/Garant/VT/vtNavigatorFormListPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT$WithVCM::vtNavigator::TvtNavigatorFormListPrim
//
// Список форм навигатора, который позволяет искать элемент в списка по ключу объект.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vtNavigatorFormListPrimPrim,
  l3Types
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvtFormHandlerID = record
  {* Ключ для поиска элемента по объекту. }
   rObject : TObject; // Ключ поиска - объект
 end;//TvtFormHandlerID

 _FindDataType_ = TvtFormHandlerID;
 _l3Searcher_Parent_ = TvtNavigatorFormListPrimPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TvtNavigatorFormListPrim = class(_l3Searcher_)
  {* Список форм навигатора, который позволяет искать элемент в списка по ключу объект. }
 end;//TvtNavigatorFormListPrim
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TvtFormHandlerID_C(anObject: TObject): TvtFormHandlerID;
  {* Возвращает заполненную запись }
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Memory
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

// start class TvtNavigatorFormListPrim

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
//#UC START# *47B9BAFD01F4_47D68267011D_var*
//#UC END# *47B9BAFD01F4_47D68267011D_var*
begin
//#UC START# *47B9BAFD01F4_47D68267011D_impl*
 Assert(aSortIndex = l3_siNative);
 Result := Integer(anItem.CloseHandler.Form) - Integer(aData.rObject);
//#UC END# *47B9BAFD01F4_47D68267011D_impl*
end;//CompareItemWithData

type _Instance_R_ = TvtNavigatorFormListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}


function TvtFormHandlerID_C(anObject: TObject): TvtFormHandlerID;
  {* Возвращает заполненную запись }
//#UC START# *4B7039C60392_47D67F4A01EA_var*
//#UC END# *4B7039C60392_47D67F4A01EA_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4B7039C60392_47D67F4A01EA_impl*
 Result.rObject := anObject;
//#UC END# *4B7039C60392_47D67F4A01EA_impl*
end;//TvtFormHandlerID.C


{$IfEnd} //not NoVCM
end.