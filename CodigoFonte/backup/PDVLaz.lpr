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
  Controls, untFormMensagem, untFormCadastro, untDM, ufrmsplash, crt,
  ufrmacesso, untformcadastroempresas, untformdatabase, untConstantes;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormPDVLaz, FormPDVLaz);
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
  with Tfrmacesso.Create(Nil) do
  try
    if ShowModal = mrCancel then
       Application.Terminate
    else begin
        Application.Run;
    end;
  finally
    Free;
  end;
end.

