unit vcmBaseOperationStates;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmBaseOperationStates - }
{ Начат: 21.02.2003 16:19 }
{ $Id: vcmBaseOperationStates.pas,v 1.3 2015/06/03 12:26:27 lulin Exp $ }

// $Log: vcmBaseOperationStates.pas,v $
// Revision 1.3  2015/06/03 12:26:27  lulin
// - пытаемся разрулить зависимости.
//
// Revision 1.2  2004/01/14 16:24:32  law
// - new method: TvcmBaseOperationsCollectionItem.StatesClass.
//
// Revision 1.1  2004/01/14 16:18:17  law
// - new units: vcmBaseOperationState, vcmBaseOperationStates.
//

{$I vcmDefine.inc }

interface

{$If not defined(NoVCM)}
uses
  Classes,

  vcmBaseCollection,
  vcmBaseOperationState
  ;

type
  TvcmBaseOperationStates = class(TvcmBaseCollection)
   {* Коллекция операций. }
    public
    // public methods
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
  end;//TvcmBaseOperationStates
  RvcmBaseOperationStates = class of TvcmBaseOperationStates;
{$IfEnd}  

implementation

{$If not defined(NoVCM)}
// start class TvcmOperationStates

class function TvcmBaseOperationStates.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmBaseOperationState;
end;
{$IfEnd}

end.

