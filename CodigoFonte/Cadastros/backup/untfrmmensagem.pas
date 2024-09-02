unit untFrmMensagem;

{$mode ObjFPC}{$H+}

interface

uses
  Windows, Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus,
  Clipbrd, Buttons, ExtCtrls, BCPanel, BCRoundedImage, BCButtonFocus, rxctrls;

type

  { TFormMensagem }

  TFormMensagem = class(TForm)
    imgbotao1: TImage;
    imgbotao2: TImage;
    imgbotao3: TImage;
    pnTitulo: TBCPanel;
    pnBotoes: TBCPanel;
    pnMensagem: TBCPanel;
    popAreaTransf: TPopupMenu;

    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure pOnClick(Sender: TObject);
    procedure EnviarParaAreaDeTransfernciaClick(Sender: TObject);
  private

  public
    intRetorn: Integer;
    intFocus : Integer;
    blnSaiEsc: Boolean;
  end;

var
  FormMensagem: TFormMensagem;

implementation

{$R *.lfm}

{ TFormMensagem }


procedure TFormMensagem.EnviarParaAreaDeTransfernciaClick(Sender: TObject);
begin
  Clipboard.AsText := pnTitulo.Caption + #13#10 + pnMensagem.Caption;
end;

procedure TFormMensagem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Key = VK_Escape) And (blnSaiEsc) then
  begin
    intRetorn := 0;
    Close;
  end;
end;

procedure TFormMensagem.FormShow(Sender: TObject);
var
  intPos: Integer;
begin
  for intPos := 0 To Self.ComponentCount - 1 Do
  begin
    If ( Self.Components[intPos] Is TBCButtonFocus )      And
       ( Self.Components[intPos].Tag = intFocus )  Then
      ( Self.Components[intPos] As TBCButtonFocus ).SetFocus;
  end;
  SetForegroundWindow(Self.Handle);
end;

procedure TFormMensagem.pOnClick(Sender: TObject);
begin
   intRetorn := (Sender As TBCButtonFocus).Tag;
   Close;
end;

end.

