unit TextViaEditorProcessorPrim;
 {* Обработчик текста через редактор }

// Модуль: "w:\common\components\gui\Garant\Daily\TextViaEditorProcessorPrim.pas"
// Стереотип: "TestCase"
// Элемент модели: "TTextViaEditorProcessorPrim" MUID: (4BE047320379)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)}
 , VCMBaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)
 , PrimTextLoad_Form
 , nevTools
 , Types
;

type
 _FormClass_ = TPrimTextLoadForm;
 _FormProducer_Parent_ = TVCMBaseTest;
 {$Include w:\common\components\gui\Garant\Daily\FormProducer.imp.pas}
 TTextViaEditorProcessorPrim = {abstract} class(_FormProducer_)
  {* Обработчик текста через редактор }
  private
   f_ScrollCount: Integer;
    {* Количество прокруток до конца документа }
  protected
   procedure Load(aForm: TPrimTextLoadForm;
    const aFileName: AnsiString;
    const aStr: AnsiString = 'Load');
    {* Загружает документ в редактор указанной формы }
   procedure Save(aForm: TPrimTextLoadForm); virtual;
    {* Сохраняет текст из редактора в стандартный выходной файл }
   procedure Scroll(aForm: TPrimTextLoadForm;
    const aSubName: AnsiString);
   procedure ScrollBack(aForm: TPrimTextLoadForm;
    const aSubName: AnsiString);
    {* Скроллирует текст в обратном направлении }
   procedure ScrollByWeel(aForm: TPrimTextLoadForm;
    aCount: Integer;
    aGoTop: Boolean = True);
    {* Прокрутить заданное число раз с помощью колеса мыши }
   procedure ScrollByLine(aForm: TPrimTextLoadForm;
    aCount: Integer;
    aUp: Boolean;
    aFromBottom: Boolean);
    {* Прокручивать построчно заданное число раз вверх или вниз }
   procedure GotoDocumentBottom(aForm: TPrimTextLoadForm);
    {* Перейти в конец документа }
   procedure PageUp(aForm: TPrimTextLoadForm);
    {* Перейти на страницу вверх }
   procedure PageDown(aForm: TPrimTextLoadForm);
   function ScrollByPage: Boolean; virtual;
   function WebStyle: Boolean; virtual;
   function SendKey: Boolean; virtual;
    {* Управлять ли окном реактора посредсвом посылки клавиш, а не вызова методов редактора }
   procedure CheckTopAnchor(const aView: InevInputView); virtual;
    {* проверить якорь начала отрисовки после окончания прокрутки }
   function F1Like: Boolean; virtual;
   function QFLike: Boolean; virtual;
    {* Создать форму-редактор для работы с КЗ. }
   procedure DoBeforeLoad(aForm: TPrimTextLoadForm); virtual;
    {* Операции предшествующие загрузке документа }
   function AllowMultiSelect: Boolean; virtual;
    {* Разершить мультивыделение. }
   function WithBaseSearch: Boolean; virtual;
    {* Форма со строкой базового поиска. }
   procedure FormMade(const aForm: _FormClass_); override;
   function MakeFormClass: FormClassRef; override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  public
   property ScrollCount: Integer
    read f_ScrollCount;
    {* Количество прокруток до конца документа }
 end;//TTextViaEditorProcessorPrim
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TextLoad_Form
 , evdSchema
 , F1LikeTextLoad_Form
 , QFLikeTextLoad_Form
 , F1LikeFormWithBS_Form
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 , Document_Const
 , k2OperationContainer
 , evdNativeWriter
 , l3Filer
 , evOp
 , l3InternalInterfaces
 , Windows
 , evCustomEditorWindow
 , Messages
 , TestFrameWork
 , TextLoad_ut_TextLoad_UserType
 , F1LikeTextLoad_ut_F1LikeTextLoad_UserType
 , QFLikeTextLoad_ut_QFLikeTextLoad_UserType
 , F1LikeFormWithBS_ut_F1LikeFormWithBS_UserType
;

{$If NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)}
{$Include w:\common\components\gui\Garant\Daily\FormProducer.imp.pas}

procedure TTextViaEditorProcessorPrim.Load(aForm: TPrimTextLoadForm;
 const aFileName: AnsiString;
 const aStr: AnsiString = 'Load');
 {* Загружает документ в редактор указанной формы }
//#UC START# *4B32454100D9_4BE047320379_var*
//#UC END# *4B32454100D9_4BE047320379_var*
begin
//#UC START# *4B32454100D9_4BE047320379_impl*
 with aForm do
 begin
  DoBeforeLoad(aForm);
  LoadManager.FileName := FileFromCurrent(aFileName);
  StartTimer;
  try
   LoadManager.Load(TextSource, k2_typDocument);
  finally
   StopTimer(aStr);
  end;//try..finally
 end;//with aForm
 Check(not Tk2OperationContainer.CheckWasExceptionInFreeInOwner);
//#UC END# *4B32454100D9_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.Load

procedure TTextViaEditorProcessorPrim.Save(aForm: TPrimTextLoadForm);
 {* Сохраняет текст из редактора в стандартный выходной файл }
//#UC START# *4BE12AEE0190_4BE047320379_var*
var
 l_Writer : TevdNativeWriter;
 l_Filer  : Tl3CustomFiler;
//#UC END# *4BE12AEE0190_4BE047320379_var*
begin
//#UC START# *4BE12AEE0190_4BE047320379_impl*
 l_Writer := TevdNativeWriter.Create;
 try
  l_Writer.Binary := false;
  l_Filer := FilerForOutput;
  try
   l_Writer.Filer := l_Filer;
  finally
   FreeAndNil(l_Filer);
  end;//try..finally
  aForm.TextSource.Save(l_Writer);
 finally
  FreeAndNil(l_Writer);
 end;//try..finally
//#UC END# *4BE12AEE0190_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.Save

procedure TTextViaEditorProcessorPrim.Scroll(aForm: TPrimTextLoadForm;
 const aSubName: AnsiString);
//#UC START# *4B32450B0166_4BE047320379_var*
var
 l_Now : Cardinal;
//#UC END# *4B32450B0166_4BE047320379_var*
begin
//#UC START# *4B32450B0166_4BE047320379_impl*
 with aForm do
 begin
  if (Text.View <> nil) then
  begin
   Il3CommandTarget(Text).ProcessCommand(ev_ocTopLeft, true, 1);
   l_Now := StartTimer;
   try
    try
     f_ScrollCount := 0;
     while not Text.View.IsDocumentTailVisible do
     begin
      if ScrollByPage then
      begin
       if SendKey then
       begin
        PostMessage(Text.Handle, $100, $22, $1510001); //Зажали PgDown
        Inc(f_ScrollCount);
       end
       else
       if Il3CommandTarget(Text).ProcessCommand(ev_ocPageDown, true, 1) then
        Inc(f_ScrollCount)
       else
        break;
      end//ScrollByPage
      else
       Text.Perform(WM_VScroll, SB_WheelDown, 0);
      Application.ProcessMessages;
      CheckTimeout(l_Now, 20 * 60 * 1000);
      if ShouldStop then Break;
     end;//while not Text.View.IsDocumentTailVisible
    finally
     if ScrollByPage then
      if SendKey then
       PostMessage(Text.Handle, $101, $22, $1510001); //Отжали PgDown
    end;//try..finally
    Application.ProcessMessages;
   finally
    StopTimer('Scroll', aSubName);
   end;//try..finally
  end;//Text.View <> nil
 end;//with aForm
//#UC END# *4B32450B0166_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.Scroll

procedure TTextViaEditorProcessorPrim.ScrollBack(aForm: TPrimTextLoadForm;
 const aSubName: AnsiString);
 {* Скроллирует текст в обратном направлении }
//#UC START# *4BFBDAB2035D_4BE047320379_var*
var
 l_Now : Cardinal;
//#UC END# *4BFBDAB2035D_4BE047320379_var*
begin
//#UC START# *4BFBDAB2035D_4BE047320379_impl*
 with aForm do
 begin
  if (Text.View <> nil) then
  begin
   GotoDocumentBottom(aForm);
   l_Now := StartTimer;
   try
    while not Text.View.TopAnchor.AtStart{.IsDocumentTailVisible} do
    begin
//     PostMessage(Text.Handle, $100, $22, $1510001); //Зажали PgDown
     if ScrollByPage then
     begin
      if not Il3CommandTarget(Text).ProcessCommand(ev_ocPageUp, true, 1) then
       break;
     end//ScrollByPage
     else
      Text.Perform(WM_VScroll, SB_WheelUp, 0);
     Application.ProcessMessages;
     CheckTimeout(l_Now, 20 * 60 * 1000);
     if ShouldStop then Break;
    end;//while not Text.View.IsDocumentTailVisible
//    PostMessage(Text.Handle, $101, $22, $1510001); //Отжали PgDown
    Application.ProcessMessages;
   finally
    StopTimer('ScrollBack', aSubName);
   end;//try..finally
  end;//Text.View <> nil
 end;//with aForm
//#UC END# *4BFBDAB2035D_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.ScrollBack

procedure TTextViaEditorProcessorPrim.ScrollByWeel(aForm: TPrimTextLoadForm;
 aCount: Integer;
 aGoTop: Boolean = True);
 {* Прокрутить заданное число раз с помощью колеса мыши }
//#UC START# *4BFE3A4003B5_4BE047320379_var*
var
 i: Integer;
//#UC END# *4BFE3A4003B5_4BE047320379_var*
begin
//#UC START# *4BFE3A4003B5_4BE047320379_impl*
 with aForm do
 begin
  if aGoTop then
   Il3CommandTarget(Text).ProcessCommand(ev_ocTopLeft, true, 1);
  for i := 0 to aCount - 1 do
  begin
   Text.Perform(WM_VScroll, SB_WheelDown, 0);
   Application.ProcessMessages;
   if ShouldStop then Break;
  end;
 end; // with aForm do
//#UC END# *4BFE3A4003B5_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.ScrollByWeel

procedure TTextViaEditorProcessorPrim.ScrollByLine(aForm: TPrimTextLoadForm;
 aCount: Integer;
 aUp: Boolean;
 aFromBottom: Boolean);
 {* Прокручивать построчно заданное число раз вверх или вниз }
//#UC START# *4C1B176A0067_4BE047320379_var*
var
 i: Integer;
//#UC END# *4C1B176A0067_4BE047320379_var*
begin
//#UC START# *4C1B176A0067_4BE047320379_impl*
 with aForm do
 begin
  if aFromBottom and aUp then
   GotoDocumentBottom(aForm);
  if aCount > 0 then
   if aUp then
    for i := 0 to aCount - 1 do
    begin
     aForm.Text.View.Scroller[True].LineUp(1);
     Application.ProcessMessages;
     if ShouldStop then Break;
    end // for i := 0 to aCount - 1 do
   else
    for i := 0 to aCount - 1 do
    begin
     aForm.Text.View.Scroller[True].LineDown(1);
     Application.ProcessMessages;
     if ShouldStop then Break;
    end // for i := 0 to aCount - 1 do
  else
   if aCount < 0 then
    if aUp then
     while not Text.View.TopAnchor.AtStart do
     begin
      aForm.Text.View.Scroller[True].LineUp(1);
      Application.ProcessMessages;
      CheckTopAnchor(aForm.Text.View);
      if ShouldStop then Break;
     end
    else
     while not Text.View.IsDocumentTailVisible do
     begin
      aForm.Text.View.Scroller[True].LineDown(1);
      Application.ProcessMessages;
      CheckTopAnchor(aForm.Text.View);
      if ShouldStop then Break;
     end;
 end; // with aForm do
//#UC END# *4C1B176A0067_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.ScrollByLine

procedure TTextViaEditorProcessorPrim.GotoDocumentBottom(aForm: TPrimTextLoadForm);
 {* Перейти в конец документа }
//#UC START# *4C46F482017F_4BE047320379_var*
//#UC END# *4C46F482017F_4BE047320379_var*
begin
//#UC START# *4C46F482017F_4BE047320379_impl*
 if QFLike then
 // - иначе редактор КЗ это как-то по-своему обрабатывает
  aForm.Text.View.Caret.Bottom
 else
  Il3CommandTarget(aForm.Text).ProcessCommand(ev_ocBottomRight, true, 1);
//#UC END# *4C46F482017F_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.GotoDocumentBottom

procedure TTextViaEditorProcessorPrim.PageUp(aForm: TPrimTextLoadForm);
 {* Перейти на страницу вверх }
//#UC START# *4C46F88F039A_4BE047320379_var*
//#UC END# *4C46F88F039A_4BE047320379_var*
begin
//#UC START# *4C46F88F039A_4BE047320379_impl*
 Il3CommandTarget(aForm.Text).ProcessCommand(ev_ocPageUp, true, 1);
//#UC END# *4C46F88F039A_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.PageUp

procedure TTextViaEditorProcessorPrim.PageDown(aForm: TPrimTextLoadForm);
//#UC START# *4D6B8501002F_4BE047320379_var*
//#UC END# *4D6B8501002F_4BE047320379_var*
begin
//#UC START# *4D6B8501002F_4BE047320379_impl*
 Il3CommandTarget(aForm.Text).ProcessCommand(ev_ocPageDown, true, 1);
//#UC END# *4D6B8501002F_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.PageDown

function TTextViaEditorProcessorPrim.ScrollByPage: Boolean;
//#UC START# *4BEBFE020080_4BE047320379_var*
//#UC END# *4BEBFE020080_4BE047320379_var*
begin
//#UC START# *4BEBFE020080_4BE047320379_impl*
 Result := true;
//#UC END# *4BEBFE020080_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.ScrollByPage

function TTextViaEditorProcessorPrim.WebStyle: Boolean;
//#UC START# *4C08CF4300BE_4BE047320379_var*
//#UC END# *4C08CF4300BE_4BE047320379_var*
begin
//#UC START# *4C08CF4300BE_4BE047320379_impl*
 Result := true;
//#UC END# *4C08CF4300BE_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.WebStyle

function TTextViaEditorProcessorPrim.SendKey: Boolean;
 {* Управлять ли окном реактора посредсвом посылки клавиш, а не вызова методов редактора }
//#UC START# *4C091B9A0305_4BE047320379_var*
//#UC END# *4C091B9A0305_4BE047320379_var*
begin
//#UC START# *4C091B9A0305_4BE047320379_impl*
 Result := false;
//#UC END# *4C091B9A0305_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.SendKey

procedure TTextViaEditorProcessorPrim.CheckTopAnchor(const aView: InevInputView);
 {* проверить якорь начала отрисовки после окончания прокрутки }
//#UC START# *4C1F0A260192_4BE047320379_var*
//#UC END# *4C1F0A260192_4BE047320379_var*
begin
//#UC START# *4C1F0A260192_4BE047320379_impl*
//#UC END# *4C1F0A260192_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.CheckTopAnchor

function TTextViaEditorProcessorPrim.F1Like: Boolean;
//#UC START# *4C9B31F6015E_4BE047320379_var*
//#UC END# *4C9B31F6015E_4BE047320379_var*
begin
//#UC START# *4C9B31F6015E_4BE047320379_impl*
 Result := false;
//#UC END# *4C9B31F6015E_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.F1Like

function TTextViaEditorProcessorPrim.QFLike: Boolean;
 {* Создать форму-редактор для работы с КЗ. }
//#UC START# *4CA0947C03CE_4BE047320379_var*
//#UC END# *4CA0947C03CE_4BE047320379_var*
begin
//#UC START# *4CA0947C03CE_4BE047320379_impl*
 Result := false;
//#UC END# *4CA0947C03CE_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.QFLike

procedure TTextViaEditorProcessorPrim.DoBeforeLoad(aForm: TPrimTextLoadForm);
 {* Операции предшествующие загрузке документа }
//#UC START# *4CA18D6B0088_4BE047320379_var*
//#UC END# *4CA18D6B0088_4BE047320379_var*
begin
//#UC START# *4CA18D6B0088_4BE047320379_impl*
//#UC END# *4CA18D6B0088_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.DoBeforeLoad

function TTextViaEditorProcessorPrim.AllowMultiSelect: Boolean;
 {* Разершить мультивыделение. }
//#UC START# *4D3EE58C037C_4BE047320379_var*
//#UC END# *4D3EE58C037C_4BE047320379_var*
begin
//#UC START# *4D3EE58C037C_4BE047320379_impl*
 Result := True;
//#UC END# *4D3EE58C037C_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.AllowMultiSelect

function TTextViaEditorProcessorPrim.WithBaseSearch: Boolean;
 {* Форма со строкой базового поиска. }
//#UC START# *4D6CB8460086_4BE047320379_var*
//#UC END# *4D6CB8460086_4BE047320379_var*
begin
//#UC START# *4D6CB8460086_4BE047320379_impl*
 Result := False;
//#UC END# *4D6CB8460086_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.WithBaseSearch

procedure TTextViaEditorProcessorPrim.FormMade(const aForm: _FormClass_);
//#UC START# *4C08D61F0231_4BE047320379_var*
//#UC END# *4C08D61F0231_4BE047320379_var*
begin
//#UC START# *4C08D61F0231_4BE047320379_impl*
 inherited;
 aForm.Text.WebStyle := WebStyle;
 aForm.Text.AllowMultiSelect := AllowMultiSelect;
//#UC END# *4C08D61F0231_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.FormMade

function TTextViaEditorProcessorPrim.MakeFormClass: FormClassRef;
//#UC START# *4C9B2B7F0266_4BE047320379_var*
//#UC END# *4C9B2B7F0266_4BE047320379_var*
begin
//#UC START# *4C9B2B7F0266_4BE047320379_impl*
 if WithBaseSearch then
  Result := TF1LikeFormWithBSForm
 else
 if QFLike then
  Result := TQFLikeTextLoadForm
 else
 if F1Like then
  Result := TF1LikeTextLoadForm
 else
  Result := TTextLoadForm;
//#UC END# *4C9B2B7F0266_4BE047320379_impl*
end;//TTextViaEditorProcessorPrim.MakeFormClass

function TTextViaEditorProcessorPrim.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TTextViaEditorProcessorPrim.GetFolder

function TTextViaEditorProcessorPrim.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BE047320379';
end;//TTextViaEditorProcessorPrim.GetModelElementGUID
{$IfEnd} // NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)
end.
