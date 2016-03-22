unit evFacadeCursor;

// Модуль: "w:\common\components\gui\Garant\EverestCommon\evFacadeCursor.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evFacadeCursor" MUID: (48EEE8A503AB)

{$Include w:\common\components\gui\Garant\EverestCommon\evDefine.inc}

interface

uses
 l3IntfUses
 , evCommonTypes
 , evCustomEditorWindow
 , evCustomEditor
;

function evGetMostInnerPos(anEditor: TevCustomEditorWindow): Integer;
 {* Возвращает позицию самого внутреннего курсора }
function evGetMostInnerEntryPos(anEditor: TevCustomEditorWindow): Integer;
 {* Возвращает позицию самого внутреннего курсора или начала выделения }
function evCursorInSel(anEditor: TevCustomEditorWindow): Boolean;
 {* Проверка находится ли курсор в выделении }
function evMostInnerCursor(anEditor: TevCustomEditor): TnevBaseCursor;
 {* Возвращает курсор самого нижнего уровня }
function evCloneCursor(anEditor: TevCustomEditor): TnevCursor;
 {* Клонировать курсор }
procedure evFreeCursor(var aCursor: TnevCursor);
 {* Освобождает объект/интерфейс курсора }
procedure evSelectPoint(anEditor: TevCustomEditor;
 const aCursor: TnevCursor);
function evGetChildCursor(anEditor: TevCustomEditor;
 const aCursor: TnevBaseCursor): TnevBaseCursor;
 {* Возвращает дочерний курсор }

implementation

uses
 l3ImplUses
 , nevTools
;

function evGetMostInnerPos(anEditor: TevCustomEditorWindow): Integer;
 {* Возвращает позицию самого внутреннего курсора }
//#UC START# *48EEED050239_48EEE8A503AB_var*
//#UC END# *48EEED050239_48EEE8A503AB_var*
begin
//#UC START# *48EEED050239_48EEE8A503AB_impl*
 Result := anEditor.Selection.Cursor.MostInner.Position;
//#UC END# *48EEED050239_48EEE8A503AB_impl*
end;//evGetMostInnerPos

function evGetMostInnerEntryPos(anEditor: TevCustomEditorWindow): Integer;
 {* Возвращает позицию самого внутреннего курсора или начала выделения }
//#UC START# *48EEED27002F_48EEE8A503AB_var*
//#UC END# *48EEED27002F_48EEE8A503AB_var*
begin
//#UC START# *48EEED27002F_48EEE8A503AB_impl*
 if anEditor.HasSelection then
  Result := anEditor.Selection.Start.MostInner.Position
 else
  Result := anEditor.Selection.Cursor.MostInner.Position;
//#UC END# *48EEED27002F_48EEE8A503AB_impl*
end;//evGetMostInnerEntryPos

function evCursorInSel(anEditor: TevCustomEditorWindow): Boolean;
 {* Проверка находится ли курсор в выделении }
//#UC START# *48EEED52016E_48EEE8A503AB_var*
//#UC END# *48EEED52016E_48EEE8A503AB_var*
begin
//#UC START# *48EEED52016E_48EEE8A503AB_impl*
 Result := InevSelection(anEditor.Selection).Contains(anEditor.Selection.Cursor);
//#UC END# *48EEED52016E_48EEE8A503AB_impl*
end;//evCursorInSel

function evMostInnerCursor(anEditor: TevCustomEditor): TnevBaseCursor;
 {* Возвращает курсор самого нижнего уровня }
//#UC START# *48EEED730106_48EEE8A503AB_var*
//#UC END# *48EEED730106_48EEE8A503AB_var*
begin
//#UC START# *48EEED730106_48EEE8A503AB_impl*
  Result := anEditor.Selection.Cursor.MostInner;
//#UC END# *48EEED730106_48EEE8A503AB_impl*
end;//evMostInnerCursor

function evCloneCursor(anEditor: TevCustomEditor): TnevCursor;
 {* Клонировать курсор }
//#UC START# *48EEEDA301B2_48EEE8A503AB_var*
//#UC END# *48EEEDA301B2_48EEE8A503AB_var*
begin
//#UC START# *48EEEDA301B2_48EEE8A503AB_impl*
 Result := anEditor.Selection.Cursor.ClonePoint(anEditor.View);
//#UC END# *48EEEDA301B2_48EEE8A503AB_impl*
end;//evCloneCursor

procedure evFreeCursor(var aCursor: TnevCursor);
 {* Освобождает объект/интерфейс курсора }
//#UC START# *48EEEDBC02F0_48EEE8A503AB_var*
//#UC END# *48EEEDBC02F0_48EEE8A503AB_var*
begin
//#UC START# *48EEEDBC02F0_48EEE8A503AB_impl*
 aCursor := nil;
//#UC END# *48EEEDBC02F0_48EEE8A503AB_impl*
end;//evFreeCursor

procedure evSelectPoint(anEditor: TevCustomEditor;
 const aCursor: TnevCursor);
//#UC START# *48EEEDD200CA_48EEE8A503AB_var*
//#UC END# *48EEEDD200CA_48EEE8A503AB_var*
begin
//#UC START# *48EEEDD200CA_48EEE8A503AB_impl*
 InevSelection(anEditor.Selection).SelectPoint(aCursor, False);
//#UC END# *48EEEDD200CA_48EEE8A503AB_impl*
end;//evSelectPoint

function evGetChildCursor(anEditor: TevCustomEditor;
 const aCursor: TnevBaseCursor): TnevBaseCursor;
 {* Возвращает дочерний курсор }
//#UC START# *48EEEDE302E0_48EEE8A503AB_var*
//#UC END# *48EEEDE302E0_48EEE8A503AB_var*
begin
//#UC START# *48EEEDE302E0_48EEE8A503AB_impl*
 if aCursor.HasInner then
  Result := aCursor.Inner
 else
  Result := nil;
//#UC END# *48EEEDE302E0_48EEE8A503AB_impl*
end;//evGetChildCursor

end.
