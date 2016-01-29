unit nevAutoreferatDocumentAnchor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevAutoreferatDocumentAnchor.pas"
// Начат: 02.03.2011 19:13
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Anchors::TnevAutoreferatDocumentAnchor
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
 TnevAutoreferatDocumentAnchor = class(TnevParaListAnchor)
 protected
 // overridden protected methods
   {$If defined(evUseVisibleCursors)}
   function DoIncLine(const aView: InevView;
    var theLine: Integer;
    aSmall: Boolean;
    const aChildrenInfo: TnevChildrenInfo): Integer; override;
   {$IfEnd} //evUseVisibleCursors
 end;//TnevAutoreferatDocumentAnchor
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}

// start class TnevAutoreferatDocumentAnchor

{$If defined(evUseVisibleCursors)}
function TnevAutoreferatDocumentAnchor.DoIncLine(const aView: InevView;
  var theLine: Integer;
  aSmall: Boolean;
  const aChildrenInfo: TnevChildrenInfo): Integer;
//#UC START# *4B1D18650208_4D6E6C6501F9_var*
//#UC END# *4B1D18650208_4D6E6C6501F9_var*
begin
//#UC START# *4B1D18650208_4D6E6C6501F9_impl*
 if not aSmall AND
    aChildrenInfo.rLinear AND
    (Abs(theLine) > aChildrenInfo.rLeafCount * 2) then
  Result := 0
 else
  Result := inherited DoIncLine(aView, theLine, aSmall, aChildrenInfo);
//#UC END# *4B1D18650208_4D6E6C6501F9_impl*
end;//TnevAutoreferatDocumentAnchor.DoIncLine
{$IfEnd} //evUseVisibleCursors

{$IfEnd} //k2ForEditor

end.