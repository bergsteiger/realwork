unit nsQuestionsWithChoices;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/nsQuestionsWithChoices.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Сюда вынес все сообщения из StdRes с Choices::nsQuestionsWithChoices
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3StringIDEx,
  l3MessageID
  ;

var
  { Локализуемые строки Questions }
 str_ChangedDocumentOnControl : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ChangedDocumentOnControl'; rValue : 'В документ на контроле внесены изменения. Выберите действие:');
  { 'В документ на контроле внесены изменения. Выберите действие:' }
 str_SearchUnresolvedContext : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'SearchUnresolvedContext'; rValue : 'В запросе есть слова, поиск по которым может не дать корректного результата: {color:Red}{italic:true}%s{italic}{color}.');
  { 'В запросе есть слова, поиск по которым может не дать корректного результата: [color:Red][italic:true]%s[italic][color].' }
 str_DropListToList : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'DropListToList'; rValue : 'Выделенные элементы:');
  { 'Выделенные элементы:' }
 str_mtNotGarantDomain : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'mtNotGarantDomain'; rValue : 'Переход по внешней ссылке');
  { 'Переход по внешней ссылке' }
 str_EmptySearchResultInBaseList : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'EmptySearchResultInBaseList'; rValue : 'Поиск в базовом (сокращенном) списке не дал результатов по заданному Вами запросу. Выберите варианты для продолжения работы:');
  { 'Поиск в базовом (сокращенном) списке не дал результатов по заданному Вами запросу. Выберите варианты для продолжения работы:' }
 str_AutologinDuplicate : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'AutologinDuplicate'; rValue : 'Пользователь с таким именем уже существует. Сделайте выбор:');
  { 'Пользователь с таким именем уже существует. Сделайте выбор:' }
 str_ChangedDocumentOnControl_SettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangedDocumentOnControl_SettingsCaption'; rValue : 'Действие при выборе измененного документа на контроле');
  { undefined }

implementation

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  
  ;

var
  { Варианты выбора для диалога ChangedDocumentOnControl }
 str_ChangedDocumentOnControl_Choice_Open : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangedDocumentOnControl_Choice_Open'; rValue : 'Открыть текст документа');
  { 'Открыть текст документа' }
 str_ChangedDocumentOnControl_Choice_Compare : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangedDocumentOnControl_Choice_Compare'; rValue : 'Сравнить с предыдущей редакцией');
  { 'Сравнить с предыдущей редакцией' }

var
  { Варианты выбора для диалога SearchUnresolvedContext }
 str_SearchUnresolvedContext_Choice_Back : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'SearchUnresolvedContext_Choice_Back'; rValue : 'Вернуться в карточку и отредактировать запрос');
  { 'Вернуться в карточку и отредактировать запрос' }
 str_SearchUnresolvedContext_Choice_Continue : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'SearchUnresolvedContext_Choice_Continue'; rValue : 'Продолжить поиск');
  { 'Продолжить поиск' }

var
  { Варианты выбора для диалога DropListToList }
 str_DropListToList_Choice_Append : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DropListToList_Choice_Append'; rValue : 'Добавить в существующий список');
  { 'Добавить в существующий список' }
 str_DropListToList_Choice_Copy : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DropListToList_Choice_Copy'; rValue : 'Копировать в новый список');
  { 'Копировать в новый список' }

var
  { Варианты выбора для диалога mtNotGarantDomain }
 str_mtNotGarantDomain_Choice_Open : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mtNotGarantDomain_Choice_Open'; rValue : 'Перейти, открыв во внешнем браузере ');
  { 'Перейти, открыв во внешнем браузере ' }
 str_mtNotGarantDomain_Choice_Stay : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mtNotGarantDomain_Choice_Stay'; rValue : 'Не переходить');
  { 'Не переходить' }

var
  { Варианты выбора для диалога EmptySearchResultInBaseList }
 str_EmptySearchResultInBaseList_Choice_Expand : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'EmptySearchResultInBaseList_Choice_Expand'; rValue : 'расширить базовый список до полного и произвести поиск в нем');
  { 'расширить базовый список до полного и произвести поиск в нем' }
 str_EmptySearchResultInBaseList_Choice_AllBase : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'EmptySearchResultInBaseList_Choice_AllBase'; rValue : 'произвести поиск по всему информационному банку');
  { 'произвести поиск по всему информационному банку' }

var
  { Варианты выбора для диалога AutologinDuplicate }
 str_AutologinDuplicate_Choice_Back : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AutologinDuplicate_Choice_Back'; rValue : 'вернуться к регистрации нового пользователя, изменив регистрационные данные');
  { 'вернуться к регистрации нового пользователя, изменив регистрационные данные' }
 str_AutologinDuplicate_Choice_Login : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AutologinDuplicate_Choice_Login'; rValue : 'войти в систему с указанными регистрационными данными, использовав введенное имя пользователя');
  { 'войти в систему с указанными регистрационными данными, использовав введенное имя пользователя' }


initialization
// Инициализация str_ChangedDocumentOnControl_Choice_Open
 str_ChangedDocumentOnControl_Choice_Open.Init;
// Инициализация str_ChangedDocumentOnControl_Choice_Compare
 str_ChangedDocumentOnControl_Choice_Compare.Init;
// Инициализация str_SearchUnresolvedContext_Choice_Back
 str_SearchUnresolvedContext_Choice_Back.Init;
// Инициализация str_SearchUnresolvedContext_Choice_Continue
 str_SearchUnresolvedContext_Choice_Continue.Init;
// Инициализация str_DropListToList_Choice_Append
 str_DropListToList_Choice_Append.Init;
// Инициализация str_DropListToList_Choice_Copy
 str_DropListToList_Choice_Copy.Init;
// Инициализация str_mtNotGarantDomain_Choice_Open
 str_mtNotGarantDomain_Choice_Open.Init;
// Инициализация str_mtNotGarantDomain_Choice_Stay
 str_mtNotGarantDomain_Choice_Stay.Init;
// Инициализация str_EmptySearchResultInBaseList_Choice_Expand
 str_EmptySearchResultInBaseList_Choice_Expand.Init;
// Инициализация str_EmptySearchResultInBaseList_Choice_AllBase
 str_EmptySearchResultInBaseList_Choice_AllBase.Init;
// Инициализация str_AutologinDuplicate_Choice_Back
 str_AutologinDuplicate_Choice_Back.Init;
// Инициализация str_AutologinDuplicate_Choice_Login
 str_AutologinDuplicate_Choice_Login.Init;
// Инициализация str_ChangedDocumentOnControl
 str_ChangedDocumentOnControl.Init;
 str_ChangedDocumentOnControl.AddChoice(str_ChangedDocumentOnControl_Choice_Open);
 str_ChangedDocumentOnControl.AddChoice(str_ChangedDocumentOnControl_Choice_Compare);
 str_ChangedDocumentOnControl.SetDlgType(mtConfirmation);
 str_ChangedDocumentOnControl.SetSettingsCaption(str_ChangedDocumentOnControl_SettingsCaption);
// Инициализация str_SearchUnresolvedContext
 str_SearchUnresolvedContext.Init;
 str_SearchUnresolvedContext.AddChoice(str_SearchUnresolvedContext_Choice_Back);
 str_SearchUnresolvedContext.AddChoice(str_SearchUnresolvedContext_Choice_Continue);
 str_SearchUnresolvedContext.SetDlgType(mtConfirmation);
// Инициализация str_DropListToList
 str_DropListToList.Init;
 str_DropListToList.AddChoice(str_DropListToList_Choice_Append);
 str_DropListToList.AddChoice(str_DropListToList_Choice_Copy);
 str_DropListToList.SetDlgType(mtConfirmation);
// Инициализация str_mtNotGarantDomain
 str_mtNotGarantDomain.Init;
 str_mtNotGarantDomain.AddChoice(str_mtNotGarantDomain_Choice_Open);
 str_mtNotGarantDomain.AddChoice(str_mtNotGarantDomain_Choice_Stay);
 str_mtNotGarantDomain.SetDlgType(mtConfirmation);
// Инициализация str_EmptySearchResultInBaseList
 str_EmptySearchResultInBaseList.Init;
 str_EmptySearchResultInBaseList.AddChoice(str_EmptySearchResultInBaseList_Choice_Expand);
 str_EmptySearchResultInBaseList.AddChoice(str_EmptySearchResultInBaseList_Choice_AllBase);
 str_EmptySearchResultInBaseList.SetDlgType(mtConfirmation);
// Инициализация str_AutologinDuplicate
 str_AutologinDuplicate.Init;
 str_AutologinDuplicate.AddChoice(str_AutologinDuplicate_Choice_Back);
 str_AutologinDuplicate.AddChoice(str_AutologinDuplicate_Choice_Login);
 str_AutologinDuplicate.SetDlgType(mtWarning);
// Инициализация str_ChangedDocumentOnControl_SettingsCaption
 str_ChangedDocumentOnControl_SettingsCaption.Init;

end.