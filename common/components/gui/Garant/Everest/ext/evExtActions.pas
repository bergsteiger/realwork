unit evExtActions;
{* Модуль "расширенной" обработки операций редактора. }

{ Библиотека "Эверест"       }
{ Автор: Люлин А.В. ©        }
{ Модуль: evExtActions.pas - }
{ Начат: 08.06.2001 13:48    }
{ $Id: evExtActions.pas,v 1.10 2012/11/01 09:41:42 lulin Exp $ }

// $Log: evExtActions.pas,v $
// Revision 1.10  2012/11/01 09:41:42  lulin
// - забыл точку с запятой.
//
// Revision 1.9  2012/11/01 07:43:07  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.8  2009/04/08 12:56:39  lulin
// [$142610892]. Вычищаем ненужные контексты.
//
// Revision 1.7  2009/04/08 12:12:34  lulin
// [$142610892]. Пытался собрать Эверест с директивой _Nemesis.
//
// Revision 1.6  2004/11/25 07:37:43  lulin
// - new unit: TevCustomEditor.
//
// Revision 1.5  2003/10/13 15:04:18  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.4  2001/06/08 13:19:36  law
// - new action: ev_ccSpecialPaste.
//
// Revision 1.3  2001/06/08 12:31:31  law
// - comments: xHelpGen.
//
// Revision 1.2  2001/06/08 12:09:04  law
// - new behavior: сделана "расширенная" обработка операций.
//
// Revision 1.1  2001/06/08 09:54:47  law
// - new: добавлены модули для "расширенной" обработки сообщений редактора.
//

{$I evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3InternalInterfaces
  ;

type
  TevExtActionsProcessor = class(Tl3Base, Il3ActionProcessor)
   {* Процессор "расширенной" обработки операций редактора. }
    public
    //public methods
      // Il3ActionProcessor
      function Process(Sender : TObject;
                       Target : TObject;
                       Action : Long;
                       Down   : Bool): Bool;
        {* - обработчик операции. }
  end;//TevExtActionsProcessor

implementation

uses
  evStandardActions,
  evEditorWindow,
  evCustomEditor,
  
  evExtDlgInsertTable,
  evExtDlgSplitCell,
  evExtDlgSpecialPaste
  ;

function TevExtActionsProcessor.Process(Sender : TObject;
                                        Target : TObject;
                                        Action : Long;
                                        Down   : Bool): Bool;
  {-}
begin
 Result := false;
 if (Target <> nil) then begin
  if (Target Is TevCustomEditor) then begin
   Case TevOperation(Action) of
    ev_ccInsertTable  : Result := evExtDlgInsertTable.Execute(TevCustomEditor(Target));
    ev_ccSplitCells   : Result := evExtDlgSplitCell.Execute(TevCustomEditor(Target).Range);
    ev_ccSpecialPaste : Result := evExtDlgSpecialPaste.Execute(TevCustomEditorWindow(Target));
   end;//Case TevOperation(Action)
  end;//Target Is TevTunedEditor
 end;//Target <> nil
end;

{$IfDef evNeedDisp}
var
 l_EditorExtActionProcessor : TevExtActionsProcessor;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\ext\evExtActions.pas initialization enter'); {$EndIf}
 l_EditorExtActionProcessor := TevExtActionsProcessor.Create;
 try
  evEditorExtActionProcessor := l_EditorExtActionProcessor;
 finally
  l3Free(l_EditorExtActionProcessor);
 end;//try..finally

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\ext\evExtActions.pas initialization leave'); {$EndIf}
finalization
 evEditorExtActionProcessor := nil;
{$EndIf evNeedDisp} 
  
end.

