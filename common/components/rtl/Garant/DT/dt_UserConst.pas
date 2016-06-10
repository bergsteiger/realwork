unit dt_UserConst;

interface

uses
  evdTaskTypes,
  dt_Types
  ;

Const
 usIDFld    = 1;
 usNameFld  = 2;
 usActiveFld = 4;
 usAF_Key = usActiveFld; //depricated

 pssLogin_fld    = 1;
 pssPass_fld     = 2;
 pssUserID_fld   = 3;

 grIdField = 1;
 grNameField = 2;
 grNameLengthField = 3;
 grImportPriorityField = 4;
 grExportPriorityField = 5;

function IsWrongUser(anUserID: TUserID): Boolean;

implementation

uses
 daInterfaces;

function IsWrongUser(anUserID: TUserID): Boolean;
begin
 Result := (anUserID = 0) or
   (anUserID = usWrongClient) or
   (anUserID = usDuplicateClient) or
   (anUserID = usDeadClient)
end;

end.
 