unit arCustomSaveDocumentHelper;

// Модуль: "w:\archi\source\projects\Common\Utils\arCustomSaveDocumentHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarCustomSaveDocumentHelper" MUID: (57E27091018D)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , k2TagGen
 , l3Filer
;

type
 TarCustomSaveDocumentHelper = class(Tl3ProtoObject)
  private
   f_Filer: Tl3CustomFiler;
  protected
   f_Generator: Tk2TagGenerator;
  protected
   function pm_GetGenerator: Tk2TagGenerator;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   function SaveDoc: Boolean; virtual; abstract;
   procedure HandleException; virtual; abstract;
  protected
   property Filer: Tl3CustomFiler
    read f_Filer
    write f_Filer;
  public
   property Generator: Tk2TagGenerator
    read pm_GetGenerator;
 end;//TarCustomSaveDocumentHelper

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *57E27091018Dimpl_uses*
 //#UC END# *57E27091018Dimpl_uses*
;

function TarCustomSaveDocumentHelper.pm_GetGenerator: Tk2TagGenerator;
//#UC START# *57E270C5018A_57E27091018Dget_var*
//#UC END# *57E270C5018A_57E27091018Dget_var*
begin
//#UC START# *57E270C5018A_57E27091018Dget_impl*
 Result := f_Generator;
//#UC END# *57E270C5018A_57E27091018Dget_impl*
end;//TarCustomSaveDocumentHelper.pm_GetGenerator

procedure TarCustomSaveDocumentHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57E27091018D_var*
//#UC END# *479731C50290_57E27091018D_var*
begin
//#UC START# *479731C50290_57E27091018D_impl*
 FreeAndNil(f_Generator);
 FreeAndNil(f_Filer);
 inherited;
//#UC END# *479731C50290_57E27091018D_impl*
end;//TarCustomSaveDocumentHelper.Cleanup

end.
