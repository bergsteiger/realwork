unit vcmBaseObjectDef;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcm -           }
{ Начат: 22.02.2004 20:53 }
{ $Id: vcmBaseObjectDef.pas,v 1.11 2013/07/05 09:10:33 lulin Exp $ }

// $Log: vcmBaseObjectDef.pas,v $
// Revision 1.11  2013/07/05 09:10:33  lulin
// - чистим код.
//
// Revision 1.10  2011/07/29 15:07:57  lulin
// {RequestLink:209585097}.
//
// Revision 1.9  2010/08/16 06:46:25  lulin
// {RequestLink:232098153}.
// [$232100559].
//
// Revision 1.8  2009/02/20 13:44:16  lulin
// - <K>: 136941122.
//
// Revision 1.7  2009/02/20 12:29:35  lulin
// - <K>: 136941122.
//
// Revision 1.6  2007/04/10 14:06:20  lulin
// - используем строки с кодировкой.
//
// Revision 1.5  2007/04/10 13:20:08  lulin
// - используем строки с кодировкой.
//
// Revision 1.4  2006/12/10 17:50:17  lulin
// - cleanup.
//
// Revision 1.3  2004/09/10 16:21:42  lulin
// - оптимизация - кешируем OpDef и передаем ссылку на OperationItem, а не на кучу параметров.
//
// Revision 1.2  2004/09/07 16:19:41  law
// - перевел VCM на кшированные обьекты.
//
// Revision 1.1  2004/01/22 18:01:14  law
// - new unit: vcmBaseObjectDef.
// - new class: TvcmBaseObjectDef.
//

{$Include vcmDefine.inc }

interface

{$IfNDef NoVCM}
uses
  vcmExternalInterfaces,
  vcmUserControls,
  vcmInterfaces,
  vcmBase
  ;
  
type
  TvcmBaseObjectDef = class(TvcmCacheableBase, IvcmBaseObjectDef)
   {* Базовый класс для объектов имеющих отображение для пользователя. }
    private
    // internal fields
      f_Name    : AnsiString;
    protected
    // internal fields
      f_Caption : IvcmCString;
    protected
    // interface methods
      // IvcmModuleDef
      function Get_Name: TvcmString;
        {-}
      function Get_Caption: IvcmCString;
        virtual;
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(const aName    : AnsiString;
                         const aCaption : IvcmCString);
        reintroduce;
        {-}
  end;//TvcmBaseObjectDef
{$EndIf NoVCM}

implementation

{$IfNDef NoVCM}
uses
  l3String
  ;

constructor TvcmBaseObjectDef.Create(const aName   : AnsiString;
                                    const aCaption : IvcmCString);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_Name := aName;
 if l3IsNil(aCaption) then
  f_Caption := vcmCStr(aName)
 else
  f_Caption := aCaption;
 Assert(not l3IsNil(f_Caption));
end;

procedure TvcmBaseObjectDef.Cleanup;
  //override;
  {-}
begin
 f_Caption := nil;
 inherited;
end;

function TvcmBaseObjectDef.Get_Name: TvcmString;
  {-}
begin
 Result := TvcmString(f_Name);
end;

function TvcmBaseObjectDef.Get_Caption: IvcmCString;
  {-}
begin
 Result := f_Caption;
end;
{$EndIf NoVCM}

end.

