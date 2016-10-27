unit nsQuestionsWithChoices;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\nsQuestionsWithChoices.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsQuestionsWithChoices" MUID: (4F9BB14900E7)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки Questions }
 str_ChangedDocumentOnControl_SettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangedDocumentOnControl_SettingsCaption'; rValue : 'Действие при выборе измененного документа на контроле');
  {* 'Действие при выборе измененного документа на контроле' }
 str_ChangedDocumentOnControl: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ChangedDocumentOnControl'; rValue : 'В документ на контроле внесены изменения. Выберите действие:');
  {* 'В документ на контроле внесены изменения. Выберите действие:' }
 str_SearchUnresolvedContext: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'SearchUnresolvedContext'; rValue : 'В запросе есть слова, поиск по которым может не дать корректного результата: {color:Red}{italic:true}%s{italic}{color}.');
  {* 'В запросе есть слова, поиск по которым может не дать корректного результата: [color:Red][italic:true]%s[italic][color].' }
 str_DropListToList: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'DropListToList'; rValue : 'Выделенные элементы:');
  {* 'Выделенные элементы:' }
 str_mtNotGarantDomain: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'mtNotGarantDomain'; rValue : 'Переход по внешней ссылке');
  {* 'Переход по внешней ссылке' }
 str_EmptySearchResultInBaseList: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'EmptySearchResultInBaseList'; rValue : 'Поиск в базовом (сокращенном) списке не дал результатов по заданному Вами запросу. Выберите варианты для продолжения работы:');
  {* 'Поиск в базовом (сокращенном) списке не дал результатов по заданному Вами запросу. Выберите варианты для продолжения работы:' }
 str_AutologinDuplicate: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'AutologinDuplicate'; rValue : 'Пользователь с таким именем уже существует. Сделайте выбор:');
  {* 'Пользователь с таким именем уже существует. Сделайте выбор:' }

implementation

uses
 l3ImplUses
 , l3MessageID
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4F9BB14900E7impl_uses*
 //#UC END# *4F9BB14900E7impl_uses*
;

const
 {* Варианты выбора для диалога ChangedDocumentOnControl }
 str_ChangedDocumentOnControl_Choice_Open: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangedDocumentOnControl_Choice_Open'; rValue : 'Открыть текст документа');
  {* 'Открыть текст документа' }
 str_ChangedDocumentOnControl_Choice_Compare: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangedDocumentOnControl_Choice_Compare'; rValue : 'Сравнить с предыдущей редакцией');
  {* 'Сравнить с предыдущей редакцией' }
 {* Варианты выбора для диалога SearchUnresolvedContext }
 str_SearchUnresolvedContext_Choice_Back: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'SearchUnresolvedContext_Choice_Back'; rValue : 'Вернуться в карточку и отредактировать запрос');
  {* 'Вернуться в карточку и отредактировать запрос' }
 str_SearchUnresolvedContext_Choice_Continue: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'SearchUnresolvedContext_Choice_Continue'; rValue : 'Продолжить поиск');
  {* 'Продолжить поиск' }
 {* Варианты выбора для диалога DropListToList }
 str_DropListToList_Choice_Append: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DropListToList_Choice_Append'; rValue : 'Добавить в существующий список');
  {* 'Добавить в существующий список' }
 str_DropListToList_Choice_Copy: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DropListToList_Choice_Copy'; rValue : 'Копировать в новый список');
  {* 'Копировать в новый список' }
 {* Варианты выбора для диалога mtNotGarantDomain }
 str_mtNotGarantDomain_Choice_Open: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mtNotGarantDomain_Choice_Open'; rValue : 'Перейти, открыв во внешнем браузере ');
  {* 'Перейти, открыв во внешнем браузере ' }
 str_mtNotGarantDomain_Choice_Stay: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mtNotGarantDomain_Choice_Stay'; rValue : 'Не переходить');
  {* 'Не переходить' }
 {* Варианты выбора для диалога EmptySearchResultInBaseList }
 str_EmptySearchResultInBaseList_Choice_Expand: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'EmptySearchResultInBaseList_Choice_Expand'; rValue : 'расширить базовый список до полного и произвести поиск в нем');
  {* 'расширить базовый список до полного и произвести поиск в нем' }
 str_EmptySearchResultInBaseList_Choice_AllBase: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'EmptySearchResultInBaseList_Choice_AllBase'; rValue : 'произвести поиск по всему информационному банку');
  {* 'произвести поиск по всему информационному банку' }
 {* Варианты выбора для диалога AutologinDuplicate }
 str_AutologinDuplicate_Choice_Back: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AutologinDuplicate_Choice_Back'; rValue : 'вернуться к регистрации нового пользователя, изменив регистрационные данные');
  {* 'вернуться к регистрации нового пользователя, изменив регистрационные данные' }
 str_AutologinDuplicate_Choice_Login: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AutologinDuplicate_Choice_Login'; rValue : 'войти в систему с указанными регистрационными данными, использовав введенное имя пользователя');
  {* 'войти в систему с указанными регистрационными данными, использовав введенное имя пользователя' }

initialization
 str_ChangedDocumentOnControl_SettingsCaption.Init;
 {* Инициализация str_ChangedDocumentOnControl_SettingsCaption }
 str_ChangedDocumentOnControl.Init;
 str_ChangedDocumentOnControl.AddChoice(str_ChangedDocumentOnControl_Choice_Open);
 str_ChangedDocumentOnControl.AddChoice(str_ChangedDocumentOnControl_Choice_Compare);
 str_ChangedDocumentOnControl.SetSettingsCaption(str_ChangedDocumentOnControl_SettingsCaption);
 str_ChangedDocumentOnControl.SetDlgType(mtConfirmation);
 {* Инициализация str_ChangedDocumentOnControl }
 str_SearchUnresolvedContext.Init;
 str_SearchUnresolvedContext.AddChoice(str_SearchUnresolvedContext_Choice_Back);
 str_SearchUnresolvedContext.AddChoice(str_SearchUnresolvedContext_Choice_Continue);
 str_SearchUnresolvedContext.SetDlgType(mtConfirmation);
 {* Инициализация str_SearchUnresolvedContext }
 str_DropListToList.Init;
 str_DropListToList.AddChoice(str_DropListToList_Choice_Append);
 str_DropListToList.AddChoice(str_DropListToList_Choice_Copy);
 str_DropListToList.SetDlgType(mtConfirmation);
 {* Инициализация str_DropListToList }
 str_mtNotGarantDomain.Init;
 str_mtNotGarantDomain.AddChoice(str_mtNotGarantDomain_Choice_Open);
 str_mtNotGarantDomain.AddChoice(str_mtNotGarantDomain_Choice_Stay);
 str_mtNotGarantDomain.SetDlgType(mtConfirmation);
 {* Инициализация str_mtNotGarantDomain }
 str_EmptySearchResultInBaseList.Init;
 str_EmptySearchResultInBaseList.AddChoice(str_EmptySearchResultInBaseList_Choice_Expand);
 str_EmptySearchResultInBaseList.AddChoice(str_EmptySearchResultInBaseList_Choice_AllBase);
 str_EmptySearchResultInBaseList.SetDlgType(mtConfirmation);
 {* Инициализация str_EmptySearchResultInBaseList }
 str_AutologinDuplicate.Init;
 str_AutologinDuplicate.AddChoice(str_AutologinDuplicate_Choice_Back);
 str_AutologinDuplicate.AddChoice(str_AutologinDuplicate_Choice_Login);
 str_AutologinDuplicate.SetDlgType(mtWarning);
 {* Инициализация str_AutologinDuplicate }
 str_ChangedDocumentOnControl_Choice_Open.Init;
 {* Инициализация str_ChangedDocumentOnControl_Choice_Open }
 str_ChangedDocumentOnControl_Choice_Compare.Init;
 {* Инициализация str_ChangedDocumentOnControl_Choice_Compare }
 str_SearchUnresolvedContext_Choice_Back.Init;
 {* Инициализация str_SearchUnresolvedContext_Choice_Back }
 str_SearchUnresolvedContext_Choice_Continue.Init;
 {* Инициализация str_SearchUnresolvedContext_Choice_Continue }
 str_DropListToList_Choice_Append.Init;
 {* Инициализация str_DropListToList_Choice_Append }
 str_DropListToList_Choice_Copy.Init;
 {* Инициализация str_DropListToList_Choice_Copy }
 str_mtNotGarantDomain_Choice_Open.Init;
 {* Инициализация str_mtNotGarantDomain_Choice_Open }
 str_mtNotGarantDomain_Choice_Stay.Init;
 {* Инициализация str_mtNotGarantDomain_Choice_Stay }
 str_EmptySearchResultInBaseList_Choice_Expand.Init;
 {* Инициализация str_EmptySearchResultInBaseList_Choice_Expand }
 str_EmptySearchResultInBaseList_Choice_AllBase.Init;
 {* Инициализация str_EmptySearchResultInBaseList_Choice_AllBase }
 str_AutologinDuplicate_Choice_Back.Init;
 {* Инициализация str_AutologinDuplicate_Choice_Back }
 str_AutologinDuplicate_Choice_Login.Init;
 {* Инициализация str_AutologinDuplicate_Choice_Login }

end.
