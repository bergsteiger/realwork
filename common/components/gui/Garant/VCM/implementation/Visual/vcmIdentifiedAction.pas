unit vcmIdentifiedAction;
{* Базовая операция с идентификатором модуля библиотеки vcm для привязки к меню. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmIdentifiedAction - }
{ Начат: 25.02.2003 20:33 }
{ $Id: vcmIdentifiedAction.pas,v 1.4 2009/02/20 16:45:41 lulin Exp $ }

// $Log: vcmIdentifiedAction.pas,v $
// Revision 1.4  2009/02/20 16:45:41  lulin
// - <K>: 136941122.
//
// Revision 1.3  2007/01/05 11:35:27  lulin
// - убран вредный параметр операции.
//
// Revision 1.2  2003/04/04 10:58:59  law
// - bug fix: была ошибка в имени типа TvcmControlID.
//
// Revision 1.1  2003/04/01 12:54:49  law
// - переименовываем MVC в VCM.
//
// Revision 1.2  2003/02/27 10:59:50  law
// - comments: xHelpGen.
//
// Revision 1.1  2003/02/25 18:02:50  law
// - new behavior: начал писать обвязку для выполнения операций модуля.
//
// Revision 1.1  2003/02/25 17:59:45  law
// - new behavior: начал писать обвязку для выполнения операций модуля.
//

{$Include vcmDefine.inc }

interface

uses
  Classes,

  vcmExternalInterfaces,
  vcmInterfaces,
  vcmAction
  ;

type
  TvcmIdentifiedAction = class(TvcmAction)
   {* Базовая операция с идентификатором модуля библиотеки vcm для привязки к меню. }
    private
    // internal fields
      f_ID : TvcmControlID;
    public
    // public methods
      constructor Create(anOwner : TComponent;
                         anID    : TvcmControlID);
        reintroduce;
        {-}
     public
     // public properties
       property ID: TvcmControlID
         read f_ID;
         {* - код управляющего элемента. }
  end;//TvcmIdentifiedAction

implementation

constructor TvcmIdentifiedAction.Create(anOwner : TComponent;
                                        anID    : TvcmControlID);
  //reintroduce;
  {-}
begin
 inherited Create(anOwner);
 f_ID := anID;
end;

end.

