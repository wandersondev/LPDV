program PDVLaz;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, untPDVLaz, lazcontrols, rxnew, untFormCadastroPadrao, untFuncoes, 
untFrmMensagem
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFormPDVLaz, FormPDVLaz);
  Application.CreateForm(TFormCadastroPadrao, FormCadastroPadrao);
  Application.CreateForm(TFrmMensagem, FrmMensagem);
  Application.Run;
end.

