unit TabInTableTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , nevTools
 , PrimTextLoad_Form
;

type
 TTabInTableTest = class(TTextEditorVisitor)
  {* Теситрование поведения таблицации в таблице }
  procedure CheckPoint(const aCellPoint: InevBasePoint);
  function GetDownMoveCount: Integer;
   {* Количество смещений вниз }
  function GetTabMoveCount: Integer;
   {* Количество смещений по табуляциии }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
 end;//TTabInTableTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
;

end.
