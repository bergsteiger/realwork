unit vcmEntityFormDef;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmEntityFormDef - }
{ Начат: 22.01.2004 21:04 }
{ $Id: vcmEntityFormDef.pas,v 1.13 2015/07/09 09:54:20 kostitsin Exp $ }

// $Log: vcmEntityFormDef.pas,v $
// Revision 1.13  2015/07/09 09:54:20  kostitsin
// чтобы не мешалось.
//
// Revision 1.12  2015/07/09 09:49:02  kostitsin
// {requestlink: 127042272 } - грохнул ещё пачку _TvcmInterfaceList.
//
// Revision 1.11  2009/02/20 13:07:04  lulin
// - <K>: 136941122.
//
// Revision 1.10  2008/03/19 14:23:42  lulin
// - cleanup.
//
// Revision 1.9  2008/01/31 18:53:32  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.8  2007/04/10 14:06:20  lulin
// - используем строки с кодировкой.
//
// Revision 1.7  2004/09/10 12:23:49  lulin
// - оптимизация - гораздо аккуратнее обращаемся с UserType'ами и VisibleOpCount. В итоге уменьшено количество различных вызовов.
//
// Revision 1.6  2004/06/02 10:20:37  law
// - удален конструктор Tl3VList.MakeIUnknown - пользуйтесь _Tl3InterfaceList.Make.
//
// Revision 1.5  2004/02/10 12:59:47  law
// - change: IvcmUserTypesIterator теперь возвращает IvcmUserTypeDef.
//
// Revision 1.4  2004/01/22 19:08:28  law
// - bug fix.
//
// Revision 1.3  2004/01/22 19:01:28  law
// - bug fix: забыл, что итераторов можно получать несколько.
//
// Revision 1.2  2004/01/22 18:42:43  law
// - new prop: IvcmEntityFormDef.UserTypesIterator.
//
// Revision 1.1  2004/01/22 18:07:21  law
// - new unit: vcmEntityFormDef.
// - new class: TvcmEntityFormDef.
//

{$I vcmDefine.inc }

interface

uses
  Classes,

  vcmExternalInterfaces,
  vcmInterfaces,
  vcmBase,
  vcmBaseObjectDef,
  vcmUserTypeDefList
  ;

type
  TvcmEntityFormDef = class(TvcmBaseObjectDef, IvcmEntityFormDef)
    private
    // internal fields
      f_UserTypes : TvcmUserTypeDefList;
      f_FormClass : TClass;
    private
    // interface methods
      // IvcmEntityFormDef
      function Get_UserTypesIterator: IvcmUserTypesIterator;
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const aName     : String;
                         const aCaption  : IvcmCString;
                         aFormClass      : TClass);
        reintroduce;
        {-}
      class function Make(const aName     : String;
                          const aCaption  : IvcmCString;
                          aFormClass      : TClass): IvcmEntityFormDef;
        reintroduce;
        {-}
  end;//TvcmEntityFormDef

implementation

uses
  SysUtils,
  
  vcmUserTypesIterator,
  vcmEntityForm,
  vcmBaseMenuManager
  ;

// start class TvcmEntityFormDef

constructor TvcmEntityFormDef.Create(const aName     : String;
                                     const aCaption  : IvcmCString;
                                     aFormClass      : TClass);
  //reintroduce;
  {-}
begin
 inherited Create(aName, aCaption);
 f_FormClass := aFormClass;
end;

class function TvcmEntityFormDef.Make(const aName     : String;
                                      const aCaption  : IvcmCString;
                                      aFormClass      : TClass): IvcmEntityFormDef;
  //reintroduce;
  {-}
var
 l_EFD : TvcmEntityFormDef;
begin
 l_EFD := Create(aName, aCaption, aFormClass);
 try
  Result := l_EFD;
 finally
  vcmFree(l_EFD);
 end;//try..finally
end;

procedure TvcmEntityFormDef.Cleanup;
  //override;
  {-}
begin
 vcmFree(f_UserTypes);
 inherited;
end;

function TvcmEntityFormDef.Get_UserTypesIterator: IvcmUserTypesIterator;
  {-}
var
 l_Form      : TvcmEntityForm;
 l_NeedClose : Boolean;
begin
 if (f_UserTypes = nil) then
 begin
  f_UserTypes := TvcmUserTypeDefList.Make;
  l_Form := g_MenuManager.BuildVirtualForm(RvcmEntityForm(f_FormClass), l_NeedClose);
  try
   l_Form.GetUserTypes(f_UserTypes);
  finally
   if l_NeedClose then
    l_Form.SafeClose;
  end;//try..finally
 end;//f_UserTypes = nil
 Result := TvcmUserTypesIterator.Make(f_UserTypes);
end;

end.

