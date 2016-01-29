unit vcmOperationStates;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmOperationStates - }
{ Начат: 21.02.2003 16:19 }
{ $Id: vcmOperationStates.pas,v 1.2 2004/01/14 16:18:17 law Exp $ }

// $Log: vcmOperationStates.pas,v $
// Revision 1.2  2004/01/14 16:18:17  law
// - new units: vcmBaseOperationState, vcmBaseOperationStates.
//
// Revision 1.1  2004/01/14 13:07:52  law
// - new units: vcmOperationState, vcmOperationStates.
//

{$I vcmDefine.inc }

interface

uses
  Classes,
  
  vcmBaseOperationStates
  ;

type
  TvcmOperationStates = class(TvcmBaseOperationStates)
   {* Коллекция операций. }
    public
    // public methods
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
  end;//TvcmOperationStates
  
implementation

uses
  vcmOperationState
  ;

// start class TvcmOperationStates

class function TvcmOperationStates.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmOperationState;
end;

end.

