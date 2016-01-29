unit evQueryCardSelection;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evQueryCardSelection.pas"
// Начат: 01.11.2005 09:03
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::QueryCard::TevQueryCardSelection
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevSelection,
  nevTools
  ;

type
 TevQueryCardSelection = class(TnevSelection)
 protected
 // overridden protected methods
   function DoGetBlock(const aDocument: InevObject): InevRange; override;
 end;//TevQueryCardSelection

implementation

uses
  k2Tags,
  evOp,
  LeafPara_Const
  ;

// start class TevQueryCardSelection

function TevQueryCardSelection.DoGetBlock(const aDocument: InevObject): InevRange;
//#UC START# *48E252D40298_48E2466300B3_var*
{$IfNDef DesignTimeLibrary}
var
 l_TagS : PInevObject;
 l_TagF : PInevObject;
 l_B    : InevBasePoint;
{$EndIf DesignTimeLibrary}
//#UC END# *48E252D40298_48E2466300B3_var*
begin
//#UC START# *48E252D40298_48E2466300B3_impl*
 {$IfNDef DesignTimeLibrary}
 if (Start = nil) then
  Result := nil
 else
 begin
  l_TagS := Start.MostInner.Obj;
  if Finish <> nil then
   l_TagF := Finish.MostInner.Obj
  else
   l_TagF := nil;
  Assert(aDocument <> nil); 
  if not l_TagS.AsObject.IsKindOf(k2_typLeafPara) then
  begin
   l_B := Start.ClonePoint(View).ToBottomChild(View).PointToParent(aDocument);
   Result := aDocument.Range(l_B, l_B);
  end//not l_TagS.IsKindOf(k2_typLeafPara)
  else
  if (l_TagF <> nil) AND l_TagS.AsObject.IsSame(l_TagF^.AsObject) then
   Result := inherited DoGetBlock(aDocument)
  else
  begin
   if (StartMark.Compare(Start) = 0) then
   begin
    l_B := l_TagS.MakePoint;
    l_B.Move(View, ev_ocBottomRight);
    Result := aDocument.Range(Start, l_B.PointToParent(aDocument))
   end//StartMark.Compare(Start) = 0
   else
   begin
    if l_TagF <> nil then
    begin
     l_B := l_TagF.MakePoint;
     Result := aDocument.Range(l_B.PointToParent(aDocument), Finish);
    end // if l_TagF <> nil then
    else
     Result := inherited DoGetBlock(aDocument);
   end;//StartMark.Compare(Start) = 0
  end;//l_TagS.IsSame(l_TagF)
 end;//Start = nil
 {$Else   DesignTimeLibrary}
 Result := inherited DoGetBlock(aDocument);
 {$EndIf  DesignTimeLibrary}
//#UC END# *48E252D40298_48E2466300B3_impl*
end;//TevQueryCardSelection.DoGetBlock

end.