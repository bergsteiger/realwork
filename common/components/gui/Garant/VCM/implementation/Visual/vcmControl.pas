unit vcmControl;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmControl -    }
{ Начат: 13.09.2004 16:08 }
{ $Id: vcmControl.pas,v 1.2 2006/12/05 14:33:30 lulin Exp $ }

// $Log: vcmControl.pas,v $
// Revision 1.2  2006/12/05 14:33:30  lulin
// - контрол переехал в визуальную библиотеку.
//
// Revision 1.1  2004/09/13 12:17:46  lulin
// - new unit: vcmControl.
//

{$I vcmDefine.inc }

interface

uses
  Controls

  {$IfDef vcmNeedL3}
  ,
  afwCustomCommonControl
  {$EndIf vcmNeedL3}
  ;

type
  TvcmControl = class({$IfDef vcmNeedL3}
                       TafwCustomCommonControl
                       {$Else  vcmNeedL3}
                       TCustomControl
                       {$EndIf vcmNeedL3})
  end;//TvcmControl

implementation

end.

