unit evFacadeSub;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestCommon"
// Модуль: "w:/common/components/gui/Garant/EverestCommon/evFacadeSub.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EverestCommon::evFacade::evFacadeSub
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EverestCommon\evDefine.inc}

interface

uses
  nevTools,
  evCustomEditor,
  evCustomEditorWindow,
  evCustomTextSource
  ;

function EvDeleteSub(anEditor: TevCustomEditorWindow;
  const aSub: IevSub): Boolean;
function EvGetSubList(aTextSource: TevCustomTextSource): InevSubList;
procedure EvDeleteAllDocumentParts(anEditor: TevCustomEditorWindow);
function EvNewSub(anEditor: TevCustomEditorWindow): IevSub;
function EvCurrentSub(anEditor: TevCustomEditorWindow): IevSub;
procedure EvSubSelect(anEditor: TevCustomEditor;
  aGoToSubID: Integer);

implementation

uses
  SysUtils,
  l3Base,
  nevBase,
  evStubs,
  evMsgCode
  ;

// unit methods

function EvDeleteSub(anEditor: TevCustomEditorWindow;
  const aSub: IevSub): Boolean;
//#UC START# *48EEF8EA0247_48EEF8D0004A_var*
//#UC END# *48EEF8EA0247_48EEF8D0004A_var*
begin
//#UC START# *48EEF8EA0247_48EEF8D0004A_impl*
 Result := aSub.Delete(anEditor.View);
//#UC END# *48EEF8EA0247_48EEF8D0004A_impl*
end;//EvDeleteSub

function EvGetSubList(aTextSource: TevCustomTextSource): InevSubList;
//#UC START# *48EEF96A02C0_48EEF8D0004A_var*
//#UC END# *48EEF96A02C0_48EEF8D0004A_var*
begin
//#UC START# *48EEF96A02C0_48EEF8D0004A_impl*
 Result := aTextSource.DocumentContainer.SubList;
//#UC END# *48EEF96A02C0_48EEF8D0004A_impl*
end;//EvGetSubList

procedure EvDeleteAllDocumentParts(anEditor: TevCustomEditorWindow);
//#UC START# *48EEFA60019E_48EEF8D0004A_var*

 function _DoSub(const aSub: IevSub): Boolean;
 var
  l_Block : IevDocumentPart;
 begin
  Result := true;
  if l3IOk(aSub.QueryInterface(IevDocumentPart, l_Block)) then
   try
    with l_Block do
     if Delete(anEditor.View) then
      SetTo(Cursor.AsObject);
   finally
    l_Block := nil;
   end;//try..finally
 end;

var
 l_OpPack : InevOp;
//#UC END# *48EEFA60019E_48EEF8D0004A_var*
begin
//#UC START# *48EEFA60019E_48EEF8D0004A_impl*
 with anEditor.TextSource do
 begin
  l_OpPack := StartOp(ev_msgDeletePara);
  try
   DocumentContainer.SubList.IterateF(evL2SubA(@_DoSub), nil, l3CStr('Удаление блоков'));
  finally
   l_OpPack := nil;
  end;//try..finally
 end;//aTextSource
//#UC END# *48EEFA60019E_48EEF8D0004A_impl*
end;//EvDeleteAllDocumentParts

function EvNewSub(anEditor: TevCustomEditorWindow): IevSub;
//#UC START# *48EEFB0F0332_48EEF8D0004A_var*
//#UC END# *48EEFB0F0332_48EEF8D0004A_var*
begin
//#UC START# *48EEFB0F0332_48EEF8D0004A_impl*
 Result := evGetSubList(anEditor.TextSource).NewSub;
 Result.Cursor := anEditor.Selection.Cursor.MostInner.AsObject;
//#UC END# *48EEFB0F0332_48EEF8D0004A_impl*
end;//EvNewSub

function EvCurrentSub(anEditor: TevCustomEditorWindow): IevSub;
//#UC START# *48EEFB1C005F_48EEF8D0004A_var*
//#UC END# *48EEFB1C005F_48EEF8D0004A_var*
begin
//#UC START# *48EEFB1C005F_48EEF8D0004A_impl*
 Result := evGetSubList(anEditor.TextSource).NewSub;
 Supports(anEditor.Selection.Cursor.MostInner, IevSub, Result);
//#UC END# *48EEFB1C005F_48EEF8D0004A_impl*
end;//EvCurrentSub

procedure EvSubSelect(anEditor: TevCustomEditor;
  aGoToSubID: Integer);
//#UC START# *48EEFD46016A_48EEF8D0004A_var*
//#UC END# *48EEFD46016A_48EEF8D0004A_var*
begin
//#UC START# *48EEFD46016A_48EEF8D0004A_impl*
  anEditor.TextSource.DocumentContainer.SubList.Sub[aGoToSubID].Select(anEditor.Selection);
//#UC END# *48EEFD46016A_48EEF8D0004A_impl*
end;//EvSubSelect

end.