unit evEditControl;

interface

uses
 l3IntfUses
 , evControl
 , evQueryCardInt
 , evEditorControlList
 , l3Interfaces
 , nevTools
 , nevBase
;

type
 TevEditControl = class(TevControl, IevEditorControlField)
  {* Базовый класс поля редактора }
  procedure DoSynchronizeSelectedValueWithText;
  function GetHasOtherField: Boolean;
  procedure AfterSetText(const Value: Il3CString);
  function GetSelectAllOnFocus: Boolean;
  function GetIsClear: Boolean;
  procedure DoInitOtherField(const aValue: IevEditorControl;
   aIsStart: Boolean);
  procedure DoClearText;
  procedure DoCheckDataText;
  function DoAnalyzeString(const aValue: Il3CString;
   aPos: Integer;
   out aRslt: Il3CString): Boolean;
  function GetIsFieldEmpty: Boolean;
  procedure CheckDataText;
   {* Проверяет введенный текст на корректность. }
  function AnalyzeString(const aValue: Il3CString;
   aPos: Integer;
   out aRslt: Il3CString): Boolean;
   {* Анализ добавленной строки, если нужно, то убирает лишние символы или разбивает строку на несколько. }
  function IsClear: Boolean;
   {* Функция возвращает призна того, что поле пустое (вынесено специально 
          для обновления кнопок!). Для реквизитов дат проверяет оба поля дат! }
  procedure InitOtherField(const aValue: IevEditorControl;
   aIsStart: Boolean);
   {* Для реквизитов с двумя полями. Используется для полей дат. }
  function IsFieldEmpty: Boolean;
   {* Проверяет является ли поле пустым (или содержит значение по умолчанию). }
  function FindButton(aButtonType: TevButtonType): IevEditorControlButton;
   {* Возвращает кнопку для поля. }
  procedure ClearText;
   {* Очищает поле редактора. }
  function SelectAllOnFocus: Boolean;
   {* Надо ли выделять поле при фокусировании. }
  function Text: Il3CString;
   {* Текст поля редактора. }
  function ErrorColor: Boolean;
   {* Установлен ли цвет ошибочного текста. }
  function Valid: Boolean;
   {* Проверяет на корректность. }
  function ChildList: IevEditorControlList;
  function DoLMouseBtnUp(const aView: InevControlView;
   const aTextPara: InevPara;
   const aPt: TnevPoint;
   const Keys: TevMouseState;
   anInPara: Boolean): Boolean;
  function DoLMouseBtnDown(const aView: InevControlView;
   const aTextPara: InevPara;
   const aPt: TnevPoint;
   const Keys: TevMouseState;
   anInPara: Boolean;
   const aMap: InevMap): Boolean;
  procedure SynchronizeSelectedValueWithText;
  function HasOtherField: Boolean;
 end;//TevEditControl
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3String
 , k2Tags
 , l3Chars
 , SysUtils
;

end.
