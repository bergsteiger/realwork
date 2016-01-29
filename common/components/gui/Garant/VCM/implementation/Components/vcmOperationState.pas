unit vcmOperationState;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmOperationState - }
{ Начат: 21.02.2003 16:19 }
{ $Id: vcmOperationState.pas,v 1.5 2004/01/14 16:18:17 law Exp $ }

// $Log: vcmOperationState.pas,v $
// Revision 1.5  2004/01/14 16:18:17  law
// - new units: vcmBaseOperationState, vcmBaseOperationStates.
//
// Revision 1.4  2004/01/14 14:54:26  law
// - bug fix.
//
// Revision 1.3  2004/01/14 14:45:45  law
// - new prop: TvcmOperationState.Checked.
//
// Revision 1.2  2004/01/14 13:58:03  law
// - new units: vcmOperationState, vcmOperationStates.
//
// Revision 1.1  2004/01/14 13:07:52  law
// - new units: vcmOperationState, vcmOperationStates.
//

{$I vcmDefine.inc }

interface

uses
  vcmBaseOperationState
  ;

type
  TvcmOperationState = class(TvcmBaseOperationState)
  end;//TvcmOperationState

implementation

end.

