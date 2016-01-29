unit vcmUserFriendly;
{* Базовый класс для объектов имеющих отображение для пользователя. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmUserFriendly - }
{ Начат: 25.02.2003 13:26 }
{ $Id: vcmUserFriendly.pas,v 1.10 2013/07/05 09:10:33 lulin Exp $ }

// $Log: vcmUserFriendly.pas,v $
// Revision 1.10  2013/07/05 09:10:33  lulin
// - чистим код.
//
// Revision 1.9  2011/07/29 15:07:57  lulin
// {RequestLink:209585097}.
//
// Revision 1.8  2009/02/20 13:44:16  lulin
// - <K>: 136941122.
//
// Revision 1.7  2009/02/20 12:29:35  lulin
// - <K>: 136941122.
//
// Revision 1.6  2007/04/12 07:57:07  lulin
// - используем строки с кодировкой.
//
// Revision 1.5  2007/04/10 14:06:20  lulin
// - используем строки с кодировкой.
//
// Revision 1.4  2006/03/20 13:03:50  lulin
// - new behavior: выливаем параметры состояний операции.
//
// Revision 1.3  2004/09/10 16:21:42  lulin
// - оптимизация - кешируем OpDef и передаем ссылку на OperationItem, а не на кучу параметров.
//
// Revision 1.2  2004/01/22 18:01:14  law
// - new unit: vcmBaseObjectDef.
// - new class: TvcmBaseObjectDef.
//
// Revision 1.1  2003/04/01 12:54:42  law
// - переименовываем MVC в VCM.
//
// Revision 1.3  2003/03/27 14:36:52  law
// - new prop: операция теперь имеет картинку.
//
// Revision 1.2  2003/03/20 16:42:56  law
// - change: всем объектам кроме Name добавлено свойство Caption.
//
// Revision 1.1  2003/02/25 11:08:05  law
// - change: добавлено определение операций модуля.
//

{$Include vcmDefine.inc }

interface

{$IfNDef NoVCM}
uses
  vcmExternalInterfaces,
  vcmUserControls,
  vcmInterfaces,
  vcmBase,
  vcmBaseObjectDef
  ;

type
  TvcmUserFriendly = class(TvcmBaseObjectDef, IvcmUserFriendlyControl)
   {* Базовый класс для объектов имеющих отображение для пользователя. }
    protected
    // internal fields
      f_Hint        : IvcmCString;
      f_LongHint    : IvcmCString;
      //f_Description : String;
      f_ImageIndex  : Integer;
    protected
    // interface methods
      // IvcmModuleDef
(*      function Get_Description: TvcmString;
        {-}*)
      function Get_Hint: IvcmCString;
        virtual;
        {-}
      function Get_LongHint: IvcmCString;
        virtual;
        {-}
      function Get_ImageIndex: Integer;
        virtual;
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const aName        : AnsiString;
                         const aCaption     : IvcmCString;
                         const aHint        : IvcmCString;
                         const aLongHint    : IvcmCString;
                         //const aDescription : String;
                         anImageIndex       : Integer);
        reintroduce;
        {-}
  end;//TvcmUserFriendly
{$EndIf NoVCM}

implementation

{$IfNDef NoVCM}
// start class TvcmUserFriendly

constructor TvcmUserFriendly.Create(const aName        : AnsiString;
                                    const aCaption     : IvcmCString;
                                    const aHint        : IvcmCString;
                                    const aLongHint    : IvcmCString;
                                    //const aDescription : String;
                                    anImageIndex       : Integer);
  //reintroduce;
  {-}
begin
 inherited Create(aName, aCaption);
 f_Hint := aHint;
 f_LongHint := aLongHint;
 //f_Description := aDescription;
 f_ImageIndex := anImageIndex;
end;

procedure TvcmUserFriendly.Cleanup;
  //override;
  {-}
begin
 f_Hint := nil;
 f_LongHint := nil;
 inherited;
end;

(*function TvcmUserFriendly.Get_Description: TvcmString;
  {-}
begin
 Result := TvcmString(f_Description);
end;*)

function TvcmUserFriendly.Get_Hint: IvcmCString;
  {-}
begin
 Result := f_Hint;
end;

function TvcmUserFriendly.Get_LongHint: IvcmCString;
  {-}
begin
 Result := f_LongHint;
end;

function TvcmUserFriendly.Get_ImageIndex: Integer;
  {-}
begin
 Result := f_ImageIndex;
end;
{$EndIf NoVCM}

end.

