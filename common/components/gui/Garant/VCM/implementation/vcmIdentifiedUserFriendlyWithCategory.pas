unit vcmIdentifiedUserFriendlyWithCategory;
{* Базовый класс для объектов имеющих отображение для пользователя, категорию и идентификатор. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmIdentifiedUserFriendlyWithCategory - }
{ Начат: 26.03.2003 18:19 }
{ $Id: vcmIdentifiedUserFriendlyWithCategory.pas,v 1.11 2013/07/05 09:10:33 lulin Exp $ }

// $Log: vcmIdentifiedUserFriendlyWithCategory.pas,v $
// Revision 1.11  2013/07/05 09:10:33  lulin
// - чистим код.
//
// Revision 1.10  2012/08/07 14:37:37  lulin
// {RequestLink:358352265}
//
// Revision 1.9  2009/02/20 12:29:35  lulin
// - <K>: 136941122.
//
// Revision 1.8  2009/02/19 16:53:47  lulin
// - <K>: 136941122. Прячем фасеты друг в друга.
//
// Revision 1.7  2007/04/12 07:57:07  lulin
// - используем строки с кодировкой.
//
// Revision 1.6  2007/04/10 14:06:20  lulin
// - используем строки с кодировкой.
//
// Revision 1.5  2006/03/20 13:03:50  lulin
// - new behavior: выливаем параметры состояний операции.
//
// Revision 1.4  2004/09/10 16:21:42  lulin
// - оптимизация - кешируем OpDef и передаем ссылку на OperationItem, а не на кучу параметров.
//
// Revision 1.3  2003/10/28 11:25:43  law
// - new prop: IvcmOperationDef._GroupID.
//
// Revision 1.2  2003/04/04 10:58:57  law
// - bug fix: была ошибка в имени типа TvcmControlID.
//
// Revision 1.1  2003/04/01 12:54:41  law
// - переименовываем MVC в VCM.
//
// Revision 1.2  2003/03/27 14:36:52  law
// - new prop: операция теперь имеет картинку.
//
// Revision 1.1  2003/03/27 13:12:13  law
// no message
//

{$Include vcmDefine.inc }

interface

uses
  vcmExternalInterfaces,
  vcmInterfaces,
  vcmIdentifiedUserFriendly
  ;

type
  TvcmIdentifiedUserFriendlyWithCategory = class(TvcmIdentifiedUserFriendly)
   {* Базовый класс для объектов имеющих отображение для пользователя, категорию и идентификатор. }
    protected
    // internal fields
      f_Category : String;
      f_GroupID  : Integer;
    protected
    // interface methods
      // IvcmIdentifiedUserFriendlyControlWithCategory
      function Get_Category: TvcmString;
        virtual;
        {-}
      function Get_GroupID: Integer;
        virtual;
        {-}
    public
    // public methods
      constructor Create(const anID         : TvcmControlID;
                         const aName        : String;
                         const aCaption     : IvcmCString;
                         const aHint        : IvcmCString;
                         const aLongHint    : IvcmCString;
                         //const aDescription : String;
                         anImageIndex       : Integer;
                         const aCategory    : String;
                         aGroupID           : Integer);
        reintroduce;
        {-}
  end;//TvcmIdentifiedUserFriendlyWithCategory


implementation

// start class TvcmIdentifiedUserFriendlyWithCategory

constructor TvcmIdentifiedUserFriendlyWithCategory.Create(const anID         : TvcmControlID;
                                                          const aName        : String;
                                                          const aCaption     : IvcmCString;
                                                          const aHint        : IvcmCString;
                                                          const aLongHint    : IvcmCString;
                                                          //const aDescription : String;
                                                          anImageIndex       : Integer;
                                                          const aCategory    : String;
                                                          aGroupID           : Integer);
  //reintroduce;
  {-}
begin
 inherited Create(anID, aName, aCaption, aHint, aLongHint, anImageIndex);
 f_Category := aCategory;
 f_GroupID := aGroupID;
end;

function TvcmIdentifiedUserFriendlyWithCategory.Get_Category: TvcmString;
  {-}
begin
 Result := TvcmString(f_Category);
end;

function TvcmIdentifiedUserFriendlyWithCategory.Get_GroupID: Integer;
  {-}
begin
 Result := f_GroupID;
end;

end.

