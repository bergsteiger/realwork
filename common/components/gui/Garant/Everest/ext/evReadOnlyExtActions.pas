unit evReadOnlyExtActions;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evReadOnlyExtActions - }
{ Начат: 14.09.2001 14:46 }
{ $Id: evReadOnlyExtActions.pas,v 1.5 2012/11/01 09:41:42 lulin Exp $ }

// $Log: evReadOnlyExtActions.pas,v $
// Revision 1.5  2012/11/01 09:41:42  lulin
// - забыл точку с запятой.
//
// Revision 1.4  2012/11/01 07:43:08  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.3  2005/03/02 09:08:36  lulin
// - bug fix: не компилировалось.
//
// Revision 1.2  2003/10/13 15:04:18  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.1  2001/09/14 12:30:34  law
// - new behavior: добавлена возможность поиска.
//

{$I evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3InternalInterfaces
  ;

type
  TevReadOnlyExtActionsProcessor = class(Tl3Base, Il3ActionProcessor)
   {* Процессор "расширенной" обработки операций редактора. }
    public
    //public methods
      // Il3ActionProcessor
      function Process(Sender : TObject;
                       Target : TObject;
                       Action : Long;
                       Down   : Bool): Bool;
        {* - обработчик операции. }
  end;//TevReadOnlyExtActionsProcessor

implementation

uses
  evStandardActions,
  evEditorWindow,
  evCustomEditor,
  evTunedEditor,
  evEditor,

  evExtSearch
  ;

function TevReadOnlyExtActionsProcessor.Process(Sender : TObject;
                                                Target : TObject;
                                                Action : Long;
                                                Down   : Bool): Bool;
  {-}
begin
 Result := false;
 if (Target <> nil) then begin
  if (Target Is TevTunedEditor) then begin
   Case TevOperation(Action) of
    ev_ccSearch : Result := evExtSearch.Search(TevCustomEditor(Target));
    ev_ccSearchAgain : Result := evExtSearch.SearchAgain(TevCustomEditor(Target));
(*    ev_ccInsertTable  : Result := evExtDlgInsertTable.Execute(TevCustomEditor(Target));
    ev_ccSplitCells   : Result := evExtDlgSplitCell.Execute(TevCustomEditor(Target).Range);
    ev_ccSpecialPaste : Result := evExtDlgSpecialPaste.Execute(TevCustomEditorWindow(Target));*)
   end;//Case TevOperation(Action)
  end;//Target Is TevTunedEditor
 end;//Target <> nil
end;

var
 l_EditorExtActionProcessor : TevReadOnlyExtActionsProcessor;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\ext\evReadOnlyExtActions.pas initialization enter'); {$EndIf}
 l_EditorExtActionProcessor := TevReadOnlyExtActionsProcessor.Create;
 try
  evEditorExtActionProcessor := l_EditorExtActionProcessor;
 finally
  l3Free(l_EditorExtActionProcessor);
 end;//try..finally

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\ext\evReadOnlyExtActions.pas initialization leave'); {$EndIf}
finalization
 evEditorExtActionProcessor := nil;
  
end.

