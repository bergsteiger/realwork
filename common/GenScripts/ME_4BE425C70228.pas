unit TextEditorVisitor;
 {* Тест, работающий с текстом документа через редактор, но не изменяющий его }

// Модуль: "w:\common\components\gui\Garant\Daily\TextEditorVisitor.pas"
// Стереотип: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextEditorVisitorPrim
;

type
 TTextEditorVisitor = {abstract} class(TTextEditorVisitorPrim)
  {* Тест, работающий с текстом документа через редактор, но не изменяющий его }
  protected
   function GetNormalFontSize: Integer; virtual;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   function MaxHeight: Integer; virtual;
    {* Если возвращается не 0, то будет организован цикл подбора высоты от FormExtent.Y до MaxHeight }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   procedure DoIt;
    {* Собственно тело теста }
 end;//TTextEditorVisitor
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , evStyleInterface
 , TestFrameWork
 , vcmBase
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

procedure TTextEditorVisitor.DoIt;
 {* Собственно тело теста }
//#UC START# *4BE131BC038E_4BE425C70228_var*
var
 l_SI : TevStyleInterface;
 l_Size : Integer;
 l_NewSize : Integer;
 l_MaxHeight : Integer;
//#UC END# *4BE131BC038E_4BE425C70228_var*
begin
//#UC START# *4BE131BC038E_4BE425C70228_impl*
 l_SI := TevStyleInterface.Make;
 try
  l_NewSize := GetNormalFontSize;
  l_Size := l_SI.Font.Size;
  try
   if (l_NewSize > 0) then
    l_SI.Font.Size := l_NewSize;
   l_MaxHeight := MaxHeight;
   if (l_MaxHeight > 0) then
   begin
    f_FixedHeight := 0;
    f_FixedHeight := FormExtent.Y;
    if (f_FixedHeight < 0) then
     f_FixedHeight := 300;
    while (f_FixedHeight < l_MaxHeight) do
    begin
     try
      VisitText;
     except
      ToLog('Form height = ' + IntToStr(f_FixedHeight));
      raise;
     end;//try..except
     Inc(f_FixedHeight);
    end;//f_FixedHeight < l_MaxHeight
   end//l_MaxHeight > 0
   else
    VisitText;
  finally
   l_SI.Font.Size := l_Size;
  end;//try..finally
 finally
  FreeAndNil(l_SI);
 end;//try..finally
//#UC END# *4BE131BC038E_4BE425C70228_impl*
end;//TTextEditorVisitor.DoIt

function TTextEditorVisitor.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4BE425C70228_var*
//#UC END# *4C07AC6F036D_4BE425C70228_var*
begin
//#UC START# *4C07AC6F036D_4BE425C70228_impl*
 Result := 0;
//#UC END# *4C07AC6F036D_4BE425C70228_impl*
end;//TTextEditorVisitor.GetNormalFontSize

function TTextEditorVisitor.MaxHeight: Integer;
 {* Если возвращается не 0, то будет организован цикл подбора высоты от FormExtent.Y до MaxHeight }
//#UC START# *4C0E56F000A4_4BE425C70228_var*
//#UC END# *4C0E56F000A4_4BE425C70228_var*
begin
//#UC START# *4C0E56F000A4_4BE425C70228_impl*
 Result := 0;
//#UC END# *4C0E56F000A4_4BE425C70228_impl*
end;//TTextEditorVisitor.MaxHeight

function TTextEditorVisitor.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TTextEditorVisitor.GetFolder

function TTextEditorVisitor.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BE425C70228';
end;//TTextEditorVisitor.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
