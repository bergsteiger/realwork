unit evCustomMemo;

interface

uses
 l3IntfUses
 , evEditorWithOperations
 , l3Interfaces
 , l3Memory
 , l3Core
 , Messages
 , Controls
 , nevBase
 , evCustomEditorModelPart
 , Classes
 , evCustomTextSource
 , l3InternalInterfaces
 , evDef
 , evCustomMemoTextSource
;

type
 RevCustomMemoTextSource = class of TevCustomMemoTextSource;
 
 TevCustomMemo = class(TevEditorWithOperations)
  {* Мемо-поле. }
  function UseMemoFontForParagraphs: Boolean;
  function TextSourceClass: RevCustomMemoTextSource;
  procedure WMGetText(var Msg: TMessage);
  procedure WMGetTextLength(var Msg: TMessage);
  procedure WMSetText(var Msg: TMessage);
  procedure CMFONTCHANGED(var Msg: TMessage);
  procedure WMKeyDown(var Msg: TWMKeyDown);
  procedure Validate;
  function KeepParaFormattingTag(aTag: Integer): Boolean;
   {* Сохранять ли элемент оформления }
  procedure CMEnter(var Message: TCMEnter);
  procedure CMExit(var Message: TCMExit);
 end;//TevCustomMemo
 
implementation

uses
 l3ImplUses
 , l3MinMax
 , l3Chars
 , l3String
 , evdInterfaces
 , l3Types
 , evMemoContextMenu
 , SysUtils
 , Graphics
 , nevTools
 , k2Tags
 , k2Facade
 , Forms
 , Windows
 , evExcept
 , Font_Const
 , TtfwClassRef_Proxy
;

end.
