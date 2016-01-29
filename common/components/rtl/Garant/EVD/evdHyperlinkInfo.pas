unit evdHyperlinkInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/evdHyperlinkInfo.pas"
// Начат: 12.11.2010 16:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Core Objects::TevdHyperlinkInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  l3Interfaces,
  evdInterfaces,
  l3ProtoObject
  ;

type
 TevdHyperlinkInfo = class(Tl3ProtoObject, IevdHyperlinkInfo)
 private
 // private fields
   f_Address : TevdAddress;
   f_Text : Il3CString;
   f_AppInfo : Il3CString;
 protected
 // realized methods
   function Get_Text: Il3CString;
   function Get_Address: TevdAddress;
   function Get_AppInfo: Il3CString;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aText: Il3CString;
     const anAddress: TevdAddress;
     const anAppInfo: Il3CString); reintroduce;
   class function Make(const aText: Il3CString;
     const anAddress: TevdAddress;
     const anAppInfo: Il3CString): IevdHyperlinkInfo; reintroduce;
     {* Сигнатура фабрики TevdHyperlinkInfo.Make }
 end;//TevdHyperlinkInfo

implementation

// start class TevdHyperlinkInfo

constructor TevdHyperlinkInfo.Create(const aText: Il3CString;
  const anAddress: TevdAddress;
  const anAppInfo: Il3CString);
//#UC START# *4CDD3E250364_4CDD3D930147_var*
//#UC END# *4CDD3E250364_4CDD3D930147_var*
begin
//#UC START# *4CDD3E250364_4CDD3D930147_impl*
 inherited Create;
 f_Text := aText;
 f_Address := anAddress;
 f_AppInfo := anAppInfo;
//#UC END# *4CDD3E250364_4CDD3D930147_impl*
end;//TevdHyperlinkInfo.Create

class function TevdHyperlinkInfo.Make(const aText: Il3CString;
  const anAddress: TevdAddress;
  const anAppInfo: Il3CString): IevdHyperlinkInfo;
var
 l_Inst : TevdHyperlinkInfo;
begin
 l_Inst := Create(aText, anAddress, anAppInfo);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TevdHyperlinkInfo.Get_Text: Il3CString;
//#UC START# *4CDD38870303_4CDD3D930147get_var*
//#UC END# *4CDD38870303_4CDD3D930147get_var*
begin
//#UC START# *4CDD38870303_4CDD3D930147get_impl*
 Result := f_Text;
//#UC END# *4CDD38870303_4CDD3D930147get_impl*
end;//TevdHyperlinkInfo.Get_Text

function TevdHyperlinkInfo.Get_Address: TevdAddress;
//#UC START# *4CDD3950013B_4CDD3D930147get_var*
//#UC END# *4CDD3950013B_4CDD3D930147get_var*
begin
//#UC START# *4CDD3950013B_4CDD3D930147get_impl*
 Result := f_Address;
//#UC END# *4CDD3950013B_4CDD3D930147get_impl*
end;//TevdHyperlinkInfo.Get_Address

function TevdHyperlinkInfo.Get_AppInfo: Il3CString;
//#UC START# *4CDD6BCA034C_4CDD3D930147get_var*
//#UC END# *4CDD6BCA034C_4CDD3D930147get_var*
begin
//#UC START# *4CDD6BCA034C_4CDD3D930147get_impl*
 Result := f_AppInfo;
//#UC END# *4CDD6BCA034C_4CDD3D930147get_impl*
end;//TevdHyperlinkInfo.Get_AppInfo

procedure TevdHyperlinkInfo.ClearFields;
 {-}
begin
 f_Text := nil;
 f_AppInfo := nil;
 inherited;
end;//TevdHyperlinkInfo.ClearFields

end.