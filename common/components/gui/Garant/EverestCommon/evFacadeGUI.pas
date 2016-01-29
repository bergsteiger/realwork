unit evFacadeGUI;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestCommon"
// Модуль: "w:/common/components/gui/Garant/EverestCommon/evFacadeGUI.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EverestCommon::evFacade::evFacadeGUI
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EverestCommon\evDefine.inc}

interface

uses
  Types,
  evCustomEditor,
  evCustomEditorWindow,
  evCustomTextSource,
  evCommonTypes,
  l3Variant
  ;

function EvInvalidatePara(aPara: Tl3Variant): Boolean;
function EvCheckInTable(const aBlock: IevCommonDataObject;
  anEditor: TevCustomEditorWindow): Boolean;
procedure EvUnformatAll(aTextSource: TevCustomTextSource);
function EvMouseLP2DP(anEditor: TevCustomEditor): TPoint;

implementation

uses
  k2Tags,
  nevTools,
  Table_Const,
  nevBase
  ;

// unit methods

function EvInvalidatePara(aPara: Tl3Variant): Boolean;
//#UC START# *48EEFA40027D_48EEF9D8031A_var*
var
 l_Para : InevPara;
//#UC END# *48EEFA40027D_48EEF9D8031A_var*
begin
//#UC START# *48EEFA40027D_48EEF9D8031A_impl*
 Result := true;
 if aPara.QT(InevPara, l_Para) then
 begin
  if (l_Para.DocumentContainer = nil) then
   Result := false
  else
   l_Para.Invalidate([nev_spExtent]);
 end;//aPara.QT(InevPara, l_Para)
//#UC END# *48EEFA40027D_48EEF9D8031A_impl*
end;//EvInvalidatePara

function EvCheckInTable(const aBlock: IevCommonDataObject;
  anEditor: TevCustomEditorWindow): Boolean;
//#UC START# *48EEFB7400DB_48EEF9D8031A_var*
var
 l_Start  : InevBasePoint;
 l_Finish : InevBasePoint;
//#UC END# *48EEFB7400DB_48EEF9D8031A_var*
begin
//#UC START# *48EEFB7400DB_48EEF9D8031A_impl*
 Result := (anEditor.Range.Table <> nil);
 (aBlock As InevRange).GetBorderPoints(l_Start, l_Finish);
 while l_Start <> nil do
 begin
  if l_Start.Obj.IsKindOf(k2_typTable) then
  begin
   Result := not l_Start.AtStart;
   if Result then
   begin
    l_Start.SetAtStart(anEditor.View, True);
    Result := not l_Start.AtStart;
    Break;
   end
   else
    Break;
  end;
  if l_Start.HasInner then
   l_Start := l_Start.Inner
  else
   l_Start := nil;
 end;
 while l_Finish <> nil do
 begin
  if l_Finish.Obj.IsKindOf(k2_typTable) then
  begin
   Result := not l_Finish.AtEnd(anEditor.View);
   if Result then
   begin
    l_Finish.SetAtEnd(anEditor.View, True);
    Result := not l_Finish.AtEnd(anEditor.View);
    Break;
   end
   else
    Break;
  end;
  if l_Finish.HasInner then
   l_Finish := l_Finish.Inner
  else
   l_Finish := nil;
 end;
//#UC END# *48EEFB7400DB_48EEF9D8031A_impl*
end;//EvCheckInTable

procedure EvUnformatAll(aTextSource: TevCustomTextSource);
//#UC START# *48EEFBCD02EA_48EEF9D8031A_var*
//#UC END# *48EEFBCD02EA_48EEF9D8031A_var*
begin
//#UC START# *48EEFBCD02EA_48EEF9D8031A_impl*
  aTextSource.DocumentContainer.TextSource.ViewArea.Update;
//#UC END# *48EEFBCD02EA_48EEF9D8031A_impl*
end;//EvUnformatAll

function EvMouseLP2DP(anEditor: TevCustomEditor): TPoint;
//#UC START# *48EEFCD2037C_48EEF9D8031A_var*
//#UC END# *48EEFCD2037C_48EEF9D8031A_var*
begin
//#UC START# *48EEFCD2037C_48EEF9D8031A_impl*
 with anEditor As InevControl do
  Result := LP2DP(View.MousePos, True);
//#UC END# *48EEFCD2037C_48EEF9D8031A_impl*
end;//EvMouseLP2DP

end.