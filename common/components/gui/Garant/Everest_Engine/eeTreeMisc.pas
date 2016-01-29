unit eeTreeMisc;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: eeTreeMisc -    }
{ Начат: 20.06.2003 17:41 }
{ $Id: eeTreeMisc.pas,v 1.1 2010/04/21 16:52:40 lulin Exp $ }

// $Log: eeTreeMisc.pas,v $
// Revision 1.1  2010/04/21 16:52:40  lulin
// {RequestLink:144575972}.
// - переходим к абсолютным путям для включаемых файлов.
//
// Revision 1.6  2009/10/28 14:09:56  lulin
// - начинаем компанию по борьбе со старыми внутренними операциями.
//
// Revision 1.2  2003/07/01 16:26:02  demon
// - bug fix: добавлена потерянная <,>
//
// Revision 1.1  2003/06/20 13:43:53  law
// - new methods: IeeTree.Iterate, IeeTree.IterateF.
//

{$I eeDefine.inc }

interface

uses
  l3Base,

  eeInterfaces
  ;

function eeL2NA(anAction: Pointer): TeeNodeAction;
  {-}

implementation

function eeL2NA(anAction: Pointer): TeeNodeAction;
  register;
  {-}
asm
          jmp  l3LocalStub
end;{asm}

end.

