unit TextViaEditorProcessorPrim;

interface

uses
 l3IntfUses
 , VCMBaseTest
 , PrimTextLoad_Form
 , nevTools
;

type
 TTextViaEditorProcessorPrim = class(TVCMBaseTest)
  {* Обработчик текста через редактор }
  procedure Load(aForm: TPrimTextLoadForm;
   const aFileName: AnsiString;
   const aStr: AnsiString);
   {* Загружает документ в редактор указанной формы }
  procedure Save(aForm: TPrimTextLoadForm);
   {* Сохраняет текст из редактора в стандартный выходной файл }
  procedure Scroll(aForm: TPrimTextLoadForm;
   const aSubName: AnsiString);
  procedure ScrollBack(aForm: TPrimTextLoadForm;
   const aSubName: AnsiString);
   {* Скроллирует текст в обратном направлении }
  procedure ScrollByWeel(aForm: TPrimTextLoadForm;
   aCount: Integer;
   aGoTop: Boolean);
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
  function ScrollByPage: Boolean;
  function WebStyle: Boolean;
  function SendKey: Boolean;
   {* Управлять ли окном реактора посредсвом посылки клавиш, а не вызова методов редактора }
  procedure CheckTopAnchor(const aView: InevInputView);
   {* проверить якорь начала отрисовки после окончания прокрутки }
  function F1Like: Boolean;
  function QFLike: Boolean;
   {* Создать форму-редактор для работы с КЗ. }
  procedure DoBeforeLoad(aForm: TPrimTextLoadForm);
   {* Операции предшествующие загрузке документа }
  function AllowMultiSelect: Boolean;
   {* Разершить мультивыделение. }
  function WithBaseSearch: Boolean;
   {* Форма со строкой базового поиска. }
 end;//TTextViaEditorProcessorPrim
 
implementation

uses
 l3ImplUses
 , TextLoad_Form
 , evdSchema
 , F1LikeTextLoad_Form
 , QFLikeTextLoad_Form
 , F1LikeFormWithBS_Form
 , TestFrameWork
 , vcmBase
 , SysUtils
 , Forms
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
;

end.
