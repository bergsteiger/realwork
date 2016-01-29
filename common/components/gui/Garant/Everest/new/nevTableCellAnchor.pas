unit nevTableCellAnchor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevTableCellAnchor.pas"
// Начат: 2009/04/28 09:56:30
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Anchors::TnevTableCellAnchor
//
// Якорь для ячейки таблицы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\new\nevDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  nevParaListAnchor,
  nevTools
  {$If defined(evUseVisibleCursors)}
  ,
  nevParaListAnchorModifyTypes
  {$IfEnd} //evUseVisibleCursors
  
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TnevTableCellAnchor = class(TnevParaListAnchor)
  {* Якорь для ячейки таблицы }
 protected
 // overridden property methods
   function pm_GetHasInner: Boolean; override;
 protected
 // overridden protected methods
   {$If defined(evUseVisibleCursors)}
   function DoIncLine(const aView: InevView;
    var theLine: Integer;
    aSmall: Boolean;
    const aChildrenInfo: TnevChildrenInfo): Integer; override;
   {$IfEnd} //evUseVisibleCursors
   procedure ClearInnerInFire; override;
 end;//TnevTableCellAnchor
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  evdTypes,
  k2Tags
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TnevTableCellAnchor

function TnevTableCellAnchor.pm_GetHasInner: Boolean;
//#UC START# *4A58BA550111_4A5D82380323get_var*
//#UC END# *4A58BA550111_4A5D82380323get_var*
begin
//#UC START# *4A58BA550111_4A5D82380323get_impl*
 Result := TevMergeStatus(IntA[k2_tiMergeStatus]) <> ev_msContinue;
 if Result then
  Result := inherited pm_GetHasInner;
//#UC END# *4A58BA550111_4A5D82380323get_impl*
end;//TnevTableCellAnchor.pm_GetHasInner

{$If defined(evUseVisibleCursors)}
function TnevTableCellAnchor.DoIncLine(const aView: InevView;
  var theLine: Integer;
  aSmall: Boolean;
  const aChildrenInfo: TnevChildrenInfo): Integer;
//#UC START# *4B1D18650208_4A5D82380323_var*
//#UC END# *4B1D18650208_4A5D82380323_var*
begin
//#UC START# *4B1D18650208_4A5D82380323_impl*
 if TevMergeStatus(IntA[k2_tiMergeStatus]) = ev_msContinue then
  Result := 0
 else
  Result := inherited DoIncLine(aView, theLine, aSmall, aChildrenInfo);
//#UC END# *4B1D18650208_4A5D82380323_impl*
end;//TnevTableCellAnchor.DoIncLine
{$IfEnd} //evUseVisibleCursors

procedure TnevTableCellAnchor.ClearInnerInFire;
//#UC START# *55376B1B00F8_4A5D82380323_var*
//#UC END# *55376B1B00F8_4A5D82380323_var*
begin
//#UC START# *55376B1B00F8_4A5D82380323_impl*
 // Выключено в: http://mdp.garant.ru/pages/viewpage.action?pageId=597332678
 // Если понадобиться восстановить, то нужно учесть, что при сбросе Inner нужно информировать родительский, т.е. базовую линию от таблицы.
 // Ибо её тогда нужно перестроить. И редактор нужно перерисовать, т.к. наверняка понадобится прокрутка. 
//#UC END# *55376B1B00F8_4A5D82380323_impl*
end;//TnevTableCellAnchor.ClearInnerInFire

{$IfEnd} //k2ForEditor

end.