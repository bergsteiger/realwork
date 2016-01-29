unit TextEditorVisitor;

interface

uses
 l3IntfUses
 , TextEditorVisitorPrim
;

type
 TTextEditorVisitor = class(TTextEditorVisitorPrim)
  {* Тест, работающий с текстом документа через редактор, но не изменяющий его }
  procedure DoIt;
   {* Собственно тело теста }
  function GetNormalFontSize: Integer;
   {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
  function MaxHeight: Integer;
   {* Если возвращается не 0, то будет организован цикл подбора высоты от FormExtent.Y до MaxHeight }
 end;//TTextEditorVisitor
 
implementation

uses
 l3ImplUses
 , SysUtils
 , evStyleInterface
 , TestFrameWork
;

end.
