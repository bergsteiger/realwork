unit evFormulaParaBitmapContainer;

// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: evFormulaParaBitmapContainer
// Начат: 15.12.2002 17:34

{$Include evDefine.inc}

interface

uses
  l3MetafileContainer,
  l3ExprContainer
  ;

{$IfDef Nemesis}
 {$Define InPlaceDraw}
{$EndIf Nemesis}

type
  TevFormulaParaBitmapContainer = {$IfDef InPlaceDraw}
                                  Tl3ExprContainer
                                  //Tl3BitmapContainer
                                  //Tl3IEBitmapContainer
                                  {$Else  InPlaceDraw}
                                  Tl3MetafileContainer
                                  //Tl3BitmapContainer
                                  {$EndIf InPlaceDraw}
                                  ;
                                  
implementation

end.