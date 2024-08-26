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
  untFrmMensagem, untFormCadastro, untDmLPDV, ufrmsplash, crt
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFormPDVLaz, FormPDVLaz);
  Application.CreateForm(TDmLPDV, DmLPDV);
  with TfrmSplash.Create(Nil) do
  try
    AlphaBlend      := True;
    AlphaBlendValue := 100;
    Position        := poScreenCenter;
    Show;
    while AlphaBlendValue < 255 do
    begin
      AlphaBlendValue:= AlphaBlendValue + 1;
      Application.ProcessMessages;
      Delay(50);
    end;
    Close;
  finally
    Free;
  end;
  Application.Run;
end.

