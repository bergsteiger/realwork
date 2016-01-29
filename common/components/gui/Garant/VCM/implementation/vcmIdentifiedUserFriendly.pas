unit vcmIdentifiedUserFriendly;
{* Базовый класс для объектов имеющих отображение для пользователя и идентификатор. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmIdentifiedUserFriendly - }
{ Начат: 25.02.2003 20:27 }
{ $Id: vcmIdentifiedUserFriendly.pas,v 1.8 2013/07/05 09:10:33 lulin Exp $ }

// $Log: vcmIdentifiedUserFriendly.pas,v $
// Revision 1.8  2013/07/05 09:10:33  lulin
// - чистим код.
//
// Revision 1.7  2009/02/20 15:18:56  lulin
// - <K>: 136941122.
//
// Revision 1.6  2009/02/20 13:07:04  lulin
// - <K>: 136941122.
//
// Revision 1.5  2007/04/12 07:57:07  lulin
// - используем строки с кодировкой.
//
// Revision 1.4  2007/04/10 14:06:20  lulin
// - используем строки с кодировкой.
//
// Revision 1.3  2006/03/20 13:03:50  lulin
// - new behavior: выливаем параметры состояний операции.
//
// Revision 1.2  2003/04/04 10:58:57  law
// - bug fix: была ошибка в имени типа TvcmControlID.
//
// Revision 1.1  2003/04/01 12:54:41  law
// - переименовываем MVC в VCM.
//
// Revision 1.4  2003/03/27 14:36:52  law
// - new prop: операция теперь имеет картинку.
//
// Revision 1.3  2003/03/20 16:42:56  law
// - change: всем объектам кроме Name добавлено свойство Caption.
//
// Revision 1.2  2003/02/27 09:37:57  law
// - new behavior: к описанию сущности добавлены операции.
//
// Revision 1.1  2003/02/25 17:59:45  law
// - new behavior: начал писать обвязку для выполнения операций модуля.
//

{$Include vcmDefine.inc }

interface

uses
  vcmExternalInterfaces,
  vcmUserControls,
  vcmInterfaces,
  vcmUserFriendly
  ;

type
  TvcmIdentifiedUserFriendly = class(TvcmUserFriendly, IvcmIdentifiedUserFriendlyControl)
   {* Базовый класс для объектов имеющих отображение для пользователя и идентификатор. }
    private
    // internal fields
      f_ID : TvcmControlID;
    protected
    // interface methods
      // IvcmIdentifiedUserFriendlyControl
      function Get_ID: TvcmControlID;
        {-}
    public
    // public methods
      constructor Create(const anID         : TvcmControlID;
                         const aName        : String;
                         const aCaption     : IvcmCString;
                         const aHint        : IvcmCString;
                         const aLongHint    : IvcmCString;
                         //const aDescription : String;
                         anImageIndex       : Integer);
        reintroduce;
        {-}
  end;//TvcmIdentifiedUserFriendly


implementation

// start class TvcmIdentifiedUserFriendly

constructor TvcmIdentifiedUserFriendly.Create(const anID         : TvcmControlID;
                                              const aName        : String;
                                              const aCaption     : IvcmCString;
                                              const aHint        : IvcmCString;
                                              const aLongHint    : IvcmCString;
                                              //const aDescription : String;
                                              anImageIndex       : Integer);
  //reintroduce;
  {-}
begin
 inherited Create(aName, aCaption, aHint, aLongHint, anImageIndex);
 f_ID := anID;
end;

function TvcmIdentifiedUserFriendly.Get_ID: TvcmControlID;
  {-}
begin
 Result := f_ID;
end;

end.

