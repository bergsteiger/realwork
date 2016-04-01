unit NOT_FINISHED_eePicture;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\NOT_FINISHED_eePicture.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TeePicture" MUID: (54BE4DB30227)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , eePara
 , eeInterfaces
 , l3Interfaces
 , ActiveX
;

type
 TeePicture = class(TeePara, IeePicture)
  protected
   function Get_Name: Il3CString;
   procedure SaveToStream(const aStream: IStream);
 end;//TeePicture
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;

function TeePicture.Get_Name: Il3CString;
//#UC START# *54819CB60119_54BE4DB30227get_var*
//#UC END# *54819CB60119_54BE4DB30227get_var*
begin
//#UC START# *54819CB60119_54BE4DB30227get_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819CB60119_54BE4DB30227get_impl*
end;//TeePicture.Get_Name

procedure TeePicture.SaveToStream(const aStream: IStream);
//#UC START# *54819D1601EF_54BE4DB30227_var*
//#UC END# *54819D1601EF_54BE4DB30227_var*
begin
//#UC START# *54819D1601EF_54BE4DB30227_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819D1601EF_54BE4DB30227_impl*
end;//TeePicture.SaveToStream
{$IfEnd} // Defined(Nemesis)

end.
