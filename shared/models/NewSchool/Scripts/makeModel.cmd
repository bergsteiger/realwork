SET FILENAME=garant
del %FILENAME%.model
findstr /M /C:"Stereotype st_ProjectGroup" *.ms.model.script>> %FILENAME%.model
c makeModel.ms.script %FILENAME%