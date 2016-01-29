unit QFLikeTextLoad_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Forms"
// Модуль: "w:/common/components/gui/Garant/Daily/Forms/QFLikeTextLoad_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Everest::QFLikeTextLoad
//
// Форма для работы с КЗ
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  vcmInterfaces,
  evQueryCardInt,
  evTextSource,
  evQueryCardEditor,
  vcmUserControls,
  l3StringIDEx,
  PrimTextLoad_Form
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  QFLikeTextLoad_ut_QFLikeTextLoad_UserType,
  evCustomTextSource,
  evCustomEditor,
  evLoadDocumentManager,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
const
   { QFLikeTextLoadIDs }
  fm_QFLikeTextLoadForm : TvcmFormDescriptor = (rFormID : (rName : 'QFLikeTextLoadForm'; rID : 0); rFactory : nil);
   { Идентификатор формы TQFLikeTextLoadForm }

type
 QFLikeTextLoadFormDef = interface(IUnknown)
  {* Идентификатор формы QFLikeTextLoad }
   ['{41C944FD-8129-43F8-89E8-75E7D231D870}']
 end;//QFLikeTextLoadFormDef

 TQFLikeTextLoadForm = {final form} class(TPrimTextLoadForm, QFLikeTextLoadFormDef)
  {* Форма для работы с КЗ }
  Entities : TvcmEntities;
 private
 // private fields
   f_QueryCard : IevQueryCard;
   f_TextSource : TevTextSource;
    {* Поле для свойства TextSource}
   f_Text : TevQueryCardEditor;
    {* Поле для свойства Text}
 protected
  procedure MakeControls; override;
 protected
 // realized methods
   function pm_GetTextSource: TevCustomTextSource; override;
   function pm_GetText: TevCustomEditor; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
 public
 // overridden public methods
   procedure AfterLoad; override;
 public
 // public properties
   property TextSource: TevTextSource
     read f_TextSource;
   property Text: TevQueryCardEditor
     read f_Text;
 end;//TQFLikeTextLoadForm
{$IfEnd} //nsTest AND not NoVCM

implementation

{$R *.DFM}

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  evQueryDocumentContainer,
  evControlContainerEX,
  nevTools,
  l3InterfacesMisc
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  QFLikeTextLoadKeywordsPack
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

var
   { Локализуемые строки ut_QFLikeTextLoadLocalConstants }
  str_ut_QFLikeTextLoadCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_QFLikeTextLoadCaption'; rValue : 'Форма для работы с КЗ');
   { Заголовок пользовательского типа "Форма для работы с КЗ" }

// start class TQFLikeTextLoadForm

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
//#UC START# *479731C50290_4CA090120212_var*
//#UC END# *479731C50290_4CA090120212_var*
begin
//#UC START# *479731C50290_4CA090120212_impl*
 inherited;
 f_QueryCard := nil;
//#UC END# *479731C50290_4CA090120212_impl*
end;//TQFLikeTextLoadForm.Cleanup

procedure TQFLikeTextLoadForm.InitControls;
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
 f_TextSource := TevTextSource.Create(Self);
 f_TextSource.Name := 'TextSource';
 f_Text := TevQueryCardEditor.Create(Self);
 f_Text.Name := 'Text';
 f_Text.Parent := Self;
 with AddUsertype(ut_QFLikeTextLoadName,
  str_ut_QFLikeTextLoadCaption,
  str_ut_QFLikeTextLoadCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_QFLikeTextLoadName
end;

{$IfEnd} //nsTest AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация QFLikeTextLoad
 TtfwClassRef.Register(TQFLikeTextLoadForm);
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoVCM)}
// Регистрация фабрики формы QFLikeTextLoad
 fm_QFLikeTextLoadForm.SetFactory(TQFLikeTextLoadForm.Make);
{$IfEnd} //nsTest AND not NoVCM
{$If defined(nsTest) AND not defined(NoVCM)}
// Инициализация str_ut_QFLikeTextLoadCaption
 str_ut_QFLikeTextLoadCaption.Init;
{$IfEnd} //nsTest AND not NoVCM

end.