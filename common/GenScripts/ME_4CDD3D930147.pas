unit evdHyperlinkInfo;

// Модуль: "w:\common\components\rtl\Garant\EVD\evdHyperlinkInfo.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevdHyperlinkInfo" MUID: (4CDD3D930147)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , evdInterfaces
 , l3Interfaces
;

type
 TevdHyperlinkInfo = class(Tl3ProtoObject, IevdHyperlinkInfo)
  private
   f_Address: TevdAddress;
   f_Text: Il3CString;
   f_AppInfo: Il3CString;
  protected
   function Get_Text: Il3CString;
   function Get_Address: TevdAddress;
   function Get_AppInfo: Il3CString;
   procedure ClearFields; override;
  public
   constructor Create(const aText: Il3CString;
    const anAddress: TevdAddress;
    const anAppInfo: Il3CString); reintroduce;
   class function Make(const aText: Il3CString;
    const anAddress: TevdAddress;
    const anAppInfo: Il3CString): IevdHyperlinkInfo; reintroduce;
 end;//TevdHyperlinkInfo

implementation

uses
 l3ImplUses
;

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
end;//TevdHyperlinkInfo.Make

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
begin
 f_Text := nil;
 f_AppInfo := nil;
 inherited;
end;//TevdHyperlinkInfo.ClearFields

end.
