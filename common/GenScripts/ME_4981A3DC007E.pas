unit FlashUtils;
 {* Утилиты для работы с Flash-схемами }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\FlashUtils.pas"
// Стереотип: "UtilityPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoFlash)}
 , vtShockwaveFlashEx
 {$IfEnd} // NOT Defined(NoFlash)
;

function nsCanMakeFlashActiveX: Boolean;
 {* Проверяет - возможно ли создать компонент для показа flash-ролика }
function nsMakeFlashActiveX(aParent: TWinControl;
 aForSplash: Boolean;
 out aFlash: TvtShockwaveFlashEx): Boolean;
 {* Создаёт компонент для показа flash-ролика }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , ComObj
 , Windows
 , Registry
;

function nsCanMakeFlashActiveX: Boolean;
 {* Проверяет - возможно ли создать компонент для показа flash-ролика }
//#UC START# *4981A569031D_4981A3DC007E_var*
var
 l_Flash: TvtShockwaveFlashEx;
//#UC END# *4981A569031D_4981A3DC007E_var*
begin
//#UC START# *4981A569031D_4981A3DC007E_impl*
 Result := nsMakeFlashActiveX(nil, false, l_Flash);
 FreeAndNil(l_Flash);
//#UC END# *4981A569031D_4981A3DC007E_impl*
end;//nsCanMakeFlashActiveX

function nsMakeFlashActiveX(aParent: TWinControl;
 aForSplash: Boolean;
 out aFlash: TvtShockwaveFlashEx): Boolean;
 {* Создаёт компонент для показа flash-ролика }
//#UC START# *4981A58A0168_4981A3DC007E_var*
const
 c_ClassIDKey: string = '\SOFTWARE\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}';
 c_TypeLibKey: string = '\SOFTWARE\Classes\TypeLib\{D27CDB6B-AE6D-11CF-96B8-444553540000}';
var
 l_Registry: TRegistry; // для загрузки Flash "руками" необходимо поместить часть информации в реестр перед этим
//#UC END# *4981A58A0168_4981A3DC007E_var*
begin
//#UC START# *4981A58A0168_4981A3DC007E_impl*
 aFlash := nil;
 try
  l_Registry := TRegistry.Create;
  try
   l_Registry.RootKey := HKEY_CURRENT_USER;
   //
   l_Registry.OpenKey(c_ClassIDKey, True);
   l_Registry.OpenKey('MiscStatus', True);
   l_Registry.WriteString('', '0');
   l_Registry.OpenKey('1', True);
   l_Registry.WriteString('', '131473');
   //
   l_Registry.OpenKey(c_TypeLibKey, True);
   l_Registry.OpenKey('1.0', True);
   l_Registry.WriteString('', 'Shockwave Flash');
   l_Registry.OpenKey('0\win32', True);
   l_Registry.WriteString('', 'flash.ocx');
   //
   l_Registry.OpenKey(c_TypeLibKey, True);
   l_Registry.OpenKey('1.0\FLAGS', True);
   l_Registry.WriteString('', '0');
   //
   aFlash := TvtShockwaveFlashEx.Create(aParent);
   // Работаем с flash только если поддерживается загрузка из потока
   // (<K> - 108626065):
   aFlash.Menu := False;
   if aFlash.IsLoadFromStreamSupported then
    with aFlash do
    begin
     Width := 2;
     Height := 2;
     Parent := aParent;
     Align := alClient;
     if not aForSplash then
     begin
      NeedDropAlignOnLoad := True;
      ScaleMode := 3; // NoScale
      AlignMode := 15{5}; // LTRB{LeftTop}
(*
http://www.delphiflash.com/using-tshockwaveflash/tshockwaveflash-properties#a2
AlignMode  Integer value from range 0..15. This is the same as SAlign.
0 - no align, 1 - L, 2 - R, 3 - LR, 4 - T, 5 - LT, 6 - TR, 7 - LTR, 8 - B, 9 - LB, 10 - RB, 11 - LRB, 12 - TB, 13 - LTB, 14 - TRB, 15 - LTRB.
*)
     end;//aForSplash
    end//with aFlash do
   else
    FreeAndNil(aFlash);
  finally
   try
    l_Registry.DeleteKey(c_TypeLibKey);
    l_Registry.DeleteKey(c_ClassIDKey);
   finally
    FreeAndNil(l_Registry);
   end;
  end;
 except
  on E: EOleSysError do
  begin
   FreeAndNil(aFlash);
  end;
 end;//try..except
 Result := aFlash <> nil;
//#UC END# *4981A58A0168_4981A3DC007E_impl*
end;//nsMakeFlashActiveX
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
