unit msmLoadedWordsListModel;

// Модуль: "w:\common\components\gui\Garant\msm\msmLoadedWordsListModel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmLoadedWordsListModel" MUID: (5811DADE01F8)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmSomeWordsListModel
 , msmConcreteModels
;

type
 TmsmLoadedWordsListModel = class(TmsmSomeWordsListModel)
  public
   constructor Create; reintroduce;
   class function Make: ImsmListModel; reintroduce;
 end;//TmsmLoadedWordsListModel

implementation

uses
 l3ImplUses
 //#UC START# *5811DADE01F8impl_uses*
 //#UC END# *5811DADE01F8impl_uses*
;

constructor TmsmLoadedWordsListModel.Create;
//#UC START# *57E51BD6031C_5811DADE01F8_var*
//#UC END# *57E51BD6031C_5811DADE01F8_var*
begin
//#UC START# *57E51BD6031C_5811DADE01F8_impl*
 inherited Create('All');
//#UC END# *57E51BD6031C_5811DADE01F8_impl*
end;//TmsmLoadedWordsListModel.Create

class function TmsmLoadedWordsListModel.Make: ImsmListModel;
var
 l_Inst : TmsmLoadedWordsListModel;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmLoadedWordsListModel.Make

end.
