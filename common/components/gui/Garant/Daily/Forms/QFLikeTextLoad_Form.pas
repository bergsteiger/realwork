unit QFLikeTextLoad_Form;
 {* Форма для работы с КЗ }

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\QFLikeTextLoad_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "QFLikeTextLoad" MUID: (4CA090120212)
// Имя типа: "TQFLikeTextLoadForm"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimTextLoad_Form
 , evQueryCardInt
 , evTextSource
 , evQueryCardEditor
 , evCustomTextSource
 , evCustomEditor
 , vcmInterfaces
 , vcmEntities
;

const
 fm_QFLikeTextLoadForm: TvcmFormDescriptor = (rFormID : (rName : 'QFLikeTextLoadForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TQFLikeTextLoadForm }

type
 TQFLikeTextLoadForm = class;

 QFLikeTextLoadFormDef = interface
  {* Идентификатор формы QFLikeTextLoad }
  ['{41C944FD-8129-43F8-89E8-75E7D231D870}']
 end;//QFLikeTextLoadFormDef

 TQFLikeTextLoadForm = {final} class(TPrimTextLoadForm, QFLikeTextLoadFormDef)
  {* Форма для работы с КЗ }
   Entities : TvcmEntities;
  private
   f_QueryCard: IevQueryCard;
   f_TextSource: TevTextSource;
   f_Text: TevQueryCardEditor;
  protected
   function pm_GetTextSource: TevCustomTextSource; override;
   function pm_GetText: TevCustomEditor; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   procedure MakeControls; override;
  public
   procedure AfterLoad; override;
  public
   property TextSource: TevTextSource
    read f_TextSource;
   property Text: TevQueryCardEditor
    read f_Text;
 end;//TQFLikeTextLoadForm
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , evQueryDocumentContainer
 , evControlContainerEX
 , nevTools
 , l3InterfacesMisc
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , QFLikeTextLoad_ut_QFLikeTextLoad_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , QFLikeTextLoadKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

function TQFLikeTextLoadForm.pm_GetTextSource: TevCustomTextSource;
//#UC START# *4C9B21D20187_4CA090120212get_var*
//#UC END# *4C9B21D20187_4CA090120212get_var*
begin
//#UC START# *4C9B21D20187_4CA090120212get_impl*
 Result := TextSource;
//#UC END# *4C9B21D20187_4CA090120212get_impl*
end;//TQFLikeTextLoadForm.pm_GetTextSource

function TQFLikeTextLoadForm.pm_GetText: TevCustomEditor;
//#UC START# *4C9B21E400A4_4CA090120212get_var*
//#UC END# *4C9B21E400A4_4CA090120212get_var*
begin
//#UC START# *4C9B21E400A4_4CA090120212get_impl*
 Result := Text;
//#UC END# *4C9B21E400A4_4CA090120212get_impl*
end;//TQFLikeTextLoadForm.pm_GetText

procedure TQFLikeTextLoadForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4CA090120212_var*
//#UC END# *479731C50290_4CA090120212_var*
begin
//#UC START# *479731C50290_4CA090120212_impl*
 inherited;
 f_QueryCard := nil;
//#UC END# *479731C50290_4CA090120212_impl*
end;//TQFLikeTextLoadForm.Cleanup

procedure TQFLikeTextLoadForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4CA090120212_var*
//#UC END# *4A8E8F2E0195_4CA090120212_var*
begin
//#UC START# *4A8E8F2E0195_4CA090120212_impl*
 inherited;
 f_TextSource.DocumentContainer := TevQueryDocumentContainer.Make;
//#UC END# *4A8E8F2E0195_4CA090120212_impl*
end;//TQFLikeTextLoadForm.InitControls

procedure TQFLikeTextLoadForm.AfterLoad;
//#UC START# *4F15435202B5_4CA090120212_var*
var
 l_Cont: InevQueryDocumentContainer;
//#UC END# *4F15435202B5_4CA090120212_var*
begin
//#UC START# *4F15435202B5_4CA090120212_impl*
 f_QueryCard := TevControlContainerEX.Make;
 if l3IOk(f_TextSource.DocumentContainer.QueryInterface(InevQueryDocumentContainer, l_Cont)) then
  f_QueryCard.LinkView(l_Cont);
//#UC END# *4F15435202B5_4CA090120212_impl*
end;//TQFLikeTextLoadForm.AfterLoad

procedure TQFLikeTextLoadForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_QFLikeTextLoadName,
  str_ut_QFLikeTextLoadCaption,
  str_ut_QFLikeTextLoadCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_QFLikeTextLoadName
 f_TextSource := TevTextSource.Create(Self);
 f_TextSource.Name := 'TextSource';
 f_Text := TevQueryCardEditor.Create(Self);
 f_Text.Name := 'Text';
 f_Text.Parent := Self;
end;//TQFLikeTextLoadForm.MakeControls

initialization
 fm_QFLikeTextLoadForm.SetFactory(TQFLikeTextLoadForm.Make);
 {* Регистрация фабрики формы QFLikeTextLoad }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TQFLikeTextLoadForm);
 {* Регистрация QFLikeTextLoad }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
