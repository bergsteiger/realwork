unit NOT_FINISHED_evdSchema;

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evdSchema.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
;

implementation

uses
 l3ImplUses
 , evNative_Schema
 {$If Defined(Archi)}
 , evArchi_Schema
 {$IfEnd} // Defined(Archi)
 {$If Defined(evMyEditor)}
 , My_Schema
 {$IfEnd} // Defined(evMyEditor)
 , Everest_Schema
 {$If Defined(DesignTimeLibrary)}
 , Design_Schema
 {$IfEnd} // Defined(DesignTimeLibrary)
;

end.
