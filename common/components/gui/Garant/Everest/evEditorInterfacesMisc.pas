unit evEditorInterfacesMisc;
{* Утилиты для работы с интерфейсами из модуля evEditorInterfaces. }

{ Библиотека "Эверест"             }
{ Автор: Люлин А.В. ©              }
{ Модуль: evEditorInterfacesMisc - }
{ Начат: 29.03.2001 16:56          }
{ $Id: evEditorInterfacesMisc.pas,v 1.6 2010/04/08 14:09:33 lulin Exp $ }

// $Log: evEditorInterfacesMisc.pas,v $
// Revision 1.6  2010/04/08 14:09:33  lulin
// {RequestLink:201491473}.
//
// Revision 1.5  2008/04/09 17:57:07  lulin
// - передаём вью в рамках <K>: 89096854.
//
// Revision 1.4  2005/01/24 11:43:15  lulin
// - new behavior: при освобождении заглушки очищаем указатель на нее.
//
// Revision 1.3  2002/12/26 16:31:28  law
// - new directive: evNeedEditableCursors.
//
// Revision 1.2  2001/08/02 11:43:18  law
// - cleanup & comments.
//
// Revision 1.1  2001/03/29 15:22:41  law
// - new: добавлен интерфейс IedLeafParagraph и метод _IedRange.IterateLeafParagraphs.
//

{$I evDefine.inc }

interface

uses
  l3Base,

  evEditorInterfaces
  ;

{$IfDef evNeedEditableCursors}
function  evL2LPA(Action: Pointer): IedRange_IterateLeafParagraphs_Action;
  {* - создает заглушку для локального метода для преобразования в TevLeafParagraphAction. }
procedure evFreeLPA(var Action: IedRange_IterateLeafParagraphs_Action);
  {* - освобождает заглушку, созданную функцией evL2LPA. }
{$EndIf evNeedEditableCursors}

implementation

{$IfDef evNeedEditableCursors}
function evL2LPA(Action: Pointer): IedRange_IterateLeafParagraphs_Action;
                {eax}
  register;
  {-}
asm
          jmp  l3LocalStub
end;{asm}

procedure evFreeLPA(var Action: IedRange_IterateLeafParagraphs_Action);
  {-}
  register;
  {-}
asm
          jmp  l3FreeLocalStub
end;{asm}
{$EndIf evNeedEditableCursors}

end.

