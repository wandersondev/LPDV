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
  Controls, untFormMensagem, untFormCadastro, untDmLPDV, ufrmsplash, crt,
  ufrmacesso, untformcadastroempresas, untDataBase;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;

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
  with Tfrmacesso.Create(Nil) do
  try
    if ShowModal = mrCancel then
       Application.Terminate
    else begin
        Application.CreateForm(TFormPDVLaz, FormPDVLaz);
        Application.CreateForm(TFormCadastroEmpresas, FormCadastroEmpresas);
        Application.CreateForm(TFormDataBase, FormDataBase);
        Application.Run;
    end;
  finally
    Free;
  end;

end.

