unit vcmInternalInterfaces;

{ Ѕиблиотека "vcm"        }
{ јвтор: Ћюлин ј.¬. ©     }
{ ћодуль: vcmInternalInterfaces - }
{ Ќачат: 23.06.2003 18:04 }
{ $Id: vcmInternalInterfaces.pas,v 1.9 2015/03/18 11:14:07 lulin Exp $ }

// $Log: vcmInternalInterfaces.pas,v $
// Revision 1.9  2015/03/18 11:14:07  lulin
// - упор€дочиваем генерацию зависимостей.
//
// Revision 1.8  2012/04/13 14:37:25  lulin
// {RequestLink:237994598}
//
// Revision 1.7  2008/03/19 14:23:42  lulin
// - cleanup.
//
// Revision 1.6  2008/02/01 15:14:33  lulin
// - избавл€емс€ от излишней универсальности списков.
//
// Revision 1.5  2007/04/04 09:10:28  lulin
// - bug fix: не заполн€лс€ контейнер в параметрах операции (CQ OIT5-24865).
//
// Revision 1.4  2004/06/02 10:20:38  law
// - удален конструктор Tl3VList.MakeIUnknown - пользуйтесь _Tl3InterfaceList.Make.
//
// Revision 1.3  2003/09/26 15:23:58  law
// - new behavior: начал делать слитие строковых ресурсов.
//
// Revision 1.2  2003/06/23 15:03:21  law
// - change: свойство _IvcmContainer.GUID переехало в IvcmEntityForm.GUID - теперь кажда€ форма имеет свой идентификатор.
// - remove interface: IvcmGUIDSetter.
// - new param: конструктор _TvcmEntityForm.Make имее еще один параметр - aGUID - дл€ восстановлени€ идентификатора формы при операци€х Back/Forward.
//
// Revision 1.1  2003/06/23 14:27:04  law
// - new behavior: теперь контейнер восстанавливает свой GUID при операци€х Back/Forward.
//

{$Include vcmDefine.inc }

interface

uses
  vcmInterfaces,

  vcmBase
  ;

type
  IvcmForms = interface(IUnknown)
    ['{627B46F8-E5F3-41C3-9A17-808CE33C2598}']
    // public methods
      procedure GetEntityForms(aList : TvcmClassList);
        {-}
  end;//IvcmForms

implementation

end.

