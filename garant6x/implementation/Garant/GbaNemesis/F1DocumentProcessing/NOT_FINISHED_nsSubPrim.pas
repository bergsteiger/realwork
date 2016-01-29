unit NOT_FINISHED_nsSubPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1DocumentProcessing"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1DocumentProcessing/NOT_FINISHED_nsSubPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::F1DocumentProcessing::F1DocumentContainers::TnsSubPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If defined(Nemesis)}
  ,
  eeSubExport
  {$IfEnd} //Nemesis
  ,
  l3Variant
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsSubPrim = class(TeeSubExport)
 protected
 // protected methods
   function Tag: Tl3Tag; virtual;
   function SubPara: Tl3Tag; virtual;
 end;//TnsSubPrim
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsSubPrim

function TnsSubPrim.Tag: Tl3Tag;
//#UC START# *4C9B0AD90093_46835879030A_var*
//#UC END# *4C9B0AD90093_46835879030A_var*
begin
//#UC START# *4C9B0AD90093_46835879030A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C9B0AD90093_46835879030A_impl*
end;//TnsSubPrim.Tag

function TnsSubPrim.SubPara: Tl3Tag;
//#UC START# *4C9B0AEF009B_46835879030A_var*
//#UC END# *4C9B0AEF009B_46835879030A_var*
begin
//#UC START# *4C9B0AEF009B_46835879030A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C9B0AEF009B_46835879030A_impl*
end;//TnsSubPrim.SubPara

{$IfEnd} //not Admin AND not Monitorings

end.